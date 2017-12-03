module.exports = {
    networks: {
        development: {
            host: "localhost",
            port: 8545,
            network_id: "*", // Match any network id
            gas: 0xfffffffffff,
            gasPrice: 0x01,
            from: "0x5862bf9e0d2834e613eabafe92b21237d17c7679"
        }
    }
};
