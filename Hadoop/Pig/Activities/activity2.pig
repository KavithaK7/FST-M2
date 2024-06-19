-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/kavithak/input.txt' AS (line);
-- Tokenize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
cntd = FOREACH grpd GENERATE group, COUNT(words);
rmf hdfs:///user/kavithak/results;
-- Store the result in HDFS
STORE cntd INTO 'hdfs:///user/kavithak/results';