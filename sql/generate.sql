-- Use something like this:
-- select gen_data(0,10000000);
-- then advisable to "analyze analyzed_data' to update statistics


create extension "uuid-ossp";

create or replace function gen_data(start integer, num_records integer)
returns void as $$
declare
    i integer := start;
    zip_id integer := 0;
    zip_code varchar;
    state varchar;
    city varchar;
begin
    while i < num_records loop
          i := i+1;

          select 1+cast(random()*74021 as int) into zip_id;

          select z.city, z.state, z.zip_code into city, state, zip_code
          from zip_codes z where z.id = zip_id;

          insert into analyzed_data
          select i as id, city, state, zip_code,
                 cast(random()*100 as smallint) as age,
                 uuid_generate_v4() as First_Name,
                 uuid_generate_v4() as Segment,
                 case when random() < 0.5 then 'Male' else 'Female' end as Gender,
                 case when random() < 0.5 then 'Caucasian' else 'African American' end as  Ethnicity ,
                 case when random() < 0.5 then 'Married' else 'Single' end as  Marital ,
                  case when random() < 0.5 then 'Self-Employed' else 'Working' end as  Employment_Status ,
       uuid_generate_v4() as Employment,
       uuid_generate_v4() as Title ,
       'Associates degree' as Education,
       case when random() < 0.5 then 'Own' else 'Rent' end as Own_Rent,
       uuid_generate_v4() as Tech_Support_Person,
       cast(random()*100000 as int) as HHI,
       cast(random()*3 as int) as Children_in_Home,
       uuid_generate_v4() as Phone_Type,
       uuid_generate_v4() as Annual_Support_Requests,
       cast(case when random() < 0.5 then '1' else '0' end
                 as boolean) as Purchased_Protection,
       cast(random()*10 as int) as Number_of_Devices_with_Protection_Plans,
       uuid_generate_v4() as Perception_of_Protection,
       cast(random()*3 as int) as TVs, 
       cast(random()*3 as int) as DVRs,
       cast(random()*3 as int) as Gamed_Console,
       cast(random()*3 as int) as Desktops,
       cast(random()*3 as int) as Laptops,
       cast(random()*3 as int) as Tablets,
       cast(random()*3 as int) as Network_Router,
       cast(random()*3 as int) as Printer,
       cast(random()*3 as int) as Wearables,
       cast(random()*3 as int) as Smartphones,
       cast(random()*3 as int) as Handhelds,
       cast(random()*3 as int) as Home_Automation,
       cast(random()*3 as int) as Home_Hub,
       cast(random()*3 as int) as Home_Appliances,
       1000*random() as Hardware_Score,
       uuid_generate_v4() as Hourly_Daily,
       uuid_generate_v4() as Weekly,
       uuid_generate_v4() as Monthly_Yearly,
       1000*random() as Software_Score,
       1000*random() as Savviness_Index,
       1000*random() as Protection_opinion,
       1000*random() as Fear,
       1000*random() as Anger,
       1000*random() as Confident,
       1000*random() as Joy,
       1000*random() as Sadness,
       1000*random() as Analytical,
       1000*random() as Tentativex ;
    end loop;
end;
$$ language plpgsql;
