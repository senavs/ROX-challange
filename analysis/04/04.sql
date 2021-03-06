SELECT  T4.PRODUCT_ID,
        T1.ORDER_DATE,
        SUM(T2.ORDER_QTY) AS PEDIDOS
FROM SALES_ORDER_HEADER AS T1
LEFT JOIN SALES_ORDER_DETAIL AS T2 ON T1.SALES_ORDER_ID = T2.SALES_ORDER_ID
LEFT JOIN SPECIAL_OFFER_PRODUCT AS T3 ON T2.SPECIAL_OFFER_ID = T3.SPECIAL_OFFER_ID
LEFT JOIN PRODUCT AS T4 ON T3.PRODUCT_ID = T4.PRODUCT_ID
GROUP BY T4.PRODUCT_ID, T1.ORDER_DATE
