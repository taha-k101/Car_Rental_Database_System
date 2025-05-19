-- Procedure Name: CALCULATE_DISCOUNT_AMOUNT
-- This stored procedure calculates the discount amount for a booking.

USE carRentalSystem;
DELIMITER $$

CREATE PROCEDURE CALCULATE_DISCOUNT_AMOUNT (
  IN dlNum VARCHAR(255),
  IN amount DECIMAL(10, 2),
  IN discountCode VARCHAR(255),
  OUT discountAmt DECIMAL(10, 2)
)
BEGIN
  DECLARE memberType CHAR(1);
  DECLARE discountPercentage DECIMAL(5, 2);

  SELECT MEMBERSHIP_TYPE INTO memberType FROM CUSTOMER_DETAILS WHERE DL_NUMBER = dlNum;

  IF COALESCE(discountCode, 'NULL') <> 'NULL' THEN
    SELECT DISCOUNT_PERCENTAGE INTO discountPercentage FROM DISCOUNT_DETAILS WHERE DISCOUNT_CODE = discountCode;
    
    IF memberType = 'M' THEN
      SET discountAmt = amount * ((discountPercentage + 10) / 100);
    ELSE
      SET discountAmt = amount * (discountPercentage / 100);
    END IF;
  ELSE
    IF memberType = 'M' THEN
      SET discountAmt = amount * 0.1;
    ELSE
      SET discountAmt = 0;
    END IF;
  END IF;
END$$

DELIMITER ;
