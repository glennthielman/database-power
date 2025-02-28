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

insert into blog_user values ('c5f65a08-f993-436b-8110-dbe56457108d', 'glenn@hello.com', 'Glenn', 'Thielman');
insert into blog_user values ('b6b110da-cf32-4614-86e7-9dd7cea754e7', 'morgane@hello.com', 'Morgane', 'Kruglanski');
insert into blog_post values ('000e32af-7de4-4299-b3ef-ec56d58d7af9', 'Leverage your database for ultimate power', 'cool stuff with databases', 'this will contain the body of the post, if I had any!!', 'c5f65a08-f993-436b-8110-dbe56457108d');
insert into blog_comment values ('5decb701-d905-4c28-8c4b-85869ba9c8e8', 'this is a good blog post, if you had any', 'b6b110da-cf32-4614-86e7-9dd7cea754e7', '000e32af-7de4-4299-b3ef-ec56d58d7af9');
insert into blog_likes values ('45b3e598-e0ec-4057-9ecc-8781764ba4b1', 'b6b110da-cf32-4614-86e7-9dd7cea754e7', 'post','000e32af-7de4-4299-b3ef-ec56d58d7af9');
insert into blog_likes values ('0b46a8fd-4f46-4e09-ae65-30cf2b02b999', 'c5f65a08-f993-436b-8110-dbe56457108d', 'comment','5decb701-d905-4c28-8c4b-85869ba9c8e8');