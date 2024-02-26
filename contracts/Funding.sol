// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract FundingCampaign {
    address public creator;
    uint256 public goalAmount;
    uint256 public deadline;
    uint256 public totalAmountRaised;
    mapping(address => uint256) public contributions;

    enum Status { Ongoing, Failed, Succeeded }
    Status public campaignStatus;

    constructor(address _creator, uint256 _goalAmount, uint256 _deadline) {
        creator = _creator;
        goalAmount = _goalAmount;
        deadline = _deadline;
        campaignStatus = Status.Ongoing;
    }

    function contribute() external payable {
        require(campaignStatus == Status.Ongoing, "Campaign is not ongoing.");
        require(block.timestamp < deadline, "Deadline has passed.");
        
        contributions[msg.sender] += msg.value;
        totalAmountRaised += msg.value;

        if (totalAmountRaised >= goalAmount) {
            campaignStatus = Status.Succeeded;
        }
    }

    function withdrawFunds() external {
        require(campaignStatus == Status.Succeeded, "Campaign has not succeeded.");
        require(msg.sender == creator, "Only the campaign creator can withdraw funds.");

        payable(msg.sender).transfer(address(this).balance);
    }

    function checkCampaignStatus() external returns (Status) {
        if (campaignStatus == Status.Ongoing && block.timestamp >= deadline) {
            campaignStatus = Status.Failed;
        }
        return campaignStatus;
    }
}
