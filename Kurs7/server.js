const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const path = require('path'); // Для работы с путями
const app = express();
const port = 3000;

// Создаем подключение к базе данных
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root', // Имя пользователя
    password: 'root', // Пароль
    database: 'sportsclub' // Имя базы данных
});

// Подключение к базе данных
db.connect((err) => {
    if (err) {
        console.error('Ошибка подключения к базе данных: ', err);
        return;
    }
    console.log('Подключено к базе данных');
});

// Настройка парсинга данных из формы
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Указываем папку для статичных файлов
app.use(express.static(path.join(__dirname)));


// Главная страница
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));  // Путь к твоему HTML файлу
});

// Обработка POST-запроса для регистрации на тренировку
app.post('/submit_registration', (req, res) => {
    const { fullName, phone, trainingCategory, trainingType, trainingDay } = req.body;

    db.query('CALL register_for_training(?, ?, ?, ?, ?)', 
        [fullName, phone, trainingCategory, trainingType, trainingDay], 
        (err, results) => {
            if (err) {
                console.error('Ошибка при регистрации на тренировку, Проверьте введённые данные: ', err);
                res.status(500).send('Ошибка при регистрации на тренировку, Проверьте введённые данные');
                return;
            }
            res.send('Запись на тренировку успешна!');
        }
    );
});


// Эндпоинт для получения всех тренировок
app.get('/api/trainings', (req, res) => {
    const query = 'SELECT id, full_name, phone, training_category, training_type, training_day, created_at FROM training_registrations';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Ошибка получения тренировок:', err);
            res.status(500).json({ error: 'Ошибка получения тренировок' });
            return;
        }
        res.json(results);
    });
});

// Эндпоинт для удаления тренировки
app.delete('/api/trainings/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM training_registrations WHERE id = ?';
    db.query(query, [id], (err, results) => {
        if (err) {
            res.status(500).json({ error: 'Ошибка удаления тренировки' });
            return;
        }
        res.json({ message: 'Тренировка удалена' });
    });
});

// Эндпоинт для обновления тренировки
app.put('/api/trainings/:id', (req, res) => {
    const { id } = req.params; // Получаем ID тренировки из URL
    const { training_day, training_category } = req.body; // Получаем данные из тела запроса

    if (!training_day || !training_category) {
        return res.status(400).json({ error: 'Необходимо указать training_day и training_category' });
    }

    const query = 'UPDATE training_registrations SET training_day = ?, training_category = ? WHERE id = ?';
    db.query(query, [training_day, training_category, id], (err, result) => {
        if (err) {
            console.error('Ошибка обновления тренировки:', err);
            return res.status(500).json({ error: 'Ошибка обновления тренировки' });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Тренировка с указанным ID не найдена' });
        }

        res.json({ message: 'Тренировка успешно обновлена' });
    });
});



// Обработка POST-запроса для бронирования занятия
app.post('/submit_booking', (req, res) => {
    const { fullName, phone, coach, date, time } = req.body;

    const trimmedCoachName = coach.trim();

    db.query('CALL book_individual_training(?, ?, ?, ?, ?)', 
        [fullName, phone, trimmedCoachName, date, time], 
        (err, results) => {
            if (err) {
                console.error('Ошибка при бронировании занятия.Выберите другое время для записи: ', err);
                res.status(500).send('Ошибка при бронировании занятия.Выберите другое время для записи');
                return;
            }
            res.status(200).send('Вы успешно записались на занятие!');
        }
    );
});

// Эндпоинт для получения расписания тренировок тренера
app.get('/trainings/:coach', (req, res) => {
    const coach = req.params.coach;
  
    // SQL-запрос для получения тренировок конкретного тренера
    const query = `SELECT training_date, training_time, coach FROM individual_bookings WHERE coach = ?`;
  
    db.execute(query, [coach], (err, results) => {
      if (err) {
        return res.status(500).json({ error: 'Ошибка при получении данных' });
      }
  
      // Отправляем данные на фронтенд
      res.json(results);
    });
  });

  

