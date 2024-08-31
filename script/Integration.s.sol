// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "lib/forge-std/src/Script.sol";
import "../src/BasicNft.sol";
import "lib/foundry-devops/src/DevOpsTools.sol";

contract Integration is Script {
    function run() external {
        address recentlyDeployedContract = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        console.log(block.chainid);
        mintNftOnContract(recentlyDeployedContract);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(
            "https://ipfs.io/ipfs/QmU22yVv6mHWqe2a9iXY1PcNNrAz8fJMZwbQhTNpiJWuXB?filename=Screenshot%20from%202024-08-17%2020-03-27.png"
        );
        vm.stopBroadcast();
    }
    //https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png
}
