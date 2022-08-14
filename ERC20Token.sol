// SPDX-License-Identifier: Unlincened

pragma solidity ^0.8.7;

    abstract contract ERC20Token {
        function name() public virtual view returns (string memory);
        function symbol() public virtual view returns (string memory);
        function decimals() public virtual view returns (uint8);
        function totalSupply() public virtual view returns (uint256);
        function balanceOf(address _owner) public virtual view returns (uint256 balance);
        function transfer(address _to, uint256 _value) public virtual returns (bool success);
        function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
        function approve(address _spender, uint256 _value) public virtual returns (bool success);
        function allowance(address _owner, address _spender) public virtual returns (uint256 remaining);

        event Transfer(address indexed _from, address indexed _to, uint256 _value);
        event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    }

    contract Owned {
        address public owner;

        constructor (){
            owner = msg.sender;
        }
    }

    contract Token is ERC20Token, Owned {
        string _symbol;     
        string _name;   
        uint8 _decimal;
        uint _totalSupply;
        address _minter;

        mapping (address => uint) balances;

        constructor (){
            _symbol = "Tks";
            _name = "SP";
            _decimal = 0;
            _totalSupply = 100;
            _minter = 0x9AC985886D8cf3b9AA1605eb7c83B0BBE26e8F28;


            balances[_minter] = _totalSupply;  //initializing totalSupply to one address
            emit Transfer(address(0),_minter,_totalSupply);
        }

        function name() public override view returns (string memory){
            return _name;
        }
        function symbol() public override view returns (string memory){
            return _symbol;
        }
        function decimals() public override view returns (uint8){
            return _decimal;
        }
        function totalSupply() public override view returns (uint256){
            return _totalSupply;
        }
        function balanceOf(address _owner) public  override view returns (uint256 balance){
            return balances[owner];
        }
        function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
            require(balances[_from] >= _value);  // 10 token as value then i should have atleast more then i sending.
            balances[_from] -= _value; //
            balances[_to] += _value;  //
            emit Transfer(_from,_to,_value);
            return true;
        }

        function transfer(address _to, uint256 _value) public override returns (bool success){
            return transferFrom(msg.sender,_to,_value);
        }
        function approve(address _spender, uint256 _value)override public returns (bool success){
            return true;
        }
        function allowance(address _owner, address _spender)override public returns (uint256 remaining){
            return 0;
        }


    }
