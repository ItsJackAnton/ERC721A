require('@nomiclabs/hardhat-waffle');
require('@nomiclabs/hardhat-ethers');

const dotenv = require('dotenv');
dotenv.config();

if (process.env.REPORT_GAS) {
  require('hardhat-gas-reporter');
}

if (process.env.REPORT_COVERAGE) {
  require('solidity-coverage');
}

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    version: '0.8.4',
    settings: {
      optimizer: {
        enabled: true,
        runs: 800,
      },
    },
  },
  //ItsJackAnton
  defaultNetwork: 'rinkeby',
  networks: {
    rinkeby: {
      url: process.env.APP_RINKEBY_RPC_URL,
      accounts: [process.env.APP_PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.APP_ETHERSCAN_KEY,
  },
  //ItsJackAnton
};
