# ___Домашняя работа №4: CTE, Views___

## ___Контекст задачи 2___

Имеется база данных для недавно созданного загородного клуба. В ней имеется информация о членах этого клуба, объектов для 
отдыха, таких как теннисные корты, и истории бронирования. Помимо прочего, клуб хочет понять, как они могут использовать 
свою информацию для анализа использования/спроса на объекты. __Обратите внимание__: этот набор данных предназначен 
исключительно для интересного набора упражнений, а схема базы данных несовершенна в нескольких аспектах — пожалуйста, не
воспринимайте ее как пример хорошего дизайна.

В БД в схеме `cd` имееются 3 таблицы.  

**Таблица `cd.members`**

```postgresql
CREATE TABLE cd.members(
    memid          INTEGER                NOT NULL,
    surname        CHARACTER VARYING(200) NOT NULL,
    firstname      CHARACTER VARYING(200) NOT NULL,
    address        CHARACTER VARYING(300) NOT NULL,
    zipcode        INTEGER                NOT NULL,
    telephone      CHARACTER VARYING(20)  NOT NULL,
    recommendedby  INTEGER,
    joindate       TIMESTAMP              NOT NULL,
    
    CONSTRAINT members_pk PRIMARY KEY (memid),
    
    CONSTRAINT fk_members_recommendedby FOREIGN KEY (recommendedby)
        REFERENCES cd.members(memid) ON DELETE SET NULL
);
```

У каждого участника есть идентификатор (не обязательно последовательный), основная информация об адресе, ссылка на 
участника, который рекомендовал их (если есть), и отметка времени, когда они присоединились.

**Таблица `cd.facilities`**

```postgresql
CREATE TABLE cd.facilities(
   facid               INTEGER                NOT NULL, 
   name                CHARACTER VARYING(100) NOT NULL, 
   membercost          NUMERIC                NOT NULL, 
   guestcost           NUMERIC                NOT NULL, 
   initialoutlay       NUMERIC                NOT NULL, 
   monthlymaintenance  NUMERIC                NOT NULL, 
   
   CONSTRAINT facilities_pk PRIMARY KEY (facid)
);
```

В таблице перечислены все доступные для бронирования объекты, которыми располагает загородный клуб. Клуб хранит 
информацию об идентификаторе/имени, стоимости бронирования как членов, так и гостей, первоначальную стоимость строительства объекта и предполагаемые ежемесячные расходы на содержание.

**Таблица `cd.bookings`**

```postgresql
CREATE TABLE cd.bookings(
   bookid     INTEGER   NOT NULL, 
   facid      INTEGER   NOT NULL, 
   memid      INTEGER   NOT NULL, 
   starttime  TIMESTAMP NOT NULL,
   slots      INTEGER   NOT NULL,
   
   CONSTRAINT bookings_pk PRIMARY KEY (bookid),
   
   CONSTRAINT fk_bookings_facid FOREIGN KEY (facid) REFERENCES cd.facilities(facid),
   
   CONSTRAINT fk_bookings_memid FOREIGN KEY (memid) REFERENCES cd.members(memid)
);
```

И таблица, отслеживающая бронирование объектов. В нем хранится идентификатор объекта, член, который сделал бронирование,
начало бронирования и количество получасовых «слотов», на которые было сделано бронирование.

---

## ___Контекст задач 3-4___