//АБОНЕМЕНТЫ


// Маршрут для записи покупки в базу данных
app.post('/purchase', (req, res) => {
    const { name, price } = req.body;
    const purchaseDate = new Date();

    const query = 'INSERT INTO buy_sub (name, price, purchase_date) VALUES (?, ?, ?)';
    db.query(query, [name, price, purchaseDate], (err, result) => {
        if (err) {
            console.error('Ошибка при записи в базу данных:', err);
            return res.status(500).send('Ошибка при записи в базу данных');
        }
        res.status(200).send('Покупка успешно добавлена');
    });
});
// Маршрут для получения всех абонементов из базы данных
app.get('/get-purchased-subscriptions', (req, res) => {
    const query = 'SELECT * FROM buy_sub';

    db.query(query, (err, results) => {
        if (err) {
            console.error('Ошибка при извлечении данных:', err);
            return res.status(500).send('Ошибка при извлечении данных');
        }
        res.json(results); // Отправляем данные в формате JSON
    });
});


//МАГАЗ
// Маршрут для записи покупок
app.post('/save-purchase', (req, res) => {
    const purchases = req.body;

    if (!Array.isArray(purchases) || purchases.length === 0) {
        return res.status(400).send('Нет данных для записи');
    }

    const sql = `
        INSERT INTO purchases (name, price, quantity, total_price, purchase_date)
        VALUES (?, ?, ?, ?, NOW())
    `;

    purchases.forEach((item) => {
        db.query(sql, [item.name, item.price, item.quantity, item.totalPrice], (err) => {
            if (err) {
                console.error('Ошибка при добавлении данных:', err);
                return res.status(500).send('Ошибка при добавлении данных');
            }
        });
    });

    res.status(200).send('Покупки успешно сохранены');
});

