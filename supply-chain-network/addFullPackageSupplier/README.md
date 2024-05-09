## Adding FullPackageSupplier to the test network

You can use the `addFullPackageSupplier.sh` script to add another organization to the Fabric test network. The `addFullPackageSupplier.sh` script generates the FullPackageSupplier crypto material, creates an FullPackageSupplier organization definition, and adds FullPackageSupplier to a channel on the test network.

You first need to run `./network.sh up createChannel` in the `test-network` directory before you can run the `addFullPackageSupplier.sh` script.

```
./network.sh up createChannel
cd addFullPackageSupplier
./addFullPackageSupplier.sh up
```

If you used `network.sh` to create a channel other than the default `mychannel`, you need pass that name to the `addfullpackagesupplier.sh` script.
```
./network.sh up createChannel -c channel1
cd addFullPackageSupplier
./addFullPackageSupplier.sh up -c channel1
```

You can also re-run the `addFullPackageSupplier.sh` script to add FullPackageSupplier to additional channels.
```
cd ..
./network.sh createChannel -c channel2
cd addFullPackageSupplier
./addFullPackageSupplier.sh up -c channel2
```

For more information, use `./addFullPackageSupplier.sh -h` to see the `addFullPackageSupplier.sh` help text.
