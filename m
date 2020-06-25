Return-Path: <SRS0=TBiR=AG=lists.cip-project.org=bounce+64572+4829+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD0C433E6
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:23 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7790206C3
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VrQlAjyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7790206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4829+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HtyhYY4521723x9J2CsficqC; Thu, 25 Jun 2020 07:10:22 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.11426.1593094221295219319
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 07:10:21 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 05PEAJ6G021343
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 16:10:19 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05PEAFXa000356;
	Thu, 25 Jun 2020 16:10:19 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core RFC 7/7] doc: Add README for secureboot
Date: Thu, 25 Jun 2020 16:10:15 +0200
Message-Id: <20200625141015.31719-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tTceyRAGyXVX9qY8IfsPrmORx4520388AA=
Content-Type: multipart/mixed; boundary="TVykkBOCWGa6ikfM5IFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593094222;
 bh=9pCX7GRHS065Ryq0T1FscW78X0JINRYF8jzS2sgRKmU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VrQlAjyuvZ9zLrogwIQYXyAZhw4MZA08LgNc6Uom60JbR3OZOvDxY43mAYQxJk3oWAI
 IdTaPEMqv+7XGlqoKYx+ySwHpiGZyKpQlxEF0ac488vo3jJy4dZFIMyyaIhZX3Ah+VIvv
 R0O6uVnJeMd9tNzlmaCBjqWH51mZnPNpmTc=

