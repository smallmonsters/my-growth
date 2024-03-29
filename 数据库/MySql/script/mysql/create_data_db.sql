CREATE DATABASE IF NOT EXISTS test;

USE test;

SET
  NAMES utf8mb4;

SET
  FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS emp;

create table
  emp (
    id int comment '编号',
    workno varchar(10) comment '工号',
    name varchar(10) comment '姓名',
    gender char comment '性别',
    age tinyint unsigned comment '年龄',
    idcard char(18) comment '身份证号',
    workaddress varchar(50) comment '工作地址',
    entrydate date comment '入职时间'
  ) comment '员工表';

INSERT INTO
  emp (
    id,
    workno,
    name,
    gender,
    age,
    idcard,
    workaddress,
    entrydate
  )
VALUES
  (
    1,
    '1001',
    '张三1',
    'M',
    25,
    '110101199001010001',
    '北京市朝阳区',
    '2022-01-01'
  ),
  (
    2,
    '1002',
    '李四',
    'F',
    28,
    '110101199001010002',
    '北京市海淀区',
    '2021-06-15'
  ),
  (
    3,
    '1003',
    '王五',
    'M',
    30,
    '110101199001010003',
    '北京市东城区',
    '2020-03-10'
  ),
  (
    4,
    '1004',
    '赵六',
    'M',
    35,
    '110101199001010004',
    '北京市西城区',
    '2019-09-20'
  ),
  (
    5,
    '1005',
    '陈七',
    'F',
    22,
    '110101199001010005',
    '北京市丰台区',
    '2023-02-28'
  ),
  (
    6,
    '1006',
    '刘八',
    'M',
    29,
    '110101199001010006',
    '北京市石景山区',
    '2022-11-11'
  ),
  (
    7,
    '1007',
    '孙九',
    'M',
    27,
    '110101199001010007',
    '北京市昌平区',
    '2024-07-10'
  ),
  (
    8,
    '1008',
    '周十',
    'F',
    24,
    '110101199001010008',
    '北京市通州区',
    '2023-09-05'
  ),
  (
    9,
    '1009',
    '吴十一',
    'M',
    26,
    '110101199001010009',
    '北京市顺义区',
    '2022-08-15'
  ),
  (
    10,
    '1010',
    '郑十二',
    'F',
    31,
    '110101199001010010',
    '北京市大兴区',
    '2021-04-25'
  ),
  (
    11,
    '1011',
    '钱十三',
    'M',
    33,
    '110101199001010011',
    '北京市房山区',
    '2020-12-03'
  ),
  (
    12,
    '1012',
    '马十四',
    'F',
    23,
    '110101199001010012',
    '北京市怀柔区',
    '2019-07-18'
  ),
  (
    13,
    '1013',
    '朱十五',
    'M',
    30,
    '110101199001010013',
    '北京市门头沟区',
    '2025-01-30'
  ),
  (
    14,
    '1014',
    '胡十六',
    'M',
    27,
    '110101199001010014',
    '北京市平谷区',
    '2024-03-20'
  ),
  (
    15,
    '1015',
    '冯十七',
    'F',
    29,
    '110101199001010015',
    '北京市密云区',
    '2023-10-12'
  ),
  (
    16,
    '1016',
    '陶十八',
    'M',
    32,
    '110101199001010016',
    '北京市延庆区',
    '2022-12-05'
  ),
  (
    17,
    '1017',
    '蒋十九',
    'F',
    26,
    '110101199001010017',
    '北京市燕郊区',
    '2021-08-25'
  ),
  (
    18,
    '1018',
    '杨二十',
    'M',
    28,
    '110101199001010018',
    '北京市霸州市',
    '2020-10-15'
  ),
  (
    19,
    '1019',
    '梁二十一',
    'F',
    25,
    '110101199001010019',
    '北京市三河市',
    '2019-11-30'
  ),
  (
    20,
    '1020',
    '韩二十二',
    'M',
    27,
    '110101199001010020',
    '北京市大厂县',
    '2018-05-08'
  );