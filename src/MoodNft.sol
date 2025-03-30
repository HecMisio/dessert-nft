// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";

contract MoodNft is ERC721 {
    error ERC721Metadata__URI_QueryFor_NonexistentToken();
    error MoodNft__CantChangeMoodIfNotOwner();

    enum NFTState {
        Happy,
        Sad,
        Angry,
        Excited,
        Bored
    }

    uint256 private s_tokenCounter;
    mapping(NFTState => string) private s_StateToSvgUri;
    mapping(uint256 => NFTState) private s_tokenIdToState;

    event CreatedNft(uint256 indexed tokenId);

    constructor(string[] memory svgUris) ERC721("MoodNft", "MD") {
        s_tokenCounter = 0;
        for (uint256 i = 0; i < svgUris.length; i++) {
            s_StateToSvgUri[NFTState(i)] = svgUris[i];
        }
    }

    function mintNft() public {
        uint256 tokenCounter = s_tokenCounter;
        _safeMint(msg.sender, tokenCounter);
        s_tokenCounter++;
        emit CreatedNft(tokenCounter);
    }

    function changeMood(uint256 tokenId) public {
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNft__CantChangeMoodIfNotOwner();
        }

        NFTState currentMood = s_tokenIdToState[tokenId];
        NFTState newMood = NFTState((uint256(currentMood) + 1) % 5);
        s_tokenIdToState[tokenId] = newMood;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert ERC721Metadata__URI_QueryFor_NonexistentToken();
        }
        string memory imageUri = s_StateToSvgUri[s_tokenIdToState[tokenId]];

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"',
                        name(), // You can add whatever name here
                        '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                        '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                        imageUri,
                        '"}'
                    )
                )
            )
        );
    }

    function getMood(uint256 tokenId) public view returns (NFTState) {
        return s_tokenIdToState[tokenId];
    }

    function getSvgUri(NFTState state) public view returns (string memory) {
        return s_StateToSvgUri[state];
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
