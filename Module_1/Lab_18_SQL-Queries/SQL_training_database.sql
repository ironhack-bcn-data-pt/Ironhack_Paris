update applestore
set track_name = 'Paid'
Where price > 0;

select track_name, rating_count_tot from applestore
group by track_name;