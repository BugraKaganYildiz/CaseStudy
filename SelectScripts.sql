-- Sold Quantities with Product Group by Generations
SELECT GNR.[generation] AS [Generation], PRD.[product_group] AS [ProductGroup], SUM(SRC.[quantity]) AS [TotalQuantity]
FROM [dbo].[Sales_Reciepts] SRC
	INNER JOIN [dbo].[Customer] CST ON CST.[customer_id] = SRC.[customer_id]
	LEFT JOIN [dbo].[Generations] GNR ON CST.[birth_year] = GNR.[birth_year]
	LEFT JOIN [dbo].[Product] PRD ON SRC.[product_id] = PRD.[product_id]
GROUP BY GNR.[generation], PRD.[product_group]
ORDER BY GNR.[generation]


-- TOP 3 Most Seller Products According to Weeks
SELECT [Product], [YearWeek], [TotalQuantity] FROM (
	SELECT 
		 ROW_NUMBER() OVER(PARTITION BY CONCAT(DTE.[Year_ID],DTE.[Week_ID]) ORDER BY SUM(SRC.[quantity]) DESC) AS [RowNumber]
		,PRD.[product] AS [Product]
		,CONCAT(DTE.[Year_ID],DTE.[Week_ID]) AS [YearWeek]
		,SUM(SRC.[quantity]) AS [TotalQuantity]
	FROM [dbo].[Sales_Reciepts] SRC
		INNER JOIN [dbo].[Customer] CST ON CST.[customer_id] = SRC.[customer_id]
		LEFT JOIN [dbo].[Product] PRD ON SRC.[product_id] = PRD.[product_id]
		LEFT JOIN [dbo].[Dates] DTE ON SRC.[transaction_date] = DTE.[transaction_date]
	GROUP BY CONCAT(DTE.[Year_ID],DTE.[Week_ID]), PRD.[product] ) TBL
WHERE [RowNumber] IN (1, 2, 3)