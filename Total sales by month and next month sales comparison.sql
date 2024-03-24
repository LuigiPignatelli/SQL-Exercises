SELECT *
FROM dbo.Sales

-- 1. Write a T-SQL query to retrieve the total sales amount for each month in the year
-- 2. Calculate the percentage change in total sales amount from one month to the next

WITH GroupedSales AS(
	SELECT
		StartMonth = DATEADD(MONTH, DATEDIFF(MONTH, 0, SaleDate), 0)
		,TotalAmount = SUM(s.Amount)
	FROM DBO.Sales as s
	GROUP BY
		DATEADD(MONTH, DATEDIFF(MONTH, 0, SaleDate), 0)
)
SELECT
	StartMonth
	,TotalAmount
	,TotalAmountNextMonth = ISNULL(LAG(TotalAmount, 1) OVER(ORDER BY StartMonth), 0)
	,ChangeInMonths = (TotalAmount - LAG(TotalAmount, 1) OVER(ORDER BY StartMonth)) / LAG(TotalAmount, 1) OVER(ORDER BY StartMonth) * 100
FROM GroupedSales