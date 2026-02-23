SELECT
  CategoryName,
  SUM(Revenue) AS TotalRevenue,
  SUM(Quantity) AS TotalUnits,
  COUNT(DISTINCT TransactionNumber) AS Transactions,
  SAFE_DIVIDE(SUM(Revenue), COUNT(DISTINCT TransactionNumber)) AS AvgOrderValue
FROM `project-2d3d3fa9-88c0-4101-827.grocery_data.vw_sales_enriched`
GROUP BY CategoryName