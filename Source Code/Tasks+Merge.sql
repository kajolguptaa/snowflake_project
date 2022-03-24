CREATE TASK superstore_task
  WAREHOUSE = my_computer_warehouse
  SCHEDULE = '1 minute'
WHEN
  SYSTEM$STREAM_HAS_DATA('superstore_stream')
AS
merge into superstore_target t
using superstore_stream s
on t.row_id=s.row_id and (metadata$action='DELETE')
when matched and metadata$isupdate='FALSE' then update set rec_version=9999, stream_type='DELETE'
when matched and metadata$isupdate='TRUE' then update set rec_version=rec_version-1
when not matched then insert  (row_id,order_id,order_date,ship_date,ship_mode,customer_id,customer_name,segment,city,country,state,postal_code,region,product_id,category,sub_category,product_name,sales,quantity,discount,profit,stream_type,rec_version,REC_DATE) values(s.row_id, s.order_id,s.order_date,s.ship_date,s.ship_mode,s.customer_d,s.customer_name,s.segemnt,s.city,s.country,s.state,s.postal_code,s.region,s.product_id,s.category,s.sub_category,s.product_name,s.sales,s.quantity,s.discount,s.profit, metadata$action,0,CURRENT_TIMESTAMP() );

ALTER TASK superstore_task RESUME;