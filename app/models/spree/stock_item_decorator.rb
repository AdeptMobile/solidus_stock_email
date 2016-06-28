Spree::StockItem.class_eval do
    after_save :send_stock_emails, if: :changed?
end

module Spree
    module StockItemExtensions
        def send_stock_emails
            Spree::StockEmail.notify(self.variant.product) if count_on_hand_was == 0 && count_on_hand > 0
        end
    end
end

::Spree::StockItem.prepend Spree::StockItemExtensions
