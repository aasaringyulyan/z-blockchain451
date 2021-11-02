pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'MilitaryUnit.sol';

contract Warrior is MilitaryUnit {
    uint attackWar;
    uint protectWar;
    address public warriorAddress = this;

    constructor(BaseStation _baseSW, uint _attackWar, uint _protectWar) 
    MilitaryUnit(_baseSW, warriorAddress) public override {
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
}