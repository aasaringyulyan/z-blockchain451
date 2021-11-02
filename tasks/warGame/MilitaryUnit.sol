pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'BaseStation.sol';
import 'GameObject.sol';
import 'GameObjectInterface.sol';
import 'MilitartInterface.sol';

contract MilitaryUnit is GameObject, MilitartInterface {
    BaseStation stationAddress; 
    
   constructor(BaseStation _station, address unit) virtual public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();

        _station.addMilitary(unit);
        stationAddress = _station;
    }

    function attack(GameObjectInterface gameObject) external {
        tvm.accept();
       gameObject.acceptAttack(getAttackPower());

    }

    function getAttackPower() virtual public returns(uint) {}

    function getPowerProtection() virtual public override returns(uint) {}

    function processingDeath(address dest) internal override {
        tvm.accept();
        stationAddress.removeMilitary(this); 
        sendAllMoneyDestroyWallet(dest);
    }

    function deathDueToStation(address dest) external override {
        tvm.accept();
        stationAddress.removeMilitary(this);
        sendAllMoneyDestroyWallet(dest);
    }
}
