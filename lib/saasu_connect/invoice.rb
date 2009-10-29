module SaasuConnect
  class Invoice < Base
    attr_accessor :uid, :lastUpdatedUid, :date, :contactUid, :shipToContactUid, :folderUid, :tags, :reference, :summary, :notes, :requiresFollowUp, :dueOrExpiryDate, :layout, :status, :invoiceNumber, :purchaseOrderNumber, :invoiceItems, :quickPayment, :payments, :isSent, :transactionType

    def uid
      @uid.to_i
    end

    def date
      return @date if @date.is_a?(Date)
      Date.parse(@date)
    end

    def contactUid
      @contactUid.to_i
    end

    def shipToContactUid
      @shipToContactUid.to_i
    end

    def folderUid
      @folderUid.to_i
    end

    def requiresFollowUp
      return @requiresFollowUp == "true" if @requiresFollowUp.is_a?(String)
      @requiresFollowUp
    end

    def dueOrExpiryDate
      return @dueOrExpiryDate if @dueOrExpiryDate.is_a?(Date)
      Date.parse(@dueOrExpiryDate)
    end

    def isSent
      return @isSent == "true" if @isSent.is_a?(String)
      @isSent
    end
  end
end
