DROP TABLE IF EXISTS responses;
DROP TABLE IF EXISTS bot_messages;
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS slack_bots;
DROP TABLE IF EXISTS bot_integrations;
DROP TABLE IF EXISTS fb_bots;
DROP TABLE IF EXISTS bots;
DROP TABLE IF EXISTS bot_types;
DROP TABLE IF EXISTS quotes;
DROP TABLE IF EXISTS trolls;
DROP TABLE IF EXISTS program_messages;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS programs;
DROP TABLE IF EXISTS slack_bots;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id            INTEGER PRIMARY KEY,
    username      TEXT,
    password      TEXT,
    email_address TEXT,
    first_name    TEXT,
    last_name     TEXT,
    active        INTEGER
);

CREATE TABLE roles (
    id   INTEGER PRIMARY KEY,
    role TEXT
);

CREATE TABLE user_roles (
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    role_id INTEGER REFERENCES roles(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE trolls (
    id          SERIAL PRIMARY KEY,
    name        TEXT,
    description TEXT
);

CREATE TABLE quotes (
    id          SERIAL PRIMARY KEY,
    troll_id    INTEGER REFERENCES trolls(id) ON DELETE CASCADE ON UPDATE CASCADE,
    text        TEXT
);

CREATE TABLE slack_bots (
    id              SERIAL PRIMARY KEY,
    slack_hook      TEXT,
    slack_channel   TEXT
);

CREATE TABLE fb_bots (
    id              SERIAL PRIMARY KEY,
    fb_token        TEXT
);

CREATE TABLE programs (
    id          SERIAL PRIMARY KEY,
    name        TEXT,
    created     TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE bot_types (
    id          SERIAL PRIMARY KEY,
    bot_type    TEXT,
    description TEXT,
    troll_id    INTEGER REFERENCES trolls(id) ON DELETE CASCADE ON UPDATE CASCADE,
    program_id  INTEGER REFERENCES programs(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE bots (
    id          SERIAL PRIMARY KEY,
    bot_type_id INTEGER REFERENCES bot_types(id) ON DELETE CASCADE ON UPDATE CASCADE,
    name        TEXT,
    active      BOOLEAN NOT NULL DEFAULT FALSE,
    created     TIMESTAMP NOT NULL DEFAULT now(),
    updated     TIMESTAMP
);

CREATE TABLE bot_integrations (
    id              SERIAL PRIMARY KEY,
    bot_id          INTEGER REFERENCES bots(id) ON DELETE CASCADE ON UPDATE CASCADE,
    fb_bot_id       INTEGER REFERENCES fb_bots(id) ON DELETE CASCADE ON UPDATE CASCADE,
    slack_bot_id    INTEGER REFERENCES slack_bots(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE contacts (
    id             SERIAL PRIMARY KEY,
    fb_id          TEXT,
    program_id     SERIAL REFERENCES programs(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE messages (
    id              SERIAL PRIMARY KEY,
   content         TEXT,
    template_type   TEXT,
    date_created    TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE program_messages (
    id              SERIAL PRIMARY KEY,
    message_id      INTEGER REFERENCES messages(id) ON DELETE CASCADE ON UPDATE CASCADE,
    program_id      INTEGER REFERENCES programs(id) ON DELETE CASCADE ON UPDATE CASCADE,
    step            INTEGER,
    launch_type     TEXT,
    launch_time     TIMESTAMP
);

CREATE TABLE responses (
    id                   SERIAL PRIMARY KEY,
    text                 TEXT,
    feedback             BOOLEAN NOT NULL DEFAULT FALSE,
    contact_id           INTEGER REFERENCES contacts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    program_message_id   INTEGER REFERENCES program_messages(id) ON DELETE CASCADE ON UPDATE CASCADE,
    recieved             TIMESTAMP NOT NULL DEFAULT NOW()
);

--
-- Load up some initial test data
--
INSERT INTO users VALUES (1, 'test01', 'mypass', 't01@na.com', 'Joe',  'Blow', 1);
INSERT INTO users VALUES (2, 'test02', 'mypass', 't02@na.com', 'Flo', 'Doe',  1);
INSERT INTO users VALUES (3, 'test03', 'mypass', 't03@na.com', 'No',   'Go',   0);
INSERT INTO roles VALUES (1, 'user');
INSERT INTO roles VALUES (2, 'admin');
INSERT INTO user_roles VALUES (1, 1);
INSERT INTO user_roles VALUES (1, 2);
INSERT INTO user_roles VALUES (2, 1);
INSERT INTO user_roles VALUES (3, 1);

INSERT INTO trolls (name, description) VALUES ('Donald Trump', 'First attempt');
INSERT INTO quotes (troll_id, text) VALUES (1, 'Sometimes your best investments are the ones you dont make');
INSERT INTO quotes (troll_id, text) VALUES (1, 'Sometimes by losing a battle you find a new way to win the war.');
INSERT INTO quotes (troll_id, text) VALUES (1, 'Everything in life is luck.');
INSERT INTO quotes (troll_id, text) VALUES (1,'You have to think anyway, so why not think big?');
INSERT INTO quotes (troll_id, text) VALUES (1, 'As long as your going to be thinking anyway, think big.');

