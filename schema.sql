create database medicAdvise;

use medicAdvise;

create table medics (
medic_id int not null auto_increment,
firstname varchar(150) not null,
lastname varchar(150) not null,
email varchar(150) not null,
phonenumber varchar(30) not null,
id_number varchar(30) not null,
password varchar(40) not null,
salt varchar(9) not null,
approved boolean not null default 0,
time_added timestamp not null default CURRENT_TIMESTAMP,
privilege int not null default 0,
primary key(medic_id)
);

create table categories (
category_id int not null auto_increment,
name varchar(30) not null,
medic_id int not null,
description text not null,
time_added timestamp not null default CURRENT_TIMESTAMP,
primary key (category_id),
foreign key (medic_id) references medics (medic_id)
);

create table category_subscriptions (
subscription_id int not null auto_increment,
category_id int not null,
medic_id int not null,
time_added timestamp not null default CURRENT_TIMESTAMP,
primary key(subscription_id),
foreign key(category_id) references categories(category_id),
foreign key(medic_id) references medics (medic_id)
);

create table questions (
question_id int not null auto_increment,
summary varchar (50) not null,
details text,
time_added timestamp not null default CURRENT_TIMESTAMP,
upvote_count int not null,
primary key (question_id)
);

create table advises (
advise_id int not null,
medic_id int not null,
question_id int not null,
advise text not null,
time_added timestamp not null default CURRENT_TIMESTAMP,
helpful_count int not null,
upvote_count int not null,
primary key (advise_id),
foreign key (medic_id) references medics (medic_id),
foreign key (question_id) references questions (question_id)
);


create table comments (
comment_id int not null auto_increment,
advise_id int not null,
medic_id int not null,
comment text not null,
time_added timestamp not null default CURRENT_TIMESTAMP,
upvote_count int not null,
primary key (comment_id),
foreign key (advise_id) references advises (advise_id),
foreign key (medic_id) references medics (medic_id)
);

