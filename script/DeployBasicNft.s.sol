// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "lib/forge-std/src/Script.sol";
import "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    BasicNft basicNft;

    function run() external returns (BasicNft) {
        vm.startBroadcast();
        basicNft = new BasicNft();
        vm.stopBroadcast();
        return basicNft;
    }
}
