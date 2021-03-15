# Generate Simulink model file from port configs

## Steps

1. Set your module info in `blocks.json`. e.g.
```json
{
    "Name": "BooltoEG",
    "DisplayName": "BooltoEG",
    "Inports": [
        "Bool"
        ],
    "Outports": [
        "States","Times"
        ]
}
```

> Notes
>>**"/"** is **not** allowed in `Name`

2. run `block_gen.m`
3. check the output model file in the matlab current directory