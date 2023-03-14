create database if not exists esnackshop;

use esnackshop;

drop table if exists user;

create table user(
	id int NOT NULL AUTO_INCREMENT, 
	username varchar(50), 
	password varchar(50), 
	email varchar(50),
	number int, 
	PRIMARY KEY (id)
);

drop table if exists snacks;

create table snacks(
	item_id varchar(50) NOT NULL AUTO_INCREMENT, 
	item_name varchar(50), 
	price float, 
	stock int, 
	PRIMARY KEY(item_id)
);

insert into snacks (item_name,price,stock) values ('Ferrero Rocher',13.00,29);
insert into snacks (item_name,price,stock) values ('Pringles Potato Crisps - Original',3.20,26);
insert into snacks (item_name,price,stock) values ('Doritos - Nacho Cheese',5.30,82);
insert into snacks (item_name,price,stock) values ('Oreos Original Biscuit',2.81,80);
insert into snacks (item_name,price,stock) values ('Reese Peanut Butter Cups',19.95,72);
insert into snacks (item_name,price,stock) values ('Goldfish Snack',4.51,35);
insert into snacks (item_name,price,stock) values ('Cheetos - Cheese Flavoured',5.80,41);
insert into snacks (item_name,price,stock) values ('M&Ms',6.25,50);
insert into snacks (item_name,price,stock) values ('Cheez-Its',4.74,115);
insert into snacks (item_name,price,stock) values ('Gummy Bears',1.57,105);

insert into snacks (item_name,price,stock) values ('Fritos Original Corn Chips',1.00,193);
insert into snacks (item_name,price,stock) values ('Kit Kat',6.56,117);
insert into snacks (item_name,price,stock) values ('Lays Potato Chips - Truffle',5.50,116);
insert into snacks (item_name,price,stock) values ('Twix Milk Chocolate Cookie Bars',4.00,180);
insert into snacks (item_name,price,stock) values ('Starburst',2.98,135);
insert into snacks (item_name,price,stock) values ('Skittles Candies - Original',4.64,16);
insert into snacks (item_name,price,stock) values ('Snickers Chocolate Bar',1.62,81);
insert into snacks (item_name,price,stock) values ('Chex Mix',7.99,10);
insert into snacks (item_name,price,stock) values ('Chocolate-Covered Pretzels',3.53,48);
insert into snacks (item_name,price,stock) values ('Ruffles - Sour Cream and Onion',5.30,162);

insert into snacks (item_name,price,stock) values ('Butterfinger',56.00,159);
insert into snacks (item_name,price,stock) values ('Hershey’s Kisses',6.56,27);
insert into snacks (item_name,price,stock) values ('Nestle Crunch',7.97,54);
insert into snacks (item_name,price,stock) values ('Animal crackers',4.95,47);
insert into snacks (item_name,price,stock) values ('Milky Way',35.64,193);
insert into snacks (item_name,price,stock) values ('Glico Pocky Biscuit Sticks - Chocolate',1.41,176);
insert into snacks (item_name,price,stock) values ('Brownie Bites',2.00,107);
insert into snacks (item_name,price,stock) values ('Kettle - Potato Chips Sea Salt',5.65,120);
insert into snacks (item_name,price,stock) values ('Nico Nico - Yaki Roasted Seaweed',4.35,55);
insert into snacks (item_name,price,stock) values ('Sunmaid Raisins',4.20,92);

insert into snacks (item_name,price,stock) values ('Marigold Fruit Jelly',1.90,59);
insert into snacks (item_name,price,stock) values ('Yan Yan Chocolate Vanilla Dips Biscuit',1.40,46);
insert into snacks (item_name,price,stock) values ('Potato Crisps Sour Cream & Onion',3.25,23);
insert into snacks (item_name,price,stock) values ('Roasted Pistachios',1.35,186);
insert into snacks (item_name,price,stock) values ('Calbee Prawn Crackers - Original',2.40,66);
insert into snacks (item_name,price,stock) values ('Thumbs Groundnut',1.95,4);
insert into snacks (item_name,price,stock) values ('Mamee Noodle Snack',2.80,56);
insert into snacks (item_name,price,stock) values ('Twisties - Cheddar Cheese',3.05,86);
insert into snacks (item_name,price,stock) values ('Bin Bin Spicy Seaweed Rice Cracker',3.00,25);
insert into snacks (item_name,price,stock) values ('Smith Barbeque Chips',3.55,164);

insert into snacks (item_name,price,stock) values ('Calbee Jagabee Seaweed Pouch',4.75,19);
insert into snacks (item_name,price,stock) values ('Natural Baked Cashew Nuts',12.00,149);
insert into snacks (item_name,price,stock) values ('Macademia Nut',3.70,50);
insert into snacks (item_name,price,stock) values ('Mala Potato Chips',7.75,89);
insert into snacks (item_name,price,stock) values ('Seedless Dried Plum',1.45,121);
insert into snacks (item_name,price,stock) values ('Dried Mangoes',4.00,73);
insert into snacks (item_name,price,stock) values ('Potato Crackers Vegetables Flavour',2.30,142);
insert into snacks (item_name,price,stock) values ('Cod Fish',3.20,68);
insert into snacks (item_name,price,stock) values ('Salted Egg Fish Skin',18.55,161);
insert into snacks (item_name,price,stock) values ('Hello Panda Chocolate',7.95,104);


drop table if exists cart;

create table cart(
	user_id int REFERENCES user(id), 
	snack_id int REFERENCES snacks(item_id),
	quantity int
);

drop table if exists log;

create table log(
	value int auto_increment,
	userid varchar(50) REFERENCES user(id),
	status varchar(50),
	PRIMARY KEY(value)
);

drop table if exists orders;

create table orders(
	user_id int REFERENCES user(id),
	item_id int REFERENCES snacks(item_id),
	qty int, 
	ordered_date varchar(100)
);
