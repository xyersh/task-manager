
## МОДЕЛИ ДАННЫХ

### USERS

| COLUMN | ATTRS | DESC | 
|--|--|--|
|id |SERIAL PRIMERY KEY | ID|
|version | BIGINT NOT NULL | версионирование записи для реализации оптимистичной блокировки |
| full_name | VARCHAR(100) NOT NULL | ФИО |
| phone | VARCHAR(20) NOT NULL UNIQUE | телефон |
| email | VARCHAR(50) | почта | 


### TASKS
|COLUMN | ATTRS | DESC |
|--|--|--|
| id | SERIAL | id |
| version | BIGINT | версия записи для оптимистичной блокировки |
| title|VARCHAR(100) NOT NULL | заголовок задачи |
| description | VARCHAR(1000) | описание задачи |
| completed | BOOLEAN NOT NULL | завершена |
| created_at | TIMESTAMPTZ NOT NULL| время/время создания задачи |
| completed_at | TIMESTAMPTZ | дата/время завершения задачи |
| autor_user_id | INTEGER |


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
