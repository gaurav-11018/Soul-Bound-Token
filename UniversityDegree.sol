//SPDX-License-Identifier : MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract UniversityDegree is ERC721URIStorage{

    address owner;
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    constructor() ERC721("UniversityDegree","Degree"){
        owner = msg.sender;
    }

    mapping(address => bool) public issuedDegrees;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function issueDegree(address to) external {
        issuedDegrees[to]=true;
    }

    mapping(address => string) public personToDegree;

    function claimDegree(string memory tokenURI) public returns(uint256){
        require(issuedDegrees[msg.sender],"Degree is not issued");

        _tokenIds.increment();
        uint256 newItemId=_tokenIds.current();
        _mint(msg.sender,newItemId);
        _setTokenURI(newItemId, tokenURI);

        personToDegree[msg.sender]=tokenURI;
        issuedDegrees[msg.sender]= false;

        return newItemId;
    }

  }