В PostgreSQL существуют такие вещи как _партиции таблиц_. 
Ознакомиться с тем что это такое и как это употреблять можно [здесь](https://gitlab.atp-fivt.org/courses-public/db2023-supplementary/global/-/tree/main/practice/seminars/11-olap#11-partitioning-%D0%BF%D0%B0%D1%80%D1%82%D0%B8%D1%86%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%D1%81%D0%B5%D0%BA%D1%86%D0%B8%D0%BE%D0%BD%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5). 
Достаточно посмотреть [пункт 1.1.1](https://gitlab.atp-fivt.org/courses-public/db2023-supplementary/global/-/tree/main/practice/seminars/11-olap#111-%D0%BE%D0%B1%D1%89%D0%B8%D0%B5-%D1%81%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D1%8F), но можно и больше :)

---

## ___Контекст задачи 5___

Для администраторов баз данных часто возникает необходимость мониторить потребляемое дисковое пространство, а особо 
отслеживать пользователей, которое злостно "отъедают" память.

---

## ___Task 1___

Посчитать первые 100 чисел Фибоначчи через рекурсивный CTE. 
Индексация начинается с нуля. Ответ упорядочить по колонке с индексом.

### Ожидаемый формат ответа

Ваш запрос должен возвращать таблицу формата:

<div align="center">

| nth | value |
|:---:|:-----:|
|  0  |   1   |
|  1  |   1   |
|  2  |   2   |

</div>

---

## ___Task 2___

Найдите нисходящую цепочку рекомендаций для участника с идентификатором 1: то есть участников, которых учасник с `memid=1` 
рекомендовал, участников, рекомендованных этими участниками, и так далее. Возвращает идентификатор и имя, фамилия участника, 
а также порядок по возрастанию идентификатора участника.

### Ожидаемый формат ответа

Ваш запрос должен возвращать таблицу формата:

<div align="center">

| memid |   firstname   |    surname     |
|:-----:|:-------------:|:--------------:|
|   4   |    Janice     |    Joplette    |
|   5   |    Gerald     |    Butters     |
|  ...  |      ...      |      ...       |

</div>

## ___Task 3___

Создать представление
`v_first_level_partition_info(parent_schema, parent_table, child_schema, child_table)`, 
которая агрегирует информацию о партициях первого уровня (непосредственные партиции). Скрипт создания должен быть нечувствителен к уже объявленным представлениям. 

Для решения вам потребуются системые таблицы: `pg_inherits`, `pg_class`, `pg_namespace`.

**Пример**  

Имея таблицу:
```postgresql
CREATE TABLE people_partitioned (
    person_id       SERIAL,
    first_name      VARCHAR(128)  NOT NULL,
    last_name       VARCHAR(128)  NOT NULL,
    birthday        DATE          NOT NULL
) PARTITION BY RANGE (birthday);


CREATE TABLE people_partitioned_birthdays_1800_to_1850
    PARTITION OF people_partitioned
        FOR VALUES FROM ('1800-01-01') TO ('1849-12-31');

CREATE TABLE people_partitioned_birthdays_1850_to_1900
    PARTITION OF people_partitioned
        FOR VALUES FROM ('1850-01-01') TO ('1899-12-31');

CREATE TABLE people_partitioned_birthdays_1900_to_1950
    PARTITION OF people_partitioned
        FOR VALUES FROM ('1900-01-01') TO ('1949-12-31');

CREATE TABLE people_partitioned_birthdays_1950_to_2000
    PARTITION OF people_partitioned
        FOR VALUES FROM ('1950-01-01') TO ('1999-12-31');

CREATE TABLE people_partitioned_birthdays_2000_to_2050
    PARTITION OF people_partitioned
        FOR VALUES FROM ('2000-01-01') TO ('2049-12-31');
```
Пример запроса к нашему представлению:
```postgresql
SELECT
    child_schema,
    child_table
FROM
    v_first_level_partition_info
WHERE 1=1
    AND parent_schema = 'public'
    AND parent_table = 'people_partitioned'
ORDER BY
    child_schema,
    child_table;
---
 ----------------------------------------------------------
| child_schema |              child_table                  |
|--------------|-------------------------------------------|
|    public    | people_partitioned_birthdays_1800_to_1850 |
|    public    | people_partitioned_birthdays_1850_to_1900 |
|    public    | people_partitioned_birthdays_1900_to_1950 |
|    public    | people_partitioned_birthdays_1950_to_2000 |
|    public    | people_partitioned_birthdays_2000_to_2050 |
 ----------------------------------------------------------
```

### Ожидаемый формат ответа

Выводить ничего не надо. Скрипт с решением должен содержать __только__ объявление представления.

---

## ___Task 4___

Усложним предыдущую задачу и cоздадим представление
`v_rec_level_partition_info(parent_schema, parent_table, child_schema, child_table, part_level)`, 
которая агрегирует информацию о партициях первого уровня (непосредственные партиции), второго уровня (таблица и партиции партиций) и так далее. 
Скрипт создания должен быть нечувствителен к уже объявленным представлениям. Можно создавать вспомогательные представления и CTE.

**Пример**  

```postgresql
CREATE TABLE dt_totals (
    dt_total date NOT NULL,
    geo varchar(2) not null,
    impressions integer DEFAULT 0 NOT NULL,
    sales integer DEFAULT 0 NOT NULL
)
PARTITION BY RANGE (dt_total);

CREATE TABLE dt_totals_201801
    PARTITION OF dt_totals
        FOR VALUES FROM ('2018-01-01') TO ('2018-01-31')
    PARTITION BY LIST (geo);

CREATE TABLE dt_totals_UK_201801 PARTITION OF dt_totals_201801 FOR VALUES IN ('UK');
CREATE TABLE dt_totals_US_201801 PARTITION OF dt_totals_201801 FOR VALUES IN ('US');
CREATE TABLE dt_totals_AU_201801 PARTITION OF dt_totals_201801 FOR VALUES IN ('AU');
```
Пример запроса к нашему представлению:
```postgresql
SELECT
    part_level,
    parent_schema,
    parent_table,
    child_schema,
    child_table
FROM
    v_rec_level_partition_info
ORDER BY
    part_level,
    parent_schema,
    parent_table,
    child_schema,
    child_table;
---
 ------------------------------------------------------------------------------------
| part_level | parent_schema | parent_table    | child_schema |   child_table        |
|------------|---------------|------------------|--------------|---------------------|
|     1      |     public    | dt_totals        |    public    | dt_totals_201801    |
|     1      |     public    | dt_totals_201801 |    public    | dt_totals_au_201801 |
|     1      |     public    | dt_totals_201801 |    public    | dt_totals_uk_201801 |
|     1      |     public    | dt_totals_201801 |    public    | dt_totals_us_201801 |
|     2      |     public    | dt_totals        |    public    | dt_totals_au_201801 |
|     2      |     public    | dt_totals        |    public    | dt_totals_uk_201801 |
|     2      |     public    | dt_totals        |    public    | dt_totals_us_201801 |
 ------------------------------------------------------------------------------------
```

### Ожидаемый формат ответа

Выводить ничего не надо. Скрипт с решением должен содержать __только__ объявление представления.

---

## ___Task 5___

Cоздайте представление
```postgresql
v_used_size_per_user(
    table_owner TEXT, 
    schema_name TEXT, 
    table_name TEXT, 
    table_size TEXT, 
    used_per_schema_user_total_size TEXT, 
    used_user_total_size TEXT
)
```
которая агрегирует информацию о потребляемой памяти по каждому пользователю текущей базы данных.
Подробнее о полях этого представления:
 * `table_owner` - имя пользователя
 * `schema_name` - имя схемы
 * `table_name` - имя таблицы, `table_owner` - владелец этой таблицы
 * `table_size` - размер таблицы (тип поля - `TEXT`, человекочитаемый формат)
 * `used_per_schema_user_total_size` - размер всех таблиц пользователя `table_owner` в схеме `schema_name` (тип поля - `TEXT`, человекочитаемый формат)
 * `used_user_total_size` - размер вообще всех таблиц пользователя `table_owner` в базе данных (тип поля - `TEXT`, человекочитаемый формат)

Скрипт создания должен быть нечувствителен к уже объявленным представлениям. Можно создавать вспомогательные представления и CTE.

Для приведения размера в человекочитаемый вид можно воспользоваться функцией `pg_size_pretty`.

**Пример**  

Пример запроса к нашему представлению:
```postgresql
SELECT
    table_owner,
    table_name,
    table_size,
    schema_name,
    used_per_schema_user_total_size,
    used_user_total_size
FROM
    v_used_size_per_user
ORDER BY
    pg_size_bytes(used_user_total_size) DESC,
    table_owner,
    pg_size_bytes(used_per_schema_user_total_size) DESC,
    schema_name,
    pg_size_bytes(table_size) DESC,
    table_name;

---

 ----------------------------------------------------------------------------------------------------------------
| table_owner | table_name   | table_size | schema_name | used_per_schema_user_total_size | used_user_total_size |
|-------------|--------------|------------|-------------|---------------------------------|----------------------|
|  postgres   | pg_proc      | 768 kB     | pg_catalog  | 2912 kB                         | 3000 kB              |
|  postgres   | pg_attribute | 456 kB     | pg_catalog  | 2912 kB                         | 3000 kB              |
|  ...        | ...          | ...        |    ...      | ...                             | ...                  |
 ----------------------------------------------------------------------------------------------------------------

```

### Ожидаемый формат ответа

Выводить ничего не надо. Скрипт с решением должен содержать __только__ объявление представления.

---