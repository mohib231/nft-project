// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    error BasicNft__TokenUriNotFound();

    uint256 s_counter;
    mapping(uint256 => string) s_tokenIdToUri;

    constructor() ERC721("BasicNft", "BN") {
        s_counter = 0;
    }

    function mintNft(string memory tokenuri) public {
        s_tokenIdToUri[s_counter] = tokenuri;
        _safeMint(msg.sender, s_counter);
        s_counter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert BasicNft__TokenUriNotFound();
        }
        return s_tokenIdToUri[tokenId];
    }
}
