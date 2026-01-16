INSERT INTO ir_config_parameter(key, value)
VALUES ('account_edi_proxy_client.demo', true)
ON CONFLICT (key) DO UPDATE SET value = true