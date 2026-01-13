WITH checkpoints AS (
        SELECT checkpoints_timed - lag(checkpoints_timed) over w as timed_checkpoints,
               checkpoints_req - lag(checkpoints_req) over w as required_checkpoints,
               buffers_checkpoint - lag(buffers_checkpoint) over w as buffers_checkpoint,
               buffers_backend - lag(buffers_backend) over w as buffers_backend,
               measured_at
        FROM bg_stats
        WHERE cluster_id = 2
        WINDOW w as (order by measured_at asc)
)
SELECT * FROM checkpoints
        WHERE measured_at > '2014-09-03 23:35:47.926066' AND
              measured_at < '2014-09-03 23:41:48.906815' AND
              (required_checkpoints > 0 OR timed_checkpoints > 0)
        ORDER BY measured_at asc;