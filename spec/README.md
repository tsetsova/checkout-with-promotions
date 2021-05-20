In order to allow flexiblity for future promotions I've abstracted the two discounts into two classes:
    - BulkPromotion which takes an item code, a threshold amount, and promotional price
    - TotalPromotion which takes a threshold price and a percentage

These Promotions classes have a commont interface and respond to only one method ```calculate_discount_for(items, total)```

The promotions are calculated in the Checkout class based on the order inside the promotional_rules param. 

To run the tests:
```
rspec
```