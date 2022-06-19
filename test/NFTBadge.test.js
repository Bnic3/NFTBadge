const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTBadge",  function () {
  
  it("Should reflect the right owner", async function () {
    const [owner,acc1, acc2] = await ethers.getSigners();
    const Badge = await ethers.getContractFactory("NFTBadge");
    const badge = await Badge.deploy();
    await badge.deployed();

    
    expect(await badge.owner()).to.equal(owner.address)
    
    

    //expect(await greeter.greet()).to.equal("Hello, world!");

 
  });
});
