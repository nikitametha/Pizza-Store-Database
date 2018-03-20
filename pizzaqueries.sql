/*select all branches having rating less than 7 and display their feedbacks*/ 
SELECT username,feedback_system.description,branch_address,rating
FROM feedback_system,branch 
WHERE rating < 7 AND feedback_system.b_address = branch_address;


/* display all the orders on which a coupon has been applied on and their description */
SELECT order_id,c_id,customer.username,phone_no,coupons.description 
FROM coupons,orders,customer
WHERE c_id  = coupon_id 
AND cust_ph_no = phone_no
GROUP BY(order_id,phone_no,username,coupons.description) 
HAVING (c_id NOTNULL)  ;


/* customers who made more than 1 orders */
SELECT cust_ph_no,username, count(cust_ph_no)
FROM orders , customer
WHERE phone_no = cust_ph_no
GROUP BY (cust_ph_no , username) HAVING count (cust_ph_no) > 1;

/*Shows orders handled by Annie Cooper */
SELECT order_id 
FROM orders, handled_by, employee 
WHERE order_id=o_id 
AND aadhar_number=aadhar_no 
AND name='Annie Cooper';

/* shows the order with min time. */
SELECT order_id,age(out_time,in_time) 
FROM orders 
WHERE age(out_time, in_time)<=ALL
(SELECT age(out_time, in_time)
FROM orders);

/*no of orders handled by each branch*/
SELECT count(*), b_address 
FROM orders 
GROUP BY b_address;

/*orders place by Rebecca Gutierrez */

SELECT * 
FROM orders 
WHERE cust_ph_no 
IN (SELECT phone_no FROM customer WHERE name='Rebecca Gutierrez');


/*Select all non-veg pizzas, which amount to 200 */
SELECT pizza_name 
FROM pizza 
WHERE veg_non_veg='Non-Veg' 
AND price<=200;

/*-----------------------------------------------------------------------------------------------------------------------------*/






