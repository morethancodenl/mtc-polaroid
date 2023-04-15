const title = document.getElementById('title');
const datetext = document.getElementById('date');
const image = document.getElementById('image');

const callback = (route, data = {}) => {
    fetch(`https://${GetParentResourceName()}/${route}`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
    });
}

const hide = () => {
    document.getElementById('body').style.display = 'none';
    callback('hide');
}

const show = () => {
    document.getElementById('body').style.display = 'block';
} 

const SetImage = ({url, name, date}) => {
    title.innerHTML = name;
    datetext.innerHTML = date;
    image.src = url;
    show();
} 


window.addEventListener('message', (event) => {
    const message = event.data;
    switch (message.type) {
        case 'image':
            SetImage(message);
        break;
    }
});

window.onkeydown = (event) => {
    if (event.key == 'Escape') {
        hide();
    }
}