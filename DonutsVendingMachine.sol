// SPDX-License-Identifier: GPL-3.0

//Note always give more ehter than reqied as some gas fee is also required !
pragma solidity >=0.7.0 <0.9.0;

contract VendingMachine
{
    address payable owner;
    mapping(address => uint) public donutBalances;
    

    constructor(uint _vedingBalance){
        owner =  payable(msg.sender);
        donutBalances[address(this)]= _vedingBalance;
    }


   modifier onlyOwner
   {
       require(msg.sender==owner,"only owner can restock");
       _;
   }


    function purchase(uint _noOfItemsBuy) public payable  
    {
       require(msg.value >=_noOfItemsBuy*2 ether,"you must pay 2 ether per donut");
       require(donutBalances[address(this)]>=_noOfItemsBuy , "");
       donutBalances[address(this)] = donutBalances[address(this)] - _noOfItemsBuy; //suntacts the number of donuts associated with the 
       donutBalances[address(msg.sender)] = donutBalances[address(msg.sender)] + _noOfItemsBuy;
       owner.transfer(msg.value);
    }

    function getVedingMachineBalance() public view returns(uint)
    {
        return donutBalances[address(this)];
    }

    function restock (uint _restocksize) public onlyOwner
    {
        donutBalances[address(this)]+=_restocksize;
    }

    function getownermoneyBalance() view external returns(uint)
    {
        return owner.balance;
    }



}