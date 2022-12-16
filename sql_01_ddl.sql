-- создание таблиц --

CREATE TABLE publisher
(
	publisher_id integer PRIMARY KEY,
	org_name varchar(128) NOT NULL,
	address text NOT NULL

);

CREATE TABLE book
(
	book_id integer PRIMARY KEY,
	title text NOT NULL,
	isbn varchar(32) NOT NULL,
	fk_publisher_id integer REFERENCES publisher(publisher_id) NOT NULL

)
-- удаление таблиц --

DROP TABLE IF EXISTS publisher;
DROP TABLE IF EXISTS book 

-- выставка данных в таблицу --

INSERT INTO book
VALUES
(1, 'Название книги номер 1', '0000000001', 1),
(2, 'Название книги номер 2', '0000000002', 1),
(3, 'Название книги номер 3', '0000000003', 2),
(4, 'Название книги номер 4', '0000000004', 2),
(5, 'Название книги номер 5', '0000000005', 2);

INSERT INTO publisher
VALUES
(1, 'Наименование паблишера номер 1', 'Город 1'),
(2, 'Наименование паблишера номер 2', 'Город 1'),
(3, 'Наименование паблишера номер 3', 'Город 3'),
(4, 'Наименование паблишера номер 4', 'Город 4')

-- добавление данных в таблицу, если были пропущены -- 

alter table book
add column fk_publisher_id;

alter table book
add constraint fk_book_publisher
foreign key(fk_publisher_id) references publisher(publisher_id)
