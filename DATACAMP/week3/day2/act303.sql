Use bank;

select d1. account_id, d1.client_id, d2.client_id, d1.type, d2.type 
from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id
and d1.type <> d2.type;