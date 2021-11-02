pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObjectInterface.sol';

contract GameObject is GameObjectInterface {
    uint public health = 10; // скрыть
    address sender;
    
    function getPowerProtection() virtual public returns(uint) {}

    // скрыть от пользователя internal
    function acceptAttack(uint attack) external override {
        if (attack > getPowerProtection()) {
            attack -= getPowerProtection();
            
            if (attack >= health) {
                health = 0;
            } else {
                health -= attack;
            }

            sender = msg.sender;

            if (isDied(health)) {
                processingDeath(sender);
            }
        }
    }

    function isDied(uint value) private returns (bool) {
        if (value == 0) {
            return true;
        }

        return false;
    }

    function processingDeath(address dest) virtual internal {
        // sendAllMoneyDestroyWallet(dest);
    }

    function sendAllMoneyDestroyWallet(address dest) internal {
        dest.transfer(1, true, 160);
    }
}
