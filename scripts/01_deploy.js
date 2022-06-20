
const {ethers} = require("hardhat");

async function main() {
  const Badge = await ethers.getContractFactory("NFTBadge");
  const badge = await Badge.deploy();
  await badge.deployed();

  console.log("NFTBadge deployed to:", badge.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
