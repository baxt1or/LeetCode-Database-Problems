SELECT
CONCAT(a.topping_name, ',', b.topping_name, ',', c.topping_name) AS pizza,
ROUND( a.cost + b.cost + c.cost, 2) AS total_cost FROM toppings a
INNER JOIN toppings b  ON a.topping_name < b.topping_name
INNER JOIN toppings c ON b.topping_name < c.topping_name 
ORDER BY total_cost DESC, pizza ASC