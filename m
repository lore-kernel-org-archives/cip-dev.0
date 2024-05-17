Return-Path: <schilling.benjamin@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C6AC04FFE
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 07:38:33 +0000 (UTC)
Subject: Re: [isar-cip-core] [PATCH] Add MCOM x86 target
To: cip-dev@lists.cip-project.org
From: "Benjamin Schilling" <schilling.benjamin@siemens.com>
X-Originating-Location: CH (147.161.228.254)
X-Originating-Platform: Windows Chrome 124
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 17 May 2024 00:38:31 -0700
References: <TY3PR01MB1107541CD6CC53A98748546C4C7E32@TY3PR01MB11075.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1107541CD6CC53A98748546C4C7E32@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Message-ID: <10232.1715931511647432527@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="HJqpilKnWBlHAxTgcqv8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 May 2024 07:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15909

--HJqpilKnWBlHAxTgcqv8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From f1138db08149989dabbec104dd94d04fa276b452 Mon Sep 17 00:00:00 2001
From: Benjamin Schilling <schilling.benjamin@siemens.com>
Date: Wed, 10 Apr 2024 17:21:11 +0200
Subject: [PATCH] Add MCOM x86 target

This patch adds the MCOM x86 as another hardware target.

Signed-off-by: Benjamin Schilling <schilling.benjamin@siemens.com>
---
Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A07 ++++++=
-
conf/machine/mcom-x86.conf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 15 +++++++++++++++
kas/board/mcom-x86.yml =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 15 +++++++++++++++
recipes-kernel/linux/cip-kernel-config.inc | =C2=A02 +-
wic/mcom-x86-efibootguard.wks.in =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 ++=
++++++++++++
5 files changed, 51 insertions(+), 2 deletions(-)
create mode 100644 conf/machine/mcom-x86.conf
create mode 100644 kas/board/mcom-x86.yml
create mode 100644 wic/mcom-x86-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index 7c19640..89f7467 100644
--- a/Kconfig
+++ b/Kconfig
@@ -43,6 +43,10 @@ config TARGET_SIMATIC_IPC227E
bool "Siemens SIMATIC IPC227E"
select ARCH_AMD64

+config TARGET_MCOM_X86
+ =C2=A0 bool "Siemens M-COM X86"
+ =C2=A0 select ARCH_AMD64
+
config TARGET_QEMU_ARM64
bool "QEMU ARM64 (aarch64)"
select ARCH_ARM64
@@ -73,6 +77,7 @@ config KAS_INCLUDE_BOARD
string
default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
default "kas/board/simatic-ipc227e.yml" if TARGET_SIMATIC_IPC227E
+ =C2=A0 default "kas/board/mcom-x86.yml" if TARGET_MCOM_X86
default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
@@ -190,7 +195,7 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19

config IMAGE_SWUPDATE
bool "SWUpdate support for root partition"
- =C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_Q=
EMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERN=
EL_6_1 ) || TARGET_HIHOPE_RZG2M
+ =C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_M=
COM_X86 ||TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QE=
MU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M

config IMAGE_SECURE_BOOT
bool "Secure boot support"
diff --git a/conf/machine/mcom-x86.conf b/conf/machine/mcom-x86.conf
new file mode 100644
index 0000000..21bcd1e
--- /dev/null
+++ b/conf/machine/mcom-x86.conf
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens Mobility GmbH, 2024
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH =3D "amd64"
+
+IMAGE_FSTYPES ?=3D "wic"
+WKS_FILE ?=3D "x86_64-generic.wks"
+IMAGER_INSTALL:wic +=3D "${GRUB_BOOTLOADER_INSTALL}"
+USE_CIP_KERNEL_CONFIG =3D "1"
+KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/si=
emens_mcom_x86_defconfig"
diff --git a/kas/board/mcom-x86.yml b/kas/board/mcom-x86.yml
new file mode 100644
index 0000000..28c4674
--- /dev/null
+++ b/kas/board/mcom-x86.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens Mobility GmbH, 2024
+#
+# Authors:
+# =C2=A0Benjamin Schilling <schilling.benjamin@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+ =C2=A0version: 14
+
+machine: mcom-x86
diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/li=
nux/cip-kernel-config.inc
index 40c378b..e99b085 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,4 +14,4 @@ SRC_URI:append =3D " ${@ \
if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else '' \
}"

