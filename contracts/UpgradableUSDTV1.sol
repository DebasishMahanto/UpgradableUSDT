// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

interface IUpgradableUSDTV1 {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function balanceOf(address _owner) external view returns (uint256);

    function transfer(address _receiver, uint256 _numTokens) external;

    function approve(address _spender, uint256 _value) external;

    function allowance(
        address _owner,
        address _spender
    ) external view returns (uint256);

    function transferFrom(address _from, address _to, uint256 _value) external;
}

contract UpgradableUSDTV1 is Initializable, IUpgradableUSDTV1 {
    string public tokenName;
    string public tokenSymbol;
    uint256 public decimalNum;
    uint256 public totalSupplyToken;
    address public owner;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    event Transfer(address _sender, address _receiver, uint256 _numTokens);
    event Approval(address _owner, address _spender, uint256 _value);

    function initialize(uint256 _totalSupplyToken) public initializer {
        owner = msg.sender;
        tokenName = "UpgradableUSDT";
        tokenSymbol = "USDT";
        decimalNum = 18;
        mint(_totalSupplyToken);
    }

    // modifier onlyOwner() {
    //     require(owner == msg.sender, "UpgradableUSDT : only owner can access");
    //     _;
    // }

    function name() external view returns (string memory) {
        return tokenName;
    }

    function symbol() external view returns (string memory) {
        return tokenSymbol;
    }

    function decimals() external view returns (uint256) {
        return decimalNum;
    }

    function totalSupply() external view returns (uint256) {
        return totalSupplyToken;
    }

    function balanceOf(address _owner) external view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _receiver, uint256 _tokensQuantity) external {
        require(_receiver != address(0), "UpgradableUSDT : invalid receiver");
        require(
            _tokensQuantity > 0,
            "UpgradableUSDT: quantity should not zero"
        );
        require(
            balances[msg.sender] >= _tokensQuantity,
            "UpgradableUSDT: insufficient tokens to transfer"
        );
        balances[msg.sender] -= _tokensQuantity;
        balances[_receiver] += _tokensQuantity;
        emit Transfer(msg.sender, _receiver, _tokensQuantity);
    }

    function approve(address _spender, uint256 _tokensQuantity) external {
        require(
            balances[msg.sender] >= _tokensQuantity,
            "UpgradableUSDT: insufficient tokens to approve"
        );
        require(
            _spender != address(0),
            "UpgradableUSDT: spender address can not zero"
        );
        require(
            _tokensQuantity > 0,
            "UpgradableUSDT: quantity should not zero"
        );
        allowed[msg.sender][_spender] += _tokensQuantity;
        emit Approval(msg.sender, _spender, _tokensQuantity);
    }

    function allowance(
        address _owner,
        address _spender
    ) external view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokensQuantity
    ) external {
        require(_from != address(0), "UpgradableUSDT: sender address zero");
        require(_to != address(0), "UpgradableUSDT: receiver address zero");
        require(
            _tokensQuantity != 0,
            "ERUpgradableUSDTC20: quantity to transfer zero"
        );

        require(
            allowed[_from][msg.sender] >= _tokensQuantity,
            "UpgradableUSDT: insufficient allowed tokens"
        );

        balances[_from] -= _tokensQuantity;
        allowed[_from][msg.sender] -= _tokensQuantity;
        balances[_to] += _tokensQuantity;
        emit Transfer(_from, _to, _tokensQuantity);
    }

    function mint(uint256 _tokenQuantity) public {
        require(owner == msg.sender, "UpgradableUSDT : only owner can access");
        require(
            _tokenQuantity > 0,
            "UpgradableUSDT: quantity should something"
        );
        totalSupplyToken += _tokenQuantity;
        balances[owner] += _tokenQuantity;
        emit Transfer(address(0), owner, _tokenQuantity);
    }
}
