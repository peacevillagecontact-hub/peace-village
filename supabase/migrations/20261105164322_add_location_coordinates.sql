-- Adds optional map-pin coordinates to public.locations, for the new Map page.
-- Nullable: a submitted location with no coordinates simply has no pin yet (it still
-- shows up anywhere else locations are listed as text).

alter table public.locations
  add column latitude numeric(9,6),
  add column longitude numeric(9,6);

comment on column public.locations.latitude is 'Optional map pin latitude, -90 to 90. Null = location has no map pin yet.';
comment on column public.locations.longitude is 'Optional map pin longitude, -180 to 180. Null = location has no map pin yet.';

alter table public.locations
  add constraint locations_latitude_range check (latitude is null or (latitude >= -90 and latitude <= 90)),
  add constraint locations_longitude_range check (longitude is null or (longitude >= -180 and longitude <= 180));
