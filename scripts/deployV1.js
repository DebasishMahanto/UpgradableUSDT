const { ethers, upgrades } = require("hardhat");

async function main() {
  const USDT1 = await ethers.getContractFactory("UpgradableUSDTV1");
  console.log("deploying version 1");
  const usdt1 = await upgrades.deployProxy(USDT1, [100], {
    initializer: "initialize",
  });
  await usdt1.deployed();
  console.log("NUM1 Deployed address: ", usdt1.address);
}
main();
