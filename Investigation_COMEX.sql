-- The purpose of this project is to obtain a clearer vision using SQL and POWER BI to understand more accurately what has been the direction of Ecuador's exports and imports. 
-- Mainly exports, since as time has progressed and in search of a lesser dependence on fossils, minerals and resources of greater limitation, new avenues of innovation are 
-- sought to avoid both the abrupt exploitation of resources and, with its counterpart, to promote the national industry to find alternative products in order to improve them, 
-- innovate them and make them more attractive to the international public, achieving better agreements and commercial relations.

-- All this data was obtained through the datawarehouse of the National Central Bank of Ecuador
-- https://www.bce.fin.ec/comercio-exterior 

-- For the purposes of the project, this data had to be cleaned, organized and stored in SQL for better conclusion.


-- Regarding the conclusions

-- The US leads as our largest client, however, there has not been an attempt at a commercial agreement to improve the national economic climate.

-- China is in second place in terms of exports in FOB value together with the US, which is in the lead, and it is curious that in terms of percentage of export volume, 
-- it only has 1.26% with respect to 100%
-- and occupies the 22nd place of all the countries to which Ecuador exports in the total volume of exports compared to the US, which occupies the first place in presence. 
-- With 25% of exports concluding that China has a minor volumen of trading but a higher FOB value related to the products that Ecuador trades with them  

-- South Korea has managed to reach a maximum peak of its exports to Ecuador in March 2024 due to the trade agreement negotiated in recent years. 

-- Among the main products, crude oil leads the list with 27.95% in the last 5 years. However, if we analyze it by year, it seems that Ecuador is seeking to promote the 
-- shrimp industry a lot, gradually managing to take the lead from the export of crude oil.

-- QUERIES

-- Share of main products exported in the last 5 years

Select pp.Producto_Principal, 
		round(sum(FOB_en_miles),2) as Fob_expor, 
		(Select round(sum(FOB_en_miles),2) from expor) as Total,
        round((sum(FOB_en_miles)/(select sum(FOB_en_miles) from expor)*100),2) as PCT
From expor ex
Left Join comex cx
On cx.Código_Subpartida=ex.Código_Subpartida
Left Join producto_principal pp
On pp.CódigoSubpartida=ex.Código_Subpartida
Group by 1
Order by 2 desc;

/*2024
Select  ex.Período,
		pp.Producto_Principal, 
		round(sum(FOB_en_miles),2) as Fob_expor, 
		(Select round(sum(FOB_en_miles),2) from expor) as Total,
        round((sum(FOB_en_miles)/(select sum(FOB_en_miles) from expor)*100),2) as PCT
From expor ex
Left Join comex cx
On cx.Código_Subpartida=ex.Código_Subpartida
Left Join producto_principal pp
On pp.CódigoSubpartida=ex.Código_Subpartida
Where ex.Período=2024
Group by 1,2
Order by 3 desc;
*/

/*2023
Select  ex.Período,
		pp.Producto_Principal, 
		round(sum(FOB_en_miles),2) as Fob_expor, 
		(Select round(sum(FOB_en_miles),2) from expor) as Total,
        round((sum(FOB_en_miles)/(select sum(FOB_en_miles) from expor)*100),2) as PCT
From expor ex
Left Join comex cx
On cx.Código_Subpartida=ex.Código_Subpartida
Left Join producto_principal pp
On pp.CódigoSubpartida=ex.Código_Subpartida
Where ex.Período=2023
Group by 1,2
Order by 3 desc;
*/

/*2022
Select  ex.Período,
		pp.Producto_Principal, 
		round(sum(FOB_en_miles),2) as Fob_expor, 
		(Select round(sum(FOB_en_miles),2) from expor) as Total,
        round((sum(FOB_en_miles)/(select sum(FOB_en_miles) from expor)*100),2) as PCT
From expor ex
Left Join comex cx
On cx.Código_Subpartida=ex.Código_Subpartida
Left Join producto_principal pp
On pp.CódigoSubpartida=ex.Código_Subpartida
Where ex.Período=2022
Group by 1,2
Order by 3 desc;
*/

/*2021 
Select  ex.Período,
		pp.Producto_Principal, 
		round(sum(FOB_en_miles),2) as Fob_expor, 
		(Select round(sum(FOB_en_miles),2) from expor) as Total,
        round((sum(FOB_en_miles)/(select sum(FOB_en_miles) from expor)*100),2) as PCT
From expor ex
Left Join comex cx
On cx.Código_Subpartida=ex.Código_Subpartida
Left Join producto_principal pp
On pp.CódigoSubpartida=ex.Código_Subpartida
Where ex.Período=2021
Group by 1,2
Order by 3 desc;
*/

/*2020
Select  ex.Período,
		pp.Producto_Principal, 
		round(sum(FOB_en_miles),2) as Fob_expor, 
		(Select round(sum(FOB_en_miles),2) from expor) as Total,
        round((sum(FOB_en_miles)/(select sum(FOB_en_miles) from expor)*100),2) as PCT
From expor ex
Left Join comex cx
On cx.Código_Subpartida=ex.Código_Subpartida
Left Join producto_principal pp
On pp.CódigoSubpartida=ex.Código_Subpartida
Where ex.Período=2020
Group by 1,2
Order by 3 desc;
*/

