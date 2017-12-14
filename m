From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 14 Dec 2017 14:57:14 +0900
Subject: [cip-dev] [PATCH 2/3] iwg20m: add device type and dictionary
	template
In-Reply-To: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1513231035-42479-3-git-send-email-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The user will have to modify myiwg20m.jinja2 according
to its environment (ip address, PDU, etc)

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 device-dictionary/myiwg20m.jinja2     |  9 +++++++++
 device-types/renesas-iwg20m.jinja2    | 15 +++++++++++++++
 integration-scripts/configure_lava.sh |  6 ++++++
 3 files changed, 30 insertions(+)
 create mode 100644 device-dictionary/myiwg20m.jinja2
 create mode 100644 device-types/renesas-iwg20m.jinja2

diff --git a/device-dictionary/myiwg20m.jinja2 b/device-dictionary/myiwg20m.jinja2
new file mode 100644
index 0000000..fc0de62
--- /dev/null
+++ b/device-dictionary/myiwg20m.jinja2
@@ -0,0 +1,9 @@
+{% extends 'renesas-iwg20m.jinja2' %}
+{% set connection_command = 'telnet localhost 8020' %}
+{% set power_on_command = 'curl http://admin:<password>@<ip>/set.cmd?cmd=setpower+p61=1' %}
+{% set power_off_command = 'curl http://admin:<password>@<ip>/set.cmd?cmd=setpower+p61=0' %}
+{% set hard_reset_command = 'curl http://admin:<password>@<ip>/set.cmd?cmd=setpower+p61=0; curl http://admin:12345678 at 192.168.11.68/set.cmd?cmd=setpower+p61=1' %}
+{% set test_delay = 500 %}
+{% set uboot_ipaddr_cmd = 'setenv ipaddr 192.168.1.55' %}
+{% set base_ip_args = 'ip=192.168.1.55' %}
+{% set extra_kernel_args = 'ignore_loglevel vmalloc=384M' %}
diff --git a/device-types/renesas-iwg20m.jinja2 b/device-types/renesas-iwg20m.jinja2
new file mode 100644
index 0000000..f1506ae
--- /dev/null
+++ b/device-types/renesas-iwg20m.jinja2
@@ -0,0 +1,15 @@
+{% extends 'base-uboot.jinja2' %}
+
+{% set console_device = console_device|default('ttySC0') %}
+{% set baud_rate = baud_rate|default(115200) %}
+{% set device_type = "renesas-iwg20m" %}
+{% set bootloader_prompt = bootloader_prompt|default('iWave-G20M >') %}
+{% set kernel_file = kernel_file | default('uImage') %}
+{% set dtb_file = dtb_file | default('r8a7743-iwg20d-q7.dtb') %}
+{% set bootm_kernel_addr = '0x40007fc0' %}
+{% set bootm_ramdisk_addr = '0x41000000' %}
+{% set bootm_dtb_addr = '0x40f00000' %}
+{% set bootz_kernel_addr = '0x40007fc0' %}
+{% set bootz_ramdisk_addr = '0x81600000' %}
+{% set bootz_dtb_addr = '0x40f00000' %}
+{% set uboot_mkimage_arch = 'arm' %}
diff --git a/integration-scripts/configure_lava.sh b/integration-scripts/configure_lava.sh
index 8d75b76..b13acdd 100755
--- a/integration-scripts/configure_lava.sh
+++ b/integration-scripts/configure_lava.sh
@@ -51,6 +51,12 @@ sudo DEBIAN_FRONTEND=noninteractive cp mybbb.dat /etc/lava-server/dispatcher-con
 sudo DEBIAN_FRONTEND=noninteractive chown lavaserver.lavaserver /etc/lava-server/dispatcher-config/devices/*
 # lava-tool device-dictionary --update mybbb.dat http://lavauser at localhost:8080/RPC2 bbb01
 
+# Renesas iwg20m
+sudo DEBIAN_FRONTEND=noninteractive cp -v /vagrant/device-types/renesas-iwg20m.jinja2 /etc/lava-server/dispatcher-config/device-types/
+sudo DEBIAN_FRONTEND=noninteractive lava-server manage device-types add renesas-iwg20m
+sudo DEBIAN_FRONTEND=noninteractive lava-server manage devices add --device-type renesas-iwg20m --worker $(hostname --long) iwg20m01
+sudo DEBIAN_FRONTEND=noninteractive cp -v /vagrant/device-dictionary/myiwg20m.jinja2 /etc/lava-server/dispatcher-config/devices/iwg20m01.jinja2
+
 # Change the default shutdown message for kernel v4.4 - comment these lines out if using older kernel with a Shutdown message of "The system is going down for reboot NOW"
 cd /usr/lib/python2.7/dist-packages/lava_dispatcher/pipeline/utils/
 sudo DEBIAN_FRONTEND=noninteractive sed -ie "/SHUTDOWN_MESSAGE/s/The system is going down for reboot NOW/Restarting system/" constants.py
-- 
2.7.4
