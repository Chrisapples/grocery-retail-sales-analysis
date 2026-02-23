SELECT
  s.SalesID,
  s.TransactionNumber,
  s.SalesDate,
  DATE(s.SalesDate) AS SalesDay,
  s.SalesPersonID,
  s.CustomerID,
  s.ProductID,
  s.Quantity,
  s.Discount,

  (s.Quantity * p.Price * (1 - IFNULL(s.Discount, 0))) AS Revenue,

  p.ProductName,
  p.Price AS ListedUnitPrice,
  p.Class AS ProductClass,
  c.CategoryID,
  c.CategoryName,

  CONCAT(
    cu.FirstName, ' ',
    IFNULL(CONCAT(cu.MiddleInitial, ' '), ''),
    cu.LastName
  ) AS CustomerName,
  cu.Address AS CustomerAddress,

  CONCAT(
    e.FirstName, ' ',
    IFNULL(CONCAT(e.MiddleInitial, ' '), ''),
    e.LastName
  ) AS SalesPersonName,
  e.Gender AS SalesPersonGender,
  e.BirthDate AS SalesPersonBirthDate,
  e.HireDate AS SalesPersonHireDate,

  cci.CityID AS CustomerCityID,
  cci.CityName AS CustomerCityName,
  cci.Zipcode AS CustomerZipcode,
  cco.CountryID AS CustomerCountryID,
  cco.CountryName AS CustomerCountryName,
  cco.CountryCode AS CustomerCountryCode,

  eci.CityID AS EmployeeCityID,
  eci.CityName AS EmployeeCityName,
  eci.Zipcode AS EmployeeZipcode,
  eco.CountryID AS EmployeeCountryID,
  eco.CountryName AS EmployeeCountryName,
  eco.CountryCode AS EmployeeCountryCode

FROM `project-2d3d3fa9-88c0-4101-827.grocery_data.sales` s

LEFT JOIN `project-2d3d3fa9-88c0-4101-827.grocery_data.products` p
  ON s.ProductID = p.ProductID

LEFT JOIN `project-2d3d3fa9-88c0-4101-827.grocery_data.categories` c
  ON p.CategoryID = c.CategoryID

LEFT JOIN `project-2d3d3fa9-88c0-4101-827.grocery_data.customers` cu
  ON s.CustomerID = cu.CustomerID

LEFT JOIN `project-2d3d3fa9-88c0-4101-827.grocery_data.cities` cci
  ON cu.CityID = cci.CityID

LEFT JOIN `project-2d3d3fa9-88c0-4101-827.grocery_data.countries` cco
  ON cci.CountryID = cco.CountryID

LEFT JOIN `project-2d3d3fa9-88c0-4101-827.grocery_data.employees` e
  ON s.SalesPersonID = e.EmployeeID

LEFT JOIN `project-2d3d3fa9-88c0-4101-827.grocery_data.cities` eci
  ON e.CityID = eci.CityID

LEFT JOIN `project-2d3d3fa9-88c0-4101-827.grocery_data.countries` eco
  ON eci.CountryID = eco.CountryID

WHERE
  s.ProductID IS NOT NULL
  AND s.CustomerID IS NOT NULL
  AND s.SalesPersonID IS NOT NULL
  AND s.SalesDate IS NOT NULL
  AND NULLIF(TRIM(s.TransactionNumber), '') IS NOT NULL
  AND (s.Quantity IS NULL OR s.Quantity >= 0)