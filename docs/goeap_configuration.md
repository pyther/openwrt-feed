`goeap_proxy` Configuration
====

For an example of configuration of `goeap_proxy`, this works on WRT1900. This
will allow you to connect to an ONT directly by forwarding EAP to an unrooted
(or rooted) network provided gateway.

`/etc/config/network`
----

Here is an example of the relevant parts of `/etc/config/network`

```text
config interface 'lan'
	option device 'br-lan'
	option proto 'static'
	option ipaddr '192.168.1.1'
	option netmask '255.255.255.0'
	option ip6assign '60'

config device
	option name 'wan'
	option macaddr 'YOUR_ONT_MAC'

config interface 'wan'
	option device 'wan'
	option force_link '1'
	option proto 'dhcp'
	option peerdns '0'
	list dns '1.1.1.1'
	list dns '1.0.0.1'

config interface 'ont'
	option proto 'none'
	option device 'wan'

config interface 'rgw'
	option proto 'none'
	option device 'lan1'

config interface 'wan6'
	option device 'wan'
	option proto 'dhcpv6'
```

`/etc/config/goeap_proxy`

----
And this matches with this part of `/etc/config/goeap_proxy`

```text
config goeap_proxy 'global'
	option wan 'ont'
	option router 'rgw'
	option ignore_logoff 0
```

After updating both of these files run

```shell
/etc/init.d/network restart
/etc/init.d/goeap_proxy restart
```
