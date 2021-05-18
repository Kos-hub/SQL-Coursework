drop table if exists manifest;
drop table if exists enquiry;
drop table if exists customer;
drop table if exists trip;
drop table if exists cam;
drop table if exists driver;
drop table if exists vehicle;
drop table if exists model;
drop table if exists category;

create table category (
    category varchar(1) primary key,
    description varchar(10) not null,
    requirement varchar(255)
);
create table model(
    model varchar(12) primary key,
    make varchar(10) not null,
    kerb integer,
    gvw integer
);
create table vehicle (
    vehicle_id integer auto_increment primary key,
    registration varchar(10) not null,
    model varchar(12) not null,
    year integer not null,
    body varchar(20),
    foreign key (model) references model(model)
);
create table driver(
    employee_no varchar(7) primary key,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    ni_no varchar(13),
    telephone varchar(20),
    mobile varchar(20),
    hazardous_goods varchar(1) not null
);

create table cam(
	cam_id integer auto_increment primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	hiring_date datetime,
	leaving_date datetime
);

create table trip(
    trip_id integer auto_increment primary key,
    departure_date datetime,
    return_date datetime,
    vehicle_id integer,
    employee_no varchar(7),
	cam_id integer,
    foreign key (vehicle_id) references vehicle(vehicle_id),
    foreign key (employee_no) references driver(employee_no),
	foreign key (cam_id) references cam(cam_id)
);

create table customer(
    reference integer auto_increment primary key,
	cam_id integer,
    company_name varchar(25) not null,
    address varchar(30) not null,
    town varchar(30),
    post_code varchar(10) not null,
    telephone varchar(20) not null,
    contact_fname varchar(25),
    contact_sname varchar(25),
    contact_email varchar(40),
	foreign key (cam_id) references cam(cam_id)
);

create table enquiry(
	enquiry_id integer auto_increment primary key,
	cam_id integer,
	reference integer,
	details varchar(20),
	response varchar(20),
	entry_date datetime,
	response_date datetime,
	status varchar(6),
	foreign key (cam_id) references cam(cam_id),
	foreign key (reference) references customer(reference)
);
create table manifest(
    barcode integer auto_increment primary key,
    trip_id integer not null,
    pickup_customer_ref integer not null,
    delivery_customer_ref integer not null,
    category varchar(1) not null,
    weight integer not null,
    foreign key (trip_id) references trip(trip_id),
    foreign key (pickup_customer_ref) references customer(reference),
    foreign key (delivery_customer_ref) references customer(reference),
    foreign key (category) references category(category)
);

insert into cam values(1, 'John', 'Smith', STR_TO_DATE('02-Jan-12','%d-%b-%Y'), STR_TO_DATE('19-Jan-12','%d-%b-%Y'));
insert into cam values(2, 'Bill', 'Red', STR_TO_DATE('03-Jan-12','%d-%b-%Y'), STR_TO_DATE('26-Jan-12','%d-%b-%Y'));
insert into cam values(3, 'Will', 'White', STR_TO_DATE('05-Jan-12','%d-%b-%Y'), STR_TO_DATE('28-Jan-12','%d-%b-%Y'));

insert into customer values(1, 1, 'Calash Ltd.',  '88 Rinkomania Lane', 'Cardigan', 'SA55 8BA', '01167 1595763', 'Cameron', 'Dunnico', 'c.dunnico@calash.co.uk');
insert into customer values(2, 2, 'Stichomancy & Co',  '17 Suspiration Street', 'Okehampton', 'EX48 4CG', '01450 2312678', 'Henry', 'Petts', 'h.petts@stichomancy.co.uk');
insert into customer values(3, 2, 'Trochiline Services',  '15 Upcast Street', 'Carrbridge', 'PH24 0BF', '01222 9556982', 'Richard', 'Hanford', 'r.hanford@trochiline.co.uk');

insert into enquiry values(1, 1, 1, 'test1', 'response1', STR_TO_DATE('03-Jan-12','%d-%b-%Y'), STR_TO_DATE('20-Jan-12','%d-%b-%Y'), 'Open');
insert into enquiry values(2, 2, 2, 'test2', 'response2', STR_TO_DATE('05-Jan-12','%d-%b-%Y'), STR_TO_DATE('24-Jan-12','%d-%b-%Y'), 'Closed');
insert into enquiry values(3, 2, 2, 'test3', 'response3', STR_TO_DATE('07-Jan-12','%d-%b-%Y'), STR_TO_DATE('26-Jan-12','%d-%b-%Y'), 'Open');

insert into model values('RIEVER', 'ALBION', 7700, 20321);

insert into driver values('0045619', 'Eamon', 'O''Looney', 'JJ 56 53 26 B', '0165 6727840', '07659 9770175', 'N');

insert into vehicle values (1, '4585 AW', 'RIEVER', 1963, '');

insert into trip values(7896, STR_TO_DATE('02-Jan-12', '%d-%b-%Y'), STR_TO_DATE('20-Jan-12','%d-%b-%Y'), 1, '0045619', 1);
