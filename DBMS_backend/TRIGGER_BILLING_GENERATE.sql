-- Trigger Name: GENERATE_BILLING
-- This trigger generates the bill and inserts a row in Billing_Details table

USE carrentalsystem;
DELIMITER $$

CREATE TRIGGER GENERATE_BILLING
AFTER UPDATE ON BOOKING_DETAILS
FOR EACH ROW
BEGIN
  DECLARE lastBillId VARCHAR(255);
  DECLARE newBillId VARCHAR(255);
  DECLARE discountAmt DECIMAL(10, 2);
  DECLARE totalAmountBeforeDiscount DECIMAL(10, 2);
  DECLARE finalAmount DECIMAL(10, 2);

  -- declaration section
  SELECT BILL_ID INTO lastBillId 
  FROM (SELECT BILL_ID, ROWNUM AS RN FROM BILLING_DETAILS) 
  WHERE RN = (SELECT MAX(ROWNUM) FROM BILLING_DETAILS);

  SET newBillId = CONCAT('BL', CAST(SUBSTRING(lastBillId, 3) AS SIGNED) + 1);

  SET totalAmountBeforeDiscount = NEW.AMOUNT ;

  CALL CALCULATE_DISCOUNT_AMOUNT(NEW.DL_NUM, totalAmountBeforeDiscount, NEW.DISCOUNT_CODE, discountAmt);

  SET finalAmount = totalAmountBeforeDiscount - discountAmt;

  -- insert new bill into the billing_details table
  INSERT INTO BILLING_DETAILS (BILL_ID, BILL_DATE, DISCOUNT_AMOUNT, TOTAL_AMOUNT, BOOKING_ID)
  VALUES (newBillId, SYSDATE(), discountAmt, finalAmount, NEW.BOOKING_ID);
  
END$$

DELIMITER ;