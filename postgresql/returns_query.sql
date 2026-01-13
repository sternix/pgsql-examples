CREATE OR REPLACE FUNCTION get_posts(some_input BIGINT)
RETURNS TABLE (
    id BIGINT,
    content TEXT,
    poster_id BIGINT,
    user_id BIGINT,
    displayname TEXT
) AS $$
BEGIN
    RETURNS QUERY
    SELECT
        posts.*,
        users.id AS user_id,
        users.displayname
    FROM
        posts
    JOIN users ON posts.poster_id = users.id;
END;
$$ LANGUAGE plpgsql;