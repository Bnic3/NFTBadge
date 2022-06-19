// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <=0.8.15;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "base64-sol/base64.sol";


contract NFTBadge is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => Badge) badgeMapping;    
    Badge[] totalBadges;

    uint badgeCounter;

    event NewBadgeCreated(uint256 indexed bid, string indexed message);
    event NewNFTBadgeCreated(uint256 indexed _tokenId, string indexed badgeId);

    constructor() ERC721("ETNA BADGE", "EBADGE") {}

    struct Badge {
        uint256 id;
        string name;
        string uri;
    }

    function mintBadgeNFT(uint _badgeId) external returns(uint){
        //require(bytes(badgeMapping[badgeId]).length != 0, "specified badge doesnt exist");
       
        uint256 newItemId = _tokenIds.current();
         Badge memory _badge = badgeMapping[_badgeId];
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, _badge.uri);
        

        _tokenIds.increment();
        return newItemId;


    }

    function addBadge(string memory _name,
        string memory _description,
        string memory svg) external onlyOwner returns(uint){
        string memory badgeUri = _createBadgeUri( _name, _description, svg);
            Badge memory newBadge = Badge(
                badgeCounter,
                _name,
                badgeUri                
            );
            badgeMapping[newBadge.id] = newBadge;
            totalBadges.push(newBadge);
            badgeCounter = badgeCounter+1;

            emit NewBadgeCreated(newBadge.id, newBadge.name);
            return newBadge.id;
    }

    function _convertSvgToUri(string memory svg)
        public
        pure
        returns (string memory)
    {
        string memory svgbaseUrl = "data:image/svg+xml;base64,";
        string memory svgBase64 = Base64.encode(abi.encodePacked(svg));
        return string(abi.encodePacked(svgbaseUrl, svgBase64));
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function _createBadgeUri(
        string memory _name,
        string memory _description,
        string memory svg
    ) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        abi.encodePacked(
                            '{"name":"',
                            _name,
                            '","description":"',
                            _description,
                            '","image":"',
                            _convertSvgToUri(svg),
                            '"}'
                        )
                    )
                )
            );
    }

    function getTotalBadges() public view returns (Badge[] memory){
        return totalBadges;
    }
}
