Return-Path: <SRS0=fSzv=BD=lists.cip-project.org=bounce+64572+5009+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A1C433E5
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:01:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3210F206D8
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PfmIz+rL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3210F206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5009+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ph2BYY4521723xFkFLzugXs7; Fri, 24 Jul 2020 08:01:58 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.7992.1595602911888646512
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 08:01:52 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 06OF1oji005834
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2020 17:01:50 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.3.170])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 06OF1lbr027266;
	Fri, 24 Jul 2020 17:01:49 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v3 6/6] doc: Add README for secureboot
Date: Fri, 24 Jul 2020 17:01:47 +0200
Message-Id: <20200724150147.8253-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200724150147.8253-1-Quirin.Gylstorff@siemens.com>
References: <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
 <20200724150147.8253-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id 06OF1oji005834
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 41mtRRXwnh5IF4bYOZQ1ffwgx4520388AA=
Content-Type: multipart/mixed; boundary="0IFFxak9uDPtJboH2UBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595602918;
 bh=QoAIpGaeuJTK/h5rGCi0GlAXgCViitGKTFwZjDEirDQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PfmIz+rLe+PsUDRWsGJSxklUogy//oacuCDNcgHdHmGdfxUASvD2Q1NlZ6jNx7DpwP3
 ofqkDV6droVNNn5Ch6iUhJzL6w0F2z1HbX/0hbUHO6or+pZoKNqMtKqWBiJCfWJYvSd2n
 0/ZoNHNNxwJPXPQT2U/nDIn0Pu1WsgZ0OlM=

