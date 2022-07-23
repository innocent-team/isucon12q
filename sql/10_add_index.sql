CREATE INDEX tenant_id ON competition (tenant_id);
CREATE INDEX tenant_id_created_at_desc ON player (tenant_id, created_at DESC);
