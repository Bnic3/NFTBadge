require('dotenv').config();
const fs = require("fs");
const path = require("path");
const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("NFTBadge",  function () {
  
  it("Should reflect the right owner", async function () {
    const [owner,acc1, acc2] = await ethers.getSigners();
    const Badge = await ethers.getContractFactory("NFTBadge");
    const badge = await Badge.deploy();
    await badge.deployed();

    
    expect(await badge.owner()).to.equal(owner.address)
    const svg1 =  fs.readFileSync(`${process.env.ROOT_DIR}/badges/badge1.svg`, {"encoding": "utf8"})
    //const svg = await badge.convertSvgToUri(svg1);
    const res = await badge.addBadge("e_tech1", "Tech Badge", svg1);
    await res.wait(1);
    const mint = await badge.mintBadgeNFT(0);
    mint.wait(1);

    const user = await badge.ownerOf(0);
    console.log(user)
    
    
    
    
    
    
    

    //expect(await greeter.greet()).to.equal("Hello, world!");

 
  });
});
