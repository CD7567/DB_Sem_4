INSERT INTO cd.clients (card_num, first_name, last_name, phone, email, age, sex, birth_date)
VALUES
('4200 8898 9047 4864', 'Mike', 'Taylor', '+1-(614)-949-24-10', 'mike.taylor@yahoo.com', 39, 'male', '1984-1-21'),
('4200 4417 8858 4441', 'Emily', 'Smith', '+2-(898)-912-21-37', 'emily.smith@yahoo.com', 43, 'female', '1980-1-12'),
('4200 7562 6339 9515', 'Barbara', 'Schmidt', '+1-(452)-705-35-06', 'barbara.schmidt@aol.com', 39, 'female', '1985-12-27'),
('4200 9156 7511 9715', 'Steve', 'Smith', '+2-(227)-008-06-21', 'steve.smith@aol.com', 34, 'male', '1989-3-24'),
('4200 2159 6560 1679', 'Kiki', 'Laurence', '+1-(080)-728-14-79', 'kiki.laurence@aol.com', 27, 'female', '1996-2-1'),
('4200 6619 3025 4007', 'Kiki', 'Euler', '+1-(652)-125-28-98', 'kiki.euler@aol.com', 27, 'female', '1996-3-11'),
('4200 7485 8447 8563', 'Barbara', 'Trump', '+1-(884)-976-31-85', 'barbara.trump@gmail.com', 33, 'female', '1991-11-26'),
('4200 0033 3749 3650', 'Kim', 'Smith', '+2-(555)-556-15-25', 'kim.smith@gmail.com', 23, 'female', '2000-2-12'),
('4200 4959 2906 8980', 'Kim', 'Schmidt', '+1-(920)-425-97-46', 'kim.schmidt@yahoo.com', 63, 'female', '1960-4-2'),
('4200 2780 2493 8770', 'Kiki', 'Pines', '+1-(536)-757-99-26', 'kiki.pines@yahoo.com', 39, 'female', '1984-3-2');

INSERT INTO cd.shops (name, category, website, email)
VALUES
('Auchan', 'Supermarket', 'auchan.com', 'reception@auchan.com'),
('7-Eleven', 'Supermarket', '7-eleven.com', NULL),
('IKEA', 'Home', 'ikea.com', NULL),
('OBI', 'Home', 'obi.com', NULL),
('Osteria Mario', 'Restaurant', 'osteriamario.com', NULL),
('Il Patio', 'Restaurant', 'ilpatio.com', NULL),
('Converse', 'Clothing', 'converse.com', NULL),
('O`Stin', 'Clothing', 'ostin.com', NULL),
('Decathlon', 'Sports', 'decathlon.com', NULL),
('All Sport Store', 'Sports', 'allsportstore.com', NULL);

INSERT INTO cd.items (vendor_code, category, name, manufacturer)
VALUES
('4 672126 892993', 'Grocery', 'Spagnetti n.4', 'Barilla'),                     --1
('1 177327 167493', 'Grocery', 'Parmesan Cheese', 'Auchan'),                    --2
('8 086321 350743', 'Grocery', 'Honey Flakes', 'Tyson Foods'),                  --3
('3 098036 796916', 'Meat', 'Ground Beef 1kg', 'Tyson Foods'),                  --4
('7 612043 909289', 'Meat', 'Ribeye Steak', 'Hormel'),                          --5
('0 966119 526102', 'Paultry', 'Chicken Legs 1 kg', 'Auchan'),                  --6
('3 211468 723510', 'Paultry', 'Chicken Wings 1 kg', 'Hormel'),                 --7
('6 647173 710313', 'Decoration', 'Floor Lamp 1.5 m White', 'IKEA'),            --8
('2 953620 747482', 'Decoration', 'Floor Lamp 1.4 m Black', 'GP'),              --9
('7 792845 242541', 'Decoration', 'Curtains Striped Blue', 'Lane'),             --10
('6 078542 947620', 'Wall decoration', 'Painting 30`', 'IKEA'),                 --11
('8 021041 132683', 'Wall decoration', 'Wallpapers Beige Geometric', 'OBI'),    --12
('0 427915 711775', 'Fragrance', 'Home Fragrance Grapefruit', 'Breesal'),       --13
('8 640530 587074', 'Fragrance', 'Home Fragrance Cherry', 'Glade'),             --14
('7 900689 307055', 'Vegetable dish', 'Coleslaw Salad', NULL),                  --15
('2 766582 630862', 'Vegetable dish', 'Grilled Veggies', NULL),                 --16
('5 255050 318855', 'Vegetable dish', 'Onion Soup', NULL),                      --17
('9 055082 362186', 'Dessert', 'Ice Cream', NULL),                              --18
('6 250971 147155', 'Dessert', 'Red Velvet', NULL),                             --19
('1 340542 290409', 'Takeaway', '3 Pizzas Combo', NULL),                        --20
('1 331185 074059', 'Takeaway', '2 Noodle Bowls', NULL),                        --21
('0 601262 270333', 'Outerwear', 'Black Jacket', 'Converse'),                   --22
('4 888931 518418', 'Outerwear', 'White Jacket', 'O`Stin'),                     --23
('6 035533 719044', 'Underwear', 'Striped Sport Bra', 'Rainbow Textile'),       --24
('2 825807 047255', 'Underwear', 'Black Underpants', 'Rainbow Textile'),        --25
('9 552015 879056', 'Shoes', 'Black Sneakers', 'Nike'),                         --26
('8 481962 818141', 'Shoes', 'Fullblack Chuck 45', 'Converse'),                 --27
('3 460084 287432', 'Shoes', 'White All-Star', 'Converse'),                     --28
('1 497056 311156', 'Sport food', 'Protein Bar', '7Lb'),                        --29
('7 145410 117880', 'Sport food', 'Oxygenated Water', '7Lb'),                   --30
('7 292205 333484', 'Sport food', 'Protein Supplement', 'GNC'),                 --31
('8 926950 480032', 'Gym equipment', 'Barbell Weight 10 kg', 'Barbell'),        --32
('5 082237 277779', 'Gym equipment', 'Yoga Mat', 'Outventure'),                 --33
('6 560525 067363', 'Accessories', 'Rain Coat', 'Outventure'),                  --34
('5 036314 986704', 'Accessories', 'Black Sunglasses', 'Ray-Ban');              --35

