From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 24 Jun 2019 14:58:15 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master]
	Import more data
Message-ID: <5d10e50747c72_2bed3fa922b2ccac175880@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
dc96f854 by Ben Hutchings at 2019-06-24T14:58:04Z
Import more data

- - - - -


11 changed files:

- issues/CVE-2018-12126.yml
- issues/CVE-2018-12127.yml
- issues/CVE-2018-12130.yml
- issues/CVE-2019-10126.yml
- issues/CVE-2019-11091.yml
- issues/CVE-2019-11599.yml
- issues/CVE-2019-12381.yml
- + issues/CVE-2019-12817.yml
- issues/CVE-2019-12818.yml
- issues/CVE-2019-12819.yml
- issues/CVE-2019-3896.yml


Changes:

=====================================
issues/CVE-2018-12126.yml
=====================================
@@ -21,6 +21,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3985-2
 - https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00233.html
 - https://usn.ubuntu.com/usn/usn-3977-2
+- https://usn.ubuntu.com/usn/usn-3977-3
 comments:
   Debian-bwh: |-
     Intel-specific hardware vulnerability similar to L1TF though more


=====================================
issues/CVE-2018-12127.yml
=====================================
@@ -21,6 +21,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3985-2
 - https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00233.html
 - https://usn.ubuntu.com/usn/usn-3977-2
+- https://usn.ubuntu.com/usn/usn-3977-3
 comments:
   Debian-bwh: |-
     Intel-specific hardware vulnerability similar to L1TF though more


=====================================
issues/CVE-2018-12130.yml
=====================================
@@ -21,6 +21,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3985-2
 - https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00233.html
 - https://usn.ubuntu.com/usn/usn-3977-2
+- https://usn.ubuntu.com/usn/usn-3977-3
 comments:
   Debian-bwh: |-
     Intel-specific hardware vulnerability similar to L1TF though more


=====================================
issues/CVE-2019-10126.yml
=====================================
@@ -3,3 +3,5 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-10126
 - https://lore.kernel.org/linux-wireless/20190531131841.7552-1-tiwai at suse.de
 - https://marc.info/?l=oss-security&m=155965912410053&w=2
+fixed-by:
+  mainline: [69ae4f6aac1578575126319d3f55550e7e440449]


=====================================
issues/CVE-2019-11091.yml
=====================================
@@ -21,6 +21,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3985-2
 - https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00233.html
 - https://usn.ubuntu.com/usn/usn-3977-2
+- https://usn.ubuntu.com/usn/usn-3977-3
 reporters:
 - Ke Sun
 - Henrique Kawakami


=====================================
issues/CVE-2019-11599.yml
=====================================
@@ -28,5 +28,6 @@ fixed-by:
   linux-4.14.y: [bb461ad8e6e0653fc6bd0f26d9173bab0aec235b]
   linux-4.19.y: [6ff17bc5936e5fab33de8064dc0690f6c8c789ca]
   linux-4.19.y-cip: [6ff17bc5936e5fab33de8064dc0690f6c8c789ca]
+  linux-4.4.y: [8f6345a11caae324ad36abca8723a5710d099a85]
   linux-5.0.y: [1eb719f09f7e319e79f6abf2b9e8c0dcc1c477b5]
   mainline: [04f5866e41fb70690e28397487d8bd8eea7d712a]


=====================================
issues/CVE-2019-12381.yml
=====================================
@@ -11,5 +11,7 @@ comments:
   Debian-bwh: |-
     There was already a null check before dereferencing the pointer.
     No security impact.
+fixed-by:
+  mainline: [425aa0e1d01513437668fa3d4a971168bbaa8515]
 ignore:
   all: Invalid


