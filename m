From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Fri, 20 Apr 2018 15:30:12 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 Renesas changes for a working health check
Message-ID: <5ada078485320_185333f9eb8449d8c13954f@sidekiq-asap-02.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
e5146230 by Robert Marshall at 2018-04-20T15:30:03Z
Renesas changes for a working health check

- - - - -
4dbfc937 by Robert Marshall at 2018-04-20T15:30:03Z
Merge branch &#39;renesasWorking&#39; into &#39;master&#39;

Renesas changes for a working health check

See merge request cip-project/cip-testing/board-at-desk-single-dev!58
- - - - -


4 changed files:

- + device-dictionary/myiwg20m.jinja2
- + device-types/renesas-iwg20m.jinja2
- integration-scripts/configure_lava.sh
- + tests/iwg20m-test-ramdisk.yaml


Changes:

=====================================
device-dictionary/myiwg20m.jinja2
=====================================
--- /dev/null
+++ b/device-dictionary/myiwg20m.jinja2
@@ -0,0 +1,8 @@
+{% extends 'renesas-iwg20m.jinja2' %}
+{% set connection_command = 'telnet 192.168.22.1  8020' %}
+{# Ensure to set 'FILL REMOTE POWER COMMAND' appropriately #}
+{% set power_on_command = 'FILL REMOTE POWER COMMAND' %}
+{% set power_off_command = 'FILL REMOTE POWER COMMAND' %}
+{% set hard_reset_command = 'FILL REMOTE POWER COMMAND' %}
+{% set test_delay = 500 %}
+{% set extra_kernel_args = 'ignore_loglevel vmalloc=384M' %}


=====================================
device-types/renesas-iwg20m.jinja2
=====================================
--- /dev/null
+++ b/device-types/renesas-iwg20m.jinja2
@@ -0,0 +1,16 @@
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
+{% set bootm_low = '0x41e00000' %}
+{% set bootm_size = '0x100000' %}
+{% set fdt_addr = '0x40f00000' %}
+{% set loadaddr = '0x40007fc0' %}
+{% set uboot_mkimage_arch = 'arm' %}


=====================================
integration-scripts/configure_lava.sh
=====================================
--- a/integration-scripts/configure_lava.sh
+++ b/integration-scripts/configure_lava.sh
@@ -49,9 +49,19 @@ echo "{% set connection_command = '/vagrant/scripts/connectBBB.sh 192.168.22.1 8
 # Import the Beaglebone Black Device Dictionary file into the LAVA2 Server
 # needs authentication token setting up
 sudo DEBIAN_FRONTEND=noninteractive cp mybbb.dat /etc/lava-server/dispatcher-config/devices/bbb01.jinja2
-sudo DEBIAN_FRONTEND=noninteractive chown lavaserver.lavaserver /etc/lava-server/dispatcher-config/devices/*
 # lava-tool device-dictionary --update mybbb.dat http://lavauser at localhost:8080/RPC2 bbb01
 
+# Renesas iwg20m
+sudo DEBIAN_FRONTEND=noninteractive cp -v /vagrant/device-types/renesas-iwg20m.jinja2 /etc/lava-server/dispatcher-config/device-types/
+sudo DEBIAN_FRONTEND=noninteractive lava-server manage device-types add renesas-iwg20m
+sudo DEBIAN_FRONTEND=noninteractive lava-server manage devices add --device-type renesas-iwg20m --worker $(hostname --long) iwg20m01
+sudo DEBIAN_FRONTEND=noninteractive cp -v /vagrant/device-dictionary/myiwg20m.jinja2 /etc/lava-server/dispatcher-config/devices/iwg20m01.jinja2
+cp -v /vagrant/device-dictionary/myiwg20m.jinja2 ~/myrenesas.dat
+
+# set permissions on the devices/device types
+sudo DEBIAN_FRONTEND=noninteractive chown lavaserver.lavaserver /etc/lava-server/dispatcher-config/devices/*
+sudo DEBIAN_FRONTEND=noninteractive chown lavaserver.lavaserver /etc/lava-server/dispatcher-config/device-types/*
+
 # Change the default shutdown message for kernel v4.4 - comment these lines out if using older kernel with a Shutdown message of "The system is going down for reboot NOW"
 cd /usr/lib/python2.7/dist-packages/lava_dispatcher/pipeline/utils/
 sudo DEBIAN_FRONTEND=noninteractive sed -ie "/SHUTDOWN_MESSAGE/s/The system is going down for reboot NOW/Restarting system/" constants.py


=====================================
tests/iwg20m-test-ramdisk.yaml
=====================================
--- /dev/null
+++ b/tests/iwg20m-test-ramdisk.yaml
@@ -0,0 +1,75 @@
+# Copyright (C) 2018, Codethink, Ltd., Robert Marshall <robert.marshall@codethink.co.uk>
+# Copyright (C) 2017, Toshiba corp., Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
+# SPDX-License-Identifier:	AGPL-3.0
+# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
+# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
+
+# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+device_type: renesas-iwg20m
+job_name: iwg20m Kernel version test using /TREE/BRANCH/TAG/arm/shmobile_defconfig/zImage
+
+timeouts:
+  job:
+    minutes: 10
+  action:
+    minutes: 5
+  connection:
+    minutes: 5
+priority: medium
+visibility: public
+
+
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 5
+    to: tftp
+    # despite this being a Debian initramfs, it is not a complete Debian rootfs, so use oe compatibility
+    os: oe
+    kernel:
+      url: http://localhost:8010/TREE/BRANCH/TAG/arm/shmobile_defconfig/zImage
+      type: zimage
+    ramdisk:
+      url: http://localhost:8010/initramfs/initramfs.cpio.gz
+      compression: gz
+      # the bootloader needs a u-boot header on the modified ramdisk
+      add-header: u-boot
+    dtb:
+      url: http://localhost:8010/TREE/BRANCH/TAG/arm/shmobile_defconfig/dtbs/r8a7743-iwg20d-q7.dtb
+# BOOT_BLOCK
+- boot:
+    auto_login:
+      login_prompt: '\(none\) login: '
+      username: root
+    prompts:
+      - '\(initramfs\)'
+    method: u-boot
+    commands: ramdisk
+    type: uimage
+    timeout:
+      minutes: 5
+
+# TEST_BLOCK
+- test:
+    timeout:
+      minutes: 5
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: kernel-version-basic
+          version: "1.0"
+          description: "check kernel version"
+          os:
+            - oe
+          scope:
+            - functional
+        run:
+          steps:
+            - lava-test-case uname --shell uname -a
+      from: inline
+      name: kernel-version-inline
+      path: inline/kernel-version-basic.yaml
+



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/4ca4eaa4a004fc10aa046bf150a1940cb26fb77f...4dbfc937754626b0284a8e307cd3ca2048a2f5a7

---
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/4ca4eaa4a004fc10aa046bf150a1940cb26fb77f...4dbfc937754626b0284a8e307cd3ca2048a2f5a7
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180420/e5f1b840/attachment-0001.html>
