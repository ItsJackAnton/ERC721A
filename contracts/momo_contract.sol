// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import './ERC721A.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract momo_contract is ERC721A, Ownable {
    uint256 MAX_MINTS = 100;
    uint256 MAX_SUPPLY = 10000;
    uint256 public mintPrice = 0.00083 ether;

    string public baseURI = 'ipfs://placeholder/';

    bool private isMintEnabled;

    constructor() ERC721A('momo', 'momo') {}

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

    //VIEW
    function getMintPrice() public view returns (uint256 _mintPrice) {
        _mintPrice = mintPrice;
    }

    function getIsMintEnabled() public view returns (bool _isMintEnabled) {
        _isMintEnabled = isMintEnabled;
    }
}
