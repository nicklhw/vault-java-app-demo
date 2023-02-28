CREATE TABLE orders (
    id int NOT NULL AUTO_INCREMENT,
    customer_name varchar(250) NOT NULL,
    product_name varchar(250) NOT NULL,
    order_date timestamp NOT NULL,
    PRIMARY KEY (id)
);