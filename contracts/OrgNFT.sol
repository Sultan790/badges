// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OrgNFT is ERC721, Ownable {
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    function issueNFT(address recipient, uint256 tokenId, string memory tokenURI) public onlyOwner {
        require(!_exists(tokenId), "Token ID already exists");
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI) public onlyOwner {
        require(_exists(tokenId), "Token ID does not exist");
        _setTokenURI(tokenId, tokenURI);
    }

    function _setTokenURI(uint256 tokenId, string memory tokenURI) internal virtual {
        require(_exists(tokenId), "Token ID does not exist");
        _tokenURIs[tokenId] = tokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "Token ID does not exist");
        return _tokenURIs[tokenId];
    }
}
