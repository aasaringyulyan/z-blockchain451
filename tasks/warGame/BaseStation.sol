pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObject.sol';

// interface testI {
//     function deathDueToStation(address ad) external;
// }

import 'MilitartInterface.sol';

contract BaseStation is GameObject {
    MilitartInterface[] public unitsAddress;
    uint protect = 5;

    function getPowerProtection() public override returns(uint) {
        tvm.accept();
        return protect;
    }

    function addMilitary(address dest) external  {
        tvm.accept();
        unitsAddress.push(MilitartInterface(dest));
    }

    function removeMilitary(address dest) public {
        tvm.accept();
        for (uint256 i = 0; i < unitsAddress.length; i++) {
            if (unitsAddress[i] == dest) {
                MilitartInterface tmp = unitsAddress[i];
                unitsAddress[i] = unitsAddress[unitsAddress.length - 1];
                unitsAddress[unitsAddress.length - 1] = tmp;
                unitsAddress.pop();
                break;
            }
        }
    }

    function processingDeath(address dest) internal override {
        tvm.accept();
        for (uint256 i = 0; i < unitsAddress.length; i++) {
            unitsAddress[i].deathDueToStation(dest);
        }
        sendAllMoneyDestroyWallet(dest);
    }
}