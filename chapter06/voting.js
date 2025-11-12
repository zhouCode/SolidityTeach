// --- 1. 你的合约信息 (请填写!) ---

// 粘贴你部署后的合约地址
const contractAddress = "0x56a2777e796eF23399e9E1d791E1A0410a75E31b";

// 粘贴完整 ABI
const contractABI = [
    {
        "inputs": [
            {
                "internalType": "string[]",
                "name": "_candidates",
                "type": "string[]"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "internalType": "address",
                "name": "voter",
                "type": "address"
            },
            {
                "indexed": true,
                "internalType": "uint256",
                "name": "candidate",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "total",
                "type": "uint256"
            }
        ],
        "name": "Voted",
        "type": "event"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "candidates",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "i",
                "type": "uint256"
            }
        ],
        "name": "getCandidate",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "name": "hasVoted",
        "outputs": [
            {
                "internalType": "bool",
                "name": "",
                "type": "bool"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "totalCandidates",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "candidate",
                "type": "uint256"
            }
        ],
        "name": "vote",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "votes",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
];


(async () => {
    try {
        // --- 1. 设置 Web3.js ---
        if (typeof web3 === 'undefined') {
            console.error("Remix 的 'web3' 实例未找到。");
            return;
        }

        // --- 2. 获取账户 ---
        const accounts = await web3.eth.getAccounts();
        if (accounts.length === 0) {
            console.error("在 'ACCOUNT' 下拉菜单中未找到账户。");
            return;
        }
        const voterAddress = accounts[1];
        console.log(`脚本将使用此账户 (Signer): ${voterAddress}`);

        // --- 3. 创建合约实例 ---
        const contract = new web3.eth.Contract(contractABI, contractAddress);
        console.log(`已成功连接到合约: ${contract.options.address}`);


        // --- 4. (函数) 读取数据 ---
        async function checkCandidates() {
            console.log("\n--- 正在读取候选人数据 ---");
            const total = await contract.methods.totalCandidates().call();
            console.log(`候选人总数: ${total.toString()}`);

            for (let i = 0; i < total; i++) {
                const candidateData = await contract.methods.getCandidate(i).call();
                console.log(`  候选人 ${i}: ${candidateData[0]}, 票数: ${candidateData[1].toString()}`);
            }
        }

        // --- 5. (函数) 写入数据 (投票) ---
        async function voteForCandidate(index) {
            console.log(`\n--- 准备为 ${index} 号候选人投票 ---`);

            const hasVoted = await contract.methods.hasVoted(voterAddress).call();
            if (hasVoted) {
                console.log("此账户已经投过票了，跳过。");
                return;
            }

            console.log("正在发送交易 (请在 MetaMask / Remix 中确认)...");
            const receipt = await contract.methods.vote(index).send({ from: voterAddress });

            console.log("✅ 投票成功! 交易已确认。");
            console.log(`   交易哈希: ${receipt.transactionHash}`);

            // 🌟 变化在这里：从交易回执中解析事件 🌟
            // 'receipt.events' 包含了此次交易触发的所有事件
            // 我们要找的是名为 "Voted" 的事件
            if (receipt.events.Voted) {
                const eventData = receipt.events.Voted.returnValues;
                console.log("\n--- 从交易回执中解析到 'Voted' 事件 ---");
                console.log(`   投票人: ${eventData.voter}`);
                console.log(`   候选人ID: ${eventData.candidate.toString()}`);
                console.log(`   该候选人总票数: ${eventData.total.toString()}`);
                console.log("--------------------------------------\n");
            } else {
                console.log("未在交易回执中找到 Voted 事件。");
            }
        }

        // --- 6. (函数) 监听事件 (已移除) ---
        // ( listenToEvents 函数已被移除，因为它导致了错误 )


        // --- 脚本执行 ---

        // 1. 立即检查当前候选人
        await checkCandidates();

        // 2. 尝试为 1 号候选人投票
        await voteForCandidate(1);

        // 3. 再次检查票数 (因为上一步的投票已经完成)
        await checkCandidates();

    } catch (e) {
        console.error("脚本执行出错:", e);
    }

})();