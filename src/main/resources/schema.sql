create table if not exists blog_user (
     id UUID not null,
     email varchar not null,
     firstname varchar not null,
     lastname varchar not null,
     primary key (id),
UNIQUE (email)
);

create table if not exists blog_post (
    id UUID not null,
    title varchar not null,
    summary varchar not null,
    body varchar not null,
    author_id uuid REFERENCES blog_user (id),
    created_on timestamp default now(),
    primary key (id)
);

create table if not exists blog_comment (
    id UUID not null,
    comment varchar not null,
    author_id uuid REFERENCES blog_user (id),
    parent_id uuid REFERENCES blog_post (id),
    primary key (id)
);

create table if not exists blog_likes (
    id UUID not null,
    author_id uuid REFERENCES blog_user (id),
    parent_type varchar not null,
    parent_id uuid,
    primary key (id),
    constraint con_parent_type check (parent_type in ('post', 'comment'))
);

create or replace view vw_recent_posts as
    select id, title, summary, created_on from blog_post order by created_on desc limit 5;

create or replace view vw_top_liked_posts as
    select id, title from blog_post where id in (
        select parent_id from blog_likes
        where parent_type = 'post'
        group by parent_id
        order by count(*) desc
    ) limit 10;

create or replace view vw_top_liked_comments as
    select c.id, c.parent_id, c.comment, u.firstname
    from blog_comment c
     inner join blog_user u on c.author_id = u.id
    where c.id in (
        select parent_id from blog_likes
        where parent_type = 'comment'
        group by parent_id
        order by count(*) desc
    ) limit 10;

create table if not exists blog_html_views (
    key varchar not null,
    value text not null,
    primary key (key)
);

