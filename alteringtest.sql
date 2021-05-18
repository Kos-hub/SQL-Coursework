--Only drivers are currently recorded – a new staff role of customer account manager (CAM) is needed
SELECT *
FROM cam;

--Every customer must be assigned a CAM, and one CAM can serve several customers
--It must be possible to identify a customer’s current CAM
SELECT reference, company_name, customer.cam_id, first_name, last_name
FROM customer
JOIN cam ON (customer.cam_id = cam.cam_id)
WHERE customer.cam_id IS NOT NULL;

--CAMs may change over time – it must be possible to find out who was the CAM at the time of any trip, even if that person has subsequently left the company
SELECT trip_id, first_name, last_name, leaving_date
FROM trip
JOIN cam ON (trip.cam_id = cam.cam_id)
WHERE trip.cam_id IS NOT NULL;

--The details of any initial customer enquiry must be recorded
SELECT customer.reference, company_name, enquiry_id, details
FROM customer
JOIN enquiry ON (customer.reference = enquiry.reference)
WHERE customer.cam_id IS NOT NULL;

--The CAM’s response must be recorded (potentially at a later date than the original query)
SELECT cam.cam_id, first_name, last_name, response
FROM cam
JOIN enquiry ON (cam.cam_id = enquiry.cam_id);

--Queries must be marked as closed when no further action is required
SELECT *
FROM enquiry;