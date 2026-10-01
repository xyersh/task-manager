
CREATE SCHEMA task_manager;

CREATE TABLE task_manager.users (
    id              SERIAL          PRIMARY KEY,
    version         BIGINT          NOT NULL DEFAULT 1,
    full_name       VARCHAR(100)    NOT NULL CHECK(char_length(full_name) BETWEEN 3 AND 100),
    phone           VARCHAR(20)     NOT NULL UNIQUE CHECK(
        phone ~ '^\+[0-9]{10, 20}$'
    )
    email           VARCHAR(100)    CHECK(
        email IS NULL
        OR
        email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    )
);


CREATE TABLE task_manager.tasks (
    id              SERIAL              PRIMARY KEY,
    version         BIGINT              NOT NULL DEFAULT 1,
    title           VARCHAR(100)        NOT NULL CHECK(
        char_length(title) BETWEEN 1 AND 100
    ),
    description     VARCHAR(1000),  
    completed       BOOLEAN             NOT NULL DEFAULT false,
    created_at      TIMESTAMPTZ         NOT NULL,
    completed_at    TIMESTAMPTZ,
    author_user_id  INTEGER             NOT NULL REFERENCES task_manager.users(id)

    CHECK(
        (completed = false AND completed_at IS NULL)
        OR
        (completed = true AND completed_at IS NOT NULL AND completed_at >= created_at)
    )
);

