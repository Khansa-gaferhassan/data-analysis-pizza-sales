Select * from pizza_sales$
--total revenue 
select SUM(total_price)AS Total_Revenue from pizza_sales$
--Avg_Order_Value
select SUM(total_price) / COUNT(DISTINCT(order_id)) 
 as Avg_Order_Value 
 from pizza_sales$

 --total_pizaa_sold
 select SUM(quantity) as total_pizaa_sold from pizza_sales$
 --total_ordrt
 select COUNT(DISTINCT(order_id)) as total_order from pizza_sales$

 --AVG pizza by order
 select CAST(CAST(SUM(quantity) as DECIMAL(10,2))/
 CAST(COUNT( DISTINCT(order_id))as DECIMAL(10,2)) AS  DECIMAL(10,2)) avg_pizza_by_order from pizza_sales$
  
  --DAYLY TREND
  select DATENAME(DW,order_date) as Order_Day ,
  COUNT(DISTINCT(order_id)) as Total_Order from pizza_sales$ Group by DATENAME(DW,order_date) 

  --mounthly trend 

  select DATENAME(MONTH, order_date) as Order_Month ,COUNT(DISTINCT(order_id)) as Total_Order 
  from pizza_sales$ group by DATENAME(MONTH, order_date) 
  ORDER BY Total_order DESC
  --TOTAL SALES BY PIZZA CATEGRY
  SELECT pizza_category ,sum(total_price)as TotalSales,sum(total_price) * 100 /(Select sum(total_price)
  from pizza_sales$ where MONTH(order_date) =1) as PCT
  from pizza_sales$  
  where MONTH(order_date) =1
  group by pizza_category

  --TOTLA SALES BBY PIZZA SIZE 
   select pizza_size,  CAST(sum(total_price)AS DECIMAL(10,2)) as Total_Sales,
CAST(
sum(total_price) * 100 /( select sum(total_Price) from pizza_sales$ where DATEPART(quarter,order_date) =1)AS DECIMAL(10,2) )
as PCT from pizza_sales$ where DATEPART(quarter,order_date) =1
  GROUP BY pizza_size 
  ORDER BY PCT DESC
  --top 5 best pizza selling by revenue , and total order
  SELECT  TOP 5 pizza_name,SUM(total_price) as Total_revenue
  from pizza_sales$
  GROUP BY pizza_name order by Total_revenue DESC
 
 -- bottom 5 pizza selling by revenue
  select TOP 5 pizza_name,sum(total_price)as total_revenue from pizza_sales$ 
  group by pizza_name
order by   total_revenue ASC


  -- top and bottom pizza  selling  total quantity
  select TOP 5 pizza_name,sum(quantity) as Total_quantity from pizza_sales$
  group by pizza_name
  order by Total_quantity DESC

  --bottom pizza  selling  total quantity
   select TOP 5 pizza_name,sum(quantity) as Total_quantity from pizza_sales$
  group by pizza_name
  order by Total_quantity ASC
  --TOP pizza  selling  total ORDER
    select TOP 5 pizza_name,sum(order_id) as Total_quantity from pizza_sales$
  group by pizza_name
  order by Total_quantity DESC



