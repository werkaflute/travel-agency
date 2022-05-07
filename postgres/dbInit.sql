--CREATE TABLES
CREATE TABLE Destinations (
    ID smallint NOT NULL,
    Country character varying(255) NOT NULL,
    City character varying(255) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Hotels (
    ID smallint NOT NULL,
    Name character varying(255) NOT NULL,
	Destination_ID smallint NOT NULL,
	Rating real NOT NULL,
	Food character varying(36) NOT NULL,
	Stars smallint,
	PRIMARY KEY (ID),
	CONSTRAINT Destination_ID FOREIGN KEY(Destination_ID) REFERENCES Destinations(ID)
);

CREATE TABLE HotelRoomTypes (
    ID smallint NOT NULL,
    Name character varying(36) NOT NULL,
    Capacity_people smallint NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE HotelRooms (
	ID smallint NOT NULL,
	Hotel_ID smallint NOT NULL,
	RoomType_ID smallint NOT NULL,
	PRIMARY KEY (ID),
	CONSTRAINT Hotel_ID FOREIGN KEY(Hotel_ID) REFERENCES Hotels(ID),
	CONSTRAINT RoomType_ID FOREIGN KEY(RoomType_ID) REFERENCES HotelRoomTypes(ID)
);

CREATE TABLE HotelRoomAvailabilities (
    ID smallint NOT NULL,
    HotelRoom_ID smallint NOT NULL,
    Quantity smallint NOT NULL,
    Date date NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT HotelRoom_ID FOREIGN KEY(HotelRoom_ID) REFERENCES HotelRooms(ID)
);

CREATE TABLE Tours (
    ID character varying(36) NOT NULL,
    Name character varying(255) NOT NULL,
    Country character varying(255) NOT NULL,
	Rating real NOT NULL,
	Food character varying(36) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE Events (
    ID uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    Username character varying(32) NOT NULL,
    RoomType_ID smallint NOT NULL, 
    TripReservation_Id uuid NOT NULL UNIQUE, 
    Type character varying(16) NOT NULL,
    Hotel_ID smallint NOT NULL,
    StartDate date NOT NULL,
    EndDate date NOT NULL,
    CONSTRAINT Hotel_ID FOREIGN KEY(Hotel_ID) REFERENCES Hotels(ID)
);

--TEST DATA

INSERT INTO Destinations(ID, Country, City)
VALUES
	(1, 'Polska', 'Gdańsk'),
	(2, 'Polska', 'Warszawa'),
	(3, 'Francja', 'Paryż'),
	(4, 'Włochy', 'Rzym');
	
INSERT INTO Hotels(ID, Name, Destination_ID, Rating, Food, Stars)
VALUES
	(1, 'Hotel GDA', 1, 4.7, '2 posilki', 3),
	(2, 'Mariott', 2, 5.5, '2 posilki', 5),
	(3, 'France hotel', 3, 5.5, '2 posilki', 5),
	(4, 'Italy hotel', 4, 5.5, '2 posilki', 5);
	
INSERT INTO HotelRoomTypes(ID, Name, Capacity_people)
VALUES 
    (1, 'Small Room', 1),
    (2, 'Medium Room', 2),
    (3, 'Large Room', 3),
    (4, 'Apartment', 4),
    (5, 'Family Room', 5),
    (6, 'Big Apartment', 6),
    (7, 'Big Family Room', 7),
    (8, 'Small Room Premium', 1),
    (9, 'Medium Room Premium', 2),
    (10, 'Large Room Premium', 3),
    (11, 'Apartment Premium', 4),
    (12, 'Family Room Premium', 5);

INSERT INTO HotelRooms(ID, Hotel_ID, RoomType_ID)
VALUES
	(1, 1, 1),
	(2, 1, 8),
	(3, 2, 8),
	(4, 2, 9),
	(5, 2, 11),
    (6, 3, 1),
    (7, 3, 2),
    (8, 3, 4),
    (9, 4, 1),
    (10, 4, 2),
    (11, 4, 4),
    (12, 4, 11);

INSERT INTO HotelRoomAvailabilities(ID, HotelRoom_ID, Quantity, Date)
VALUES 
    (1, 1, 3, '2022-05-20'),
    (2, 1, 3, '2022-05-21'),
    (3, 1, 3, '2022-05-22'),
    (4, 1, 2, '2022-05-23'),
    (5, 1, 2, '2022-05-24'),
    (6, 1, 2, '2022-05-25'),
    (7, 1, 2, '2022-05-26');

CREATE DATABASE transportsdb;
\connect transportsdb;


CREATE TABLE Places (
    ID bigserial NOT NULL,
    Country character varying(255) NOT NULL,
    City character varying(255) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE Transport (
    ID bigserial NOT NULL,
    Destination_Places_ID bigserial NOT NULL,
    Source_Places_ID bigserial NOT NULL,
    TransportType character varying(255) NOT NULL,
    TransportDate DATE NOT NULL,
    Places int NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT Destination_Places_ID FOREIGN KEY(Destination_Places_ID) REFERENCES Places(ID),
    CONSTRAINT Source_Places_ID FOREIGN KEY(Source_Places_ID) REFERENCES Places(ID)
);
-- ID bigserial NOT NULL,
CREATE TABLE TransportEvent (
    ID uuid DEFAULT gen_random_uuid() ,
    Transport_ID bigserial NOT NULL,
    Event_ID uuid NOT NULL,
    Places int NOT NULL,
    Type character varying(16) NOT NULL,
    Username character varying(32) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT Transport_ID FOREIGN KEY(Transport_ID) REFERENCES Transport(ID)
);

INSERT INTO Places(ID, Country, City)
VALUES
    (1, 'Polska', 'Gdańsk'),
    (2, 'Polska', 'Warszawa'),
    (3, 'Włochy', 'Rzym'),
    (4, 'Włochy', 'Neapol'),
    (5, 'Francja', 'Paryż'),
    (6, 'Francja', 'Nicea');

INSERT INTO Transport(ID, Destination_Places_ID,Source_Places_ID,TransportType,TransportDate,Places)
VALUES
    (1, 3, 1,'Plane','2022-06-01',7),
    (2, 1, 3,'Plane', '2022-06-03',7),
    (7, 3, 1,'Bus','2022-06-01',7),
    (8, 1, 3,'Bus', '2022-06-03',7),
    (3, 4, 2,'Bus','2022-06-01',7),
    (4, 2, 4,'Plane','2022-06-03',7),
    (5, 5, 2,'Plane','2022-06-01',7),
    (6, 2, 6,'Plane','2022-06-03',7);

CREATE DATABASE trips;
\connect trips;

CREATE TABLE OrderedTrips
(
    Trip_ID uuid PRIMARY KEY,
    Username character varying(32) NOT NULL,
    Room_Type_Name character varying(32) NOT NULL,
    Country character varying(255) NOT NULL,
    City character varying(255) NOT NULL,
    Food character varying(36) NOT NULL,
    Transport_Type_Name character varying(16) NOT NULL,
    Hotel_Name character varying(255) NOT NULL,
    Persons int NOT NULL,
    StartDate date NOT NULL,
    EndDate date NOT NULL
);