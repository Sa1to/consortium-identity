const ChairmanRegistry = artifacts.require("./ChairmanRegistry.sol");
const Oracle = artifacts.require("./Oracle.sol");

const oracleMembers = ["0x5862bf9e0d2834e613eabafe92b21237d17c7679"];

module.exports = function(deployer) {
  deployer.deploy(ChairmanRegistry);
  deployer.deploy(Oracle(oracleMembers));
};
