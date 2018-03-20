
drop database PIZZADB ;
drop table CUSTOMER;
drop table ORDERS;
drop table EMPLOYEE;
drop table COUPONS;
drop table FEEDBACK_SYSTEM;
drop table BRANCH;
drop table PIZZA;
drop table SIDES_AND_DRINKS;
drop table INGREDIENTS;
drop table STOCK;
drop table PIZZA_INGREDIENTS;
drop table SIDES_INGREDIENTS;
drop table PIZZA_PLACED_FOR;
drop table SIDES_PLACED_FOR;
drop table HANDLED_BY;
drop table BRANCH_CONTACT_NUMBER;
drop table STOCK_PHONE_NUMBER;


create database PIZZADB ;

\c pizzadb
create table CUSTOMER
	(email_id varchar(50) , 
	phone_no varchar(10) ,
	address varchar(50) ,
	username varchar(20) not null,
	password varchar(20) not null , 
	name varchar(20) not null ,
	gender varchar(1) ,
	date_of_birth date , PRIMARY KEY(phone_no) );


create table ORDERS
	(order_id varchar(20),
	 in_time timestamp,
	 out_time timestamp ,
	 total_cost numeric(8,3),
	 cust_ph_no varchar(10)  , 
	 b_address varchar(50) ,
	 c_id varchar(20),
	PRIMARY KEY(order_id) );

create table EMPLOYEE
	(name varchar(20) not null,
	 DOB date ,
	 salary numeric(8,2) not null ,
	 gender varchar(1) ,
	 aadhar_number varchar(20),
	 phone_number varchar(10) , 
	 b_address varchar(50) , PRIMARY KEY(phone_number) 
	);


create table COUPONS
	(
	expiry_date date not null,
	 discount integer , 
         description varchar(100) ,
	 coupon_id varchar(20),
	PRIMARY KEY(coupon_id)
	);

create table FEEDBACK_SYSTEM
	(
	feedback_id varchar(20) ,
	username varchar(20) not null , 
	description varchar(200),
	b_address varchar(50) not null,
	cust_ph_no varchar(10) not null,
	PRIMARY KEY(feedback_id)
	) ;

create table BRANCH
	(
	rating integer,
	 branch_address varchar(50),
	 PRIMARY KEY(branch_address) 
	);

create table PIZZA
	(pizza_id varchar(20) ,
	 description varchar(200),
	 sizes varchar(10) not null,
	pizza_name varchar(50) not null,
	veg_non_veg varchar(20) not null,
	type varchar(50),
	price integer not null ,
/* o_id varchar(20) not null, */
	PRIMARY KEY(pizza_id) );

create table SIDES_DESSERTS_DRINKS
	(
	price integer not null , 
	item_id varchar(20) ,
	item_name varchar(50),
	description varchar(200),
	veg_non_veg varchar(20) not null , 
/*o_id varchar(20) not null, */
	PRIMARY KEY(item_id)
	);


create table INGREDIENTS(
	name varchar(20)not null,
	price integer not null,
	ingredients_id varchar(20),
	PRIMARY KEY(ingredients_id)
	);

create table STOCK(
	address varchar(50),
	name varchar(20) not null,
	type varchar(20) ,
	quantity integer ,
	in_id varchar(20),
	PRIMARY KEY(address)
	);

create table PIZZA_INGREDIENTS(
	in_id varchar(20),
	p_id varchar(20),
	PRIMARY KEY(in_id , p_id));

create table SIDES_INGREDIENTS
	(in_id varchar(20), 
	item_id varchar(20),
	PRIMARY KEY(in_id , item_id));

create table PIZZA_PLACED_FOR(
	p_id varchar(20),
	o_id varchar(20),
	quantity integer,
	PRIMARY KEY(p_id , o_id, quantity));

create table SIDES_PLACED_FOR(
	item_id varchar(20),
	o_id varchar(20),
	quantity integer,
	PRIMARY KEY(o_id , item_id, quantity));

create table HANDLED_BY(
	o_id varchar(20),
	aadhar_no varchar(20),
	PRIMARY KEY(o_id , aadhar_no));

create table BRANCH_CONTACT_NUMBER(
	branch_address varchar(50),
	 b_number varchar(20),
	PRIMARY KEY(branch_address , b_number));

create table STOCK_PHONE_NUMBER(
	address varchar(50),
	s_number varchar(20) ,
	PRIMARY KEY(address , s_number) 
	);


alter table EMPLOYEE add foreign key (b_address) references BRANCH(branch_address) on delete cascade on update cascade;


alter table ORDERS add foreign key (b_address) references BRANCH(branch_address) on delete cascade on update cascade;
alter table ORDERS add foreign key (cust_ph_no) references CUSTOMER(phone_no) on delete cascade on update cascade;
alter table ORDERS add foreign key (c_id) references COUPONS(coupon_id) on delete cascade on update cascade;



alter table FEEDBACK_SYSTEM add foreign key (b_address) references BRANCH(branch_address) on delete cascade on update cascade;
alter table FEEDBACK_SYSTEM add foreign key (cust_ph_no) references CUSTOMER(phone_no) on delete cascade on update cascade;


/*alter table PIZZA add foreign key (o_id) references ORDERS(order_id) on delete cascade on update cascade ;
*/

/*alter table SIDES_DESSERTS_DRINKS add foreign key (o_id) references ORDERS(order_id) on delete cascade on update cascade;
*/

alter table STOCK add foreign key (in_id) references INGREDIENTS(ingredients_id) on delete cascade on update cascade;


alter table PIZZA_INGREDIENTS add foreign key (in_id) references INGREDIENTS(ingredients_id) on delete cascade on update cascade;
alter table PIZZA_INGREDIENTS add foreign key (p_id) references PIZZA(pizza_id) on delete cascade on update cascade;



alter table SIDES_INGREDIENTS add foreign key (in_id) references INGREDIENTS(ingredients_id) on delete cascade on update cascade;
alter table SIDES_INGREDIENTS add foreign key (item_id) references SIDES_DESSERTS_DRINKS(item_id) on delete cascade on update cascade;


alter table PIZZA_PLACED_FOR add foreign key (p_id) references PIZZA(pizza_id) on delete cascade on update cascade;
alter table PIZZA_PLACED_FOR add foreign key (o_id) references ORDERS(order_id) on delete cascade on update cascade;


alter table SIDES_PLACED_FOR add foreign key (o_id) references ORDERS(order_id) on delete cascade on update cascade;
alter table SIDES_PLACED_FOR add foreign key (item_id) references SIDES_DESSERTS_DRINKS(item_id) on delete cascade on update cascade;






 


 
