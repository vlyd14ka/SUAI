document.getElementById('tolstoyBtn').addEventListener('click', function() {
    loadPhoto('Толстой');
});

document.getElementById('dostoevskyBtn').addEventListener('click', function() {
    loadPhoto('Достоевский');
});

document.getElementById('tchaikovskyBtn').addEventListener('click', function() {
    loadPhoto('Чайковский');
});

document.getElementById('block1').addEventListener('click', function() {
    changeContentAndColor(this);
});

document.getElementById('block2').addEventListener('click', function() {
    changeContentAndColor(this);
});

function loadPhoto(name) {
    var photoContainer = document.getElementById('photoContainer');
    var photoUrl;

    switch (name) {
        case 'Толстой':
            photoUrl = '1.jpg';
            break;
        case 'Достоевский':
            photoUrl = '2.jpg';
            break;
        case 'Чайковский':
            photoUrl = '3.jpg';
            break;
        default:
            photoUrl = '';
    }

    if (photoUrl) {
        photoContainer.innerHTML = `<img src="${photoUrl}" alt="${name}">`;
    } else {
        photoContainer.innerHTML = 'No photo available';
    }
}

function changeContentAndColor(element) {
    var colors = ['#ff0000', '#00ff00', '#0000ff', '#ffff00', '#ff00ff', '#00ffff', '#ff8000', '#8000ff', '#0080ff', '#ff0080', '#80ff00', '#00ff80', '#800000', '#008000', '#000080', '#808080'];
    var randomColor = colors[Math.floor(Math.random() * colors.length)];
    var newText = prompt('напишите новый текст:');
    if (newText !== null) {
        element.textContent = newText;
        element.style.backgroundColor = randomColor;
    }
}
