
const express = require('express'); 
const bodyParser = require('body-parser');
const path = require('path');
const multer = require('multer');
const fs = require('fs');

const app = express(); 

const port = 3000;

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const uploadPath = path.join(__dirname, 'uploads');
        if (!fs.existsSync(uploadPath)) {
            fs.mkdirSync(uploadPath);
        }
        cb(null, uploadPath); 
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname)); 
    }
});

const upload = multer({
    storage: storage,
    limits: { fileSize: 200000 }, 
    fileFilter: (req, file, cb) => {
        const allowedTypes = ['image/jpeg'];
        if (!allowedTypes.includes(file.mimetype)) {
            return cb(new Error('Файл должен быть в формате JPG.'));
        }
        cb(null, true);
    }
}).single('file');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(__dirname));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '3.html'));
});

app.post('/register', (req, res) => {
    upload(req, res, (err) => {
        if (err instanceof multer.MulterError) {
            if (err.code === 'LIMIT_FILE_SIZE') {
                return res.status(400).send('Размер файла должен быть не более 200 кб.');
            }
        } else if (err) {
            return res.status(400).send(err.message);
        }

        if (!req.file) {
            return res.status(400).send('Файл обязателен для загрузки.');
        }

        
        if (req.file.size < 100000) {
            return res.status(400).send('Размер файла должен быть не менее 100 кб.');
        }

        const { username, email, phone, play, seatType, extras, comments, date } = req.body;

        if (!username || !email || !phone || !play || !seatType || !date) {
            return res.status(400).send('Пожалуйста, заполните все обязательные поля!');
        }

        const extrasList = Array.isArray(extras) ? extras.join(', ') : extras || 'Нет';

        // Сохраняем данные в файл
        const orderDetails = `
            Имя: ${username}
            Электронная почта: ${email}
            Телефон: ${phone}
            Спектакль: ${play}
            Тип места: ${seatType}
            Дополнительные услуги: ${extrasList}
            Комментарий: ${comments || 'Нет'}
            Дата: ${date}
            Путь к файлу: ${req.file.path}
            Время последнего доступа: ${new Date().toLocaleString()}
        `;

        const filePath = path.join(__dirname, 'order.txt');
        fs.writeFileSync(filePath, orderDetails);

        res.send(`
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Заказ подтверждён</title>
                <link rel="stylesheet" href="3.1.css"> <!-- Ссылка на файл стилей -->
            </head>
            <body>
                <div class="container">
                    <h2>Спасибо за заказ, ${username}!</h2>
                    <p>Ваши данные были успешно сохранены в файл.</p>
                    <p>
                        Нажав здесь можете <a href="/order.txt" download>скачать файл заказа</a>.
                    </p>
                    <p><strong>Время последнего доступа к файлу:</strong> ${new Date().toLocaleString()}</p>
                </div>
            </body>
            </html>
        `);
        
    });
});


app.listen(port, () => {
    console.log(`Сервер запущен на http://localhost:${port}`);
});
