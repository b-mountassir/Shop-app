# E-commerce user stories

The following requirements are written base on the Behavior-Driven Stories. UI is not provided but let's use aliexpress for references.

## Authentication:
- [X] User should be able to create account and choose to be a buyer or a seller on signup page (default should be buyer)
- [X] User should be able to login with correct credentials. Using incorrect credentials should be rejected.
- [X] **Optional:** User should be able to change his info.

## Categories
- [X] Categories should be created by the platform admin, buyer and seller will use pre-made categogies.

## Buyer:
- [ ] **Buyer should be able to see categories and product on landing page.** (`host/`)
    - [ ] It is not required to show all categories on landing page. However trending categories should be displayed (like clothing, electronics...)
    - [ ] 5 products should be displayed for each trending categories order by latest created. **optional:** or most bought products
    - [ ] Each product should be displayed with main picture and name, price, seller name
- [ ] **Buyer should be able to search (by name) or filter products (by categories) and sort results by price.**
- [ ] **Buyer should be able to see products which belongs to a categories** using path: `host/category_name/`
- [ ] **Buyer should be able to see product details when he clicks on one.**
    - [ ] There should be a single product detail page showing all product details (UI [examples](https://www.aliexpress.com/item/1005001423263333.html))
- [ ] **Buyer should be able to add products to cart for making order**
    - [ ] Buyer should not be able to add products to cart if the stock quantity is not available
    - [ ] Buyer should be able to add different products to cart.
    - [ ] Cart should persist, meaning if he add products to cart and log out then login back, products should still be in cart.
- [ ] **Buyer should be able to make order from his current cart**
    - [ ] Buyer should not be able to do so if cart is empty
    - [ ] After successfully making the order, cart should be empty.
- [ ] **Buyer should be able to see his orders history. Each order record should show the following contents:**
    - [ ] Date purchased
    - [ ] Product name, small product picture, seller, price, quantity for each product and total for each product (price * quantity) and total bill.
    - [ ] Buyer should be able to see product detail and **optional:** seller detail when he clicks on product and seller
- [ ] **Buyer should be able to leave a review on product that he bought**
    - [ ] **Super Optional:** Buyer should be able to review for the product only once per order. And he should see purchased products which he has yet left a review

***Note: No need to handle payment, just assume that buyer can make any orders***

## Seller
- [ ] **Seller should be able to create products with the following contents**
    - [ ] Products should belong to at least 01 category
    - [ ] Required: Name, description, main picture, price, stock quantity
- [ ] **Seller should be able to manage products that he created:**
    - [ ] Toggle `published` to `true/false`. By default, after creating a product, seller should toggle it to `published` to make it public to buyers. Once product is published, it cannot be reverted to `false`. To discontinue a product see the next note
    - [ ] Toggle: `on_sale` to `true or false` to set a product is on sale or not. If user decides to stop selling a product, he should toggle `on_sale` to `false`. 
    - [ ] Seller should be able to change product detail for `not published` product. 
    - [ ] Seller should NOT be able to change details for `published` product except the stock quantity.
    - [ ] Do not hard-delete a product.
- [ ] **Seller should be able to see historical data:**
    - [ ] Seller should only see products that he sold in orders summary (together with details that associated to his products only, not other sellers)
    - [ ] Products he has sold and amount he has earned for each.
    - [ ] **Optional:** Clicking on each product, he should see more details: selling info.
    - [ ] **Optional:** Seller should be able to see all previous products a buyer has bought from him

## Product Stock
- [ ] Stock count should be updated (decrease) when user makes purchase, not adds to cart
- [ ] Buyer should not be able to add to cart if the stock user wants to add is greater than current stock count (frontend & backend)
- [ ] Buyer should not be able to make purchase if the number of product he wants to order is greater than current stock count, even if product is already added to cart (# of product added to cart is just temporary and not counted as user has yet make an order)


## Reviews
- Buyer can write review for products which he bought only (verified review), and only one time per purchase
- Reminder system: 
    - An email to reminder buyer to leave review for products which he bought and yet left review (after 1 day of the purchase time).
    - Reminder email should be sent only once / as many time as seller sets

