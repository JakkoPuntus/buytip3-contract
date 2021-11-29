
pragma ton-solidity >=  0.38.0;
pragma AbiHeader expire;

import "./interfaces/ITONTokenWallet.sol";



contract Exchange {

    uint32 public timestamp;
    TvmCell EMPTY_PAYLOAD;

    constructor() public {

        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();

        timestamp = now;
    }

    
    function touch() external {

        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        timestamp = now;
    }

    function sendValue(address dest, uint128 amount, bool bounce) public view {

        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        dest.transfer({value: amount, flag: 1});
    }


    function transferTokenToRecipient(address from, address dest, uint64 amount) public view { 
        
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        ITONTokenWallet(from).transferToRecipient{ value: 0.5 ton, flag: 1, bounce: true }(
                0x0,
                dest,
                amount,
                0.1 ton,
                0,
                address(this),
                false,
                EMPTY_PAYLOAD
            );
    }

}