/*2019
Select  ex.Período,
		pp.Producto_Principal, 
		round(sum(FOB_en_miles),2) as Fob_expor, 
		(Select round(sum(FOB_en_miles),2) from expor) as Total,
        round((sum(FOB_en_miles)/(select sum(FOB_en_miles) from expor)*100),2) as PCT
From expor ex
Left Join comex cx
On cx.Código_Subpartida=ex.Código_Subpartida
Left Join producto_principal pp
On pp.CódigoSubpartida=ex.Código_Subpartida
Where ex.Período=2019
Group by 1,2
Order by 3 desc;
*/

-- Percentage of total exports in FOB values in the last 5 years by countries

WITH TotalFob AS (
    SELECT round(sum(FOB_en_miles), 2) as Total_Fob
    FROM expor
)
Select 
    ex.País_Destino,
    round(sum(ex.FOB_en_miles), 2) as Fob_expor,
    tf.Total_Fob,
    round((sum(FOB_en_miles)/(select sum(FOB_en_miles) from expor)*100),2) as PCT
From expor ex
Cross Join TotalFob tf
Group by ex.País_Destino, tf.Total_Fob
Order by 4 desc;

-- Percentage of volume exports in the last 5 years by country

Select 
		País_Destino as Paises,
		count(*) as Conteo,
        (Select count(*) from expor) as Total,
        count(*)*100/(Select count(*) from expor) as Pct
From expor
Group by 1
Order by 4 desc;

-- Percentage of Ecuador's largest customers (United States and China) in the most exported product at Chapter level in the month of January 2021

Select
	Período,
    País_Destino,
    cx.Capítulo,
    round(Fob_en_miles,2) as FOB, 
    round(sum(fob_en_miles) over (partition by Período),2) as Total_Enero,
    round(fob_en_miles * 100/sum(fob_en_miles) over (partition by Período),4) as Pct_Mensual
From expor ex
Left Join comex cx
On cx.Código_Subpartida=ex.Código_Subpartida
Where País_Destino in ("Estados Unidos","China") and cx.Capítulo regexp "COMBUSTIBLES MINERALES" and ex.Período=2021 AND Mes="Enero"; 

-- Difference in exports to the United States and China with their percentage difference. The United States always has a greater presence in terms of exports

Select Período,
		round(Expor_USA,2) as Total_USA,
        round(Expor_China,2) as Total_China,
		Round(Expor_USA-Expor_China,2) as Diferencia_Potencias,
        Round(Expor_China/Expor_USA-1,4)*100 as Porcentaje
From        
(
Select Período, 
		sum(case when País_Destino="Estados Unidos" then FOB_en_miles end) As Expor_USA,
        sum(case when País_Destino="China" then FOB_en_miles end) As Expor_China
From expor
Group by 1
Order by 1 desc) as A;

-- In the search for imports of higher value over 10,000.00 in FOB value. The United States leads for most of the year. 
-- Interesting fact is the import of the chapter on Nuclear Reactors, boilers, machines and equipment by China

Select distinct im24.País_Origen, im24.Mes, cx.Capítulo, round(sum(im24.FOB),2) as Total
From imp_2024 im24
Left Join comex cx
On cx.Código_Subpartida=im24.Código_Subpartida
Group by 1,2,3
Having sum(im24.FOB)>100000
Order by 4 desc
Limit 10;

-- Find the minimum and maximum imports in this last year


-- Minimum
Select im24.País_Origen, im24.Mes, min(im24.FOB) as Minimum
From imp_2024 im24
Where im24.País_Origen Not in ("NO DEFINIDO","SIN ESTADISTICAS")
Group by 1,2
Order by 3
Limit 5;

-- Maximum 
Select im24.País_Origen, im24.Mes, max(im24.FOB) as Maximo
From imp_2024 im24
Where im24.País_Origen Not in ("NO DEFINIDO","SIN ESTADISTICAS")
Group by 1,2
Order by 3 desc
Limit 5;

-- Regarding the economic areas of the world, we seek to find the average of exports to these areas.

Select pa.Area_económica, round(avg(ex.FOB_en_miles),2) as Average_by_Economic_Area
From expor ex
Right Join pais_area_económica pa
On ex.País_Destino=pa.Pais
Group by 1
Order by 2 desc;

-- Total exports of shrimp and banana as the main product for the last month of record (August 2024)

Select ex.Período, ex.Mes ,pp.Producto_Principal, round(sum(ex.FOB_en_miles),2) as Total
From expor ex
Left Join comex cx
On ex.Código_Subpartida=cx.Código_Subpartida
Left Join producto_principal pp
On pp.CódigoSubpartida=cx.Código_Subpartida
Where ex.Mes in ("Agosto") and ex.Período=2024 and (pp.Producto_Principal regexp "CAMARONES" OR pp.Producto_Principal regexp "BANANO")
Group by 1,2,3
Order by 4 desc;

-- Ecuador's top 10 clients in the last 5 years

Select País_Destino, round(sum(FOB_en_miles),2) as Total
From expor 
Group by 1
Order by 2 desc
Limit 10;  
