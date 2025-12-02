-- 1. Who entered the CEO’s Office close to the time of the murder?
SELECT e.employee_id, e.name, kl.entry_time, kl.exit_time
FROM employees AS e
JOIN keycard_logs AS kl
On e.employee_id = kl.employee_id
WHERE room = 'CEO Office' AND kl.entry_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00';

-- 2. Who claimed to be somewhere else but was not?
SELECT e.name, a.claimed_location AS 'They claim to be here',
kl.room AS 'Actual location', kl.entry_time, kl.exit_time
FROM alibis AS a
JOIN keycard_logs AS kl
ON a.employee_id = kl.employee_id
JOIN employees AS e
ON a.employee_id = e.employee_id
WHERE a.claim_time BETWEEN kl.entry_time AND kl.exit_time
AND a.claimed_location <> kl.room;

-- 3. Who made or received calls around 20:50–21:00?
SELECT c.caller_id, c.receiver_id, e1.name AS 'Caller', 
e2.name AS 'Reciever', c.call_time
FROM calls AS c
JOIN employees AS e1 ON c.caller_id = e1.employee_id
JOIN employees AS e2 ON c.receiver_id = e2.employee_id
WHERE call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00';

-- 4. What evidence was found at the crime scene?
SELECT room, description, found_time
FROM evidence
WHERE room = 'CEO Office';

-- 5. Which suspect’s movements, alibi, and call activity don’t add up?
SELECT name AS killer
FROM employees
WHERE employee_id = 4;

