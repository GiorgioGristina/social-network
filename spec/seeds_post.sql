
TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, number_of_views, account_id) VALUES ('traveling solo', 'it amazing', 200, 2);
INSERT INTO posts (title, content, number_of_views, account_id) VALUES ('south america 3 months', 'Colombia, Ecuador, Peru', 20, 2);
