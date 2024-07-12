Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D10C3DA52
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 08:51:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.3546.1720774286902669167
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 01:51:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 46C8pPpb3910673; Fri, 12 Jul 2024 17:51:25 +0900
X-Iguazu-Qid: 2yAaySvebzpa3M8Qgr
X-Iguazu-QSIG: v=2; s=0; t=1720774284; q=2yAaySvebzpa3M8Qgr; m=2GdSMCSzEVAQajGjX56YVqW+0ZVcc8zgBOHJyoZF3vs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 46C8pNB31497871
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 17:51:24 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/2] doc: Add information about Debian snakeoil and user generated keys method for secure boot
Date: Fri, 12 Jul 2024 14:15:57 +0530
X-TSB-HOP2: ON
Message-Id: <20240712084557.3351285-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712084557.3351285-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20240712084557.3351285-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Jul 2024 08:51:21.0132 (UTC) FILETIME=[AAE62EC0:01DAD438]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 08:51:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16463

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/boards/README.m-com-x86.md | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/doc/boards/README.m-com-x86.md b/doc/boards/README.m-com-x86.md
index cbd74ad..8b183ff 100644
--- a/doc/boards/README.m-com-x86.md
+++ b/doc/boards/README.m-com-x86.md
@@ -42,14 +42,27 @@ For verification, please follow the [SWUpdate verification steps](../README.swup
 **Note:**
 * All the steps are specific to M-COM RT X86 V1 device hence consult device specific manual for other devices for Secure Boot verification.
 
-Copy KeyTool.efi and UEFI keys into USB stick as mentioned in [Secure boot key enrollment](../README.secureboot.md#secure-boot-key-enrollment)
+The isar-cip-core supports secure boot using below keys,
+
+* Debian snakeoil keys --> The current build system selects this method as default
+* User generated keys
+
+### Debian snakeoil keys
+
+Refer the section [Generate keys from Debian snakeoil keys](../README.secureboot.md#generate-keys-from-debian-snakeoil-keys) to generate required UEFI keys and copy them (PK.esl and PK.auth) to `keys` folder. create `keys` folder in the isar-cip-core if doen't exist.
+
+### User generated keys
+
+Refer the section [Generate keys](../README.secureboot.md#generate-keys-1) to generate required UEFI keys. It will generate the UEFI keys in `keys` folder.
+
+Once the UEFI keys are generated, copy `KeyTool.efi` and `keys` folder (i.e UEFI keys) into USB stick as mentioned in [Secure boot key enrollment](../README.secureboot.md#secure-boot-key-enrollment)
 
 Insert USB memory stick to M-COM device.
 
 Power on and Press F12 key to Enter BIOS setup.
 
 **Note:**
-* if you want to restore the default BIOS settings then
+* In order to restore the default BIOS settings then
 Under "Save & Exit" tab, Click on "Restore User Defaults" and select "Yes" to restore default values.
 
 Enable Secure Boot and enter to Setup Mode by following below steps
@@ -69,7 +82,7 @@ Under Save & Exit tab,
 
 Exit from the KeyTool.efi and built-in EFI shell to BIOS.
 
-Optionally you can confirm the injected keys like below:
+Optionally the injected keys can be confirmed like below:
 
 Under security tab,
 * Click on "Secure Boot" and then "Key Management" to confirm the injected Secure Boot keys (DB, KEK and PK).
@@ -79,7 +92,9 @@ Under Save & Exit" tab
 
 Now the keys are injected, remove the USB stick.
 
-Refer the section [Build the cip core image](README.m-com-x86.md#build-the-cip-core-image) to create secure boot enabled image,
+For Debian snakeoil keys method, refer the section [Build the cip core image](README.m-com-x86.md#build-the-cip-core-image) to create secure boot enabled image.
+
+For User generated keys method, refer the build steps here [Build image](../README.secureboot.md#build-image), please note the following keys `keys/demoDB.crt` and `keys/demoDB.key` needs to be copied under `recipes-devtools/secure-boot-secrets/files` path before building the image.
 
 Once build is completed, flash the Secure Boot image to USB stick and insert the USB memory stick to M-COM device.
 
-- 
2.39.2