--TVykkBOCWGa6ikfM5IFC
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.secureboot.md | 188 +++++++++++++++++++++++++++++++++++++++
 kas/opt/qemu-wic.yml     |  14 +++
 2 files changed, 202 insertions(+)
 create mode 100644 doc/README.secureboot.md
 create mode 100644 kas/opt/qemu-wic.yml

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
new file mode 100644
index 0000000..3cd76af
--- /dev/null
+++ b/doc/README.secureboot.md
@@ -0,0 +1,188 @@
+# Efibootguard Secure boot
+
+This document describes how to generate a secure boot capable image with
+[efibootguard](https://github.com/siemens/efibootguard).
+
+## Description
+
+The image build signs the efibootguard bootloader (bootx64.efi) and generates
+a signed [unified kernel image](https://systemd.io/BOOT_LOADER_SPECIFICATION/).
+A unified kernel image packs the kernel, initramfs and the kernel command-line
+in one binary object. As the kernel command-line is immutable after the build
+process, the previous selection of the root file system with a command-line parameter is no longer
+possible. Therefore the selection of the root file-system occurs now in the initramfs.
+
+The image uses an A/B partition layout to update the root file system. The sample implementation to
+select the root file system generates a uuid and stores the id in /etc/os-release and in the initramfs.
+During boot the initramfs compares its own uuid with the uuid stored in /etc/os-release of each rootfs.
+If a match is found the rootfs is used for the boot.
+
+## Adaptation for Images
+
+###  WIC
+The following elements must be present in a wks file to create a secure boot capable image.
+
+```
+part --source efibootguard-efi  --sourceparams "signwith=<script or executable to sign the image>"
+part --source efibootguard-boot --sourceparams "uefikernel=<name of the unified kernel>,signwith=<script or executable to sign the image>"
+```
+
+#### Script or executable to sign the image
+
+The wic plugins for the [bootloader](./scripts/lib/wic/plugins/source/efibootguard-efi.py)
+and [boot partition](./scripts/lib/wic/plugins/source/efibootguard-boot.py) require an
+executable or script with the following interface:
+```
+<script_name> <inputfile> <outputfile>
+```
+- script name: name and path of the script added with
+`--sourceparams "signwith=/usr/bin/sign_secure_image.sh"` to the wic image
+- inputfile: path and name of the file to be signed
+- outputfile: path and name of the signed input
+
+Supply the script name and path to wic by adding
+`signwith=<path and name of the script to sign>"` to sourceparams of the partition.
+
+
+### Existing packages to sign an image
+
+#### ebg-secure-boot-snakeoil
+
+This package uses the snakeoil key and certificate from the ovmf package(0.0~20200229-2)
+backported from Debian bullseye and signs the image.
+
+#### ebg-secure-boot-secrets
+This package takes a user-generated certificate and adds it to the build system.
+The following variable and steps are necessary to build a secure boot capable image:
+- Set certification information to sign and verify the image with:
+    - SB_CERTDB: The directory containing the certificate database create with certutil
+    - SB_VERIFY_CERT: The certificate to verify the signing process
+    - SB_KEY_NAME: Name of the key in the certificate database
+- if necessary change the script to select the boot partition after an update
+    - recipes-support/initramfs-config/files/initramfs.selectrootfs.script
+
+The files referred by SB_CERTDB and SB_VERIFY_CERT must be store in  `recipes-devtools/ebg-secure-boot-secrets/files/`
+
+## QEMU
+
+Set up a secure boot test environment with [QEMU](https://www.qemu.org/)
+
+### Prerequisites
+
+- OVMF from edk2 release edk2-stable201911 or newer
+  - This documentation was tested under Debian 10 with OVMF (0.0~20200229-2) backported from Debian
+  bullseye
+- efitools for KeyTool.efi
+  - This documentation was tested under Debian 10 with efitools (1.9.2-1) backported from Debian bullseye
+- libnss3-tools
+
+### Debian Snakeoil keys
+
+The build copies the  Debian Snakeoil keys to the directory `./build/tmp/deploy/images/<machine>/OVMF. Y
+u can use them as described in section [Start Image](### Start the image).
+
+### Generate Keys
+
+#### Reuse exiting keys
+
+It is possible to use exiting keys like /usr/share/ovmf/PkKek-1-snakeoil.pem' from Debian
+by executing the script  `scripts/generate-sb-db-from-existing-certificate.sh`, e.g.:
+```
+export SB_NAME=<name for the secureboot config>
+export SB_KEYDIR=<location to store the database>
+export INKEY=<secret key of the certificate>
+export INCERT=<certificate>
+export INNICK=<name of the certificate in the database>
+scripts/generate-sb-db-from-existing-certificate.sh
+```
+This will create the directory `SB_KEYDIR` and will store the `${SB_NAME}certdb` with the given name.
+
+Copy the used certificate and database to `recipes-devtools/ebg-secure-boot-secrets/files/`
+
+#### Generate keys
+
+To generate the necessary keys and information to test secure-boot with QEMU
+execute the script `scripts/generate_secure_boot_keys.sh`
+
+##### Add Keys to OVMF
+1. Create a folder and copy the generated keys and KeyTool.efi
+(in Debian the file can be found at: /lib/efitools/x86_64-linux-gnu/KeyTool.efi) to the folder
+```
+mkdir secureboot-tools
+cp -r keys secureboot-tools
+cp /lib/efitools/x86_64-linux-gnu/KeyTool.efi secureboot-tools
+```
+2. Copy the file OVMF_VARS.fd (in Debian the file can be found at /usr/share/OVMF/OVMF_VARS.fd)
+to the current directory. OVMF_VARS.fd contains no keys can be instrumented for secureboot.
+3. Start QEMU with the script scripts/start-efishell.sh
+```
+scripts/start-efishell.sh secureboot-tools
+```
+4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the following steps:
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
+kas-docker --isar build kas/cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-secure-boot-snakeoil.yml
+```
+
+For user-generated keys, create a new option file. This option file could look like this:
+```
+header:
+  version: 8
+  includes:
+   - opt/ebg-swu.yml
+   - opt/ebg-secure-boot-initramfs.yml
+
+local_conf_header:
+  secure-boot: |
+    IMAGER_BUILD_DEPS += "ebg-secure-boot-secrets"
+    IMAGER_INSTALL += "ebg-secure-boot-secrets"
+  user-keys:
+    SB_CERTDB = "democertdb"
+    SB_VERIFY_CERT = "demo.crt"
+    SB_KEY_NAME = "demo"
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
+SECURE_BOOT=y \
+./start-qemu.sh amd64
+```
+
+The default `OVMF_VARS.snakeoil.fd` boot to the EFI shell. To boot Linux enter the following command:
+```
+FS0:\EFI\BOOT\bootx64.efi
+```
+To change the boot behavior, enter `exit` in the shell to enter the bios and change the boot order.
+
+#### User-generated keys
+Start the image with the following command:
+```
+SECURE_BOOT=y \
+OVMF_CODE=./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE.secboot.fd \
+OVMF_VARS=<path to the modified OVMF_VARS.fd> \
+./start-qemu.sh amd64
+```
diff --git a/kas/opt/qemu-wic.yml b/kas/opt/qemu-wic.yml
new file mode 100644
index 0000000..3489183
--- /dev/null
+++ b/kas/opt/qemu-wic.yml
@@ -0,0 +1,14 @@
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Licensed under the Siemens Inner Source License 1.2, or at your option any
+# later version.
+#
+
+header:
+  version: 8
+
+local_conf_header:
+  qemu-wic: |
+    IMAGE_TYPE ?= "wic-img"
+    WKS_FILE = "qemu-amd64-${BOOTLOADER}.wks"
-- 
2.20.1


--TVykkBOCWGa6ikfM5IFC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4829): https://lists.cip-project.org/g/cip-dev/message=
/4829
Mute This Topic: https://lists.cip-project.org/mt/75103455/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--TVykkBOCWGa6ikfM5IFC--
