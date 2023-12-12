pragma solidity ^0.8.20;

import "./UpgradableUSDTV1.sol";

contract UpgradableUSDTV2 is UpgradableUSDTV1 {
    function burn(uint256 _numTokens) external {
        require(owner == msg.sender, "UpgradableUSDT : only owner can access");
        require(
            balances[owner] >= _numTokens,
            "UpgradableUSDTV2: insufficient tokens to burn"
        );
        require(
            _numTokens != 0,
            "UpgradableUSDTV2:number of token to burn is zero"
        );
        totalSupplyToken -= _numTokens;
        balances[owner] -= _numTokens;
        emit Transfer(owner, address(0), _numTokens);
    }
}
