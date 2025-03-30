// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";
import {MoodNft} from "src/MoodNft.sol";

contract TestMoodNft is Test {
    MoodNft private moodNft;
    address private Alice = makeAddr("Alice");

    function setUp() public {
        DeployMoodNft deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        // Check the name of the NFT
        string memory expectedName = "MoodNft";
        string memory actualName = moodNft.name();
        assertEq(actualName, expectedName, "NFT name is incorrect");
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(Alice);
        moodNft.mintNft();

        assertEq(moodNft.balanceOf(Alice), 1, "Balance should be 1 after minting");
        assertEq(moodNft.ownerOf(0), Alice, "Alice should be the owner of token ID 0");
        assertEq(uint256(moodNft.getMood(0)), 0, "Mood of token ID 0 should be happy (0)");
        assertEq(
            (moodNft.getSvgUri(moodNft.getMood(0))),
            moodNft.getSvgUri(MoodNft.NFTState.Happy),
            "Mood of token ID 0 should be happy (0)"
        );
    }

    function testChangeMood() public {
        vm.prank(Alice);
        moodNft.mintNft();

        vm.prank(Alice);
        moodNft.changeMood(0);

        assertEq(uint256(moodNft.getMood(0)), 1, "Mood of token ID 0 should be sad (1)");
        assertEq(
            (moodNft.getSvgUri(moodNft.getMood(0))),
            moodNft.getSvgUri(MoodNft.NFTState.Sad),
            "Mood of token ID 0 should be sad (1)"
        );
    }
}
