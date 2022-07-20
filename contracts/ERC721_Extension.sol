// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import './ERC721A.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract ERC721_Extension is ERC721A, Ownable {
    uint256 private MAX_MINTS;
    uint256 private MAX_SUPPLY;
    uint256 private mintPrice;

    string private baseURI;

    bool private isMintEnabled;
    bool private reveal;

    constructor(string memory _initBaseURI) ERC721A('Fat&Tired Ratcoiner', 'FTR') {
        MAX_MINTS = 100;
        MAX_SUPPLY = 10000;
        mintPrice = 0.00083 ether;
        baseURI = _initBaseURI;
    }

    function mint(uint256 quantity) external payable {
        // _safeMint's second argument now takes in a quantity, not a tokenId.
        require(isMintEnabled == true, 'Mint is not yet enabled');
        require(quantity + _numberMinted(msg.sender) <= MAX_MINTS, 'Exceeded the limit');
        require(totalSupply() + quantity <= MAX_SUPPLY, 'Sold out');
        require(msg.value >= (mintPrice * quantity), 'Not enough ether sent');
        _safeMint(msg.sender, quantity);
    }

    function withdraw() external payable onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    //PUBLIC WRITE ONLYOWNER

    function setMintPrice(uint256 _mintPrice) public onlyOwner {
        mintPrice = _mintPrice;
    }

    function EnableMint(bool _value) public onlyOwner {
        isMintEnabled = _value;
    }

    function EnableReveal() public onlyOwner {
        reveal = true;
    }

    //PUBLIC CLIENT

    //VIEW
    function getMintPrice() public view returns (uint256 _mintPrice) {
        _mintPrice = mintPrice;
    }

    function getIsMintEnabled() public view returns (bool _isMintEnabled) {
        _isMintEnabled = isMintEnabled;
    }

    function getIsRevealed() public view returns (bool _reveal) {
        _reveal = reveal;
    }
}
