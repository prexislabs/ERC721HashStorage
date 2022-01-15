// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./ERC721HashStorage.sol";

contract MyToken is ERC721, ERC721URIStorage, ERC721HashStorage, Ownable {
  using Counters for Counters.Counter;

  Counters.Counter private _tokenIdCounter;

  constructor() ERC721("MyToken", "MTK") {}

  function safeMint(
    string memory uri,
    bytes32 metadataHash,
    bytes32 mediaHash
  ) public onlyOwner returns (uint256 _tokenId) {
    uint256 tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();
    _safeMint(owner(), tokenId);
    _setTokenURI(tokenId, uri);
    _setTokenHashes(tokenId, metadataHash, mediaHash);

    return tokenId;
  }

  function burn(uint256 tokenId) external {
    _burn(tokenId);
  }

  // The following functions are overrides required by Solidity.

  function _burn(uint256 tokenId)
    internal
    override(ERC721, ERC721URIStorage, ERC721HashStorage)
  {
    super._burn(tokenId);
  }

  function tokenURI(uint256 tokenId)
    public
    view
    override(ERC721, ERC721URIStorage)
    returns (string memory)
  {
    return super.tokenURI(tokenId);
  }
}
