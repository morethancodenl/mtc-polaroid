![Polaroid](https://i.imgur.com/DkWqDk5.png)

# Polaroid
A Polaroid Camera resource for QBCore or Qbox Framework, within the script we focused on usability and a clean UI.

## 🔌 Installation:
To get started with the MTC Polaroid resource, follow these steps:

1. Clone this repository and place the files into your designated resources folder.
2. Rename the script file to ```mtc-polaroid```.
3. Configure the webhook in the ```server/main.lua``` file.
4. Set up the necessary inventory items.
5. Use the Polaroid Camera with the ```polaroid_paper``` item in you're inventory.

If you want to use qb-input/Don't have ox_lib installed:
1. Head over to fxmanifest.lua
2. Remove the following line: `'@ox_lib/init.lua'`
3. Change shared.lua to use Input `qb`

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

[![Discord](https://discord.com/api/guilds/1075048579758035014/widget.png?style=banner2)](https://discord.gg/cFuv5BMWzK)