app.get('/get-purchases', (req, res) => {
    const sql = `
        SELECT name, price, quantity, total_price, 
        DATE_FORMAT(purchase_date, '%Y-%m-%d %H:%i:%s') AS purchase_date 
        FROM purchases
        ORDER BY purchase_date DESC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Ошибка при получении данных:', err);
            return res.status(500).send('Ошибка при получении данных');
        }

        res.json(results);
    });
});

//АРЕНДА 
app.post('/submit_rental', (req, res) => {
    console.log(req.body);  // Log the request body
    const { item, rental_date, return_date, phone } = req.body;

    // Вставляем данные в таблицу rentals
    const query = 'INSERT INTO rentals (item, rental_date, return_date, phone) VALUES (?, ?, ?, ?)';
    db.query(query, [item, rental_date, return_date, phone], (err, result) => {
        if (err) {
            console.error('Ошибка при записи в базу данных:', err);
            return res.status(500).json({ success: false, message: 'Ошибка при записи в базу данных' });
        }
        console.log('Data inserted:', result);  // Log the result of insertion
        res.status(200).json({ success: true, message: 'Данные успешно сохранены' });
    });
});
// Эндпоинт для получения всех бронирований
app.get('/rentals', (req, res) => {
    // Запрос к базе данных для получения всех записей из таблицы rentals
    const query = 'SELECT * FROM rentals';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Ошибка при выполнении запроса: ' + err.stack);
            res.status(500).json({ error: 'Не удалось получить данные' });
        } else {
            res.json(results);  // Отправляем результаты в формате JSON
        }
    });
});



// Обработка GET-запроса для получения списка отзывов
app.get('/reviews', (req, res) => {
    const query = 'SELECT * FROM reviews ORDER BY review_date DESC';
    db.query(query, (err, result) => {
        if (err) {
            console.error('Ошибка при получении отзывов: ' + err.stack);
            return res.status(500).send('Ошибка сервера');
        }
        res.json(result);
    });
});

// Обработка POST-запроса для добавления отзыва
app.post('/reviews', (req, res) => {
    const { reviewerName, reviewRating, reviewText } = req.body;
    const reviewDate = new Date().toISOString().slice(0, 19).replace('T', ' ');  // Текущая дата

    const query = 'INSERT INTO reviews (reviewer_name, review_rating, review_text, review_date) VALUES (?, ?, ?, ?)';
    db.query(query, [reviewerName, reviewRating, reviewText, reviewDate], (err, result) => {
        if (err) {
            console.error('Ошибка при добавлении отзыва: ' + err.stack);
            return res.status(500).send('Ошибка сервера');
        }
        res.status(200).send('Отзыв успешно добавлен');
    });
});




// Маршрут для получения списка пользователей
app.get('/api/users', (req, res) => {
    db.query('SELECT * FROM users', (err, result) => {
        if (err) {
            return res.status(500).json({ error: 'Failed to retrieve users' });
        }
        res.json({ users: result });
    });
});

app.get('/api/user/:id', (req, res) => {
    const userId = req.params.id;
    db.query('SELECT * FROM users WHERE id = ?', [userId], (err, result) => {
        if (err) {
            return res.status(500).json({ error: 'Failed to retrieve user data' });
        }
        if (result.length === 0) {
            return res.status(404).json({ error: 'User not found' });
        }
        res.json({ user: result[0] });
    });
});



// Маршрут для получения информации о пользователе по имени
app.get('/api/user/:name', (req, res) => {
    const userName = req.params.name;

    // Запрос на получение данных пользователя по имени
    const query = 'SELECT * FROM users WHERE name = ?';
    db.query(query, [userName], (err, results) => {
        if (err) {
            console.error('Ошибка при получении данных пользователя: ', err);
            return res.status(500).json({ error: 'Ошибка при получении данных пользователя' });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'Пользователь не найден' });
        }

        // Отправляем информацию о пользователе
        const user = results[0];
        res.json({
            user: {
                name: user.name,
                age: user.age,
                city: user.city,
                activity: user.activity
            }
        });
    });
});

// Создание нового пользователя
app.post('/api/addUser', (req, res) => {
    const { name, age, city, activity, phone } = req.body;

    const query = `INSERT INTO users (name, age, city, activity, phone) VALUES (?, ?, ?, ?, ?)`;

    db.query(query, [name, age, city, activity, phone], (err, result) => {
        if (err) {
            console.error('Ошибка при добавлении пользователя: ', err);
            return res.status(500).send('Ошибка при добавлении пользователя');
        }
        res.json({ success: true, message: 'Пользователь успешно добавлен!' });
    });
});



app.put('/api/user/:id', (req, res) => {
    const userId = req.params.id;
    const { name, age, city, activity, phone } = req.body;

    const query = `UPDATE users SET name = ?, age = ?, city = ?, activity = ?, phone = ? WHERE id = ?`;

    db.query(query, [name, age, city, activity, phone, userId], (err, result) => {
        if (err) {
            console.error('Ошибка при обновлении пользователя: ', err);
            return res.status(500).json({ error: 'Ошибка при обновлении пользователя' });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Пользователь не найден' });
        }

        res.json({ success: true, message: 'Пользователь успешно обновлен!' });
    });
});



// Обработка DELETE-запроса для удаления пользователя
app.delete('/api/user/:id', (req, res) => {
    const userId = req.params.id;

    const query = `DELETE FROM users WHERE id = ?`;

    db.query(query, [userId], (err, result) => {
        if (err) {
            console.error('Ошибка при удалении пользователя: ', err);
            return res.status(500).json({ error: 'Ошибка при удалении пользователя' });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Пользователь не найден' });
        }

        res.json({ success: true, message: 'Пользователь успешно удален!' });
    });
});

// Запуск сервера
app.listen(port, () => {
    console.log(`Сервер работает на http://localhost:${port}`);
});


  