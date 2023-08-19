![More Than Code: Vehicle Rental](https://i.imgur.com/6muGpRq.png)

# Polaroid
A Polaroid Camera resource for QBCore or Qbox Framework, within the script we focused on usability and a clean UI.

## 🔌 Installation:
To get started with the MTC Polaroid resource, follow these steps:

1. Clone this repository and place the files into your designated resources folder.
2. Rename the script file to ```mtc-polaroid```.
3. Configure the webhook in the ```server/main.lua``` file.
4. Set up the necessary inventory items.
5. Use the Polaroid Camera with the ```polaroid_paper``` item in you're inventory.

## 📦 Items
You can find the images for the items mentioned below in the ```images``` directory.

**qb-core**
```lua
['polaroid_camera'] = {
    ['name'] = 'polaroid_camera',
    ['label'] = 'Polaroid camera',
    ['weight'] = 5000,
    ['type'] = 'item',
    ['image'] = 'polaroid.png',
    ['unique'] = true,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'Did we just go back in time?'
},
['polaroid'] = {
    ['name'] = 'polaroid',
    ['label'] = 'Polaroid image',
    ['weight'] = 10,
    ['type'] = 'item',
    ['image'] = 'photo.png',
    ['unique'] = true,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'Cool image bro'
},
['polaroid_paper'] = {
    ['name'] = 'polaroid_paper',
    ['label'] = 'Polaroid paper',
    ['weight'] = 10,
    ['type'] = 'item',
    ['image'] = 'photo.png',
    ['unique'] = false,
    ['useable'] = false,
    ['shouldClose'] = false,
    ['combinable'] = nil,
    ['description'] = 'Some paper'
}
```

**ox_inventory**
```lua
["polaroid_camera"] = {
    label = "Polaroid camera",
    weight = 5000,
    stack = false,
    close = true,
    description = "Did we just go back in time?",
    client = {
        image = "polaroid.png",
    }
},
["polaroid_paper"] = {
    label = "Polaroid paper",
    weight = 10,
    stack = true,
    close = false,
    description = "Some paper",
    client = {
        image = "photo.png",
    }
},
["polaroid"] = {
    label = "Polaroid image",
    weight = 10,
    stack = false,
    close = true,
    description = "Cool image bro",
    client = {
        image = "photo.png",
    }
}
```
## 👉 Join our community
[![Discord](https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/tWMvPtq8uu)