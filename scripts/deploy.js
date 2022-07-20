const hh = require('hardhat');

const baseAbi = 'QmQ8xy9SeQKgd3DRLoAwhxTGPwa1sRfrRWYSvDgC3U7pkA';
function getAbi() {
  return `ipfs://${baseAbi}/`;
}

async function main() {
  const Contract = await hh.ethers.getContractFactory('ERC721_Extension');
  const contract = await Contract.deploy(getAbi());

  await contract.deployed();

  console.log('ERC721_Extension deployed to:', contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err);
    process.exit(1);
  });
