SELECT * FROM `shop-project`.users;
truncate table Users; 

create table Items(
id int auto_increment primary key,
name varchar(60) not null,
price varchar(60) not null,
totalNumber varchar(60) not null,

constraint uq_name unique (name)
);
truncate table Items;
truncate table Users;
drop table items;

alter table items drop constraint uq_name;


alter table Items add column user_id int;
alter table Items add constraint fk_Items foreign key (user_id) references Users(id);

select * from Items order by id; 

