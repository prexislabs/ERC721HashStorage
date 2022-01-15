const hre = require("hardhat");

async function main() {
  const MyToken = await hre.ethers.getContractFactory("MyToken");
  const mytoken = await MyToken.deploy();

  await mytoken.deployed();

  console.log("MyToken deployed to:", mytoken.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
