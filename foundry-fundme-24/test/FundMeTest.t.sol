// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol"; //the console is for printing function.
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        //fundMe = new FundMe(); // this creates a new instance for the fundMe contract, therefore is the owner of the contract
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMinDollarIsFive() public view {
        //I was initially having a warning problem which chatgpt solved. Pointing the function to be a view function, therefore inserting "{view}"
        console.log("hello world");
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        console.log(fundMe.i_owner());
        console.log(msg.sender);

        //this doesn't work because the msg.sender is not a the owner of the fundMe contract instead the FundMeTest contract is the deployer of the FundMe contract.
        assertEq(fundMe.i_owner(), msg.sender); // the msg.sender is the calling the transaction.
        //assertEq(fundMe.i_owner(), address(this));
    }

    function testPriceFeedVersion() public view {
        console.log(fundMe.getVersion());
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
}
