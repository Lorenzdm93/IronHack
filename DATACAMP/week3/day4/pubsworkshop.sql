Use publications;

#who are the top 3 most profiting authors
select * from titleauthor;
select * from sales;
select * from titles;

select * from titleauthor as ta
join sales as s
on ta.title_id = s.title_id
join titles as t
on t.title_id = ta.title_id
group by 
limit 3;