-SRCREV_cip-kernel-config ?=3D "ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7"
+SRCREV_cip-kernel-config ?=3D "6631b32fa94bec538be1728500afcc6aa6881d29"
diff --git a/wic/mcom-x86-efibootguard.wks.in b/wic/mcom-x86-efibootguard.w=
ks.in
new file mode 100644
index 0000000..6382ff7
--- /dev/null
+++ b/wic/mcom-x86-efibootguard.wks.in
@@ -0,0 +1,14 @@
+# short-description: x86 with EFI Boot Guard and SWUpdate
+# long-description: Disk image for x86 machines with EFI Boot Guard and SW=
Update
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.squashfs" -=
-align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0F=
C63DAF-8483-4772-8E79-3D69D8477DE4
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_U=
UID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
+
+# home and var are extra partitions
+
+part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --lab=
el home --align 1024 =C2=A0--size 1G --extra-space=3D100M --fsuuid 1f55d66a=
-40d8-11ee-be56-0242ac120002
+part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsuui=
d 96be3374-4258-11ee-be56-0242ac120002
+
+bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,115200 =
rootwait earlyprintk watchdog.handle_boot_enabled=3D0 iTCO_wdt.nowayout=3D1=
 "
--
2.39.2

--HJqpilKnWBlHAxTgcqv8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From f1138db08149989dabbec104dd94d04fa276b452 Mon Sep 17 00:00:00 2001<br /=
>From: Benjamin Schilling &lt;schilling.benjamin@siemens.com&gt;<br />Date:=
 Wed, 10 Apr 2024 17:21:11 +0200<br />Subject: [PATCH] Add MCOM x86 target<=
br /><br /><br />This patch adds the MCOM x86 as another hardware target.<b=
r /><br /><br />Signed-off-by: Benjamin Schilling &lt;schilling.benjamin@si=
emens.com&gt;<br />---<br />&nbsp;Kconfig &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;| &nbsp;7 ++++++-<br />&nbsp;conf/machine/mcom-x86.conf &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | 15 +++++++++++++++<=
br />&nbsp;kas/board/mcom-x86.yml &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; | 15 +++++++++++++++<br />&nbsp;recipes-kernel=
/linux/cip-kernel-config.inc | &nbsp;2 +-<br />&nbsp;wic/mcom-x86-efibootgu=
ard.wks.in &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | 14 ++++++++++++++<br />&nbs=
p;5 files changed, 51 insertions(+), 2 deletions(-)<br />&nbsp;create mode =
100644 conf/machine/mcom-x86.conf<br />&nbsp;create mode 100644 kas/board/m=
com-x86.yml<br />&nbsp;create mode 100644 wic/mcom-x86-efibootguard.wks.in<=
br /><br /><br />diff --git a/Kconfig b/Kconfig<br />index 7c19640..89f7467=
 100644<br />--- a/Kconfig<br />+++ b/Kconfig<br />@@ -43,6 +43,10 @@ confi=
g TARGET_SIMATIC_IPC227E<br />&nbsp; &nbsp; bool "Siemens SIMATIC IPC227E"<=
br />&nbsp; &nbsp; select ARCH_AMD64<br />&nbsp;<br />+config TARGET_MCOM_X=
86<br />+ &nbsp; bool "Siemens M-COM X86"<br />+ &nbsp; select ARCH_AMD64<b=
r />+<br />&nbsp;config TARGET_QEMU_ARM64<br />&nbsp; &nbsp; bool "QEMU ARM=
64 (aarch64)"<br />&nbsp; &nbsp; select ARCH_ARM64<br />@@ -73,6 +77,7 @@ c=
onfig KAS_INCLUDE_BOARD<br />&nbsp; &nbsp; string<br />&nbsp; &nbsp; defaul=
t "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64<br />&nbsp; &nbsp; defaul=
t "kas/board/simatic-ipc227e.yml" if TARGET_SIMATIC_IPC227E<br />+ &nbsp; d=
efault "kas/board/mcom-x86.yml" if TARGET_MCOM_X86<br />&nbsp; &nbsp; defau=
lt "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64<br />&nbsp; &nbsp; defau=
lt "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M<br />&nbsp; &nbsp; d=
efault "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM<br />@@ -190,7 +195,7 @@=
 if IMAGE_FLASH &amp;&amp; !KERNEL_4_4 &amp;&amp; !KERNEL_4_19<br />&nbsp;<=
