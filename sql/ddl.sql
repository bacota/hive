-- Could be loaded from plsql with
-- \copy  zip_codes (zip_code, city, state) from 'new-zip-codes.csv' csv;
create sequence zip_code_seq;
create table zip_codes(
       id int primary key default nextval('zip_code_seq'),
       zip_code varchar,
       city varchar,
       state varchar
);

Create table analyzed_data (
       id bigint primary key,
       City varchar,
       State varchar,
       Zip varchar,
       Age smallint,
       First_Name varchar,
       Segment varchar,
       Gender varchar,
       Ethnicity varchar,
       Marital varchar,
       Employment_Status varchar,
       Employment varchar,
       Title varchar,
       Education varchar,
       Own_Rent varchar,
       Tech_Support_Person varchar,
       HHI int,
       Children_in_Home varchar,
       Phone_Type varchar,
       Annual_Support_Requests varchar,
       Purchased_Protection bool,
       Number_of_Devices_with_Protection_Plans int,
       Perception_of_Protection varchar,
       TVs int,
       DVRs int,
       Gamed_Console int,
       Desktops int,
       Laptops int,
       Tablets int,
       Network_Router int,
       Printer int,
       Wearables int,
       Smartphones int,
       Handhelds int,
       Home_Automation int,
       Home_Hub int,
       Home_Appliances int,
       Hardware_Score float,
       Hourly_Daily varchar,
       Weekly varchar,
       Monthly_Yearly varchar,
       Software_Score float,
       Savviness_Index float,
       Protection_opinion float,
       Fear float,
       Anger float,
       Confident float,
       Joy float,
       Sadness float,
       Analytical float,
       Tentative float 
);


create sequence transcripts_id_seq;

create table transcripts (
       id bigint primary key default nextval('transcripts_id_seq'),
       User_id int,
       First_Name varchar,
       Task_id int,
       sub varchar,
       Media_URL varchar,
       Media_URL_Shared varchar,
       Type varchar,
       Processed_Text varchar
);
