// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0 <= 0.8.15;
 import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
 import "@openzeppelin/contracts/access/Ownable.sol";
contract NFTBadge is ERC721,Ownable {
  mapping(uint => Badge) badges;

  event NewBadgeCreated(uint indexed bid, string indexed message);

  constructor() ERC721("ETNA BADGE", "EBADGE"){

  }

  struct Badge{
    uint id;
    string name;
    string uri;
  }

  function addBadge(string calldata svg) external onlyOwner {

  }



}