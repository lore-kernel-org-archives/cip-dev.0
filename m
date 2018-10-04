From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Thu, 04 Oct 2018 13:44:53 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 Use zImage to fix the iwg20m health check failures #186
Message-ID: <5bb6195519ff_1b513fcb3a3d88cc6071b2@sidekiq-asap-03-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
924551c5 by Robert Marshall at 2018-09-28T09:26:20Z
Use zImage to fix the iwg20m health check failures #186

LAVA converts the zImage to a uImage using bootm_kernel_addr
which can cause iwg20m not to boot.

- - - - -
333024a2 by Robert Marshall at 2018-10-04T13:44:50Z
Merge branch &#39;iwg20m-usezImage&#39; into &#39;master&#39;

Use zImage to fix the iwg20m health check failures #186

See merge request cip-project/cip-testing/board-at-desk-single-dev!63
- - - - -


2 changed files:

- device-types/renesas-iwg20m.jinja2
- tests/iwg20m-test-ramdisk.yaml


Changes:

=====================================
device-types/renesas-iwg20m.jinja2
=====================================
@@ -4,11 +4,11 @@
 {% set baud_rate = baud_rate|default(115200) %}
 {% set device_type = "renesas-iwg20m" %}
 {% set bootloader_prompt = bootloader_prompt|default('iWave-G20M >') %}
-{% set kernel_file = kernel_file | default('uImage') %}
+{% set kernel_file = kernel_file | default('zImage') %}
 {% set dtb_file = dtb_file | default('r8a7743-iwg20d-q7.dtb') %}
-{% set bootm_kernel_addr = '0x40007fc0' %}
-{% set bootm_ramdisk_addr = '0x41000000' %}
-{% set bootm_dtb_addr = '0x40f00000' %}
+{% set bootz_kernel_addr = '0x40008000' %}
+{% set bootz_ramdisk_addr = '0x41000000' %}
+{% set bootz_dtb_addr = '0x40f00000' %}
 {% set bootm_low = '0x41e00000' %}
 {% set bootm_size = '0x100000' %}
 {% set fdt_addr = '0x40f00000' %}


=====================================
tests/iwg20m-test-ramdisk.yaml
=====================================
@@ -47,7 +47,6 @@ actions:
       - '\(initramfs\)'
     method: u-boot
     commands: ramdisk
-    type: uimage
     timeout:
       minutes: 5
 



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/f6ac04206848442dff3b5f18880274d9f64df61b...333024a28086e6f98ec9b871d5467e0544c2ac9e

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/f6ac04206848442dff3b5f18880274d9f64df61b...333024a28086e6f98ec9b871d5467e0544c2ac9e
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181004/5ee4abd4/attachment.html>
