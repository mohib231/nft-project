// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
error MOODNFT_MOODCHANEISNOTOWNER(string);

    uint256 s_tokenCounter;
    string s_happySvgImageUri;
    string s_sadSvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) s_tokenIdToMood;

    constructor(
        string memory happySvgMoodUri,
        string memory sadSvgMoodUri
    ) ERC721("MoodNft", "MNFT") {
        s_happySvgImageUri = happySvgMoodUri;
        s_sadSvgImageUri = sadSvgMoodUri;
        s_tokenCounter = 0;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function moodFlipper(uint256 tokenId) public {
        if (ownerOf(tokenId) != msg.sender) {
            revert MOODNFT_MOODCHANEISNOTOWNER("Sorry you are not the owner of this token");
        }

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageUri = s_happySvgImageUri;
        } else {
            imageUri = s_sadSvgImageUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '",',
                                '"description":"An nft that reflects owner mood",',
                                '"attributes":{"trait_type":"moodiness","value":"100"},',
                                '"image":"',
                                imageUri,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
