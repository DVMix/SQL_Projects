CREATE OR REPLACE FUNCTION selling_process(pr TEXT) RETURNS integer AS
$BODY$
	DECLARE
		coin_type INTEGER;
		coin_type_num INTEGER;
		kind_array INTEGER[];
		kind_array_length INTEGER;
		cost INTEGER;
		user_wallet_balance INTEGER;
		result INTEGER;
	BEGIN
		user_wallet_balance = user_wallet_balance();
		cost = (SELECT price FROM products WHERE prod = pr);

		IF(SELECT checking_user_wallet(pr) = 1)		
		THEN
			user_wallet_balance = user_wallet_balance - cost;
			UPDATE products SET onwarehouse = onwarehouse - 1 WHERE prod = pr;

			kind_array = array(select kind from user_wallet order by kind desc);
			kind_array_length = (select count(kind) from user_wallet);			

			FOR i IN 1..kind_array_length
			LOOP
				coin_type = kind_array[i]; 
				--RAISE NOTICE 'coin_type - %', coin_type;
				coin_type_num = (SELECT number FROM user_wallet WHERE kind = coin_type); 
				--RAISE NOTICE 'coin_type_num - %', coin_type_num;
				UPDATE machine_wallet SET number = number + coin_type_num WHERE kind = coin_type;
				UPDATE user_wallet SET number = number - coin_type_num WHERE kind = coin_type;
			END LOOP;
			IF(SELECT change_check(user_wallet_balance) = 0)
			THEN 
				EXECUTE change(user_wallet_balance);
			ELSE
				EXECUTE change(user_wallet_balance);
				RAISE NOTICE 'CAN"T RETURN FULL CHANGE - NOT ENOUGH COINS';
			END IF;
			result = 0;
		ELSE 
			result = 1;
		END IF;
		RETURN result;
	END;
$BODY$
LANGUAGE 'plpgsql';