CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    IF (SELECT COUNT(*) FROM INSERTED) > 1 AND EXISTS (SELECT ID_SKU, COUNT(*) as cnt FROM INSERTED GROUP BY ID_SKU HAVING COUNT(*) >= 2)
    BEGIN
        UPDATE b
        SET DiscountValue = b.Value * 0.05
        FROM dbo.Basket b
        JOIN INSERTED i ON i.ID = b.ID
        WHERE b.ID_SKU = i.ID_SKU
    END
    ELSE
    BEGIN
        UPDATE b
        SET DiscountValue = 0
        FROM dbo.Basket b
        JOIN INSERTED i ON i.ID = b.ID
        WHERE b.ID_SKU = i.ID_SKU
    END
END