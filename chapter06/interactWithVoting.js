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
    // 获取账户
    const accounts = await web3.eth.getAccounts();

    // 创建合约实例
    const contract = new web3.eth.Contract(contractABI, contractAddress);

    // 1. 使用 call() 与合约交互：调用函数
    // const data = await contract.methods.getCandidate(0).call();
    // console.log(data[0]); // "Alice"
    // console.log(data[1]); // 0 (票数)
    // // 也可以指定 'from' 地址，用于模拟特定账户的调用
    // const hasVoted = await contract.methods.hasVoted(voterAddress).call({ from: voterAddress });

    // 2. 使用 send() 与合约交互：发送交易
    // .send() 需要一个配置对象，至少包含 'from'
    // const voterAddress = accounts[6];
    // let receipt = await contract.methods.vote(1).send({ from: voterAddress });
    // console.log(receipt);
    // 你还可以指定 Gas 限制，以防合约出错
    // receipt = await contract.methods.vote(1).send({
    //     from: voterAddress,
    //     gas: 150000 // 手动设置 Gas Limit
    // });
    // console.log(receipt);
    // 如果是 payable 函数，你需要发送 ETH
    // await contract.methods.deposit().send({ from: voterAddress, value: web3.utils.toWei("1", "ether") });

    // 3. 使用 estimateGas() 预估 Gas 费用
    // 语法与 .send() 非常相似
    // try {
    //     const gasAmount = await contract.methods.vote(1).estimateGas({ from: voterAddress });
    //     console.log(`预估 Gas 消耗: ${gasAmount}`);

    //     // 然后你可以在 .send() 中使用这个值
    //     await contract.methods.vote(1).send({
    //         from: voterAddress,
    //         gas: gasAmount
    //     });

    // } catch (error) {
    //     // 如果交易会 revert (例如 "你已经投过票了")
    //     // .estimateGas() 会失败并抛出错误
    //     console.error("预估 Gas 失败 (交易可能会被 Revert):", error.message);
    // }

    // 4. getPastEvents() - (查询历史)
    // 获取从创世区块到最新区块的所有 "Voted" 事件
    // const pastEvents = await contract.getPastEvents('Voted', {
    //     fromBlock: 0,
    //     toBlock: 'latest'
    // });

    // 你也可以过滤 (例如：只看某个特定的人的投票)
    // const specificVotes = await contract.getPastEvents('Voted', {
    //     filter: { voter: '0xSOME_ADDRESS_HERE' }, // 必须是 indexed 字段
    //     fromBlock: 0,
    //     toBlock: 'latest'
    // });

    // pastEvents.forEach(event => {
    //     console.log(event.returnValues);
    // });

    // 5. .events.EVENT_NAME() - (监听未来)
    // (在 Remix 脚本中会失败)
    // contract.events.Voted({ fromBlock: 'latest' })
    //     .on('data', (event) => {
    //         console.log("实时监听到事件:", event.returnValues);
    //     })
    //     .on('error', (error) => {
    //         console.error("订阅出错:", error);
    //     });
})();