/*
=============================================================================================
Database Initialization Script
=============================================================================================
Purpose:
      Sets up the 'DataWarehouse' database with a medallion architecture layout, Provisioning
      three layeres schemas:
          - Bronze: raw ingestion layer
          - Silver : cleansed and validated data
          - Gold: aggregated, business-ready data 
=============================================================================================
*/

-- Initialize DataWarehouse database
Create Database DataWarehouse;
GO 

Use DataWarehouse;
Go

-- Provision medallion architecture schemas 
Create Schema Bronze;
Go

Create Schema Silver;
Go

Create Schema Gold;
Go 
