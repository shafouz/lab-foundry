library Lib {
    function destroy() public {
        selfdestruct(payable(msg.sender));
    }
}
