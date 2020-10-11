pragma solidity >=0.4.22 <0.7.0;
import 'ReputationToken.sol';
import 'ModeratorToken.sol';
import 'ProjectCreator.sol';
contract Moderator{
    
    
    ModeratorToken mod;
    ReputationToken rep;
    ProjectCreator project;
      struct Transaction{
        string purpose;
        uint value;
        string proofLink;
        address admin;
        uint index;
        bool verified;
        uint transactionIndex;
    }
    Transaction t;
    constructor() public{
        
        mod = ModeratorToken(0xb7Da98C003a11689f6DCd608c4B4Fa042D5f357c);
        rep = ReputationToken(0x3E1175C0697169a7e6e4B9B7646679607cceCB06);
        //Replace with projectcreator address 
        project = ProjectCreator(0x3E1175C0697169a7e6e4B9B7646679607cceCB06);
        
    }
    function generateRandomTransaction() public{
      (string memory purpose, uint value, string memory proofLink,address admin,uint index,bool verified,uint transactionIndex) = project.requestedRandomTransactionFromMod();
       t.purpose = purpose;
       t.value = value;
       t.proofLink = proofLink;
       t.admin = admin;
       t.index = index;
       t.verified = verified;
       t.transactionIndex = transactionIndex;
    }
    
    function validateTransaction() public{
        //Replace with transaction index
        project.makeTransactionValid(t.admin,t.index,t.transactionIndex);
        //TODO
        //Increase mod tokens and increase reputation tokens for the owner of project
        //emit event

    }
    
    function rejectTransaction() public{
        //emit event
        //TODO
        //Reduce reputation tokens and increase mod tokens
        
        //Do nothing other than emit an event
        
        
        
    }
    
    //Reward mod tokens in both reject and validate functions
    //Reward and reduce reputation token as and when deemed necessary
    
}