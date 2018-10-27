# Create MongDB Cluster with Vagrant

Run it;

```bash
vagrant up
```

**Optional**: If you want to reach MongoDB instances from your local computer (via [Robo3T](https://robomongo.org)) you need to add these lines to hosts file;

```bash
172.81.81.2 master01
172.81.81.3 replica01
172.81.81.4 replica02
```