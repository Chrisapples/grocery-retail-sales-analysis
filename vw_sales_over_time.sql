SELECT
  SalesDay,
  SUM(Revenue) AS DailyRevenue,
  SUM(Quantity) AS DailyUnits,
  COUNT(DISTINCT TransactionNumber) AS Transactions
FROM `project-2d3d3fa9-88c0-4101-827.grocery_data.vw_sales_enriched`
GROUP BY SalesDay