const { ethers, upgrades } = require("hardhat");

const v1_Address = "";

async function main() {
  const USDT2 = await ethers.getContractFactory("UpgradableUSDTV2");
  console.log("Upgrading USDT...");
  await upgrades.upgradeProxy(v1_Address, USDT2);
  console.log("upgraded....");
}
