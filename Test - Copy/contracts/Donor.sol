pragma solidity >=0.4.22 <=0.7.0;
import 'ReputationToken.sol';
import 'ProjectCreator.sol';
contract DonorContract{
    
    address payable public  donor;
    ProjectCreator p;
    address payable projectCreatorAdd;
    constructor() public{
        //TODO Replace with Project Creator address 
        projectCreatorAdd = msg.sender;
        p = ProjectCreator(projectCreatorAdd);
    }
    event DonatedMoney(address donor, uint amount,string message,address projectAdmin, uint index);
    
    //  function donateMoney (uint remaining, address payable projectContract, uint value, string memory message,address ngo) public payable{
    //      //Here remaining denotes amount remaining to donate
    //     require(ngo != donor,"Error!");
    //     require(value <= remaining,"Value exceeding project campaign!");
    //     require(value <= donor.balance,"Value more than balance");
    //     //Send the value to the Project contract
    //     projectContract.transfer(value);
    //     emit DonatedMoney(donor,value,message,ngo);
    // } 
    
    function donate(uint donation, address admin, uint index,string memory message)public payable{
        donor = msg.sender;
        //Call function in ProjectCreator to update values
        if(p.checkLimit(donation,admin,index) == true){
            //Message saying not possible to donate since limit has been crossed/ Invalid amount
        }else{
            projectCreatorAdd.transfer(donation);
            p.donatedAmount(donation,admin,index);
            //Emit event after this
            emit DonatedMoney(donor,donation,message,admin,index);
            //Access transaction using web3.js
        }
        
    }
    
    //For retreiving the donations, use the emit in Web3.js to get everything.
    
}