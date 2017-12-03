pragma solidity ^0.4.15;


import "./ChairmanRegistry.sol";


contract Oracle {


    struct Proposal {
    // may be extended with whatever data is needed to identify company
    string companyName;
    address[] membersThatHaventVoted;
    // voting for creating chairman registry 0 - not voted 1 - no 2 - yes
    uint8 votes;
    uint8 numberOfVotes;
    }

    address[] members;

    uint numberOfMembers;

    ChairmanRegistry registry;

    // chairmanAddress => proposal
    mapping (address => Proposal) proposals;

    bool locked;

    modifier validAddress(address adr){
        require(adr != address(0));
        _;
    }

    modifier isMember(){
        bool isMemberOfOracle = false;

        for (uint i = 0; i < members.length; i++) {
            if (msg.sender == members[i]) {
                isMemberOfOracle = true;
            }
        }

        require(isMemberOfOracle);
        _;
    }

    modifier haventVotedYet(address chairmanAddress){
        bool haventVoted = false;
        //checks that msg.sender is in array of members that havent voted for given proposal
        for (uint i = 0; i < proposals[chairmanAddress].membersThatHaventVoted.length; i++) {
            if (proposals[chairmanAddress].membersThatHaventVoted[i] == msg.sender) {
                haventVoted = true;
            }
        }
        require(haventVoted);
        _;
    }

    modifier noReentrancy(){
        require(!locked);
        locked = true;
        _;
        locked = false;
    }

    modifier isChairmanRegistry(){
        require(msg.sender == address(registry));
        _;
    }

    function Oracle(address[] _members) {
        members = _members;
        registry = new ChairmanRegistry();
    }

    function createProposal(address chairman, string companyName)
    isChairmanRegistry
    {
        proposals[chairman] = Proposal(companyName, members, 0, 0);
    }

    function vote(address chairman, bool voteFor)
    validAddress(msg.sender)
    isMember
    haventVotedYet(chairman) {
        if (voteFor) {
            proposals[chairman].votes = proposals[chairman].votes + 2;
            ++proposals[chairman].numberOfVotes;
        }
        else {
            ++proposals[chairman].votes;
            ++proposals[chairman].numberOfVotes;
        }
        // check if voting is finished
        if (proposals[chairman].numberOfVotes == numberOfMembers) {
            //check if proposal has passed
            if (proposals[chairman].votes == (2 * numberOfMembers)) {
                registerChairman(chairman, proposals[chairman].companyName);
            }
            else {
                delete proposals[chairman];
            }
        }
    }

    function registerChairman(address chairman, string companyName) private
    validAddress(msg.sender)
    isMember
    noReentrancy
    {
        registry.assignChairman(chairman, companyName);
        delete proposals[chairman];
    }

    function getProposal(address chairman)
    constant
    validAddress(chairman)
    returns (Proposal){
        return proposals[chairman];
    }
}