=====================================
issues/CVE-2019-12817.yml
=====================================
@@ -0,0 +1,20 @@
+description: |-
+  It was discovered that the Linux kernel did not properly separate certain
+  memory mappings when creating new userspace processes on 64-bit Power
+  (ppc64el) systems. A local attacker could use this to access memory contents
+  or cause memory corruption of other processes on the system.
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12817
+- https://usn.ubuntu.com/usn/usn-4031-1
+comments:
+  Ubuntu-tyhicks: |-
+    The vulnerability was introduced in upstream kernel version v4.17
+    This issue only affects ppc64el. The 32-bit powerpc architecture is
+     not affected.
+    Power8, Power7, Power6, Power5, and older 64-bit Power systems are
+     affected by default
+    Power9 LPARs running under PowerVM are affected by default. This
+     issue does not affect Power9 bare metal systems by default. Power9 bare metal
+     is only affected when "disable_radix" is specified as a kernel boot option.
+introduced-by:
+  mainline: [f384796c40dc55b3dba25e0ee9c1afd98c6d24d1]


=====================================
issues/CVE-2019-12818.yml
=====================================
@@ -10,3 +10,12 @@ references:
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=58bdd544e2933a21a51eecf17c3f5f94038261b5
 - https://github.com/torvalds/linux/commit/58bdd544e2933a21a51eecf17c3f5f94038261b5
 - https://www.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.20.15
+fixed-by:
+  linux-3.16.y: [2c716db6f80cef6159972be0dab86892c39de277]
+  linux-4.14.y: [b275f8e6a0096cac11cf697c4e3ad226070264f5]
+  linux-4.19.y: [f132b3f5f1ad1cbe818474ab8d0b555ff39369d5]
+  linux-4.19.y-cip: [f132b3f5f1ad1cbe818474ab8d0b555ff39369d5]
+  linux-4.4.y: [6e7339d5ee302fcbfe8ef29c058cc85c360849b9]
+  linux-4.4.y-cip: [6e7339d5ee302fcbfe8ef29c058cc85c360849b9]
+  linux-4.9.y: [05d3d2d0b8574d0f61d12a64e2c6475a5c3d5ba6]
+  mainline: [58bdd544e2933a21a51eecf17c3f5f94038261b5]


=====================================
issues/CVE-2019-12819.yml
=====================================
@@ -8,3 +8,14 @@ references:
 - https://git.kernel.org/linus/6ff7b060535e87c2ae14dd8548512abfdda528fb
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6ff7b060535e87c2ae14dd8548512abfdda528fb
 - https://github.com/torvalds/linux/commit/6ff7b060535e87c2ae14dd8548512abfdda528fb
+introduced-by:
+  mainline: [0c692d07842a67d9aa6b8266a80e4ac460a5c1a2]
+fixed-by:
+  linux-3.16.y: [8a5e2f4be5d08d16964ce2adb8da6fc42052c6f1]
+  linux-4.14.y: [07c2216c3783daca34ea0d86affb9dfc5346f183]
+  linux-4.19.y: [96a3b14450afa83f4f3ffdeafaca19db8e05c2fd]
+  linux-4.19.y-cip: [96a3b14450afa83f4f3ffdeafaca19db8e05c2fd]
+  linux-4.4.y: [a1b4ace43842791d908a8837304031e439c2ea39]
+  linux-4.4.y-cip: [a1b4ace43842791d908a8837304031e439c2ea39]
+  linux-4.9.y: [c4bec922def2285707cd3be3a80be46467ad8cde]
+  mainline: [6ff7b060535e87c2ae14dd8548512abfdda528fb]


=====================================
issues/CVE-2019-3896.yml
=====================================
@@ -5,3 +5,9 @@ description: |-
 references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3896
 - https://bugzilla.redhat.com/show_bug.cgi?id=1694812
+- https://marc.info/?t=127366612300001&r=1&w=2
+- https://marc.info/?l=linux-kernel&m=127422151819010&w=2
+- https://lore.kernel.org/patchwork/patch/205534/
+- ttps://marc.info/?t=136035740900005&r=1&w=2
+fixed-by:
+  mainline: [2dcb22b346be7b7b7e630a8970d69cf3f1111ec1]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/dc96f854ab41d10385d0c90aae5efc0402d5f9ed

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/dc96f854ab41d10385d0c90aae5efc0402d5f9ed
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190624/55b64733/attachment-0001.html>
