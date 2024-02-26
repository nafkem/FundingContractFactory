// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./Funding.sol";

contract FundingFactory {
    address[] public campaigns;

    function createCampaign(uint256 _goalAmount, uint256 _deadline) external {
        address newCampaign = address(new FundingCampaign(msg.sender, _goalAmount, _deadline));
        campaigns.push(newCampaign);
    }

    function getCampaigns() external view returns (address[] memory) {
        return campaigns;
    }
}
