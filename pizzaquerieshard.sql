/*(SELECT aadhar_number FROM EMPLOYEE WHERE b_address IN ( SELECT branch_address FROM branch WHERE rating=9)); */

/* Increase salary of employees who have handled 2 or more orders, and also those in branches with highest rating as a bonus */
UPDATE employee SET salary=1.1*salary WHERE aadhar_number IN (( SELECT aadhar_no FROM handled_by GROUP BY aadhar_no HAVING count(*)>=2) UNION (SELECT aadhar_number FROM EMPLOYEE WHERE b_address IN ( SELECT branch_address FROM branch WHERE rating>=ALL(SELECT rating FROM branch))));

/* show all party orders*/
CREATE VIEW party_orders AS SELECT phone_no, name, order_id, pizza_name, quantity FROM customer,pizza, orders, pizza_placed_for WHERE o_id=order_id and cust_ph_no=phone_no and p_id=pizza_id and quantity>1 ORDER BY pizza_name;


/*employee handling most orders */

select handled_by.aadhar_no ,employee.name ,count ( handled_by.aadhar_no ),employee.b_address
from handled_by 
inner join employee
on employee.aadhar_number = handled_by.aadhar_no 
group by (handled_by.aadhar_no , employee.name,employee.b_address )
having count(handled_by.aadhar_no ) >=ALL 
(select count(handled_by.aadhar_no ) from handled_by group by(handled_by.aadhar_no) );  


/*
select handled_by.aadhar_no ,o_id 
from handled_by 
left join orders
on o_id = order_id
group by (handled_by .aadhar_no , o_id);
*/

/*select the pizza's using most ingredients */
select p_id , pizza_name , count(in_id)
from pizza_ingredients 
inner join pizza 
on pizza_id = p_id 
group by (p_id, pizza_name )
having count(p_id) >=ALL (select count(pizza_ingredients.p_id) from pizza_ingredients group by(pizza_ingredients.p_id));

/* select sides using most ingredients */
/*select sides_ingredients.item_id , item_name , count(in_id)
from sides_ingredients 
inner join sides_desserts_drinks
on sides_desserts_drinks.item_id = sides_ingredients.item_id
group by (sides_ingredients.item_id , item_name)
having count(sides_ingredients.item_id ) >=ALL(select count(sides_ingredients.item_id)from sides_ingredients group by (sides_ingredients.item_id));
*/


/*select the most ordered pizza's */
select pizza_id , pizza_name , count(pizza_id)
from pizza
inner join pizza_placed_for 
on pizza_id = p_id 
group by (pizza_id , pizza_name)
having count ( pizza_id )>ALL(select count(pizza_id) from pizza group by (pizza_id));

/*select the most ordered sides */
/*select sides_desserts_drinks.item_id , sides_desserts_drinks.item_name , count(sides_desserts_drinks.item_id)
from sides_desserts_drinks
inner join sides_placed_for 
on sides_placed_for.item_id = sides_desserts_drinks.item_id 
group by (sides_desserts_drinks.item_id , sides_desserts_drinks.item_name)
having count ( sides_desserts_drinks.item_id )>ALL(select count(sides_desserts_drinks.item_id) from sides_desserts_drinks group by (sides_desserts_drinks.item_id));
*/


/* change stock quantity when a pizza or side is ordered */
UPDATE STOCK SET  quantity = quantity-5
where quantity >0 and in_id in ( select ingredients_id from ingredients where ingredients_id in(select pizza_ingredients.in_id from pizza_ingredients where p_id in(select pizza_placed_for.p_id from pizza_placed_for)));

UPDATE STOCK SET  quantity = quantity-5
where quantity >0 and in_id in ( select ingredients_id from ingredients where ingredients_id in(select sides_ingredients.in_id from sides_ingredients where item_id in(select sides_placed_for.item_id from sides_placed_for)));

UPDATE STOCK SET quantity = 0
where quantity = 1000;



/* no of ingredients used in pizza*/
SELECT p.pizza_name, count(*)ingredients_id
FROM PIZZA as p, INGREDIENTS, PIZZA_INGREDIENTS as pi
WHERE p.pizza_id=pi.p_id and pi.in_id= ingredients_id
GROUP BY pizza_id;




/*decrease price of pizza by 25% of intial cost if it has not appeared in orders */
SELECT pizza_name, (price-0.25*price) as new_price 
FROM PIZZA 
WHERE NOT EXISTS(
SELECT * FROM PIZZA_PLACED_FOR WHERE p_id=pizza_id) ;





 
