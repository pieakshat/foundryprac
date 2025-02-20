// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/Test.sol";
import "../src/dex.sol";
import "../src/token.sol";

contract TestDex is Test {
    Dex dex; 
    TT token1; 
    TT token2; 
    address deployer = address(this); 
    address user1 = address(0x123); 

    function setUp() public {
        dex = new Dex(); 
        token1 = new TT(); 
        token2 = new TT(); 

        token1.mint(deployer, 1000 ether); 
        token2.mint(deployer, 1000 ether); 
        token1.mint(user1, 1000 ether); 
        token2.mint(user1, 1000 ether); 

    }

    function testCreatePool() public {
        token1.approve(address(dex), 500 ether); 

        // create pool 
        vm.deal(deployer, 10 ether); 
        dex.createPool{value: 10 ether}(IERC20(address(token1)), 500 ether);

        // verify pool exists
        (address poolAddr, uint price, uint ethReserve, uint tokenReserve) = dex.poolInfo(address(token1));  
        assertEq(poolAddr, address(token1));
        assertEq(ethReserve, 10 ether);
        assertEq(tokenReserve, 500 ether);
    }

    function testEthToTokenSwap() public {

        // create the pool first
        token1.approve(address(dex), 500 ether); 
        vm.deal(deployer, 10 ether);
        dex.createPool{value: 10 ether}(IERC20(address(token1)), 500 ether);

        // eth to token swap 
        vm.deal(user1, 1 ether);    // used to fund the address some specified amount
        vm.prank(user1);    // makes user1 msg.sender for the next function
        dex.ethToTokenSwap{value: 1 ether}(IERC20(address(token1)), 0);

        uint256 userBalance = token1.balanceOf(user1); 
        assertGt(userBalance, 0);
    }

    function testTokenToEthSwap() public {
        
    }

}