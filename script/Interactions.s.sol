// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";

contract MintBasicNft is Script {
    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        // Read file content
        string memory filePath = "images/artistic/matedata/artistics.txt";
        string memory fileContent = vm.readFile(filePath);

        // Split file content by lines to get each tokenUri
        string[] memory tokenUris = splitFileContent(fileContent);

        // Start broadcasting transactions
        vm.startBroadcast();

        // Iterate through tokenUris and mint
        for (uint256 i = 0; i < tokenUris.length; i++) {
            BasicNft(contractAddress).mintNft(tokenUris[i]);
        }

        vm.stopBroadcast();
    }

    // Helper function: Split file content by lines
    function splitFileContent(string memory content) internal pure returns (string[] memory) {
        uint256 lineCount = countLines(content);
        string[] memory lines = new string[](lineCount);

        bytes memory contentBytes = bytes(content);
        uint256 lineIndex = 0;
        uint256 start = 0;

        for (uint256 i = 0; i < contentBytes.length; i++) {
            if (contentBytes[i] == "\n") {
                lines[lineIndex] = substring(content, start, i);
                lineIndex++;
                start = i + 1;
            }
        }

        // Add the last line
        if (start < contentBytes.length) {
            lines[lineIndex] = substring(content, start, contentBytes.length);
        }

        return lines;
    }

    // Helper function: Count the number of lines in the content
    function countLines(string memory content) internal pure returns (uint256) {
        bytes memory contentBytes = bytes(content);
        uint256 lineCount = 1; // At least one line

        for (uint256 i = 0; i < contentBytes.length; i++) {
            if (contentBytes[i] == "\n") {
                lineCount++;
            }
        }

        return lineCount;
    }

    // Helper function: Extract a substring from a string
    function substring(string memory str, uint256 startIndex, uint256 endIndex) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);

        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }

        return string(result);
    }
}
