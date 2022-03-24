create or replace stream superstore_stream on table superstore;

update superstore set region='west' where row_id=8;

select * from superstore_stream;