insert into blog_user values ('c5f65a08-f993-436b-8110-dbe56457108d', 'glenn@hello.com', 'Glenn', 'Thielman');
insert into blog_user values ('b6b110da-cf32-4614-86e7-9dd7cea754e7', 'morgane@hello.com', 'Morgane', 'Kruglanski');
insert into blog_post values ('000e32af-7de4-4299-b3ef-ec56d58d7af9', 'Leverage your database for ultimate power', 'cool stuff with databases', 'this will contain the body of the post, if I had any!!', 'c5f65a08-f993-436b-8110-dbe56457108d', to_timestamp('2025-02-28 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
insert into blog_comment values ('5decb701-d905-4c28-8c4b-85869ba9c8e8', 'this is a good blog post, if you had any', 'b6b110da-cf32-4614-86e7-9dd7cea754e7', '000e32af-7de4-4299-b3ef-ec56d58d7af9');
insert into blog_likes values ('45b3e598-e0ec-4057-9ecc-8781764ba4b1', 'b6b110da-cf32-4614-86e7-9dd7cea754e7', 'post','000e32af-7de4-4299-b3ef-ec56d58d7af9');
insert into blog_likes values ('0b46a8fd-4f46-4e09-ae65-30cf2b02b999', 'c5f65a08-f993-436b-8110-dbe56457108d', 'comment','5decb701-d905-4c28-8c4b-85869ba9c8e8');


--RANDOM USERS
INSERT INTO blog_user VALUES ('7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'alice@example.com', 'Alice', 'Johnson');
INSERT INTO blog_user VALUES ('f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'bob@example.com', 'Bob', 'Smith');
INSERT INTO blog_user VALUES ('2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'charlie@example.com', 'Charlie', 'Brown');
INSERT INTO blog_user VALUES ('8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'david@example.com', 'David', 'Miller');
INSERT INTO blog_user VALUES ('9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'emma@example.com', 'Emma', 'Wilson');


--RANDOM POSTS
INSERT INTO blog_post VALUES ('1a2b3c4d-5e6f-7890-1234-56789abcdef0', 'Mastering SQL Joins', 'A deep dive into SQL joins', 'Understanding INNER, OUTER, LEFT, and RIGHT joins.', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', to_timestamp('2025-02-01 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('2b3c4d5e-6f70-8901-2345-6789abcdef12', 'Indexing Best Practices', 'How to optimize your queries', 'Learn how to speed up your database queries with indexing.', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', to_timestamp('2025-02-02 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('3c4d5e6f-7890-1234-5678-90abcdef1234', 'NoSQL vs SQL', 'Choosing the right database', 'A comparison between relational and non-relational databases.', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', to_timestamp('2025-02-03 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('4d5e6f70-8901-2345-6789-0abcdef12345', 'Scaling Your Database', 'Handling large datasets', 'Strategies for optimizing performance in large-scale applications.', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', to_timestamp('2025-02-04 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('5e6f7089-0123-4567-890a-bcdef1234567', 'Transaction Management', 'Ensuring ACID compliance', 'A guide to understanding atomicity, consistency, isolation, and durability.', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', to_timestamp('2025-02-05 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('6f708901-2345-6789-0abc-def123456789', 'Database Normalization', 'Designing efficient schemas', 'Breaking down normalization and why it matters.', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', to_timestamp('2025-02-06 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('7f809012-3456-7890-abcd-ef1234567890', 'Denormalization Strategies', 'When to break normalization rules', 'Understanding when and why denormalization is useful.', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', to_timestamp('2025-02-07 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('89012345-6789-0abc-def1-234567890abc', 'Optimizing Query Performance', 'Techniques for faster queries', 'Learn how to use indexing, caching, and query optimization.', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', to_timestamp('2025-02-08 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('90123456-7890-abcd-ef12-34567890abcd', 'Stored Procedures vs Queries', 'Choosing the best approach', 'Analyzing the benefits and drawbacks of stored procedures.', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', to_timestamp('2025-02-09 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('a1234567-890a-bcde-f123-4567890abcde', 'Working with JSON in SQL', 'Using JSON data efficiently', 'A guide to handling JSON data in modern databases.', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', to_timestamp('2025-02-10 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('b2345678-90ab-cdef-1234-567890abcdef', 'The Power of Views', 'Using views for better structure', 'Why and how to use SQL views to simplify queries.', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', to_timestamp('2025-02-11 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('c3456789-0abc-def1-2345-67890abcdef1', 'Sharding and Partitioning', 'Breaking down large databases', 'Techniques for distributing data across multiple nodes.', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', to_timestamp('2025-02-12 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('d4567890-abcd-ef12-3456-7890abcdef12', 'Database Security Best Practices', 'Protecting your data', 'Learn how to secure your database from threats.', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', to_timestamp('2025-02-13 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('e567890a-bcde-f123-4567-890abcdef123', 'Event Sourcing and Databases', 'Capturing state changes over time', 'Using event sourcing as an architectural pattern.', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', to_timestamp('2025-02-14 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('f67890ab-cdef-1234-5678-90abcdef1234', 'Concurrency Control', 'Avoiding race conditions', 'Managing concurrent database operations effectively.', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', to_timestamp('2025-02-15 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('12345678-90ab-cdef-1234-567890abcdef', 'Graph Databases Explained', 'Understanding relationships in data', 'An introduction to graph databases like Neo4j.', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', to_timestamp('2025-02-16 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('23456789-0abc-def1-2345-67890abcdef1', 'Full-Text Search in SQL', 'Building powerful search functionality', 'Using full-text indexing for efficient searches.', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', to_timestamp('2025-02-17 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('34567890-abcd-ef12-3456-7890abcdef12', 'Time-Series Databases', 'Managing time-based data', 'A deep dive into databases like InfluxDB and TimescaleDB.', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', to_timestamp('2025-02-18 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('4567890a-bcde-f123-4567-890abcdef123', 'ETL Processes for Data Warehouses', 'Extract, Transform, Load', 'Understanding ETL pipelines and best practices.', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', to_timestamp('2025-02-19 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('567890ab-cdef-1234-5678-90abcdef1234', 'Data Migration Strategies', 'Moving data between systems', 'Techniques for seamless database migrations.', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', to_timestamp('2025-02-20 12:00:00', 'yyyy-mm-dd hh:mi:ss'));
INSERT INTO blog_post VALUES ('67890abc-def1-2345-6789-0abcdef12345', 'Backup and Recovery', 'Preventing data loss', 'Best practices for database backup and recovery.', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', to_timestamp('2025-02-21 12:00:00', 'yyyy-mm-dd hh:mi:ss'));

--RANDOM COMMENTS
INSERT INTO blog_comment VALUES ('1a2b3c4d-5678-90ab-cdef-1234567890ab', 'Great explanation, really helped me understand!', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', '1a2b3c4d-5e6f-7890-1234-56789abcdef0');
INSERT INTO blog_comment VALUES ('2b3c4d5e-6789-0abc-def1-234567890abc', 'I love this approach, will definitely try it.', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', '2b3c4d5e-6f70-8901-2345-6789abcdef12');
INSERT INTO blog_comment VALUES ('3c4d5e6f-7890-abcd-ef12-34567890abcd', 'Could you provide more examples for clarity?', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', '3c4d5e6f-7890-1234-5678-90abcdef1234');
INSERT INTO blog_comment VALUES ('4d5e6f70-8901-bcde-f123-4567890abcde', 'Nice! How does this compare to MongoDB?', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', '4d5e6f70-8901-2345-6789-0abcdef12345');
INSERT INTO blog_comment VALUES ('5e6f7089-0123-cdef-1234-567890abcdef', 'I wish I knew this earlier, thanks a lot!', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', '5e6f7089-0123-4567-890a-bcdef1234567');
INSERT INTO blog_comment VALUES ('6f708901-2345-def1-2345-67890abcdef1', 'Super useful breakdown, I appreciate it.', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', '6f708901-2345-6789-0abc-def123456789');
INSERT INTO blog_comment VALUES ('7f809012-3456-ef12-3456-7890abcdef12', 'This post saved me hours of debugging!', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', '7f809012-3456-7890-abcd-ef1234567890');
INSERT INTO blog_comment VALUES ('89012345-6789-f123-4567-890abcdef123', 'Can you cover more on query optimization?', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', '89012345-6789-0abc-def1-234567890abc');
INSERT INTO blog_comment VALUES ('90123456-7890-0123-4567-890abcdef456', 'I disagree, I think NoSQL has more advantages.', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', '90123456-7890-abcd-ef12-34567890abcd');
INSERT INTO blog_comment VALUES ('a1234567-890a-2345-6789-0abcdef12345', 'Love this blog! Keep up the great work.', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'a1234567-890a-bcde-f123-4567890abcde');
INSERT INTO blog_comment VALUES ('b2345678-90ab-3456-7890-abcdef123456', 'Super informative, I learned something new today.', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'b2345678-90ab-cdef-1234-567890abcdef');
INSERT INTO blog_comment VALUES ('c3456789-0abc-4567-890a-bcdef1234567', 'Would love a part two on this topic!', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'c3456789-0abc-def1-2345-67890abcdef1');
INSERT INTO blog_comment VALUES ('d4567890-abcd-5678-90ab-cdef12345678', 'Wow, this method is so efficient.', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'd4567890-abcd-ef12-3456-7890abcdef12');
INSERT INTO blog_comment VALUES ('e567890a-bcde-6789-0abc-def123456789', 'I am implementing this now. Thanks!', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'e567890a-bcde-f123-4567-890abcdef123');
INSERT INTO blog_comment VALUES ('f67890ab-cdef-7890-1234-567890abcdef', 'Never thought of it this way, amazing insight!', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'f67890ab-cdef-1234-5678-90abcdef1234');
INSERT INTO blog_comment VALUES ('12345678-90ab-8901-2345-67890abcdef1', 'Your examples made this easy to understand.', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', '12345678-90ab-cdef-1234-567890abcdef');
INSERT INTO blog_comment VALUES ('23456789-0abc-9012-3456-7890abcdef12', 'Do you have any recommendations for further reading?', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', '23456789-0abc-def1-2345-67890abcdef1');
INSERT INTO blog_comment VALUES ('34567890-abcd-a123-4567-890abcdef123', 'This should be required reading for database devs!', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', '34567890-abcd-ef12-3456-7890abcdef12');
INSERT INTO blog_comment VALUES ('4567890a-bcde-b234-5678-90abcdef1234', 'I encountered an issue, can you help?', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', '4567890a-bcde-f123-4567-890abcdef123');
INSERT INTO blog_comment VALUES ('567890ab-cdef-c345-6789-0abcdef12345', 'Your explanation was crystal clear.', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', '567890ab-cdef-1234-5678-90abcdef1234');
INSERT INTO blog_comment VALUES ('67890abc-def1-d456-7890-abcdef123456', 'This was exactly what I needed, thank you!', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', '67890abc-def1-2345-6789-0abcdef12345');
INSERT INTO blog_comment VALUES ('890abcd1-2345-f678-90ab-cdef12345678', 'Very well explained, I appreciate the effort.', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', '89012345-6789-0abc-def1-234567890abc');
INSERT INTO blog_comment VALUES ('901bcdef-4567-0123-4567-890abcdef123', 'Do you have more posts on database design?', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', '90123456-7890-abcd-ef12-34567890abcd');
INSERT INTO blog_comment VALUES ('a12cdef3-6789-1234-5678-90abcdef1234', 'I tried this, and it improved my queries a lot!', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'a1234567-890a-bcde-f123-4567890abcde');
INSERT INTO blog_comment VALUES ('b23def45-8901-2345-6789-0abcdef12345', 'Interesting concept, but does it scale well?', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'b2345678-90ab-cdef-1234-567890abcdef');
INSERT INTO blog_comment VALUES ('c34ef567-9012-3456-7890-abcdef123456', 'Thank you for covering this topic in detail!', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'c3456789-0abc-def1-2345-67890abcdef1');
INSERT INTO blog_comment VALUES ('d45f6789-0123-4567-890a-bcdef1234567', 'Any suggestions for tools to automate this?', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'd4567890-abcd-ef12-3456-7890abcdef12');
INSERT INTO blog_comment VALUES ('e567890a-1234-5678-90ab-cdef12345678', 'I had trouble implementing this, any advice?', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'e567890a-bcde-f123-4567-890abcdef123');
--INSERT INTO blog_comment VALUES ('7890abcd-ef12-e567-890a-bcdef1234567', 'Would you recommend this approach for large datasets?', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', '7890abcd-ef12-3456-7890-abcdef123456');
INSERT INTO blog_comment VALUES ('f67890ab-2345-6789-0abc-def123456789', 'This is a great alternative to traditional methods.', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'f67890ab-cdef-1234-5678-90abcdef1234');
INSERT INTO blog_comment VALUES ('12345678-3456-7890-abcd-ef1234567890', 'How would this compare to using a different indexing method?', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', '12345678-90ab-cdef-1234-567890abcdef');
INSERT INTO blog_comment VALUES ('23456789-4567-890a-bcde-f12345678901', 'Would love to see benchmarks for this approach.', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', '23456789-0abc-def1-2345-67890abcdef1');
INSERT INTO blog_comment VALUES ('34567890-5678-90ab-cdef-123456789012', 'Super clear writing, thanks for sharing!', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', '34567890-abcd-ef12-3456-7890abcdef12');
INSERT INTO blog_comment VALUES ('4567890a-6789-0abc-def1-234567890123', 'Are there any edge cases to watch out for?', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', '4567890a-bcde-f123-4567-890abcdef123');
INSERT INTO blog_comment VALUES ('567890ab-7890-1bcd-ef23-456789012345', 'This technique worked well in my last project!', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', '567890ab-cdef-1234-5678-90abcdef1234');
INSERT INTO blog_comment VALUES ('67890abc-8901-2cde-f345-678901234567', 'Great insight, I never thought about it this way.', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', '67890abc-def1-2345-6789-0abcdef12345');
--INSERT INTO blog_comment VALUES ('7890abcd-9012-3def-4567-890123456789', 'Are there alternative ways to implement this?', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', '7890abcd-ef12-3456-7890-abcdef123456');
INSERT INTO blog_comment VALUES ('890abcd1-0123-4ef5-6789-01234567890a', 'Thanks for the examples, they were really useful.', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', '89012345-6789-0abc-def1-234567890abc');
INSERT INTO blog_comment VALUES ('901bcdef-1234-5f67-890a-1234567890ab', 'I will share this with my team, very helpful!', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', '90123456-7890-abcd-ef12-34567890abcd');
INSERT INTO blog_comment VALUES ('a12cdef3-2345-6789-0abc-3456789012cd', 'Your explanation makes complex topics so simple.', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'a1234567-890a-bcde-f123-4567890abcde');
INSERT INTO blog_comment VALUES ('b23def45-3456-7890-abcd-4567890123de', 'This is my go-to reference now, thanks!', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'b2345678-90ab-cdef-1234-567890abcdef');

--RANDOM POST LIKES
INSERT INTO blog_likes VALUES ('1a2b3c4d-5678-90ab-cdef-1234567890ab', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'post', '1a2b3c4d-5e6f-7890-1234-56789abcdef0');
INSERT INTO blog_likes VALUES ('2b3c4d5e-6789-0abc-def1-234567890abc', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'post', '2b3c4d5e-6f70-8901-2345-6789abcdef12');
INSERT INTO blog_likes VALUES ('3c4d5e6f-7890-abcd-ef12-34567890abcd', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'post', '3c4d5e6f-7890-1234-5678-90abcdef1234');
INSERT INTO blog_likes VALUES ('4d5e6f70-8901-bcde-f123-4567890abcde', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'post', '4d5e6f70-8901-2345-6789-0abcdef12345');
INSERT INTO blog_likes VALUES ('5e6f7089-0123-cdef-1234-567890abcdef', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'post', '5e6f7089-0123-4567-890a-bcdef1234567');
INSERT INTO blog_likes VALUES ('6f708901-2345-def1-2345-67890abcdef1', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'post', '6f708901-2345-6789-0abc-def123456789');
INSERT INTO blog_likes VALUES ('7f809012-3456-ef12-3456-7890abcdef12', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'post', '7f809012-3456-7890-abcd-ef1234567890');
INSERT INTO blog_likes VALUES ('89012345-6789-f123-4567-890abcdef123', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'post', '89012345-6789-0abc-def1-234567890abc');
INSERT INTO blog_likes VALUES ('90123456-7890-0123-4567-890abcdef456', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'post', '90123456-7890-abcd-ef12-34567890abcd');
INSERT INTO blog_likes VALUES ('a1234567-890a-2345-6789-0abcdef12345', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'post', 'a1234567-890a-bcde-f123-4567890abcde');
INSERT INTO blog_likes VALUES ('b2345678-90ab-3456-7890-abcdef123456', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'post', 'b2345678-90ab-cdef-1234-567890abcdef');
INSERT INTO blog_likes VALUES ('c3456789-0abc-4567-890a-bcdef1234567', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'post', 'c3456789-0abc-def1-2345-67890abcdef1');
INSERT INTO blog_likes VALUES ('d4567890-abcd-5678-90ab-cdef12345678', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'post', 'd4567890-abcd-ef12-3456-7890abcdef12');
INSERT INTO blog_likes VALUES ('e567890a-bcde-6789-0abc-def123456789', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'post', 'e567890a-bcde-f123-4567-890abcdef123');
INSERT INTO blog_likes VALUES ('f67890ab-cdef-7890-1234-567890abcdef', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'post', 'f67890ab-cdef-1234-5678-90abcdef1234');
INSERT INTO blog_likes VALUES ('12345678-90ab-8901-2345-67890abcdef1', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'post', '12345678-90ab-cdef-1234-567890abcdef');
INSERT INTO blog_likes VALUES ('23456789-0abc-9012-3456-7890abcdef12', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'post', '23456789-0abc-def1-2345-67890abcdef1');
INSERT INTO blog_likes VALUES ('34567890-abcd-a123-4567-890abcdef123', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'post', '34567890-abcd-ef12-3456-7890abcdef12');
INSERT INTO blog_likes VALUES ('4567890a-bcde-b234-5678-90abcdef1234', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'post', '4567890a-bcde-f123-4567-890abcdef123');
INSERT INTO blog_likes VALUES ('567890ab-cdef-c345-6789-0abcdef12345', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'post', '567890ab-cdef-1234-5678-90abcdef1234');
INSERT INTO blog_likes VALUES ('67890abc-def1-d456-7890-abcdef123456', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'post', '67890abc-def1-2345-6789-0abcdef12345');
INSERT INTO blog_likes VALUES ('7890abcd-ef12-e567-890a-bcdef1234567', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'post', '7890abcd-ef12-3456-7890-abcdef123456');
INSERT INTO blog_likes VALUES ('890abcd1-2345-f678-90ab-cdef12345678', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'post', '89012345-6789-0abc-def1-234567890abc');
INSERT INTO blog_likes VALUES ('f3b8e96a-1d4f-4c32-9f29-58bd4a6f3d91', 'c5f65a08-f993-436b-8110-dbe56457108d', 'post', '000e32af-7de4-4299-b3ef-ec56d58d7af9');


--RANDOM COMMENT LIKES

INSERT INTO blog_likes VALUES ('a1b2c3d4-5678-90ab-cdef-1234567890ff', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'comment', '1a2b3c4d-5678-90ab-cdef-1234567890ab');
INSERT INTO blog_likes VALUES ('fd46d48d-01b5-4c65-9737-a3fda9629aa3', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'comment', '1a2b3c4d-5678-90ab-cdef-1234567890ab');
INSERT INTO blog_likes VALUES ('22f1fdd5-8a0b-475e-b024-d7f5611e5209', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'comment', '1a2b3c4d-5678-90ab-cdef-1234567890ab');
INSERT INTO blog_likes VALUES ('aa2c9896-88ec-4d2f-9690-8a9addda22d9', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'comment', '1a2b3c4d-5678-90ab-cdef-1234567890ab');
INSERT INTO blog_likes VALUES ('54c24e1b-8eb0-4a05-9818-0bb25506b78b', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'comment', '1a2b3c4d-5678-90ab-cdef-1234567890ab');
INSERT INTO blog_likes VALUES ('b2c3d4e5-6789-0abc-def1-234567890f01', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'comment', '2b3c4d5e-6789-0abc-def1-234567890abc');
INSERT INTO blog_likes VALUES ('c3d4e5f6-7890-abcd-ef12-34567890f012', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'comment', '3c4d5e6f-7890-abcd-ef12-34567890abcd');
INSERT INTO blog_likes VALUES ('d4e5f6a7-8901-bcde-f123-4567890f1234', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'comment', '4d5e6f70-8901-bcde-f123-4567890abcde');
INSERT INTO blog_likes VALUES ('e5f6a7b8-9012-cdef-1234-567890f23456', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'comment', '5e6f7089-0123-cdef-1234-567890abcdef');
INSERT INTO blog_likes VALUES ('f6a7b8c9-0123-def1-2345-67890f345678', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'comment', '6f708901-2345-def1-2345-67890abcdef1');
INSERT INTO blog_likes VALUES ('a7b8c9d0-1234-ef12-3456-7890f4567890', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'comment', '7f809012-3456-ef12-3456-7890abcdef12');
INSERT INTO blog_likes VALUES ('b8c9d0e1-2345-f123-4567-890f56789012', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'comment', '89012345-6789-f123-4567-890abcdef123');
INSERT INTO blog_likes VALUES ('c9d0e1f2-3456-0123-5678-90f678901234', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'comment', '90123456-7890-0123-4567-890abcdef456');
INSERT INTO blog_likes VALUES ('d0e1f2a3-4567-1234-6789-0f7890123456', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'comment', 'a1234567-890a-2345-6789-0abcdef12345');
INSERT INTO blog_likes VALUES ('e1f2a3b4-5678-2345-7890-f89012345678', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'comment', 'b2345678-90ab-3456-7890-abcdef123456');
INSERT INTO blog_likes VALUES ('f2a3b4c5-6789-3456-8901-901234567890', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'comment', 'c3456789-0abc-4567-890a-bcdef1234567');
INSERT INTO blog_likes VALUES ('a3b4c5d6-7890-4567-9012-012345678901', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'comment', 'd4567890-abcd-5678-90ab-cdef12345678');
INSERT INTO blog_likes VALUES ('b4c5d6e7-8901-5678-0123-123456789012', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'comment', 'e567890a-bcde-6789-0abc-def123456789');
INSERT INTO blog_likes VALUES ('c5d6e7f8-9012-6789-1234-234567890123', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'comment', 'f67890ab-cdef-7890-1234-567890abcdef');
INSERT INTO blog_likes VALUES ('d6e7f8a9-0123-7890-2345-345678901234', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'comment', '12345678-90ab-8901-2345-67890abcdef1');
INSERT INTO blog_likes VALUES ('e7f8a9b0-1234-8901-3456-456789012345', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'comment', '23456789-0abc-9012-3456-7890abcdef12');
INSERT INTO blog_likes VALUES ('f8a9b0c1-2345-9012-4567-567890123456', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'comment', '34567890-abcd-a123-4567-890abcdef123');
INSERT INTO blog_likes VALUES ('a9b0c1d2-3456-0123-5678-678901234567', '8d3e2a7b-9c0d-4e5f-1b6c-7a9d8f0b2c4e', 'comment', '4567890a-bcde-b234-5678-90abcdef1234');
INSERT INTO blog_likes VALUES ('b0c1d2e3-4567-1234-6789-789012345678', '9c0d8f2b-1e4a-5b7c-3d6e-7a9f0b2c8d3e', 'comment', '567890ab-cdef-c345-6789-0abcdef12345');
INSERT INTO blog_likes VALUES ('c1d2e3f4-5678-2345-7890-890123456789', '7e1a9b4c-3f77-4b9a-bc6d-8e9d3c2a1f52', 'comment', '67890abc-def1-d456-7890-abcdef123456');
INSERT INTO blog_likes VALUES ('d2e3f4a5-6789-3456-8901-901234567890', 'f4d2c9e8-5b6a-41f3-8c2d-7d8e9a0b1c34', 'comment', '890abcd1-2345-f678-90ab-cdef12345678');
INSERT INTO blog_likes VALUES ('e3f4a5b6-7890-4567-9012-012345678901', '2b5c7d8e-9f0a-4b1c-8d3e-6a7b9c0d2e4f', 'comment', '901bcdef-4567-0123-4567-890abcdef123');
INSERT INTO blog_likes VALUES ('f4a5b6c7-8901-5678-0123-123456789012', 'c5f65a08-f993-436b-8110-dbe56457108d', 'comment', 'a12cdef3-6789-1234-5678-90abcdef1234');
--INSERT INTO blog_likes VALUES ('a5b6c7d8-9012-6789-1234-234567890123', 'a1d4e6c8-8b92-4d55-9e01-4f6d3b52a1f9', 'comment', '4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a');