import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const FundingFactory = await ethers.getContractFactory("FundingFactory");
  const fundingFactory = await FundingFactory.deploy();

  console.log("fundingFactory deployed to:", fundingFactory.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
