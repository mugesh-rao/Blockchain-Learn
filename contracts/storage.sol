pragma solidity ^0.8.0;

contract VotingApp {
    struct Voter {
        bool hasVoted;
        uint256 vote;
    }
    
    mapping(address => Voter) voters;
    uint256[] public options;
    
    function addOption(uint256 option) public {
        options.push(option);
    }
    
    function vote(uint256 option) public {
        require(!voters[msg.sender].hasVoted, "You have already voted!");
        require(option < options.length, "Invalid option!");
        
        voters[msg.sender].hasVoted = true;
        voters[msg.sender].vote = option;
    }
    
    function tally() public view returns(uint256[] memory, uint256[] memory) {
        uint256[] memory results = new uint256[](options.length);
        
        for (uint256 i = 0; i < options.length; i++) {
            results[i] = 0;
        }
        
        for (uint256 i = 0; i < options.length; i++) {
            results[voters[msg.sender].vote]++;
        }
        
        return (options, results);
    }
}
