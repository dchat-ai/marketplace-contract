# dChat.ai - EVM Smart Contract Proof of Concept

## dChat.ai Marketplace Smart Contract

dchat.ai's marketplace allows any user to sell and buy access to various trained AI chat bots, that act as an assistant to their needs.

## Design decisions Marketplace Smart Contract

Based on the challenges that were met, some decisions were taken

1. Keeping track of the sellers' sold products as a mapping
2. Keeping track of the sellers' unclaimed funds, in other the ensure that withdrawing doesn't have vulnerabilities
3. Viewer methods that accomodate building a frontend
4. Enough simplicity, while ensuring security

**Keeping track of the sellers' sold products as a mapping**
The seller would need to know what was sold, this could help with analytics or simple data, to help them understand what was good and what wasn't.
It also serves as an easy way of keeping track of sales within the smart contract.

**Keeping track of the sellers' unclaimed funds**
When withdrawing sellers should be able to claim multiple funds at once, in order to reduce gas costs, while at the same time they can't withdraw more than they have available.

**Viewer methods that accomodate building a frontend**
In order to have Seller and Buyer detailed purchases pages, data is being passed in an easier way to incorporate into their respective frontend pages.

**Enough simplicity, while ensuring security**
The purpose was not to built a groundbreaking Marketplace, but a simple elegant solution, that is secure. Therefore not many variables or contextual logic was implemented.

### Deployment commands example

forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY src/Marketplace.sol:Marketplace --legacy

### Deployments

**Scroll Sepolia Deployment**

Deployed to: 0x535791515adeB452cDAA87C088849C8A2e4ef8b1
Transaction hash: 0xbf3abd790d35d1361244fffcdbd586fdefcefa697e1493e301c160fbb1104088

**Filecoin Calibration Deployment**

Deployed to: 0x079ae838078578559E61b3F3eF8C8c7dDE4E5A63

**Mantle Testnet Deployment**

Deployed to: 0x7ca484e8D02297436aBe799624F766417A8C91Da
Transaction hash: 0x226d433eff721580e911e1bac7a94ead2e0ff119712b5be60407fbb0c90b2f1b

**Polygon zkEVM Testnet Deployment**

Deployed to: 0x535791515adeB452cDAA87C088849C8A2e4ef8b1
Transaction hash: 0xc2fabb6e018738d6ff94eb8713c64057f75f9b5f659d40e9de61a38e895eb213
