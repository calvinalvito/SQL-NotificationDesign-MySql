use mysql_notification;

-- USER
create table "user"(
    id varchar(100) not null,
    name varchar(100)
);

--Notification
CREATE TABLE notification (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    create_at TIMESTAMP NOT NULL,
    user_id VARCHAR(100)
) ENGINE=InnoDB;

--Menambahkan 
ALTER TABLE notification
ADD CONSTRAINT fk_notification_user
FOREIGN KEY (user_id) REFERENCES user(id);

--Deskripsi Tabel Notification
DESC notification;

insert into notification(
    title,detail,create_at,user_id
) 
values ('Contoh Pesanan','Detail Pesanan',CURRENT_TIMESTAMP(),'Budi');

insert into notification(
    title,detail,create_at,user_id
) 
values ('Contoh Promo','Detail Promo',CURRENT_TIMESTAMP(), null);

insert into notification(
    title,detail,create_at,user_id
) 
values ('Contoh Pembayaran','Detail Pembayaran',CURRENT_TIMESTAMP(), 'Santoso');

select * from notification;

select * from notification where (user_id='Santoso' or user_id is null) ORDER BY create_at DESC;

select * from notification where (user_id='Budi' or user_id is null) ORDER BY create_at DESC;

--Category
CREATE TABLE category(
    id varchar(100) not null,
    name varchar(100) not null,
    primary key(id)
)ENGINE=InnoDB;

ALTER TABLE notification
ADD COLUMN category_id VARCHAR(100);

DESCRIBE notification;

--Menghubungkan category dan notification
ALTER TABLE notification
ADD CONSTRAINT fk_notification_category
FOREIGN KEY (category_id) REFERENCES category(id);

DESCRIBE notification;

select * from notification;

insert into category(
    id,name
) VALUES ('Info', 'Info'),
('Promo','Promo');

UPDATE notification SET `category_id` = 'Info'
where id=1;
UPDATE notification SET `category_id` = 'Promo'
where id=2;
UPDATE notification SET `category_id` = 'Info'
where id=3;

select * from notification;
select * from category;

select * from notification where (user_id='Budi' or user_id is null) ORDER BY create_at DESC;

select * from notification n JOIN category c on (n.`category_id` = c.id)
where (n.user_id='Budi' or n.user_id is null) ORDER BY n.create_at DESC;

select * from notification n JOIN category c on (n.`category_id` = c.id)
where (n.user_id='Santoso' or n.user_id is null) ORDER BY n.create_at DESC;

--Read & Unread Notification
CREATE TABLE notification_read(
    id int not null AUTO_INCREMENT,
    is_read boolean not null,
    notification_id int not null,
    user_id varchar(100) not null,
    PRIMARY key (id)
)ENGINE = InnoDB;

ALTER TABLE `notification_read`
ADD CONSTRAINT fk_notification_read_notification
FOREIGN KEY (notification_id) REFERENCES notification(id);

ALTER TABLE `notification_read`
ADD CONSTRAINT fk_notification_read_user
FOREIGN KEY (user_id) REFERENCES user(id);

DESC notification_read;

select * from notification;

insert into `notification_read`(is_read, `notification_id`,`user_id`)
values(true,2,'Santoso');
insert into `notification_read`(is_read, `notification_id`,`user_id`)
values(true,2,'Budi');

--Cek Notifikasi
select * from notification n 
JOIN category c on (n.`category_id` = c.id)
LEFT JOIN notification_read nr on (nr.`notification_id` = n.id)
where (n.user_id='Santoso' or n.user_id is null) 
AND (nr.user_id='Budi' or nr.`user_id` is null)
ORDER BY n.create_at DESC;

--Counter
-- Melihat Notifikasi berapa banyak
select count(*) from notification n 
JOIN category c on (n.`category_id` = c.id)
LEFT JOIN notification_read nr on (nr.`notification_id` = n.id)
where (n.user_id='Santoso' or n.user_id is null) 
AND (nr.`user_id` is null)
ORDER BY n.create_at DESC;





