use tass;

CREATE TABLE Country (
  CountryCode VARCHAR(30) NOT NULL,
  CountryName VARCHAR(30),
  PRIMARY KEY (CountryCode)
);

CREATE TABLE City (
  CityCode VARCHAR(30) NOT NULL,
  CityName VARCHAR(30),
  CountryCode VARCHAR(30),
  PRIMARY KEY (CityCode),
  FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode) ON DELETE NO ACTION
															ON UPDATE CASCADE
);

CREATE TABLE Airline (
  AirlineCode VARCHAR(30) NOT NULL,
  AirlineName VARCHAR(30),
  CountryCode VARCHAR(30) NOT NULL,
  PRIMARY KEY (AirlineCode),
  FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode) ON DELETE NO ACTION
															 ON UPDATE CASCADE
);
                                                             
CREATE TABLE FLIGHT (
  FlightNumber VARCHAR(30) NOT NULL,
  BusinessClassIndicator VARCHAR(30),
  AirlineCode VARCHAR(30),
  PRIMARY KEY(FlightNumber),
  FOREIGN KEY (AirlineCode) REFERENCES Airline(AirlineCode) ON DELETE NO ACTION
															 ON UPDATE CASCADE
);


CREATE TABLE BookingOffice (
OfficeID VARCHAR(30) NOT NULL UNIQUE,
CityCode VARCHAR(30),
PRIMARY KEY (OfficeID),
FOREIGN KEY (CityCode) REFERENCES City(CityCode) ON DELETE NO ACTION
												 ON UPDATE CASCADE
                                                );

CREATE TABLE Currency (
Currency VARCHAR(30) NOT NULL UNIQUE,
Abbreviation VARCHAR(30),
CountryCode VARCHAR(30),
PRIMARY KEY(CountryCode),
FOREIGN KEY(CountryCode) REFERENCES Country(CountryCode) ON DELETE NO ACTION
														 ON UPDATE CASCADE
);

CREATE TABLE Airport (
AirportCode VARCHAR(30) NOT NULL,
AirportName VARCHAR(30),
AirportTax INT,
CityCode VARCHAR(30),
PRIMARY KEY(AirportCode),
FOREIGN KEY(CityCode) REFERENCES City(CityCode) ON DELETE NO ACTION
												ON UPDATE CASCADE
);

CREATE TABLE FlightAvailability (
FlightNumber VARCHAR(30) NOT NULL,
ArrivalDateTime date NOT NULL UNIQUE,
DepartureDateTime date NOT NULL UNIQUE,
TotalBusinessSeats INT,
BookedBusinessSeats INT,
TotalEconomySeats INT,
BookedEconomySeats INT,
OriginAirportCode VARCHAR(30),
DestinationAirportCode VARCHAR(30),
PRIMARY KEY (FlightNumber, ArrivalDateTime, DepartureDateTime),
FOREIGN KEY (FlightNumber) REFERENCES Flight(FlightNumber) ON DELETE NO ACTION
														   ON UPDATE CASCADE,
FOREIGN KEY (OriginAirportCode) REFERENCES Airport(AirportCode) ON DELETE NO ACTION
															    ON UPDATE CASCADE,
FOREIGN KEY (DestinationAirportCode) REFERENCES Airport(AirportCode) ON DELETE NO ACTION
															         ON UPDATE CASCADE
);

CREATE TABLE Class (
ClassID VARCHAR(30) NOT NULL UNIQUE,
class VARCHAR(30),
PRIMARY KEY (ClassID));

CREATE TABLE `Status` (
StatusID VARCHAR(30) NOT NULL UNIQUE,
`Status` VARCHAR(30),
PRIMARY KEY(StatusID));

CREATE TABLE Customer (
CustomerID VARCHAR(30) NOT NULL,
FirstName VARCHAR(30),
LastName VARCHAR(30),
Nationality VARCHAR(30),
Street VARCHAR(30),
City VARCHAR(30),
Province VARCHAR(30),
Country VARCHAR(30),
PostalCode VARCHAR(30),
PRIMARY KEY (CustomerID));

CREATE TABLE CustomerEmail (
CustomerID VARCHAR(30) NOT NULL,
Email VARCHAR(30) NOT NULL,
PRIMARY KEY (CustomerID, Email),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE NO ACTION
														 ON UPDATE CASCADE);

CREATE TABLE CustomerPhone(
CustomerID VARCHAR(30) NOT NULL,
LocalNumber VARCHAR(30) NOT NULL,
CountryCode VARCHAR(30) NOT NULL,
AreaCode VARCHAR(30),
PRIMARY KEY(CustomerID, LocalNumber, CountryCode),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE NO ACTION
														 ON UPDATE CASCADE);

CREATE TABLE `Exchange` (
FromCurrency VARCHAR(30) NOT NULL UNIQUE,
ToCurrency VARCHAR(30) NOT NULL UNIQUE,
`Date` date NOT NULL,
ExchangeRate DOUBLE,
PRIMARY KEY (FromCurrency, ToCurrency, `Date`),
FOREIGN KEY (FromCurrency) REFERENCES Currency(Currency) ON DELETE NO ACTION
														 ON UPDATE CASCADE,
FOREIGN KEY (ToCurrency) REFERENCES Currency(Currency) ON DELETE NO ACTION
													   ON UPDATE CASCADE
);

CREATE TABLE Booking (
BookingID VARCHAR(30) NOT NULL, 
BookingDate date,
FlightPrice DOUBLE,
FlightNumber VARCHAR(30),
ArrivalDateTime date,
DepartureDateTime date,
ClassID VARCHAR(30),
StatusID VARCHAR(30),
OfficeID VARCHAR(30),
CustomerID VARCHAR(30),
PRIMARY KEY(BookingID),
FOREIGN KEY(FlightNumber) REFERENCES Flight(FlightNumber) ON DELETE NO ACTION
														  ON UPDATE CASCADE,
FOREIGN KEY(ArrivalDateTime) REFERENCES FlightAvailability(ArrivalDateTime) ON DELETE NO ACTION
															                ON UPDATE CASCADE,
FOREIGN KEY(DepartureDateTime) REFERENCES FlightAvailability(DepartureDateTime) ON DELETE NO ACTION
															                    ON UPDATE CASCADE,
FOREIGN KEY(ClassID) REFERENCES Class(ClassID) ON DELETE NO ACTION
											   ON UPDATE CASCADE,
FOREIGN KEY(StatusID) REFERENCES `Status`(StatusID) ON DELETE NO ACTION
													ON UPDATE CASCADE,
FOREIGN KEY(OfficeID) REFERENCES BookingOffice(OfficeID) ON DELETE NO ACTION
														ON UPDATE CASCADE,
FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON DELETE NO ACTION
														ON UPDATE CASCADE
);

CREATE TABLE Payment (
PaymentID VARCHAR(30) NOT NULL,
PaymemntDate date,
PaidAmount DOUBLE,
Balance DOUBLE,
CustomerID VARCHAR(30),
BookingID VARCHAR(30),
PRIMARY KEY(PaymentID),
FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON DELETE NO ACTION
														ON UPDATE CASCADE,
FOREIGN KEY(BookingID) REFERENCES Booking(BookingID) ON DELETE NO ACTION
													 ON UPDATE CASCADE
)











