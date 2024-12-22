# [1454. Faol foydalanuvchilar 🔒](https://leetcode.com/problems/active-users)

## Tavsif

<p><strong>Faol foydalanuvchilar</strong> - bu hisoblariga ketma-ket besh yoki undan ko‘p kun davomida kirgan foydalanuvchilardir.</p>

<p>Yechim yozing va <strong>faol foydalanuvchilar</strong>ning <code>id</code> va <code>name</code> ustunlarini toping.</p>

<p>Natijaviy jadvalni <strong>id</strong> bo‘yicha tartiblangan holda qaytaring.</p>

<p>Natijaviy format quyidagi misolda ko‘rsatilgan.</p>

<p>&nbsp;</p>
<p><strong class="example">1-misol:</strong></p>

<pre>
<strong>Kirish:</strong> 
Accounts jadvali:
+----+----------+
| id | name     |
+----+----------+
| 1  | Winston  |
| 7  | Jonathan |
+----+----------+
Logins jadvali:
+----+------------+
| id | login_date |
+----+------------+
| 7  | 2020-05-30 |
| 1  | 2020-05-30 |
| 7  | 2020-05-31 |
| 7  | 2020-06-01 |
| 7  | 2020-06-02 |
| 7  | 2020-06-02 |
| 7  | 2020-06-03 |
| 1  | 2020-06-07 |
| 7  | 2020-06-10 |
+----+------------+
<strong>Chiqish:</strong> 
+----+----------+
| id | name     |
+----+----------+
| 7  | Jonathan |
+----+----------+
<strong>Izoh:</strong> 
ID = 1 bo‘lgan Winston foydalanuvchisi faqat 2 kun kirgan, shuning uchun u faol foydalanuvchi hisoblanmaydi.
ID = 7 bo‘lgan Jonathan foydalanuvchisi esa 7 marta, 6 xil kunlarda kirgan, va ulardan 5 tasi ketma-ket kunlardir (2020-05-30 dan 2020-06-03 gacha). Shu sababli, Jonathan faol foydalanuvchi hisoblanadi.
</pre>

<p>&nbsp;</p>

#### PostgreSQL

```sql
-- Write your PostgreSQL query statement below
WITH cte AS (
SELECT DISTINCT l.id, a.name,l.login_date
FROM logins l
INNER JOIN accounts a ON l.id = a.id
ORDER BY l.id, l.login_date
),


cte2 AS (SELECT
*,
CASE WHEN login_date- LAG(login_date) OVER(PARTITION BY id ORDER BY login_date) =1 THEN 0 ELSE 1 END AS gap
FROM cte),

cte3 AS (SELECT
*,
SUM(gap) OVER(PARTITION BY id ORDER BY login_date) AS group_id
FROM cte2)

SELECT
DISTINCT id, name
FROM cte3
GROUP BY id, name, group_id
HAVING COUNT(*) >= 5
ORDER BY id
```
