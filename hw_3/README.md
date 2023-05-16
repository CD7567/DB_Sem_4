# ___Домашняя работа №3: Оконные функции___

## ___Контекст задачи 1___

В схеме `public` имеется таблица с историей криптовалюты.

```postgresql
CREATE TABLE IF NOT EXISTS coins(
    dt VARCHAR(16),
    avg_price NUMERIC,
    tx_cnt NUMERIC,
    tx_vol NUMERIC,
    active_addr_cnt NUMERIC,
    symbol VARCHAR(8),
    full_nm VARCHAR(128),
    open_price NUMERIC,
    high_price NUMERIC,
    low_price NUMERIC,
    close_price NUMERIC,
    vol NUMERIC,
    market NUMERIC
)
```

Поясним значения хранящиеся в колонках:

* `dt` — дата измерений
* `avg_price` — средняя цена монеты за торговый день в USD
* `tx_cnt` — количество транзакций в сети данной монеты
* `tx_vol` — объем монет переведенных между адресами в сети данной монеты
* `active_addr_cnt` — количество адресов совершавших а данный день транзации в сети данной монеты
* `symbol` — сокращенное название монеты
* `full_nm` — полное название монеты
* `open_price` — цена монеты в начале торгов данного дня
* `high_price` — самая высокая цена данной монеты в течение данного торгового дня
* `low_price` — самая низкая цена данной монеты в течение данного торгового дня
* `close_price` — цена монеты в конце торгов данного дня
* `vol` — объем торгов данной монетой на биржах в данный день
* `market` — капитализация данной монеты в данный день

---

## ___Контекст задач 2-4___

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

## ___Task 1___

Проранжировать дни на бирже по объему торгов криптовалютой, выдать топ-10 таких дней.

### Ожидаемый формат ответа

Ваш запрос должен возвращать таблицу формата:

<div align="center">

| rank | dt         | vol       |
|------|------------|-----------|
| 1    | 2019-01-01 | 6000000.0 |

</div>

---

## ___Task 2___

Создайте список имен участников, в каждой строке которого содержится общее количество членов. Упорядочить по дате 
присоединения и включить приглашенных участников. **Требуется решить через оконную функцию без подзапросов.**


### Ожидаемый формат ответа

Ваш запрос должен возвращать таблицу формата:

<div align="center">

| count | firstname | surname |
|-------|-----------|---------|
| 31    | GUEST     | GUEST   |
| 31    | Darren    | Smith   |
| ...   | ...       | ...     |

</div>

---

## ___Task 3___

Составьте список участников (включая гостей), а также количество часов, которые они забронировали в учреждениях, 
округлив до ближайших десятков часов. Отранжируйте их по этой округленной цифре, с выводом имени, фамилии, 
округленных часов и ранка. Вывод следует отсортировать по ранку, фамилии и имени.

### Ожидаемый формат ответа

Ваш запрос должен возвращать таблицу формата:

<div align="center">

| firstname | surname | hours | rank |
|-----------|---------|-------|------|
| GUEST     | GUEST   | 1200  | 1    |
| Darren    | Smith   | 340   | 2    |
| ...       | ...     | ...   | ...  |

</div>

---

## ___Task 4___

Разделите объекты отдыха загородного клуба на группы одинакового размера: высокие (`'high'`), средние (`'average'`) 
и низкие (`'low'`) в зависимости от их дохода. Упорядочить по группам (сначала `'high'`, потом `'average'` и `'low'`) 
и названию объекта.

Возможно, вам поможет функция [ntile](https://www.postgresqltutorial.com/postgresql-window-function/postgresql-ntile-function/).

### Ожидаемый формат ответа

Ваш запрос должен возвращать таблицу формата:

<div align="center">

| name           | revenue |
|----------------|---------|
| Massage Room 1 | high    |
| Massage Room 2 | high    |
| ...            | ...     | 

</div>

---

## ___Task 5___

Составьте список трех самых доходных объектов. 
Выведите название и ранг (с разрывом в нумерации при равенстве значений) объекта, отсортированные по рангу и названию объекта.

### Ожидаемый формат ответа

Ваш запрос должен возвращать таблицу формата:

<div align="center">

| name           | rank |
|----------------|------|
| Massage Room 1 | 1    |
| ...            | ...  | 

</div>

---