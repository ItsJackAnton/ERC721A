const hh = require('hardhat');

async function main() {
  const Momo = await hh.ethers.getContractFactory('momo_contract');
  const momo = await Momo.deploy();

  await momo.deployed();

  console.log('momo_contract deployed to:', momo.address);
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err);
    process.exit(1);
  });
