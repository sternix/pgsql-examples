select measured_at::time,
        (current_tx_id - coalesce(lag(current_tx_id, 1) over w, current_tx_id))
          / extract( epoch from  (measured_at - lag(measured_at, 1) over w))::numeric
            as tx_sec
        from heartbeats as h
        where cluster_id = 2 AND
        measured_at > '2014-09-03 23:35:48.299049' AND
        measured_at < '2014-09-03 23:41:48.299463'
        window w as (order by measured_at)
        order by measured_at asc;
