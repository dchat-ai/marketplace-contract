// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Marketplace {
    // Variables
    // Not sure an owner is needed
    address public owner;

    mapping(uint => Product) public products;
    uint public productCount;
    mapping(uint => Purchase) public purchases;
    uint public purchaseCount;
    mapping(address => uint) public sellerFunds;
    mapping(address => uint[]) public sellerSoldProducts;

    // Structs
    struct Product {
        uint productId;
        address seller;
        string name;
        uint price;
    }

    struct Purchase {
        address buyer;
        uint productId;
        uint purchaseTime;
    }

    // Events
    event ProductCreated(
        uint indexed productId,
        address indexed seller,
        string name,
        uint price
    );
    event ProductPurchased(
        uint indexed productId,
        address indexed buyer,
        uint purchaseTime
    );

    constructor() {
        owner = msg.sender;
    }

    function createProduct(string memory name, uint price) external {
        require(price > 0, "Price must be greater than 0");
        productCount++;
        products[productCount] = Product(productCount, msg.sender, name, price);

        emit ProductCreated(productCount, msg.sender, name, price);
    }

    function purchaseProduct(uint productId) external payable {
        Product storage product = products[productId];
        require(msg.value == product.price, "Wrong amount");

        address seller = product.seller;
        purchaseCount++;
        purchases[purchaseCount] = Purchase(
            msg.sender,
            productId,
            block.timestamp
        );

        sellerFunds[seller] += product.price;
        sellerSoldProducts[seller].push(productId);

        emit ProductPurchased(productId, msg.sender, block.timestamp);
    }

    function withdrawBalance() external {
        uint balance = sellerFunds[msg.sender];
        require(balance > 0, "No funds to withdraw");
        sellerFunds[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: balance}("");
        require(success, "Transfer to seller failed");
    }

    function getSellerProducts() external view returns (Product[] memory) {
        uint[] storage productIds = sellerSoldProducts[msg.sender];
        Product[] memory result = new Product[](productIds.length);

        for (uint i = 0; i < productIds.length; i++) {
            result[i] = products[productIds[i]];
        }

        return result;
    }

    function getPurchasesFromAddress(
        address _address
    ) external view returns (Purchase[] memory) {
        uint count = 0;

        for (uint i = 1; i <= purchaseCount; i++) {
            if (purchases[i].buyer == _address) {
                count++;
            }
        }

        Purchase[] memory result = new Purchase[](count);
        uint index = 0;

        for (uint i = 1; i <= purchaseCount; i++) {
            if (purchases[i].buyer == _address) {
                result[index] = purchases[i];
                index++;
            }
        }

        return result;
    }

    function getSellerBalance(address seller) external view returns (uint) {
        return sellerFunds[seller];
    }
}
