# mvie-autostart-models

IBM Maximo Visual Inspection Edge automatic starting of models in a folder

## Description

Automatically starts MVI models from a common folder: `/opt/ibm/mvie-autostart-models`

After installation, any zip file placed into this folder will be automatically started when the system boots.

**Note**: this is not an official IBM script, and no guarantees are made for it's usefulness or functionality.

## File naming convention

Files need to be named like `model.part.gpu.zip` when they are placed in the autostart folder.

Examples:

| Filename         | Model | Port  | GPU   |
| ---------------- | :---: | :---: | :---: |
| wheel.5001.0.zip | wheel | 5001  | 0     |
| mask.5002.0.zip  | mask  | 5002  | 0     |
| mask2.5003.1.zip | mask2 | 5003  | 1     |


## Installation

1. install the script (as root)

```
cd /opt/ibm
git clone https://github.com/ericlowry/mvie-autostart-models.git
cd mvie-autostart-models
```

2. Activate the script

Tell your OS to call the script at start up.


Ubuntu:
```
rc.local instructions coming soon
```

Redhat:
```
init.d instructions coming soon
```

3. Move models into autostart folder and test configuration.

```
mv ~/Downloads/my-wheel-model.zip ./wheel.5001.0.zip
```

Note: script stops and removes named models as needed.

```
./mvie-autostart-models.sh
```

4. Restart and check your models
```
shutdown -r now
```

```
docker ps -q -f name=wheel
```
