
## Overview 

mini-bird 是一项Text2SQL基准测试，来源于https://bird-bench.github.io，旨在评估LLM在复杂的真实文本转SQL任务查询能力。


## Dataset 
[原始数据集下载](https://drive.google.com/file/d/13VLWIwpw5E3d5DUkMvzw7hvHE67a4XkG/view?usp=sharing)

- mini_dev_mysql.json  包括question 、evidence和真值sql
- mini_dev_mysql_gold.sql 真值sql
- mini_dev_mysql_gold.json  真值数据
- mini_dev_mysql/BIRD_dev.sql  mysql shema以及数据
- dev_databases  数据库以及table 列信息

## Inference:
可以用先进的llm模型进行推理，并保存预测结果，结果存放在`./output/predict_mini_dev_gpt-35-turbo_cot_MySQL.json`中。
```bash
sh run_llm.sh
```
打榜提升
* 数据层  丰富schema 信息，解决列名语义模糊问题
* 检索层  引入rag增强检索schema信息和历史复杂案例，提供少样本
* agent层  react 架构分布推理


## Evaluation:
### Execution (EX) Evaluation:
评估数据包括预测数据和真值数据，分别存放在`./output/predict_mini_dev_gpt-35-turbo_cot_MySQL.json`和`./data/mini_dev_mysql.json`中， 执行结果需严格相等。
```bash
cd ./evaluation/
sh run_evaluation.sh
```

### Reward-based Valid Efficiency Score (R-VES):
基于时间的奖励机制评估，真值sql执行时间/预测sql的执行时间，大于1 表示预测的时间更短，奖励越多。
R-VES评估文件存放在`./evaluation/evaluation_ves.py`中,评估算法重复5次计算VES,报告最高结果。

### Soft F1-Score Evaluation:
软f1-score评估文件存放`./evaluation/evaluation_f1.py`中,基于预测结果和真值数据，计算预测结果和真值的相似度。soft F1-score 是一个更宽松的指标，减少了预测 SQL 查询产生的表中列顺序和缺失值的影响。

## Evaluation Results on Mini Dev Set

### Execution Accuracy (EX)

| Difficulty     | Simple | Moderate | Challenging | Total |
|----------------|--------|----------|-------------|-------|
| Count          | 19     | 17       | 5           | 41    |
| EX (%)         | 57.89  | 52.94    | 20.00       | 51.22 |

### Robust Valid Execution Score (R-VES)

| Difficulty     | Simple | Moderate | Challenging | Total |
|----------------|--------|----------|-------------|-------|
| Count          | 19     | 17       | 5           | 41    |
| R-VES (%)      | 59.76  | 52.85    | 17.32       | 51.72 |