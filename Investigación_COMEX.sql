-- El propósito de este proyecto es obtener una vision mas clara con el uso de SQL y POWER BI para entender a mayor exactitud cual ha sido el rumbo 
-- de las exportaciones e importaciones de Ecuador. Principalmente las exportaciones ya que a medida que ha avanzado el tiempo y en búsqueda de una menor
-- dependencia de los fosiles, minerales y recursos de mayor limitante, se busca explorar nuevas vias de innovacion para evitar tanto la explotación abrupta de recursos 
-- como con su contraparte impulsar a la industria nacional para encontrar productos alternos con el fin de mejorarlos, innovarlos y volverlos mas atractivos al pulbico 
-- internacional logrando mejores acuerdos y relaciones comerciales 

-- Todos estos datos fueron obtenidos a través del datawarehouse del Banco Central Nacional del Ecuador
-- https://www.bce.fin.ec/comercio-exterior 

-- Para efectos del proyecto estos datos debían ser depurados, organizados y almacenados en SQL para su mejor conclusión.

-- Con respecto a las conclusiones en cuanto a las siguientes consultas:

-- EEUU lidera como nuestro mayor cliente, sin embargo, no ha existido un intendo de acuerdo comercial para mejorar el clima economico nacional

-- China lleva un segundo puesto en cuanto a exportaciones en valor FOB y es curioso que en cuanto a porcentaje de exportaciones, solo tienen el 1.26% con respecto al 100%
-- y ocupa el lugar 22 de todos los paises a los que Ecuador exporta en total FOB en comparacion a EEUU que ocupa el primer puesto en presencia con el 25% en porcentaje de 
-- exportaciones

-- Corea del Sur ha logrado alcanzar un pico maximo de sus exportaciones hacia Ecuador en Marzo del 2024 por el 
-- acuerdo comercial que se negocio en los ultimos años

-- Dentro de los productos principales, el Petroleo Crudo lidera la lista con un 27.95% en los últimos 5 años. Sin embargo, si lo analizamos por año,
-- tal parece que Ecuador busca promover bastante la industria del camaron logrando de poco en poco quitarle el liderato a la exportacion de Petroleo Crudo

-- CONSULTAS

-- Participacion de productos principales exportados en los ultimos 5 años

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

-- Porcentaje de las exportaciones totales en valor FOB en los ultimos 5 años

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

-- Porcentaje de volumen de exportaciones en los ultimos 5 años por pais

Select 
		País_Destino as Paises,
		count(*) as Conteo,
        (Select count(*) from expor) as Total,
        count(*)*100/(Select count(*) from expor) as Pct
From expor
Group by 1
Order by 4 desc;

-- Porcentaje de los mayores clientes de Ecuador (Estados Unidos y China) en el producto de mayor exportacion a nivel Capítulo en el mes de Enero 2021
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

-- Diferencia en cuanto a las exportaciones hacia Estados Unidos y China con su diferencia porcentual. EEUU tiene siempre una mayor presencia a nivel de exportaciones

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

-- En la busqueda de las importaciones de mayor valor superior a los 10.000.00 en valor FOB, Estados Unidos lidera en casi todo el año. Dato interesante la importacion
-- del capitulo de Reactores Nuclreare, calderas, maquinas y aparatos por parte de China 

Select distinct im24.País_Origen, im24.Mes, cx.Capítulo, round(sum(im24.FOB),2) as Total
From imp_2024 im24
Left Join comex cx
On cx.Código_Subpartida=im24.Código_Subpartida
Group by 1,2,3
Having sum(im24.FOB)>100000
Order by 4 desc
Limit 10;

-- Encontrar el minimo y maximo de importaciones en este ultimo año

Select im24.País_Origen, im24.Mes, min(im24.FOB) as Minimum
From imp_2024 im24
Where im24.País_Origen Not in ("NO DEFINIDO","SIN ESTADISTICAS")
Group by 1,2
Order by 3
Limit 5;

-- Maximo 
Select im24.País_Origen, im24.Mes, max(im24.FOB) as Maximo
From imp_2024 im24
Where im24.País_Origen Not in ("NO DEFINIDO","SIN ESTADISTICAS")
Group by 1,2
Order by 3 desc
Limit 5;

-- Con respecto a las areas economicas del mundo, se busca encontrar el promedio de exportaciones hacia estas areas 

Select pa.Area_económica, round(avg(ex.FOB_en_miles),2) as Average_by_Economic_Area
From expor ex
Right Join pais_area_económica pa
On ex.País_Destino=pa.Pais
Group by 1
Order by 2 desc;

-- Total de las exportaciones del camaron y banano como producto principal del ultimo mes de registro (Agosto del 2024) 

Select ex.Período, ex.Mes ,pp.Producto_Principal, round(sum(ex.FOB_en_miles),2) as Total
From expor ex
Left Join comex cx
On ex.Código_Subpartida=cx.Código_Subpartida
Left Join producto_principal pp
On pp.CódigoSubpartida=cx.Código_Subpartida
Where ex.Mes in ("Agosto") and ex.Período=2024 and (pp.Producto_Principal regexp "CAMARONES" OR pp.Producto_Principal regexp "BANANO")
Group by 1,2,3
Order by 4 desc;

-- Los 10 principales clientes de Ecuador en los ultimos 5 años

Select País_Destino, round(sum(FOB_en_miles),2) as Total
From expor 
Group by 1
Order by 2 desc
Limit 10;  