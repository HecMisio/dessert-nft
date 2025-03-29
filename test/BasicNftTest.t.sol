// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "src/BasicNft.sol";

contract BasicNftTest is Test {
    // The address of the BasicNft contract
    BasicNft public basicNft;
    address public Alice = makeAddr("Alice");
    string public constant avator = "ipfs://bafkreieqdzrdwfcvewakx7e4fhlgp53v5zkfpy5wncyh7dglcipee6s2cm";

    function setUp() public {
        DeployBasicNft deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        // Check the name of the NFT
        string memory expectedName = "Beauty";
        string memory actualName = basicNft.name();
        assertEq(actualName, expectedName, "NFT name is incorrect");
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(Alice);
        basicNft.mintNft(avator);

        assertEq(basicNft.balanceOf(Alice), 1, "Balance should be 1 after minting");
        assertEq(
            keccak256(abi.encodePacked(avator)),
            keccak256(abi.encodePacked(basicNft.tokenURI(0))),
            "Token ID 0 should be excectly the avator URI"
        );
    }
}
