# BGP Configure

## Usage

Run script `install.sh` as root. It will use `yum` as package manager, which is the default on CentOS.

## Configuration

Specify the address of the peer router in `bgpd.conf` before installing. `dump_bgp.sh` runs once every day to dump the whole BGP table into `/tmp`. If you want to change the directory, please find it in `dump_bgp.sh`. And if you want to change the interval between dump, find the configuration in `install.sh`.
