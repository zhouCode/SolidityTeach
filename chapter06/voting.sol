// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Voting {
    string[] public candidates;
    mapping(uint256 => uint256) public votes;
    mapping(address => bool) public hasVoted;
    event Voted(address indexed voter, uint256 indexed candidate, uint256 total);
    constructor(string[] memory _candidates) {
        require(_candidates.length > 0, "No candidates");
        candidates = _candidates;
    }
    function vote(uint256 candidate) public {
        require(candidate < candidates.length, "Invalid candidate");
        require(!hasVoted[msg.sender], "Already voted");
        hasVoted[msg.sender] = true;
        votes[candidate] += 1;
        emit Voted(msg.sender, candidate, votes[candidate]);
    }
    function totalCandidates() public view returns (uint256) {
        return candidates.length;
    }
    function getCandidate(uint256 i) public view returns (string memory, uint256) {
        return (candidates[i], votes[i]);
    }
}
