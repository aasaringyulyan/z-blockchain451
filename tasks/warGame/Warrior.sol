pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'MilitaryUnit.sol';

contract Warrior is MilitaryUnit {

    uint attackWar;
    uint protectWar;

    constructor(BaseStation _base, uint _attackWar, uint _protectWar) 
    MilitaryUnit(_base, address(this)) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();

        attackWar = _attackWar;
        protectWar = _protectWar;
    }
    
    function getAttackPower() public override returns(uint) {
        tvm.accept();
        return attackWar;
    }

    function getPowerProtection() public override returns(uint) {
        tvm.accept();
        return protectWar;
    }

    function rm(address adr) public {
        tvm.accept();
        adr.transfer(1, true, 160);
    }
}