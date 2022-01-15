// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @dev ERC721 token with metadata and midia hash storage.
 */
abstract contract ERC721HashStorage is ERC721 {
  mapping(uint256 => bytes32) public tokenMetadataHash;
  mapping(uint256 => bytes32) public tokenMediaHash;

  /**
   * @dev Sets `_tokenMetadataHash` and `_tokenMediaHash` as hashes of `tokenId`.
   *
   * Requirements:
   *
   * - `_tokenId` must exist.
   * - `_tokenMetadataHash` different from zero
   * - `_tokenMediaHash` different from zero
   */
  function _setTokenHashes(
    uint256 _tokenId,
    bytes32 _tokenMetadataHash,
    bytes32 _tokenMediaHash
  ) internal virtual {
    require(_exists(_tokenId), "ERC721HashStorage: URI set of nonexistent token");
    require(_tokenMetadataHash != bytes32(0), "ERC721HashStorage: metadata hash with zero value");
    require(_tokenMediaHash != bytes32(0), "ERC721HashStorage: media hash with zero value");

    tokenMetadataHash[_tokenId] = _tokenMetadataHash;
    tokenMediaHash[_tokenId] = _tokenMediaHash;
  }

  /**
   * @dev Destroys `tokenId`.
   * The approval is cleared when the token is burned.
   *
   * Requirements:
   *
   * - `tokenId` must exist.
   *
   * Emits a {Transfer} event.
   */
  function _burn(uint256 _tokenId) internal virtual override {
    super._burn(_tokenId);

    if (bytes32(tokenMetadataHash[_tokenId]).length != 0) {
      delete tokenMetadataHash[_tokenId];
    }

    if (bytes32(tokenMediaHash[_tokenId]).length != 0) {
      delete tokenMediaHash[_tokenId];
    }
  }
}
