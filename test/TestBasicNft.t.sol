// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../script/DeployBasicNft.s.sol";
import "../src/BasicNft.sol";
import "lib/forge-std/src/Test.sol";

contract TestBasicNft is Test {
    BasicNft basicNft;
    DeployBasicNft deployer;

    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function test_isNameCorrect() public view {
        string memory name = "BasicNft";

        assertEq(keccak256(abi.encodePacked(name)), keccak256(abi.encodePacked(basicNft.name())));
    }
}
