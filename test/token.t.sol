// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/token.sol";

contract TokenTest is Test {
    TT token; 
    address deployer = address(this); 
    address user1 = address(0x123); 
    address user2 = address(0x456); 

    function setUp() public {
        token = new TT(); 
    }

    function testInitialSupply() public {
        uint256 totalSupply = token.totalSupply();
        assertEq(totalSupply, 2_000_000 * 10 ** token.decimals(), "Incorrect initial supply"); 
    }

    function testMintingTokens() public {
        uint256 balanceBefore = token.balanceOf(deployer); 
        token.mintTokens(); 
        uint256 balanceAfter = token.balanceOf(deployer); 

        assertEq(balanceAfter, balanceBefore + 1000, "minting did not work correctly"); 
    }

    function testTransferTokens() public {
        token.transfer(user1, 1000); 
        assertEq(token.balanceOf(user1), 1000, "Transfer failed"); 
    }

    function testFail_TransferMoreThanBalance() public {
        token.transfer(user2, 3_000_000 * 10 ** token.decimals()); 
    }
    
    }