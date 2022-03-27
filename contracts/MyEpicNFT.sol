
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract MyEpicNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  event NewEpicNFTMinted(address sender, uint256 tokenId);

  constructor() ERC721 ("SpeakOutNft", "SPO") {
  }

  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
  function makeAnEpicNFT() public {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    require(newItemId <500,"Cannot mint more than 500 NFT's" );

   bytes memory real=abi.encodePacked(bytes("0000000000000000000000000000000000000000000000000000000000000000"),bytes(uint2str(newItemId)));

    string memory finalTokenUri = string(
          abi.encodePacked("ipfs://Qmd7BfqPN3zUkh5mfGZkg9WicdiYG623PdQV1sKemYQqLb/metadata/",real[-64],".json")
    );
console.log(finalTokenUri);
    _safeMint(msg.sender, newItemId);
  
    _setTokenURI(newItemId, finalTokenUri);
  
    
    // console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    emit NewEpicNFTMinted(msg.sender, newItemId);
  }

  function getTotalNFTsMintedSoFar() public view returns (uint256){
return(_tokenIds.current());
  }
}