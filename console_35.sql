CREATE SCHEMA bai6_ss9;

SET search_path TO bai6_ss9;

CREATE TABLE Products
(
    product_id  INT PRIMARY KEY,
    name        VARCHAR(255)   NOT NULL,
    price       NUMERIC(15, 2) NOT NULL,
    category_id INT            NOT NULL
);

INSERT INTO Products (product_id, name, price, category_id)
VALUES (1, 'Laptop Dell XPS', 1500.00, 1),
       (2, 'MacBook Pro M3', 2000.00, 1),
       (3, 'iPhone 15 Pro', 1000.00, 2),
       (4, 'Samsung Galaxy S24', 900.00, 2),
       (5, 'Sony WH-1000XM5', 350.00, 3);

CREATE OR REPLACE PROCEDURE
    update_product_price(p_category_id INT, p_increase_percent NUMERIC)
    LANGUAGE plpgsql
AS
$$
    DECLARE
    v_price_record RECORD;
    v_new_price NUMERIC(15, 2);
BEGIN

    FOR v_price_record IN SELECT  * FROM products WHERE category_id = p_category_id
    LOOP
        v_new_price := v_price_record.price*(1 +p_increase_percent/100) ;

        UPDATE products
        SET price = v_new_price
        WHERE v_price_record.product_id =  products.product_id;
    END LOOP;

end;
$$;

CALL update_product_price(1 ,10);