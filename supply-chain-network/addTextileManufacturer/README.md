## Adding Textiles to the test network

You can use the `addTextiles.sh` script to add another organization to the Fabric test network. The `addTextiles.sh` script generates the Textiles crypto material, creates an Textiles organization definition, and adds Textiles to a channel on the test network.

You first need to run `./network.sh up createChannel` in the `test-network` directory before you can run the `addTextiles.sh` script.

```
./network.sh up createChannel
cd addTextiles
./addTextiles.sh up
```

If you used `network.sh` to create a channel other than the default `mychannel`, you need pass that name to the `addtextile.sh` script.
```
./network.sh up createChannel -c channel1
cd addTextiles
./addTextiles.sh up -c channel1
```

You can also re-run the `addTextiles.sh` script to add Textiles to additional channels.
```
cd ..
./network.sh createChannel -c channel2
cd addTextiles
./addTextiles.sh up -c channel2
```

For more information, use `./addTextiles.sh -h` to see the `addTextiles.sh` help text.
