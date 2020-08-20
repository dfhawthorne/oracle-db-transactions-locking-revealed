column trace new_val TRACE

select c.value || '/diag/rdbms/' || e.db_unique_name || '/' || d.instance_name || '/trace/' || d.instance_name || '_ora_' || a.spid || '.trc' trace
  from v$process a, v$session b, v$parameter c, v$instance d, v$database e
 where a.addr = b.paddr
   and b.audsid = userenv('sessionid')
   and c.name = 'diagnostic_dest'
/

disconnect
!tkprof &TRACE ./tk.prf &1
-- connect /
connect eoda/eoda@trans_demo
host less tk.prf