INSERT INTO cd.items_info (item_id, shop_id, price)
VALUES
(1, 1, 0.30),
(1, 2, 0.31),
(2, 1, 2.00),
(3, 2, 1.50),
(4, 1, 10.1),
(4, 2, 10.2),
(5, 2, 3.00),
(6, 1, 3.00),
(7, 1, 3.52),
(7, 2, 3.51),
(8, 3, 50.00),
(9, 4, 55.00),
(10, 3, 10.00),
(10, 4, 10.00),
(11, 3, 30.00),
(12, 4, 40.00),
(13, 3, 16.00),
(13, 4, 15.50),
(14, 3, 15.50),
(14, 4, 16.00),
(15, 5, 15.00),
(15, 6, 15.00),
(16, 5, 10.00),
(16, 6, 11.00),
(17, 6, 15.00),
(17, 5, 10.00),
(18, 5, 1.00),
(18, 6, 1.00),
(19, 5, 5.00),
(19, 6, 5.00),
(20, 6, 30.0),
(21, 5, 20.0),
(22, 7, 100.0),
(23, 8, 90.0),
(24, 8, 20.0),
(24, 9, 20.0),
(24, 10, 20.0),
(25, 8, 10.0),
(25, 9, 10.0),
(25, 10, 10.0),
(26, 10, 90.0),
(26, 9, 90.0),
(27, 7, 90.0),
(27, 9, 90.0),
(28, 7, 95.0),
(28, 10, 95.0),
(29, 10, 2.0),
(29, 9, 2.0),
(29, 2, 2.0),
(30, 10, 4.0),
(30, 9, 4.0),
(31, 10, 20.0),
(31, 9, 20.0),
(32, 9, 40.0),
(33, 10, 15.0),
(34, 10, 30.0),
(34, 8, 40.0),
(34, 7, 35.0),
(35, 9, 100.0),
(35, 10, 105.0);

INSERT INTO cd.offers (name, start_dttm, expiration_dttm, status)
VALUES
('Vegetable dishes weekend', '2023-02-25 00:00:00', '2023-02-27 00:00:00', FALSE),
('Auchan products weekend', '2023-02-11 00:00:00', '2023-02-13 00:00:00', FALSE),
('Sports food friday', '2023-04-14 00:00:00', '2023-04-15 00:00:00', FALSE),
('Meating christmas', '2022-12-25 00:00:00', '2023-01-01 00:00:00', FALSE),
('Home with IKEA', '2023-04-01 00:00:00', '2023-05-01 00:00:00', TRUE),
('Combo sunday', '2023-03-05 00:00:00', '2023-03-06 00:00:00', FALSE),
('Converse in Converse', '2023-03-01 00:00:00', '2023-03-08 00:00:00', FALSE),
('Adventure Outventure', '2023-01-01 00:00:00', '2023-01-15 00:00:00', FALSE),
('Decor fest', '2023-04-18 00:00:00', '2023-04-25 00:00:00', FALSE),
('Fragrant weekend', '2023-04-08 00:00:00', '2023-04-10 00:00:00', FALSE);

