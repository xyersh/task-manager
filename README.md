
## МОДЕЛИ ДАННЫХ

### USERS

| COLUMN | ATTRS | DESC | 
|--|--|--|
|id |SERIAL PRIMERY KEY | ID|
|version | BIGINT NOT NULL DEFAULT 1 | версионирование записи для реализации оптимистичной блокировки |
| full_name | VARCHAR(100) NOT NULL | ФИО. Длина от 3 до 100 символов |
| phone | VARCHAR(20) NOT NULL UNIQUE | телефон. Проверка на валидность |
| email | VARCHAR(50) | почта. NULL или валидное значение | 


### TASKS
|COLUMN | ATTRS | DESC |
|--|--|--|
| id | SERIAL | id |
| version | BIGINT DEFAULT 1| версия записи для оптимистичной блокировки |
| title|VARCHAR(100) NOT NULL | заголовок задачи. Длина от 1 до 100 символов |
| description | VARCHAR(1000) | описание задачи |
| completed | BOOLEAN NOT NULL | завершена |
| created_at | TIMESTAMPTZ NOT NULL| время/время создания задачи |
| completed_at | TIMESTAMPTZ | дата/время завершения задачи. NULL если completed=fasle, ИЛИ  >= чем created_at если completed=true |
| autor_user_id | INTEGER |  NULL, ИЛИ валидный EMAIL |


## API

### фича USERS

- создать пользователя
    `POST users`
- получить пользователя по ID
  `GET users/{user_id}`
- получить список пользователей с пагинацией
 `GET users?limit={limit}&offset={offset}`
- изменить конкретного пользователя
`PATCH users/{user_id}` 
- удалить пользователя
`DELETE users/{user_id}` 

### фича TASKS
- создать таску
  `POST tasks`
- получить список таск
`GET tasks?user_id={user_id}&limit={limit}&offset={offset}`
- получить конкретную таску по ID
`GET tasks/{task_id}`
- изменить конкретную таску
  `PATCH tasks/{task_id}`
- удалить таску по ID
`DELETE tasks/{task_id}`

### фича STATISTICS
- получить статистику по задачам
  `GET statistics?user_id={user_id}&from={date_from}&to={date_to}`
