# mtc-camera

## Our links
- [Discord](https://discord.gg/APFHf9hhkG)
- [Tebex (Paid scripts)](https://mtc.tebex.io/)


## Setting up:
1. Clone the files and put it in your resources folder
2. Rename the script to mtc-camera
3. Setup the webhook in server/main.lua
4. Use the camera item with the paper item in your inventory

## Items:

**QBCore Shared Items**
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

**OX Inventory Data**
```
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
    },
```
