pragma solidity ^0.6.2;
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
contract ReputationToken is ERC20{
    address owner;
    constructor() ERC20("Reputation","RP") public {
        _mint(msg.sender, 100000 * 10 ** uint(decimals()));
        owner = msg.sender;
        
    }
    
}