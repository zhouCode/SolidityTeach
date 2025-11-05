// rpc_call_demo.js
(async () => {
    
    // --- 准备工作 ---
    const accounts = await web3.eth.getAccounts();
    const myAddress = accounts[0];
    console.log("将要查询此账户的余额:", myAddress);

    // --- 1. 高级封装方式 (Web3.js) ---
    // (这是我们一直在用的方式)
    console.log("\n--- 1. Web3.js 封装调用 ---");
    const balance = await web3.eth.getBalance(myAddress);
    console.log("Web3.js 结果:", web3.utils.fromWei(balance, "ether"), "ETH");


    // --- 2. 原始 JSON-RPC 方式 (在 JS 中) ---
    // (这才是本节课的重点)
    console.log("\n--- 2. 原始 JSON-RPC 调用 ---");

    // [对应 "curl --data" 里的 JSON, ]
    const rpcPayload = {
        jsonrpc: "2.0",
        method: "eth_getBalance", // 
        params: [myAddress, "latest"], // 
        id: 12345 // 随机选一个 ID
    };

    console.log("正在发送 RPC Payload:", rpcPayload);

    // web3.currentProvider.send 是 Remix 脚本中发送原始 RPC 的方式
    web3.currentProvider.send(rpcPayload, (err, res) => {
        if (err) {
            console.error("RPC 错误:", err);
            return;
        }
        
        console.log("收到 RPC 响应:", res);
        
        // res.result 是十六进制的 Wei
        const balanceHex = res.result; 
        console.log("RPC 结果 (十六进制Wei):", balanceHex);
        console.log("RPC 结果 (ETH):", web3.utils.fromWei(balanceHex, "ether"), "ETH");
    });

})();