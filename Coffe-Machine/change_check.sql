CREATE OR REPLACE FUNCTION change_check(n INTEGER) RETURNS integer AS
$BODY$
	DECLARE
		result INTEGER;
		coin_type INTEGER;
		coin_type_num INTEGER;
		user_wallet_balance INTEGER;
		kind_array INTEGER[];
		kind_array_length INTEGER;
	BEGIN
		user_wallet_balance = n;
		
		kind_array = array(select kind from user_wallet order by kind desc);
		kind_array_length = (select count(kind) from user_wallet);
		RAISE NOTICE 'user_wallet_balance = %', user_wallet_balance;
	
		IF (SELECT machine_wallet_balance())>=user_wallet_balance
		THEN
			FOR i IN 1..kind_array_length
			LOOP
				IF(user_wallet_balance>0)
				THEN
					coin_type = kind_array[i]; 
					RAISE NOTICE 'coin_type - %', coin_type;
					
					coin_type_num = user_wallet_balance/coin_type; 
					RAISE NOTICE 'coin_type_num - %', coin_type_num;
					
					IF(SELECT number FROM machine_wallet WHERE kind = coin_type)>=coin_type_num
					THEN
						user_wallet_balance = user_wallet_balance - coin_type_num*coin_type;
					ELSE
						coin_type_num = (SELECT number FROM machine_wallet WHERE kind = coin_type);
						user_wallet_balance = user_wallet_balance - coin_type_num*coin_type;
					END IF; 
					RAISE NOTICE 'after proc - user_wallet_balance - %', user_wallet_balance;
					IF(user_wallet_balance>0)
					THEN
						result = 1;
					ELSE
						result = 0;
					END IF;
				ELSE
					result = 0;
				END IF;
			END LOOP;
		ELSE
			result = 1;
		END IF;
		RETURN result;
	END;
$BODY$
LANGUAGE 'plpgsql';