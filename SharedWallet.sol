pragma solidity ^0.8.4;


import "./Allowance.sol";

contract SharedWalletProject is Allowance {
    
    event MoneySent(address indexed _to, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    function WithdrawTo(address payable _to, uint _amount) public ownerOrAllowed(_amount){
      
       require(_amount <= address(this).balance, "Contract doesn't own enough money");
       if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);

    }
    
    
    function ContractBalance() public view returns(uint){
        return address(this).balance;
    }
    receive() external payable{
        emit MoneyReceived(msg.sender,msg.value);
    }
    
    function renounceOwnership() public override onlyOwner {
        revert("can't renounceOwnership here");
    }
    
    
}