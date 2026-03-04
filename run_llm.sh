
eval_path='./data/mini_dev_mysql.json'
dev_path='./output/'
db_root_path='./data/dev_databases/'
use_knowledge='True'
mode='mini_dev' 
cot='True'



#YOUR_API_KEY='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'
YOUR_API_KEY=''

engine='gpt-35-turbo'

# Choose the number of threads to run in parallel, 1 for single thread
num_threads=3

# Choose the SQL dialect to run, e.g. SQLite, MySQL
sql_dialect='MySQL'

python3 -u ./src/llm_request.py --db_root_path ${db_root_path} --api_key ${YOUR_API_KEY} --mode ${mode} \
--engine ${engine} --eval_path ${eval_path} --data_output_path ${dev_path} --use_knowledge ${use_knowledge} \
--chain_of_thought ${cot} --num_process ${num_threads} --sql_dialect ${sql_dialect}