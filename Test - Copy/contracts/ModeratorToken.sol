pragma solidity >=0.4.22 <0.7.0;
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
contract ModeratorToken is ERC20{
    address owner;
    constructor() ERC20("ModeratorToken","MOD") public {
        _mint(msg.sender, 100000 * 10 ** uint(decimals()));
        owner = msg.sender;
        
    }
}