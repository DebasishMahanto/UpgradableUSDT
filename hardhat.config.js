require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-waffle");
/** @type import('hardhat/config').HardhatUserConfig */
const privateKey =
  "bee4353de7b885db413ce5b65fcc27c1d021f626f7c0f3e299aec96bea81aa59";
module.exports = {
  networks: {
    avalanche: {
      url: "https://api.avax.network/ext/bc/C/rpc",
      accounts: [privateKey],
    },
  },
  solidity: "0.8.20",
};
