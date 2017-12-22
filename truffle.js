module.exports = {
    networks: {
        development: {
            host: "localhost",
            port: 8545,
            network_id: "*", // Match any network id
            gas: 4600000,
            gasPrice: 0.0000000000000000000000001
            // from: "0x5862bf9e0d2834e613eabafe92b21237d17c7679"
        }
    }
};
