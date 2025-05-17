const Asin = x => Math.asin(x); // Функция арксинуса

// Функция для построения сплайна
const FillSpline = (nodes, R) => {
    const curve = [];
    for (let i = 0; i < nodes.length - 3; i++) {
        for (let j = 0; j <= 1; j += 0.1) {
            curve.push(R(nodes.slice(i, i + 4), j).toFixed(2));
        }
    }
    return curve;
};

// Функция для вычисления точки сплайна
const R = (P, t) => {
    return (1 - t) ** 3 * P[0] / 6 +
           (3 * t ** 3 - 6 * t ** 2 + 4) * P[1] / 6 +
           (-3 * t ** 3 + 3 * t ** 2 + 3 * t + 1) * P[2] / 6 +
           t ** 3 * P[3] / 6;
};

// Получение узлов для сплайна
const GetNodes = (x, num) => {
    const step = Math.floor(x.length / num);
    return Array.from({ length: num }, (_, i) => x[i * step]).filter(Boolean);
};

const numPoints = 23; // Количество точек
const labels = [], data_points = [];

// Заполнение данных для графика
for (let x = -1; x <= 1; x += 0.1) {
    labels.push(x.toFixed(2));
    data_points.push(Asin(x).toFixed(2));
}

// Создаем узлы для сплайна
const nodes_x = GetNodes(labels, numPoints);
const nodes_y = nodes_x.map(x => Asin(parseFloat(x)).toFixed(2));

// Создаем равномерные точки для сплайна
const spline_points_x = Array.from({ length: numPoints }, (_, i) => (-1 + (2 / (numPoints - 1)) * i).toFixed(2));
const spline_points_y = spline_points_x.map(x => Asin(x).toFixed(2));

// Настройка графика
const ctx = document.getElementById('arcsin_chart').getContext('2d');
new Chart(ctx, {
    type: 'scatter',
    data: {
        datasets: [
            {
                label: 'Spline',
                data: spline_points_x.map((x, i) => ({ x, y: spline_points_y[i] })),
                borderColor: 'red',
                borderWidth: 2,
                fill: false,
                showLine: true,
            },
            {
                label: 'f(x) = asin(x)',
                data: labels.map((label, i) => ({ x: label, y: data_points[i] })),
                borderColor: 'blue',
                borderWidth: 3,
                fill: false,
                showLine: true,
                pointRadius: 0,
            }
        ]
    },
    options: {
        responsive: true,
        scales: {
            xAxes: [{ display: true }],
            yAxes: [{ display: true }]
        }
    }
});
// Функция для вычисления среднего отклонения
const Mean = (spline_x, spline_y) => {
    const averageDeviation = spline_x.reduce((m, x, i) => {
        return m + Math.abs(Asin(parseFloat(x)) - parseFloat(spline_y[i]));
    }, 0) / spline_x.length;

    document.getElementById('deviation-value').innerText = averageDeviation.toFixed(4);
};
// Вызов функции для вычисления среднего отклонения
Mean(nodes_x, nodes_y);
