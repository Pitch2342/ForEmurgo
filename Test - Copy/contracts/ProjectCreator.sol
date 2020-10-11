pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;
import 'ReputationToken.sol';
contract ProjectCreator{
    
    struct Project{
        string name;
        string description;
        uint limit;
        address admin;
        uint donatedValue;
        uint balance;
        mapping ( uint=> Transaction) transactions;
        uint transactionSize;
    }
    struct Transaction{
        Project p;
        string purpose;
        uint value;
        string proofLink;
        address admin;
        uint index;
        bool verified;
        uint transactionIndex;
    }
    ReputationToken rep;
    constructor() public{
        rep = ReputationToken(0x3E1175C0697169a7e6e4B9B7646679607cceCB06);
    }
     Project p;
     mapping (address => Project[]) public projects;
     mapping(uint256 => Transaction) queue;
     uint256 first = 1;
     uint256 last = 0;
     address[] internal keyList;
     Transaction[] toBeVerified;
    function createProject(string memory _name, string memory _desc, uint _value) public{
        //If reputation is less than one, not allowed to create project
       // Transaction[] memory transactions;
       p = Project({name: _name, description: _desc, limit: _value,admin: msg.sender,donatedValue: 0, balance: _value,transactionSize: 0});
        // p = Project(_name,_desc,_value,msg.sender,0,_value,transactions[-1] = t,0);
        projects[msg.sender].push(p);
        //TODO Remove duplicates
        keyList.push(msg.sender);
    }
    function viewProject(address owner,uint index) public view returns(string memory name, string memory desc,uint value,address admin){
        Project memory pr = projects[owner][index];
        return (pr.name,pr.description,pr.limit,pr.admin);
    }
    function viewProjects(address admin) public view returns (string[] memory names, string[] memory desc, uint[] memory limits,address[] memory owners){
        uint length = projects[admin].length;
        string[] memory n = new string[](length);
        string[] memory d = new string[](length);
        uint[] memory l = new uint[](length);
        address[] memory o = new address[](length);
        for (uint i=0;i<length;i++){
            Project memory pr = projects[admin][i];
            n[i] = pr.name;
            d[i] = pr.description;
            l[i] = pr.limit;
            o[i] = pr.admin;
        }
        return (n,d,l,o);
    }
    function viewAllProjectAdmins() public view returns(address[] memory arrayOfProjectOwners){
        return keyList;
        //Use this list to retreive all the owners and based on that, use the view projects function. 
    }
    
    function submitProof(string memory link, address admin, uint index, uint transactionIndex) public{
        //For what transaction?
        //Add transaction to tobeverified transaction
        projects[admin][index].transactions[transactionIndex].proofLink = link;
        enqueue(projects[admin][index].transactions[transactionIndex]);
    }
    function requestedRandomTransactionFromMod()public returns( string memory purpose,uint value, string memory proofLink,address admin,uint index,bool verified,uint transactionIndex){
        Transaction memory review = dequeue();
        //Return details of this Transaction
        //return review;
        return (review.purpose,review.value,review.proofLink,review.admin,review.index,review.verified,review.transactionIndex);
    }
  
    function enqueue(Transaction memory data) internal {
        last += 1;
        queue[last] = data;
    }
    
    function dequeue() internal returns (Transaction memory data) {
        require(last >= first);  // non-empty queue

        data = queue[first];

        delete queue[first];
        first += 1;
    }
    function withdraw(uint amount, uint index,string memory purpose) public{
        //Withdraw based on reputation
        //Index is the project index list
        
        //TODO Add reputation Logic
        require(projects[msg.sender][index].balance > amount,"Invalid Withdrawal Amount");
        msg.sender.transfer(amount);
        projects[msg.sender][index].balance = projects[msg.sender][index].limit - amount;
        //Add transaction details
        uint transactionSize = projects[msg.sender][index].transactionSize;
        Transaction memory t = Transaction(projects[msg.sender][index],purpose,amount,"",msg.sender,index,false,transactionSize);
        
        projects[msg.sender][index].transactions[transactionSize] = t;
        projects[msg.sender][index].transactionSize++;
        
    }
    function checkLimit(uint donatedAmt, address admin, uint index) public view returns (bool isLimitReached){
        uint currentDonated = projects[admin][index].donatedValue;
        uint limit = projects[admin][index].limit;
        if(currentDonated+ donatedAmt < limit){
            return true;
        }else{
            return false;
        }
        
    }
    function donatedAmount(uint donatedAmt, address admin, uint index) public{
        projects[admin][index].donatedValue = projects[admin][index].donatedValue + donatedAmt;
        projects[admin][index].balance = projects[admin][index].limit - projects[admin][index].donatedValue;
    }
    
    function viewDonatedAmount(address admin, uint index)public view returns(uint value){
        return projects[admin][index].donatedValue;
    }
    function makeTransactionValid(address admin, uint index, uint transactionIndex)public{
        projects[admin][index].transactions[transactionIndex].verified = true;
    }
      function viewAllTransactionsForProject()public{
        //TODO
        
    }
    
}
































