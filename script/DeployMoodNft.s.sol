// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "lib/forge-std/src/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    MoodNft moodNft;
    string public happySvgUri =vm.readFile('./images/happy.svg');
    string public sadSvgUri =vm.readFile('./images/sad.svg');
    function run() external returns (MoodNft) {
        vm.startBroadcast();
        moodNft = new MoodNft(svgToBase64(happySvgUri), svgToBase64(sadSvgUri));
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToBase64(
        string memory svg
    ) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    (Base64.encode(bytes(abi.encodePacked(svg))))
                )
            );
    }
}
