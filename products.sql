use magist;
#	What categories of tech products does Magist have?
select  Distinct P.product_category_name
from products P
where P.product_category_name in( "audio","eletronicos","telephonia","pcs","informatica_acessorios");
#select distinct product_category_name, product_category_name_english
 #from product_category_name_translation;
 
 #How many products of these tech categories have been sold (within the time window of the database snapshot)? 

select  count(distinct P.product_id) No_Sold_products
from orders O
left join  order_items Ord_item
on Ord_item.order_id=O.order_id
left join products P 
on Ord_item.product_id=P.product_id
where P.product_category_name in( "audio","eletronicos","telephonia","pcs","informatica_acessorios") and O.order_status="delivered";

#What percentage does that represent from the overall number of products sold?
select  sum(Ord_item.price) Tech_sales
from products P
left join  order_items Ord_item
on Ord_item.product_id=P.product_id
left join orders O 
on O.order_id=Ord_item.order_id
where P.product_category_name in( "audio","eletronicos","telephonia","pcs","informatica_acessorios")  and  O.order_status="delivered";

select  sum(Ord_item.price) No_Tech_sales
from products P
left join  order_items Ord_item
on Ord_item.product_id=P.product_id
left join orders O 
on O.order_id=Ord_item.order_id
where P.product_category_name  not in( "audio","eletronicos","telephonia","pcs","informatica_acessorios") and  O.order_status="delivered";

select  sum(Ord_item.price) sales
from products P
left join  order_items Ord_item
on Ord_item.product_id=P.product_id
left join orders O 
on O.order_id=Ord_item.order_id
where O.order_status="delivered";
#	What’s the average price of the products being sold?
select  round(avg(Ord_item.price),2) Avg_tech_price
from products P
left join  order_items Ord_item
on Ord_item.product_id=P.product_id
left join orders O 
on O.order_id=Ord_item.order_id
where P.product_category_name in( "audio","eletronicos","telephonia","pcs","informatica_acessorios")  and  O.order_status="delivered";
select   distinct order_status from orders;

#Are expensive tech products popular? *
select   Ord_item.order_id, Ord_item.product_id,max(Ord_item.price),min(Ord_item.price)
from products P
left join  order_items Ord_item
on Ord_item.product_id=P.product_id
left join orders O 
on O.order_id=Ord_item.order_id
where P.product_category_name in( "audio","eletronicos","telephonia","pcs","informatica_acessorios")  and  O.order_status="delivered"
group by Ord_item.order_id;