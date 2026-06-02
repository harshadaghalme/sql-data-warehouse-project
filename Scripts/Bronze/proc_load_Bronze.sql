/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
Loads data from source CSV files into the Bronze layer tables.

- Truncates existing data in Bronze tables.
- Uses BULK INSERT to load data from source files.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE Bronze.load_Bronze as 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME , @batch_start_time DATETIME , @batch_end_time DATETIME;

	BEGIN TRY
	SET @batch_start_time = GETDATE();
	print '==============================================================================================';
	print 'Loading Bronze Layer';
	print '==============================================================================================';

	print '----------------------------------------------------------------------------------------------';
	print 'Loading CRM Tables';
	print '----------------------------------------------------------------------------------------------';

	SET @start_time = GETDATE();
	print '>>> Truncating : Bronze.crm_cust_info';
	TRUNCATE TABLE Bronze.crm_cust_info;

	print '>>> Inserting : Bronze.crm_cust_info';
	BULK INSERT Bronze.crm_cust_info
	from 'C:\sql\DWH_SQL_Project\Dataset\source_crm\cust_info.csv'
	with (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	print '>> Load Duration: ' + CAST (DATEDIFF(SECOND , @start_time , @end_time) as NVARCHAR) + 'seconds';
	print '-----------------------------------------------------------------------------------------------';

	SET @start_time = GETDATE();
	print '>>> Truncating : Bronze.crm_prd_info';
	TRUNCATE TABLE Bronze.crm_prd_info;

	print '>>> Inserting : Bronze.crm_prd_info';
	BULK INSERT Bronze.crm_prd_info
	from 'C:\sql\DWH_SQL_Project\Dataset\source_crm\prd_info.csv'
	with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	print '>> Load Duration:' + CAST (DATEDIFF(SECOND , @start_time , @end_time ) as NVARCHAR) + 'seconds';
	print'------------------------------------------------------------------------------------------------';
	
	SET @start_time = GETDATE();
	print '>>> Truncating : Bronze.crm_sales_details';
	TRUNCATE TABLE Bronze.crm_sales_details;

	print '>>> Inserting : Bronze.crm_sales_details';
	BULK INSERT Bronze.crm_sales_details
	from 'C:\sql\DWH_SQL_Project\Dataset\source_crm\sales_details.csv'
	with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	print '>> Load Duration: ' + CAST (DATEDIFF(SECOND , @start_time , @end_time) as NVARCHAR ) + 'seconds';
	print '-----------------------------------------------------------------------------------------------';


	print '----------------------------------------------------------------------------------------------';
	print 'Loading ERP Tables';
	print '----------------------------------------------------------------------------------------------';

	SET @start_time = GETDATE();
	print '>>> Truncating : Bronze.erp_CUST_AZ12';
	TRUNCATE TABLE Bronze.erp_CUST_AZ12;

	print '>>> Inserting : Bronze.erp_CUST_AZ12';
	BULK INSERT Bronze.erp_CUST_AZ12
	from 'C:\sql\DWH_SQL_Project\Dataset\source_erp\CUST_AZ12.csv'
	with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	print ' >> Load Duration: '  + CAST(DATEDIFF(SECOND , @start_time , @end_time) as NVARCHAR) + 'seconds';
	print ' ---------------------------------------------------------------------------------------------';


	SET @start_time = GETDATE();
	print '>>> Truncating : Bronze.erp_LOC_A101';
	TRUNCATE TABLE Bronze.erp_LOC_A101;

	print '>>> Inserting : Bronze.erp_LOC_A101';
	BULK INSERT Bronze.erp_LOC_A101
	from 'C:\sql\DWH_SQL_Project\Dataset\source_erp\LOC_A101.csv'
	with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	print '>> Load Duration: ' + CAST(DATEDIFF(SECOND , @start_time , @end_time) as NVARCHAR) + 'seconds';
	print '---------------------------------------------------------------------------------------------';

	SET @start_time = GETDATE();
	print '>>> Truncating : Bronze.erp_PX_CAT_G1V2';
	TRUNCATE TABLE Bronze.erp_PX_CAT_G1V2;

	print '>>> Inserting : Bronze.erp_PX_CAT_G1V2';
	BULK INSERT Bronze.erp_PX_CAT_G1V2
	from 'C:\sql\DWH_SQL_Project\Dataset\source_erp\PX_CAT_G1V2.csv'
	with(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	print '>> Load Duration: ' + CAST(DATEDIFF(SECOND , @start_time , @end_time) as NVARCHAR) + 'seconds';
	print '---------------------------------------------------------------------------------------------';

	SET @batch_end_time = GETDATE();
	print '==========================================================================================================';
	print ' Loading Bronze Completed.'
	print ' -- Total Duration : ' + CAST(DATEDIFF(SECOND, @batch_start_time , @batch_end_time ) as NVARCHAR) + 'seconds';
	print '===========================================================================================================';

	END TRY 
	BEGIN CATCH 
	print '==================================================================================================';
	print 'Error occurred during loading Bronze layer';
	print 'Error Message' + ERROR_MESSAGE();
	print 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	print 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	print '==================================================================================================';

	END CATCH 

end