--0IFFxak9uDPtJboH2UBY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.secureboot.md | 229 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)
 create mode 100644 doc/README.secureboot.md

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
new file mode 100644
index 0000000..d79248b
--- /dev/null
+++ b/doc/README.secureboot.md
@@ -0,0 +1,229 @@
+# Efibootguard Secure boot
+
+This document describes how to generate a secure boot capable image with
+[efibootguard](https://github.com/siemens/efibootguard).
+
+## Description
+
+The image build signs the efibootguard bootloader (bootx64.efi) and gene=
rates
+a signed [unified kernel image](https://systemd.io/BOOT_LOADER_SPECIFICA=
TION/).
+A unified kernel image packs the kernel, initramfs and the kernel comman=
d-line
+in one binary object. As the kernel command-line is immutable after the =
build
+process, the previous selection of the root file system with a command-l=
ine parameter is no longer
+possible. Therefore the selection of the root file-system occurs now in =
the initramfs.
+
+The image uses an A/B partition layout to update the root file system. T=
he sample implementation to
+select the root file system generates a uuid and stores the id in /etc/o=
s-release and in the initramfs.
+During boot the initramfs compares its own uuid with the uuid stored in =
/etc/os-release of each rootfs.
+If a match is found the rootfs is used for the boot.
+
+## Adaptation for Images
+
+###  WIC
+The following elements must be present in a wks file to create a secure =
boot capable image.
+
+```
+part --source efibootguard-efi  --sourceparams "signwith=3D<script or ex=
ecutable to sign the image>"
+part --source efibootguard-boot --sourceparams "uefikernel=3D<name of th=
e unified kernel>,signwith=3D<script or executable to sign the image>"
+```
+
+#### Script or executable to sign the image
+
+The wic plugins for the [bootloader](./scripts/lib/wic/plugins/source/ef=
ibootguard-efi.py)
+and [boot partition](./scripts/lib/wic/plugins/source/efibootguard-boot.=
py) require an
+executable or script with the following interface:
+```
+<script_name> <inputfile> <outputfile>
+```
+- script name: name and path of the script added with
+`--sourceparams "signwith=3D/usr/bin/sign_secure_image.sh"` to the wic i=
mage
+- inputfile: path and name of the file to be signed
+- outputfile: path and name of the signed input
+
+Supply the script name and path to wic by adding
+`signwith=3D<path and name of the script to sign>"` to sourceparams of t=
he partition.
+
+
+### Existing packages to sign an image
+
+#### ebg-secure-boot-snakeoil
+
+This package uses the snakeoil key and certificate from the ovmf package=
(0.0~20200229-2)
+backported from Debian bullseye and signs the image.
+
+#### ebg-secure-boot-secrets
+This package takes a user-generated certificate and adds it to the build=
 system.
+The following variable and steps are necessary to build a secure boot ca=
pable image:
+- Set certification information to sign and verify the image with:
+    - SB_CERTDB: The directory containing the certificate database creat=
e with certutil
+    - SB_VERIFY_CERT: The certificate to verify the signing process
+    - SB_KEY_NAME: Name of the key in the certificate database
+- if necessary change the script to select the boot partition after an u=
pdate
+    - recipes-support/initramfs-config/files/initramfs.selectrootfs.scri=
pt
+
+The files referred by SB_CERTDB and SB_VERIFY_CERT must be store in  `re=
cipes-devtools/ebg-secure-boot-secrets/files/`
+
+## QEMU
+
+Set up a secure boot test environment with [QEMU](https://www.qemu.org/)
+
+### Prerequisites
+
+- OVMF from edk2 release edk2-stable201911 or newer
+  - This documentation was tested under Debian 10 with OVMF (0.0~2020022=
9-2) backported from Debian
+  bullseye
+- efitools for KeyTool.efi
+  - This documentation was tested under Debian 10 with efitools (1.9.2-1=
) backported from Debian bullseye
+- libnss3-tools
+
+### Debian Snakeoil keys
+
+The build copies the  Debian Snakeoil keys to the directory `./build/tmp=
/deploy/images/<machine>/OVMF. Y
+u can use them as described in section [Start Image](### Start the image=
).
+
+### Generate Keys
+
+#### Reuse exiting keys
+
+It is possible to use exiting keys like /usr/share/ovmf/PkKek-1-snakeoil=
.pem' from Debian
+by executing the script  `scripts/generate-sb-db-from-existing-certifica=
te.sh`, e.g.:
+```
+export SB_NAME=3D<name for the secureboot config>
+export SB_KEYDIR=3D<location to store the database>
+export INKEY=3D<secret key of the certificate>
+export INCERT=3D<certificate>
+export INNICK=3D<name of the certificate in the database>
+scripts/generate-sb-db-from-existing-certificate.sh
+```
+This will create the directory `SB_KEYDIR` and will store the `${SB_NAME=
}certdb` with the given name.
+
+Copy the used certificate and database to `recipes-devtools/ebg-secure-b=
oot-secrets/files/`
+
+#### Generate keys
+
+To generate the necessary keys and information to test secure-boot with =
QEMU
+execute the script `scripts/generate_secure_boot_keys.sh`
+
+##### Add Keys to OVMF
+1. Create a folder and copy the generated keys and KeyTool.efi
+(in Debian the file can be found at: /lib/efitools/x86_64-linux-gnu/KeyT=
ool.efi) to the folder
+```
+mkdir secureboot-tools
+cp -r keys secureboot-tools
+cp /lib/efitools/x86_64-linux-gnu/KeyTool.efi secureboot-tools
+```
+2. Copy the file OVMF_VARS.fd (in Debian the file can be found at /usr/s=
hare/OVMF/OVMF_VARS.fd)
+to the current directory. OVMF_VARS.fd contains no keys can be instrumen=
ted for secureboot.
+3. Start QEMU with the script scripts/start-efishell.sh
+```
+scripts/start-efishell.sh secureboot-tools
+```
+4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the following =
steps:
+          -> "Edit Keys"
+             -> "The Allowed Signatures Database (db)"
+                -> "Add New Key"
+                -> Change/Confirm device
+                -> Select "DB.esl" file
+             -> "The Key Exchange Key Database (KEK)"
+                -> "Add New Key"
+                -> Change/Confirm device
+                -> Select "KEK.esl" file
+             -> "The Platform Key (PK)
+                -> "Replace Key(s)"
+                -> Change/Confirm device
+                -> Select "PK.auth" file
+5. quit QEMU
+
+### Build image
+
+Build the image with a signed efibootguard and unified kernel image
+with the snakeoil keys by executing:
+```
+kas-docker --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg=
-swu.yml:kas/opt/ebg-secure-boot-snakeoil.yml
+```
+
+For user-generated keys, create a new option file. This option file coul=
d look like this:
+```
+header:
+  version: 8
+  includes:
+   - opt/ebg-swu.yml
+   - opt/ebg-secure-boot-initramfs.yml
+
+local_conf_header:
+  secure-boot: |
+    IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-secrets"
+    IMAGER_INSTALL +=3D "ebg-secure-boot-secrets"
+  user-keys:
+    SB_CERTDB =3D "democertdb"
+    SB_VERIFY_CERT =3D "demo.crt"
+    SB_KEY_NAME =3D "demo"
+```
+
+Replace `demo` with the name of the user-generated certificates.
+
+### Start the image
+
+#### Debian snakeoil
+
+Start the image with the following command:
+```
+SECURE_BOOT=3Dy \
+./start-qemu.sh amd64
+```
+
+The default `OVMF_VARS.snakeoil.fd` boot to the EFI shell. To boot Linux=
 enter the following command:
+```
+FS0:\EFI\BOOT\bootx64.efi
+```
+To change the boot behavior, enter `exit` in the shell to enter the bios=
 and change the boot order.
+
+#### User-generated keys
+Start the image with the following command:
+```
+SECURE_BOOT=3Dy \
+OVMF_CODE=3D./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE.secboot.=
fd \
+OVMF_VARS=3D<path to the modified OVMF_VARS.fd> \
+./start-qemu.sh amd64
+```
+# Example: Update the image
+
+For updating the image, the following steps are necessary:
+- [Build the image with snakeoil keys](### Build image)
+- save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-im=
age-cip-core-buster-qemu-amd64.swu` to /tmp
+- modify the image for example add a new version to the image by adding =
`PV=3D2.0.0` to
+  [cip-core-image.bb](recipes-core/images/cip-core-image.bb)
+- start the new target and copy the swu `cip-core-image-cip-core-buster-=
qemu-amd64.swu`
+  to the running system, e.g.:
+```
+SECURE=3Dy ./start-qemu.sh amd64 -virtfs local,path=3D/tmp,mount_tag=3Dh=
ost0,security_model=3Dpassthrough,id=3Dhost0
+```
+- mount `host0` on target with:
+```
+mount -t 9p -o trans=3Dvirtio,version=3D9p2000.L host0 /mnt
+```
+- check which partition is booted, e.g. with `lsblk`:
+```
+root@demo:/mnt# lsblk
+NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
+sda      8:0    0    2G  0 disk
+=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
+=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
+=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
+=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part /
+=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part
+```
+
+- install with `swupdate -i /mnt/cip-core-image-cip-core-buster-qemu-amd=
64.swu`
+- reboot
+- check which partition is booted, e.g. with `lsblk`. The rootfs should =
have changed:
+```
+root@demo:~# lsblk
+NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
+sda      8:0    0    2G  0 disk
+=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
+=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
+=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
+=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part
+=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part /
+```
--=20
2.20.1


--0IFFxak9uDPtJboH2UBY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5009): https://lists.cip-project.org/g/cip-dev/message=
/5009
Mute This Topic: https://lists.cip-project.org/mt/75767907/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0IFFxak9uDPtJboH2UBY--
