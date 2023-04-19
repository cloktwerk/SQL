CREATE FUNCTION dbo.udf_GetSKUPrice (@ID_SKU int)
RETURNS decimal(18, 2)
AS
BEGIN
    DECLARE @Price decimal(18, 2)

    SELECT @Price = SUM(Value) / SUM(Quantity)
    FROM dbo.Basket
    WHERE ID_SKU = @ID_SKU

    RETURN @Price
END;