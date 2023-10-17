// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {Marketplace} from "../src/Marketplace.sol";

contract MarketplaceScript is Script {
    function setUp() public {}

    function run() external returns (Marketplace) {
        vm.startBroadcast();
        Marketplace marketplace = new Marketplace();
        vm.stopBroadcast();
        return marketplace;
    }
}
