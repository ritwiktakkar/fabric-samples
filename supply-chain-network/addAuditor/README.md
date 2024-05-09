## Adding Auditor to the test network

You can use the `addAuditor.sh` script to add another organization to the Fabric test network. The `addAuditor.sh` script generates the Auditor crypto material, creates an Auditor organization definition, and adds Auditor to a channel on the test network.

You first need to run `./network.sh up createChannel` in the `test-network` directory before you can run the `addAuditor.sh` script.

```
./network.sh up createChannel
cd addAuditor
./addAuditor.sh up
```

If you used `network.sh` to create a channel other than the default `mychannel`, you need pass that name to the `addauditor.sh` script.
```
./network.sh up createChannel -c channel1
cd addAuditor
./addAuditor.sh up -c channel1
```

You can also re-run the `addAuditor.sh` script to add Auditor to additional channels.
```
cd ..
./network.sh createChannel -c channel2
cd addAuditor
./addAuditor.sh up -c channel2
```

For more information, use `./addAuditor.sh -h` to see the `addAuditor.sh` help text.
