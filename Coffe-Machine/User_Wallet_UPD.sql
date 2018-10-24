-- ФУНКЦИЯ ПОПОЛНЯЕТ КОШЕЛЕК ПОКУПАТЕЛЯ НА N МОНЕТ K НОМИНАЛА 
-- (ПРИМЕР User_Wallet_UPD(5) - НОМИНАЛ = 5)

CREATE OR REPLACE FUNCTION User_Wallet_UPD (k integer) RETURNS void as
$BODY$
	DECLARE
		kind_array INTEGER[];
	BEGIN
		kind_array = array(select kind from user_wallet order by kind desc);
		IF (k IN (SELECT kind FROM user_wallet))
		THEN
			UPDATE user_wallet SET number = number + 1 WHERE (kind = k);
		ELSE
			INSERT INTO user_wallet VALUES(k,1);
			--RAISE NOTICE '+coin_type - %', k;
			INSERT INTO machine_wallet VALUES(k,0);
			INSERT INTO change VALUES(k,0);
		END IF;
	END;
$BODY$
LANGUAGE 'plpgsql';

