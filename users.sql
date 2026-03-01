SELECT * FROM `shop-project`.users;
truncate table Users; 

create table Items(
id int auto_increment primary key,
name varchar(60) not null,
price varchar(60) not null,
totalNumber varchar(60) not null,
user_name varchar(60) not null,
user_id int not null,

constraint uq_name unique (name),
constraint fk_Items_id foreign key (user_id) references Users(id),
constraint fk_Items_UN foreign key (user_name) references Users(username)
);
truncate table Items;
truncate table Users; 
drop table items;

