In order to allow flexiblity for future promotions I've abstracted the two discounts into two classes:
    - BulkPromotion which takes an item code, a threshold amount, and promotional price
    - TotalPromotion which takes a threshold price and a percentage

These Promotion classes have a common interface and respond to only one method ```calculate_discount_for(items, total)``` which returns the total discount: the amount to be subtracted from the total.

The promotions are calculated in the Checkout class based on the order inside the promotional_rules param. 

To run the tests:
```
rspec
```