/*1. Consultar el supermercado que tenga más cantidad de productos con el tipo 
“CARNICOS” que han vendido hasta la fecha 31 de diciembre del 2013 retornando el 
nombre del supermercado, la cantidad, la descripción del tipo de supermercado y la 
fecha de venta.*/
SELECT C.NOMBRE_SUPERMERCADO,A.CANTIDAD,(SELECT B.DESCRIPCION_TIPO
	FROM PRODUCTO AS A 
		INNER JOIN TIPO_PRODUCTO AS B
		ON A.ID_PRODUCTO=B.ID_TIPO_PRODUCTO
			WHERE B.ID_TIPO_PRODUCTO=4) AS DESCRIPCION_TIPO_PRODUCTO, A.FECHA_VENTE
	FROM FACTURA AS A
		INNER JOIN  (SELECT A.NOMBRE_SUPERMERCADO, B.ID_VENDEDOR
    FROM SUPERMERCADO AS A
		INNER JOIN VENDEDOR AS B
		ON A.ID_SUPERMERCADO = B.ID_SUPERMERCADO) AS C
		ON A.ID_VENDEDOR = C.ID_VENDEDOR
			WHERE A.FECHA_VENTE <= '2013-12-31' AND A.ID_PRODUCTO=4;

/*2. Seleccionar los clientes que compran en el SUPERMERCADO “Exito” cuya compra 
supera los $150.000 mil pesos e imprimir todos los datos del cliente más el nombre 
del supermercado y el valor de venta, y ordenarlos descendentemente.*/
SELECT D.*,A.ID_VENDEDOR, C.NOMBRE_SUPERMERCADO, A.VALOR_VENTA
    FROM FACTURA AS A
		INNER JOIN CLIENTE AS D 
		ON A.ID_CLIENTE = D.ID_CLIENTE
		INNER JOIN (SELECT B.ID_VENDEDOR, A.ID_SUPERMERCADO, A.NOMBRE_SUPERMERCADO
    FROM SUPERMERCADO AS A
		INNER JOIN VENDEDOR AS B
		ON A.ID_SUPERMERCADO = B.ID_SUPERMERCADO
			WHERE A.ID_SUPERMERCADO=1) AS C
			ON A.ID_VENDEDOR = C.ID_VENDEDOR
				WHERE A.VALOR_VENTA >= 150000
		ORDER BY A.VALOR_VENTA DESC;

/*3. Construir la consulta que permita conocer las ventas totales de cada vendedor en 
cada SUPERMERCADO, retornando el nombre del vendedor, SUPERMERCADO y valor 
total de ventas por cada vendedor ordenado descendentemente por valor.
*/
SELECT C.NOMBRE_VENDEDOR, C.NOMBRE_SUPERMERCADO, SUM(A.VALOR_VENTA) AS TOTAL_VENTAS
    FROM FACTURA AS A INNER JOIN (SELECT B.ID_VENDEDOR,B.NOMBRE_VENDEDOR,A.NOMBRE_SUPERMERCADO 
    FROM SUPERMERCADO AS A
		INNER JOIN VENDEDOR AS B 
		ON A.ID_SUPERMERCADO = B.ID_SUPERMERCADO) AS C
		ON A.ID_VENDEDOR = C.ID_VENDEDOR
		GROUP BY A.ID_VENDEDOR
    ORDER BY TOTAL_VENTAS DESC;

/*4. Consultar las facturas cuyo valor es superior a $100.000 pesos y el código del 
vendedor sea el 3, retornando el número de la factura, el valor de la factura y el 
nombre del vendedor.
*/
SELECT A.NUMERO_FACTURA, A.VALOR_VENTA, B.NOMBRE_VENDEDOR	
	FROM FACTURA AS A
		INNER JOIN VENDEDOR AS B 
		ON A.ID_VENDEDOR = B.ID_VENDEDOR
			WHERE A.VALOR_VENTA > 100000 AND A.ID_VENDEDOR=3;


