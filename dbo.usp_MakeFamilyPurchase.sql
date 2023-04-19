CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        RAISERROR('Семьи с фамилией "%s" не существует', 16, 1, @FamilySurName);
        RETURN;
    END;

    DECLARE @PurchaseValue decimal(18, 2) = (SELECT SUM(Value) FROM dbo.Basket b JOIN dbo.Family f ON b.ID_Family = f.ID WHERE f.SurName = @FamilySurName);

    UPDATE dbo.Family SET BudgetValue = BudgetValue - @PurchaseValue WHERE SurName = @FamilySurName;
END;