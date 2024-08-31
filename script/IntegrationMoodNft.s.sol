// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "lib/forge-std/src/Script.sol";
import "../src/MoodNft.sol";
import "lib/foundry-devops/src/DevOpsTools.sol";

contract MintMoodNft is Script {
    function run() external {
        address recentlyDeployedContract = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        console.log(block.chainid);
        mintNftOnContract(recentlyDeployedContract);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlippingMoodNft is Script {
    uint256 tokenId = 0;
    function run() external {
        address recentlyDeployedContract = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        console.log(block.chainid);
        mintNftOnContract(recentlyDeployedContract);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).moodFlipper(tokenId);
        vm.stopBroadcast();
        if (tokenId == 1) {
            tokenId = 0;
        }
    }
}
