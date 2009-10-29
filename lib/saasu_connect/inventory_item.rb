module SaasuConnect
  class InventoryItem
    attr_accessor :uid, :lastUpdatedUid, :code, :description, :isActive, :notes, :isInventoried, :assetAccountUid, :stockOnHand, :currentValue, :isBought, :purchaseExpenseAccountUid, :purchaseTaxCode, :minimumStockLevel, :primarySupplierContactUid, :primarySupplierItemCode, :defaultReOrderQuantity, :buyingPrice, :isBuyingPriceIncTax, :isSold, :saleIncomeAccountUid, :saleTaxCode, :saleCoSAccountUid, :sellingPrice, :isSellingPriceIncTax
  end
end
