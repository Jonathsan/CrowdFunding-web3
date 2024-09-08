

pragma solidity >=0.8.2 <0.9.0;


contract Will {
    address owner;
    uint fortune;
    bool deceased;
   

    constructor() payable public{
        owner = msg.sender;
        fortune= msg.value;
        deceased= false;
    }

    //The only person who can call the contract is the owner
    modifier onlyOwner{
        require(msg.sender==owner);
        _;

    }
    //Modifier to only allocate the funds if the owner is deceased
    modifier mustBeDeceased{
        require(deceased == true);
        _;
    }

    //list pf family wallets
    address payable [] familywallets;

    //map through inheritance
    mapping(address => uint)inheritance;

    
    //set inheritance for each address

    function setInheritance(address payable  wallet, uint amount) public{
        //to add wallet to family wallets
        familywallets.push(wallet);
        inheritance[wallet] = amount;
    }

    //pay each member based on their wallet address
    function payout() private mustBeDeceased{
        for(uint i=0; i<familywallets.length; i++){
            //transfer funds to receivers address
            familywallets[i].transfer(inheritance[familywallets[i]]);
        }
    }
     //Oracle stimulated switch
    function hasDeceased() public  onlyOwner{
        deceased=true;
        payout();
    }
}