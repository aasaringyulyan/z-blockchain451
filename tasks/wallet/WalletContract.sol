pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract WalletContract {
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();
    }

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);

		tvm.accept();
		_;
	}

    // Стандартная отправка.
    function sendTransaction(address dest, uint128 value, bool bounce) 
    public pure checkOwnerAndAccept {
        dest.transfer(value, bounce, 0);
    }

    // Отправить без оплаты комиссии за свой счет.
    function sendWithoutCommissionPayment(address dest, uint128 value) 
    public pure checkOwnerAndAccept {
        dest.transfer(value, true, 0);
    }

    // Отправить с оплатой комисси за свой счет.
    function sendWithCommissionPayment(address dest, uint128 value) 
    public pure checkOwnerAndAccept {
        dest.transfer(value, true, 1);
    }

    // Отправить все деньги и уничтожить кошелек.
    function sendAllMoneyDestroyWallet(address dest) 
    public pure checkOwnerAndAccept {
        dest.transfer(1, true, 160);
    }
}
