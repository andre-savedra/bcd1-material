create database emailServer;
use emailServer;


create table users (
	id bigint not null auto_increment,
    name varchar(150) not null,
    emailAddress varchar(100) not null,
    primary key(id)
);

create table email (
	id bigint not null auto_increment,
    subject varchar(150) not null,
    body varchar(5000),
    sentDate datetime not null default now(),
    status enum ('Draft', 'Sending', 'Sent') not null,
    userFK bigint not null,
    primary key(id),
    foreign key(userFK) references users(id)    
);

create table attachment(
	id bigint not null auto_increment,
    emailFK bigint not null,
    link varchar(1000) not null,
    fileName varchar(200) not null,
    size long not null,
    primary key(id),
    foreign key(emailFK) references email(id)
);

create table users_destination(
	id bigint not null auto_increment,
    emailFK bigint not null,
    userFK bigint not null,
    primary key(id),
    foreign key(emailFK) references email(id),
    foreign key(userFK) references users(id)
);






