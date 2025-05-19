DELIMITER $$

CREATE PROCEDURE GENERATE_REVENUE_REPORT()
BEGIN
    DECLARE thisLocationID INT;
    DECLARE currentLocationID INT;
    DECLARE locationName VARCHAR(255);
    DECLARE thisCategoryName VARCHAR(255);
    DECLARE thisNoOfCars INT;
    DECLARE thisRevenue DECIMAL(15,2);

    -- Cursor declaration
    DECLARE done BOOLEAN DEFAULT FALSE;

    DECLARE CURSOR_REPORT CURSOR FOR
        SELECT TABLE1.LOCATIONID, TABLE1.CATNAME, TABLE1.NOOFCARS,
            COALESCE(SUM(IFNULL(TABLE2.AMOUNT, 0)), 0) AS REVENUE
        FROM (
            SELECT LC.LID AS LOCATIONID, LC.CNAME AS CATNAME,
                COUNT(C.REGISTRATION_NUMBER) AS NOOFCARS
            FROM (
                SELECT L.LOCATION_ID AS LID, CC.CATEGORY_NAME AS CNAME
                FROM CAR_CATEGORY CC
                CROSS JOIN LOCATION_DETAILS L
            ) LC
            LEFT OUTER JOIN CAR C ON LC.CNAME = C.CAR_CATEGORY_NAME AND LC.LID = C.LOC_ID
            GROUP BY LC.LID, LC.CNAME
            ORDER BY LC.LID
        ) TABLE1
        LEFT OUTER JOIN (
            SELECT BC.PLOC AS PICKLOC, BC.CNAME AS CNAMES,
                SUM(BL.TOTAL_AMOUNT) AS AMOUNT
            FROM (
                SELECT B.PICKUP_LOC AS PLOC, C1.CAR_CATEGORY_NAME AS CNAME, B.BOOKING_ID AS BID
                FROM BOOKING_DETAILS B
                INNER JOIN CAR C1 ON B.REG_NUM = C1.REGISTRATION_NUMBER
            ) BC
            INNER JOIN BILLING_DETAILS BL ON BC.BID = BL.BOOKING_ID
            WHERE (CURDATE() - BL.BILL_DATE) <= 30
            GROUP BY BC.PLOC, BC.CNAME
            ORDER BY BC.PLOC
        ) TABLE2 ON TABLE1.LOCATIONID = TABLE2.PICKLOC AND TABLE1.CATNAME = TABLE2.CNAMES
        GROUP BY TABLE1.LOCATIONID, TABLE1.CATNAME, TABLE1.NOOFCARS
        ORDER BY TABLE1.LOCATIONID;

    -- Procedure body
    SELECT INTO done FALSE;
    OPEN CURSOR_REPORT;
    FETCH CURSOR_REPORT INTO thisLocationID, thisCategoryName, thisNoOfCars, thisRevenue;

    IF done THEN
        SELECT 'No Report to be Generated' AS Output;
    ELSE
        SELECT thisLocationID INTO currentLocationID;
        next_location: LOOP
            SELECT LOCATION_NAME INTO locationName FROM LOCATION_DETAILS WHERE LOCATION_ID = currentLocationID;

            SELECT ' ' AS Output;
            SELECT 'Location Name: ' || locationName AS Output;
            SELECT ' ' AS Output;
            SELECT 'Car Category    Number of Cars    Revenue' AS Output;
            SELECT '------------    --------------    -------' AS Output;
            SELECT CONCAT(
                thisCategoryName,
                RPAD(' ', (16 - LENGTH(thisCategoryName))),
                thisNoOfCars,
                RPAD(' ', (18 - LENGTH(thisNoOfCars))),
                thisRevenue
            ) AS Output;

            fetch_more: LOOP
                FETCH CURSOR_REPORT INTO thisLocationID, thisCategoryName, thisNoOfCars, thisRevenue;
                IF done THEN
                    LEAVE fetch_more;
                END IF;

                IF thisLocationID = currentLocationID THEN
                    SELECT CONCAT(
                        thisCategoryName,
                        RPAD(' ', (16 - LENGTH(thisCategoryName))),
                        thisNoOfCars,
                        RPAD(' ', (18 - LENGTH(thisNoOfCars))),
                        thisRevenue
                    ) AS Output;
                ELSE
                    SELECT ' ' AS Output;
                    SELECT '*****' AS Output;
                    SELECT ' ' AS Output;
                    LEAVE next_location;
                END IF;
            END LOOP;
        END LOOP next_location;
    END IF;

    CLOSE CURSOR_REPORT;
END $$

DELIMITER ;