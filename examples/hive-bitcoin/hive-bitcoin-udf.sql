-- demonstrate the capabilities of the HadoopCryptoLedger Hive UDF for Bitcoin 

-- assumption is that you have deployed the UDFs: https://github.com/ZuInnoTe/hadoopcryptoledger/wiki/Hive-UDF
-- and created in the database 'blockchains' the table 'BitcoinBlockChain' using the HiveSerde (see also https://github.com/ZuInnoTe/hadoopcryptoledger/blob/master/examples/hive-bitcoin/hive-bitcoin.sql)
-- and made the functions as temporary functions available. if you use permanent functions you need to add the prefix hcl.

-- the following example display all outputs of transactions to determine their destinations (depending on the amount of available Blockchain data this might return a long list!)
SELECT hclBitcoinScriptPattern(expout.txoutscript) FROM (select * from BitcoinBlockchain LATERAL VIEW explode(transactions) exploded_transactions as exptran) transaction_table LATERAL VIEW explode (exptran.listofoutputs) exploded_outputs as expout;


--- the following example displays the transaction hash of a given transaction. You can use the transaction hashes to determine which output has been used as input in another transaction and ultimatively to build a transaction graph to trace the route of bitcoins in the blockchain
SELECT hclBitcoinTransactionHash(transactions[0]) FROM BitcoinBlockChain LIMIT 1;


