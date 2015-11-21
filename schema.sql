drop database if exists medicInfo;

create database medicInfo;

use medicInfo;

create table county
(
	county_id int not null auto_increment,
    county_name varchar(50),
    primary key (county_id)
);

create table adminstrator
(
	admin_email varchar(100) not null,
    firstname varchar(100),
    lastname varchar(100),
    password varchar(40),
    salt varchar(40)
);

create table public_user
(
    user_id int not null auto_increment,    
	gender char(1) not null default 'M',
    date_of_birth date,
    county_id int,   
    time_added timestamp not null default CURRENT_TIMESTAMP,
    primary key(user_id),
    foreign key(county_id) references county(county_id)
);

create table medic 
(
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

create table category
(
	category_id int not null auto_increment,
	name varchar(30) not null,
	medic_id int,
	description text not null,
	time_added timestamp not null default CURRENT_TIMESTAMP,
	primary key (category_id),
	foreign key (medic_id) references medic (medic_id)
);

create table category_subscription 
(
	subscription_id int not null auto_increment,
	category_id int not null,
	user_id int,
	time_added timestamp not null default CURRENT_TIMESTAMP,
	primary key(subscription_id),
    foreign key(category_id) references category(category_id),
	foreign key(user_id) references public_user(user_id)	
);

create table question 
(
	question_id int not null auto_increment,
	summary varchar (50) not null,
	details text,
	time_added timestamp not null default CURRENT_TIMESTAMP,	
	primary key (question_id)
);

create table question_referral
(
	question_referral_id int not null auto_increment,
    question_id int,
    from_medic_id int,
    to_medic_id int,
    referral_status int(1) not null default 0, #1 for viewd 0 for not viewed.        
    primary key(question_referral_id),
    foreign key(question_id) references question(question_id),
    foreign key(from_medic_id) references medic(medic_id),
    foreign key(to_medic_id) references medic(medic_id)
);

create table user_question
(
	user_question_id int not null auto_increment,
    question_id int,
    user_id int,
	foreign key(question_id) references question(question_id),
	foreign key(user_id) references public_user(user_id),
    primary key(user_question_id)
);


create table question_vote
(
	question_vote_id int not null auto_increment,
    medic_id int,
    vote int not null default 0,
    foreign key(medic_id) references medic (medic_id),
    primary key (question_vote_id)
);

create table advice 
(
	advice_id int not null,
	medic_id int,
	question_id int,
	advice text not null,
	time_added timestamp not null default CURRENT_TIMESTAMP,	
	primary key (advice_id),
	foreign key (medic_id) references medic (medic_id),
	foreign key (question_id) references question (question_id)
);

create table advice_alert
(
	advice_alert_id int not null auto_increment,
    advice_id int,
    alert_message varchar(150),
    alert_period int, #number of days for which the alert should be active
    alert_interval int, #number of hour after which an alert should appear
    primary key(advice_alert_id),
    foreign key(advice_id) references advice(advice_id)    
);


create table advice_helpfulness
(
	advice_helpfulness_id int not null auto_increment,
    advice_id int,
    user_id int, 
    vote int not null default 0,
    primary key(advice_helpfulness_id),    
    foreign key(advice_id) references advice(advice_id),
    foreign key(user_id) references public_user(user_id)
);


create table comment
(
	comment_id int not null auto_increment,
	advice_id int,
	medic_id int ,
	comment text not null,
	time_added timestamp not null default CURRENT_TIMESTAMP,	
	primary key (comment_id),
	foreign key (advice_id) references advice (advice_id),
	foreign key (medic_id) references medic (medic_id)
);

create table comment_vote
(
	comment_vote_id int not null auto_increment,
	comment_id int,
    medic_id int,
    vote int not null default 0, # -1 for a down_vote, 1 for an upvote 0 for default
    primary key (comment_vote_id),
    foreign key (comment_id) references comment (comment_id),
    foreign key (medic_id) references medic (medic_id)
);


create table post
(
	post_id int not null,    
    medic_id int,
    post_title varchar(50),
    summary varchar (50) not null,
	details text,
    time_added timestamp not null default CURRENT_TIMESTAMP,
    primary key(post_id),
    foreign key (medic_id) references medic (medic_id)
);
