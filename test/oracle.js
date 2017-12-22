var Oracle = artifacts.require("./Oracle.sol");
contract('Oracle', function (accounts) {
    it("should assert true", function () {
        var oracle;
        Oracle.deployed().then(function (instance) {
            oracle = instance;
            oracle.proposals.call();
        }).then(function (prop) {
            assert.equal(prop, undefined, 'err');

        });
    });
});
