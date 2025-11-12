// 文件名 sample6-01.js
(async () => {
    console.log("--- Web3.js 演示 ---");
    try {
        console.log("Remix 自动注入的 Web3 版本 (web3.version):", web3.version);
        
        // 书中的 web3.version.node 已过时
        // 现代 web3.js (v1.x) 中获取节点信息的方式：
        const nodeInfo = await web3.eth.getNodeInfo();
        console.log("节点信息 (web3.eth.getNodeInfo):", nodeInfo);

        const version = await web3.eth.getProtocolVersion();
        console.log("Protocol Version (web3.eth.getProtocolVersion):", version);
    
    } catch (e) {
        console.error("Web3.js 部分出错:", e);
    }

    console.log("\n" + "---".repeat(10) + "\n"); // 分隔符

    console.log("--- Ethers.js (v5) 演示 ---");
    try {
        // Ethers v5 (Remix) 必须手动创建 Provider
        // 我们利用 web3 已经连接好的 currentProvider
        const provider = new ethers.providers.Web3Provider(web3.currentProvider);
        
        console.log("Ethers.js 版本 (ethers.version):", ethers.version);

        // Ethers.js 的 "getNetwork" 是更常见的操作
        // 它获取的是链ID和名称，而不是节点客户端版本
        const network = await provider.getNetwork();
        console.log("网络信息 (provider.getNetwork):", network);
        
        // Ethers.js 没有 getProtocolVersion() 或 getNodeInfo() 的高级 API
        // 但我们可以用 provider.send() 来直接调用底层的 JSON-RPC
        
        // 对应 web3.eth.getProtocolVersion()
        const protocolVersionEthers = await provider.send("eth_protocolVersion", []);
        console.log("Protocol Version (provider.send):", protocolVersionEthers);

        // 对应 web3.eth.getNodeInfo()
        const nodeInfoEthers = await provider.send("web3_clientVersion", []);
        console.log("节点信息 (provider.send):", nodeInfoEthers);

    } catch (e) {
        console.error("Ethers.js 部分出错:", e);
    }

})();