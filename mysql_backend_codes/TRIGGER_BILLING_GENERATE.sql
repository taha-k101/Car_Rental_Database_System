-- Trigger Name: GENERATE_BILLING
-- This trigger generates the bill and inserts a row in Billing_Details table

USE carRentalSystem;
DELIMITER $$

CREATE TRIGGER GENERATE_BILLING
AFTER UPDATE ON BOOKING_DETAILS
FOR EACH ROW
BEGIN
  DECLARE lastBillId VARCHAR(255);
  DECLARE newBillId VARCHAR(255);
  DECLARE discountAmt DECIMAL(10, 2);
  DECLARE totalLateFee DECIMAL(10, 2);
  DECLARE totalTax DECIMAL(10, 2);
  DECLARE totalAmountBeforeDiscount DECIMAL(10, 2);
  DECLARE finalAmount DECIMAL(10, 2);

  -- declaration section
  SELECT BILL_ID INTO lastBillId FROM (SELECT BILL_ID, ROWNUM AS RN FROM BILLING_DETAILS) 
  WHERE RN = (SELECT MAX(ROWNUM) FROM BILLING_DETAILS);

  SET newBillId = CONCAT('BL', CAST(SUBSTRING(lastBillId, 3) AS SIGNED) + 1);

  CALL CALCULATE_LATE_FEE_AND_TAX(NEW.ACT_RET_DT_TIME, NEW.RET_DT_TIME, NEW.REG_NUM, NEW.AMOUNT, totalLateFee, totalTax);

  SET totalAmountBeforeDiscount = NEW.AMOUNT + totalLateFee + totalTax;

  CALL CALCULATE_DISCOUNT_AMOUNT(NEW.DL_NUM, totalAmountBeforeDiscount, NEW.DISCOUNT_CODE, discountAmt);

  SET finalAmount = totalAmountBeforeDiscount - discountAmt;

  -- insert new bill into the billing_details table
  INSERT INTO BILLING_DETAILS (BILL_ID, BILL_DATE, DISCOUNT_AMOUNT, TOTAL_AMOUNT, TAX_AMOUNT, BOOKING_ID, TOTAL_LATE_FEE) 
  VALUES (newBillId, SYSDATE(), discountAmt, finalAmount, totalTax, NEW.BOOKING_ID, totalLateFee);

END$$

DELIMITER ;