br />&nbsp;config IMAGE_SWUPDATE<br />&nbsp; &nbsp; bool "SWUpdate support =
for root partition"<br />- &nbsp; depends on TARGET_QEMU_AMD64 || TARGET_SI=
MATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TA=
RGET_QEMU_RISCV64 &amp;&amp; KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M<br />+ &nb=
sp; depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_MCOM_X=
86 ||TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RI=
SCV64 &amp;&amp; KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M<br />&nbsp;<br />&nbsp=
;config IMAGE_SECURE_BOOT<br />&nbsp; &nbsp; bool "Secure boot support"<br =
/>diff --git a/conf/machine/mcom-x86.conf b/conf/machine/mcom-x86.conf<br /=
>new file mode 100644<br />index 0000000..21bcd1e<br />--- /dev/null<br />+=
++ b/conf/machine/mcom-x86.conf<br />@@ -0,0 +1,15 @@<br />+#<br />+# CIP C=
ore, generic profile<br />+#<br />+# Copyright (c) Siemens Mobility GmbH, 2=
024<br />+#<br />+# SPDX-License-Identifier: MIT<br />+#<br />+<br />+DISTR=
O_ARCH =3D "amd64"<br />+<br />+IMAGE_FSTYPES ?=3D "wic"<br />+WKS_FILE ?=
=3D "x86_64-generic.wks"<br />+IMAGER_INSTALL:wic +=3D "${GRUB_BOOTLOADER_I=
NSTALL}"<br />+USE_CIP_KERNEL_CONFIG =3D "1"<br />+KERNEL_DEFCONFIG =3D "ci=
p-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_mcom_x86_defconfig"=
<br />diff --git a/kas/board/mcom-x86.yml b/kas/board/mcom-x86.yml<br />new=
 file mode 100644<br />index 0000000..28c4674<br />--- /dev/null<br />+++ b=
/kas/board/mcom-x86.yml<br />@@ -0,0 +1,15 @@<br />+#<br />+# CIP Core, gen=
eric profile<br />+#<br />+# Copyright (c) Siemens Mobility GmbH, 2024<br /=
>+#<br />+# Authors:<br />+# &nbsp;Benjamin Schilling &lt;schilling.benjami=
n@siemens.com&gt;<br />+#<br />+# SPDX-License-Identifier: MIT<br />+#<br /=
>+<br />+header:<br />+ &nbsp;version: 14<br />+<br />+machine: mcom-x86<br=
 />diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel=
/linux/cip-kernel-config.inc<br />index 40c378b..e99b085 100644<br />--- a/=
recipes-kernel/linux/cip-kernel-config.inc<br />+++ b/recipes-kernel/linux/=
cip-kernel-config.inc<br />@@ -14,4 +14,4 @@ SRC_URI:append =3D " ${@ \<br =
/>&nbsp; &nbsp; &nbsp;if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else =
'' \<br />&nbsp; &nbsp; &nbsp;}"<br />&nbsp;<br />-SRCREV_cip-kernel-config=
 ?=3D "ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7"<br />+SRCREV_cip-kernel-co=
nfig ?=3D "6631b32fa94bec538be1728500afcc6aa6881d29"<br />diff --git a/wic/=
mcom-x86-efibootguard.wks.in b/wic/mcom-x86-efibootguard.wks.in<br />new fi=
le mode 100644<br />index 0000000..6382ff7<br />--- /dev/null<br />+++ b/wi=
c/mcom-x86-efibootguard.wks.in<br />@@ -0,0 +1,14 @@<br />+# short-descript=
ion: x86 with EFI Boot Guard and SWUpdate<br />+# long-description: Disk im=
age for x86 machines with EFI Boot Guard and SWUpdate<br />+<br />+include =
ebg-sysparts.inc<br />+<br />+part --source rawcopy --sourceparams "file=3D=
${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS=
_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4<br />+part =
--source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}=
" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4<br />+<br />+# home and =
var are extra partitions<br />+<br />+part /home --source rootfs --change-d=
irectory=3Dhome --fstype=3Dext4 --label home --align 1024 &nbsp;--size 1G -=
-extra-space=3D100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002<br />+par=
t /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsuuid 96=
be3374-4258-11ee-be56-0242ac120002<br />+<br />+bootloader --ptable gpt --a=
ppend=3D"console=3Dtty0 console=3DttyS0,115200 rootwait earlyprintk watchdo=
g.handle_boot_enabled=3D0 iTCO_wdt.nowayout=3D1 "<br />--<br />2.39.2<br />

--HJqpilKnWBlHAxTgcqv8--

