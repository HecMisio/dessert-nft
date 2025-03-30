// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {console} from "forge-std/console.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory happySvg = vm.readFile("images/mood/happy.svg");
        string memory sadSvg = vm.readFile("images/mood/sad.svg");
        string memory angrySvg = vm.readFile("images/mood/angry.svg");
        string memory excitedSvg = vm.readFile("images/mood/excited.svg");
        string memory boredSvg = vm.readFile("images/mood/bored.svg");
        string[] memory svgUris = new string[](5);
        svgUris[0] = svgToImageURI(happySvg);
        svgUris[1] = svgToImageURI(sadSvg);
        svgUris[2] = svgToImageURI(angrySvg);
        svgUris[3] = svgToImageURI(excitedSvg);
        svgUris[4] = svgToImageURI(boredSvg);

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(svgUris);
        vm.stopBroadcast();

        console.log("MoodNft deployed to: ", address(moodNft));
        return moodNft;
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory base64Svg = Base64.encode(bytes(svg));
        return string(abi.encodePacked("data:image/svg+xml;base64,", base64Svg));
    }
}
