// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IFundingFactory {
    function createCampaign(uint256 _goalAmount, uint256 _deadline) external;

    function getCampaigns() external view returns (address[] memory);
}