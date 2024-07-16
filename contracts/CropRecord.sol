// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract CropRecord  {
    uint256 public tokenCount;

    struct Farmer {
        uint256 id;
        string name;
        address farmerAddress;
    }

    struct Crop {
        uint256 id;
        uint256 farmerId;
        string cropType;
        uint256 fieldArea;
        string description;
    }

    mapping(address => uint256) public farmerIdByAddress; // Maps address to farmer ID
    mapping(uint256 => bool) public hasMintedNFT; // Track whether NFT has been minted for a crop

    Farmer[] public farmers;
    Crop[] public crops;

    uint256 public farmerCount;
    uint256 public cropCount;



    function registerFarmer(string memory _name) public {
        require(!isFarmerRegistered[msg.sender], "Farmer already registered");

        uint256 newFarmerId = farmerCount++;
        farmers.push(Farmer(newFarmerId, _name, msg.sender));
        farmerIdByAddress[msg.sender] = newFarmerId;
        isFarmerRegistered[msg.sender] = true;
    }

    function registerCrop(string memory _cropType, uint256 _fieldArea, string memory _description) public returns (uint256) {
        uint256 farmerId = farmerIdByAddress[msg.sender];
        require(farmerId != 0, "Farmer not registered");
        require(farmers[farmerId].farmerAddress == msg.sender, "Invalid farmer ID");

        crops.push(Crop(cropCount++, farmerId, _cropType, _fieldArea,_description));
        return cropCount - 1;
    }

    mapping(address => bool) public isFarmerRegistered; // Track if an address is registered as a farmer

    function getAllFarmers() public view returns (Farmer[] memory) {
        return farmers;
    }
}
