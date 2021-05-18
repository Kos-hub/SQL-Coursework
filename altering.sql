CREATE TABLE cam(
	cam_id integer auto_increment primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	hiring_date datetime,
	leaving_date datetime
);

ALTER TABLE trip
ADD cam_id integer,
ADD FOREIGN KEY (cam_id) REFERENCES cam(cam_id);

ALTER TABLE customer
ADD cam_id integer,
ADD FOREIGN KEY (cam_id) REFERENCES cam(cam_id);

CREATE TABLE enquiry(
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

--Adding entries
insert into cam values(1, 'John', 'Smith', STR_TO_DATE('02-Jan-12','%d-%b-%Y'), STR_TO_DATE('19-Jan-12','%d-%b-%Y'));
insert into cam values(2, 'Bill', 'Red', STR_TO_DATE('03-Jan-12','%d-%b-%Y'), STR_TO_DATE('26-Jan-12','%d-%b-%Y'));
insert into cam values(3, 'Will', 'White', STR_TO_DATE('05-Jan-12','%d-%b-%Y'), STR_TO_DATE('28-Jan-12','%d-%b-%Y'));

UPDATE customer
SET cam_id = 1
WHERE reference = 1; 

UPDATE customer 
SET cam_id = 2
WHERE reference = 2;

UPDATE customer
SET cam_id = 2
WHERE reference = 3;

UPDATE trip
SET cam_id = 1
WHERE trip_id = 73894;

insert into enquiry values(1, 1, 1, 'test1', 'response1', STR_TO_DATE('03-Jan-12','%d-%b-%Y'), STR_TO_DATE('20-Jan-12','%d-%b-%Y'), 'Open');
insert into enquiry values(2, 2, 2, 'test2', 'response2', STR_TO_DATE('05-Jan-12','%d-%b-%Y'), STR_TO_DATE('24-Jan-12','%d-%b-%Y'), 'Closed');
insert into enquiry values(3, 2, 2, 'test3', 'response3', STR_TO_DATE('07-Jan-12','%d-%b-%Y'), STR_TO_DATE('26-Jan-12','%d-%b-%Y'), 'Open');
