--Processing Product table--
-------Update table to fill SKU and Category of what missing in Product Detail table---------
select *
from [Amazon India Report] ar left join [Product Detail] pd on ar.Style = pd.Style
where pd.SKU is null and pd.Size = ar.Size
---------Update statement------------(null)
----------
update [Product Detail]
set Category = 'SET'
where SKU is null and Category is null
----------
update [Product Detail]
set Color = 'Multicolor'
where SKU is null and Color is null
----------
update [Product Detail]
set Category = a.Category, SKU = a.SKU
from [Product Detail] p inner join [Amazon India Report] a on a.Style = p.Style and a.Size = p.Size
where p.SKU is null
----------
update [Product Detail]
set SKU = CONCAT_WS('-',Style,Category,Size) 
where SKU is null or SKU like '%REF%'
----------
delete [Product Detail]
where Sku in (
select SKU
from [Product Detail]
group by SKU
having COUNT(SKU) > 1)
-----------
delete [Product Detail]
where Sku in (
select SKU
from [Product Detail]
group by SKU
having COUNT(SKU) > 1) and Stock in (0,1)
-----------
update [Product Detail]
set SKU = a.SKU
from [Amazon India Report] a left join [Product Detail] p on a.Style = p.Style and a.Size = p.Size
------REF-------
update [Product Detail]
set SKU = a.SKU
from [Product Detail] p 
inner join [Amazon India Report] a on p.Style = a.Style and p.Size = a.Size
where p.SKU like '%REF%'
---------International Sale SKU update-----------
update [International Sale Report]
set SKU = p.SKU, Stock = p.Stock
from [International Sale Report] i  left join [Product Detail] p on i.Style = p.Style and i.Size = p.Size
where i.SKu is null
------------
update [International Sale Report]
set Size = 'S TO XXL'
where Size is null
------------
update [International Sale Report]
set SKU = p.SKU, Stock = p.Stock
from [International Sale Report] i inner join [Product Detail] p on i.Style = p.Style
where i.SKU is null and i.Size not in ('Free') and p.Size in ('S','M','L','XS','XL','XXL')




