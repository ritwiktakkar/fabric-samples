## Adding RawMaterials to the test network

You can use the `addRawMaterials.sh` script to add another organization to the Fabric test network. The `addRawMaterials.sh` script generates the RawMaterials crypto material, creates an RawMaterials organization definition, and adds RawMaterials to a channel on the test network.

You first need to run `./network.sh up createChannel` in the `test-network` directory before you can run the `addRawMaterials.sh` script.

```
./network.sh up createChannel
cd addRawMaterials
./addRawMaterials.sh up
```

If you used `network.sh` to create a channel other than the default `mychannel`, you need pass that name to the `addrawmaterials.sh` script.
```
./network.sh up createChannel -c channel1
cd addRawMaterials
./addRawMaterials.sh up -c channel1
```

You can also re-run the `addRawMaterials.sh` script to add RawMaterials to additional channels.
```
cd ..
./network.sh createChannel -c channel2
cd addRawMaterials
./addRawMaterials.sh up -c channel2
```

For more information, use `./addRawMaterials.sh -h` to see the `addRawMaterials.sh` help text.
