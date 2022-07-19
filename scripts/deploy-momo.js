const hh = require('hardhat');

const baseAbi = 'QmVgJYyqWXU7ep3cHsA82txUtiJjPrnSAaN5vhAQBbD4tU';
function getAbi() {
  return `ipfs://${baseAbi}/`;
}

async function main() {
  const Momo = await hh.ethers.getContractFactory('momo_contract');
  const momo = await Momo.deploy(getAbi());

  await momo.deployed();

  console.log('momo_contract deployed to:', momo.address);
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err);
    process.exit(1);
  });