INSERT INTO cd.offers_content (offer_id, item_id, shop_id, interest)
VALUES
(1, 15, 5, 0.1),
(1, 15, 6, 0.1),
(1, 16, 5, 0.1),
(1, 16, 6, 0.1),
(1, 17, 6, 0.1),
(2, 2, 1, 0.05),
(2, 6, 1, 0.05),
(3, 30, 10, 0.07),
(3, 31, 9, 0.07),
(4, 4, 1, 0.15),
(4, 4, 2, 0.15),
(4, 5, 2, 0.15),
(5, 14, 3, 0.05),
(5, 13, 3, 0.05),
(6, 20, 6, 0.07),
(6, 21, 5, 0.10),
(7, 8, 3, 0.05),
(7, 9, 4, 0.05),
(8, 13, 3, 0.10),
(8, 14, 3, 0.10),
(8, 13, 4, 0.08),
(8, 14, 4, 0.05),
(9, 8, 3, 0.07),
(9, 11, 3, 0.07),
(10, 14, 3, 0.05),
(10, 13, 3, 0.05);

INSERT INTO cd.transactions (client_id, type, total_bonuses, time, status)
VALUES
(1, 'gift', 5, '2022-01-21 00:00:00', 'successful'),
(2, 'gift', 5, '2022-01-12 00:00:00', 'successful'),
(3, 'gift', 5, '2022-12-27 00:00:00', 'successful'),
(4, 'gift', 5, '2022-03-24 00:00:00', 'successful'),
(5, 'gift', 5, '2022-02-01 00:00:00', 'successful'),
(1, 'purchase', 6, '2023-02-26 10:00:00', 'successful'),
(2, 'purchase', 0.551, '2022-02-12 11:00:00', 'successful'),
(3, 'purchase', 9.25, '2022-03-05 12:00:00', 'successful'),
(4, 'purchase', 2.6, '2022-02-26 13:00:00', 'successful'),
(9, 'purchase', 1.55, '2022-04-09 14:00:00', 'successful'),
(1, 'spend', 3, '2023-03-10 12:30:27', 'successful'),
(2, 'spend', 4, '2023-03-11 13:40:28', 'successful'),
(5, 'spend', 5, '2023-03-12 14:50:29', 'aborted');

INSERT INTO cd.transactions_content (transaction_id, item_id, quantity, bonus_count)
VALUES
(6, 15, 2, 3),
(6, 16, 3, 3),
(7, 2, 2, 0.2),
(7, 6, 2, 0.351),
(8, 27, 1, 4.5),
(8, 28, 1, 4.75),
(9, 15, 1, 1.5),
(9, 16, 2, 1.1),
(10, 13, 1, 0.8),
(10, 14, 1, 0.75);

INSERT INTO cd.clients_history (client_id, event_dttm, event_type)
VALUES
(1, '2021-12-01 12:00:00', 'join'),
(2, '2021-12-02 13:00:00', 'join'),
(3, '2021-12-03 14:00:00', 'join'),
(4, '2021-12-04 15:00:00', 'join'),
(5, '2021-12-05 16:00:00', 'join'),
(6, '2021-12-06 17:00:00', 'join'),
(7, '2021-12-07 18:00:00', 'join'),
(8, '2021-12-08 19:00:00', 'join'),
(9, '2021-12-09 20:00:00', 'join'),
(10, '2021-12-10 21:00:00', 'join'),
(7, '2022-06-05 14:00:00', 'pause'),
(7, '2022-06-06 17:00:00', 'resume'),
(7, '2022-07-05 19:00:00', 'leave');

INSERT INTO cd.clients_wallet (client_id, balance)
VALUES
(1, 8),
(2, 1.551),
(3, 14.25),
(4, 7.6),
(5, 5),
(6, 0),
(7, 0),
(8, 0),
(9, 1.55),
(10, 0);

INSERT INTO cd.clients_wallet_history (client_id, transaction_id, balance, rewrite_dttm)
VALUES
(1, 1, 5, '2022-01-21 00:00:00'),
(1, 6, 11, '2023-02-26 10:00:00'),
(1, 11, 8, '2023-03-10 12:30:27'),
(2, 2, 5, '2022-01-12 00:00:00'),
(2, 7, 5.551, '2022-02-12 11:00:00'),
(2, 12, 1.551, '2023-03-11 13:40:28'),
(3, 3, 5, '2022-12-27 00:00:00'),
(3, 8, 14.25, '2022-03-05 12:00:00'),
(4, 4, 5, '2022-03-24 13:00:00'),
(4, 9, 7.6, '2022-02-26 13:00:00'),
(5, 5, 5, '2022-02-01 00:00:00'),
(5, 13, 0, '2023-03-12 14:50:29'),
(5, 13, 5, '2023-03-13 15:30:59'),
(9, 10, 1.55, '2022-04-09 14:00:00')