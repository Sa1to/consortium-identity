const ChairmanRegistry = artifacts.require("./ChairmanRegistry.sol");
const Oracle = artifacts.require("./Oracle.sol");


var oracleMembers = ['0x540e8aa6bd075ed64f248c7f4d9241a8358e59b9'];
module.exports = function (deployer) {
    deployer.deploy(Oracle, oracleMembers);
};
