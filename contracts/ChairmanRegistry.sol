pragma solidity ^0.4.15;


import "./Oracle.sol";


contract ChairmanRegistry {

    // multisig contract that is responsible for authentication weather or not user have claims to chairman position
    Oracle oracle;

    // chairmanAddress => companyName
    mapping (address => string) chairmanMap;

    modifier isOracle(){
        require(oracle == msg.sender);
        _;
    }

    modifier validAddress(address adr){
        require(adr != address(0));
        _;
    }

    // some more sophisticated validation of company name may be implemented here
    modifier validCompany(string compName){
        require(keccak256(compName) != keccak256(""));
        _;
    }

    function ChairmanRegistry() {
        oracle = Oracle(msg.sender);
    }

    function becomeChairman(string companyName) public
    validAddress(msg.sender)
    validCompany(companyName) {
        //send request to oracle
        oracle.createProposal(msg.sender, companyName);
    }

    function assignChairman(address validatedChairman, string companyName)
    isOracle
    validAddress(validatedChairman)
    validCompany(companyName) {
        chairmanMap[validatedChairman] = companyName;
    }

    function getCompanyAssigned(address companyChairman) constant
    validAddress(companyChairman) returns (string){
        return chairmanMap[companyChairman];
    }

}
