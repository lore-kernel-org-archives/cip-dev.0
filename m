Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEE1C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 15:01:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.18812.1720191683045954728
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 08:01:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 465F1Lx61110650; Sat, 6 Jul 2024 00:01:21 +0900
X-Iguazu-Qid: 2rWgU4KG4IV1sWjb3S
X-Iguazu-QSIG: v=2; s=0; t=1720191680; q=2rWgU4KG4IV1sWjb3S; m=7R4SSN2+2n0Smb9VV7pq7g8rXqHqnRprtBxmPBb8gaQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 465F1JfF4105308
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 6 Jul 2024 00:01:20 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3] README.m-com-x86.md: Add M-COM board specific details
Date: Fri,  5 Jul 2024 20:26:01 +0530
X-TSB-HOP2: ON
Message-Id: <20240705145601.1413337-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2024 15:01:18.0044 (UTC) FILETIME=[3065E9C0:01DACEEC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 15:01:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16417

From: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>

Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/boards/README.m-com-x86.md | 102 +++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 doc/boards/README.m-com-x86.md

diff --git a/doc/boards/README.m-com-x86.md b/doc/boards/README.m-com-x86.md
new file mode 100644
index 0000000..cbd74ad
--- /dev/null
+++ b/doc/boards/README.m-com-x86.md
@@ -0,0 +1,102 @@
+# ISAR CIP Core: Instructions for M-COM RT X86 V1
+
+## Build the CIP Core image
+
+Set up `kas-container` as described in the [top-level README](../../README.md).
+Then build the base image,
+```
+host$ ./kas-container menu
+```
+Select below options to create base image,
+
+* Generic x86 machine booting via UEFI
+* Kernel 6.1.x-cip
+* Bookworm (12)
+* Click on Build to start the build
+
+For SWUpdate image, Just select below additional options on top of base image,
+
+* SWUpdate support for root partition
+* Set EFI Boot Guard watchdog timeout in seconds to "0"
+
+For Secure Boot image, Just select below option on top of SWUpdate image options
+
+* Secure boot support
+
+After the build is finished, insert a USB stick and flash the image.
+
+## Software Update and verification
+
+Refer the section [Build the cip core image](README.m-com-x86.md#build-the-cip-core-image) to create the image with Software update enabled,
+
+Copy the .swu file generated from the first build to temporary folder, which will be used for swupdate.
+
+Create second image(RT Kernel image) so, additionally select RT Kernel option on top of SWUpdate image here.
+
+Flash the image with RT Kernel to USB and boot the image from USB. Copy the .swu file from the temporary folder to M-COM device.
+
+For verification, please follow the [SWUpdate verification steps](../README.swupdate.md#swupdate-verification)
+
+## Secure Boot Configuration and Verification
+
+**Note:**
+* All the steps are specific to M-COM RT X86 V1 device hence consult device specific manual for other devices for Secure Boot verification.
+
+Copy KeyTool.efi and UEFI keys into USB stick as mentioned in [Secure boot key enrollment](../README.secureboot.md#secure-boot-key-enrollment)
+
+Insert USB memory stick to M-COM device.
+
+Power on and Press F12 key to Enter BIOS setup.
+
+**Note:**
+* if you want to restore the default BIOS settings then
+Under "Save & Exit" tab, Click on "Restore User Defaults" and select "Yes" to restore default values.
+
+Enable Secure Boot and enter to Setup Mode by following below steps
+
+**Note:**
+* Due to following step, old keys will be deleted hence it’s recommended to take backup of old keys to avoid any data loss.
+
+Under Security tab,
+* Enable Secure Boot if disabled. The System Mode will be "User" by default.
+* Click on "Reset To Setup Mode" to remove existing keys.
+   Select "Yes" to delete all Secure Boot keys database
+* The System Mode should change to "Setup" once we delete all Secure Boot keys.
+
+Under Save & Exit tab,
+* Go to "Boot Override" and click on "UEFI: Built-in EFI shell" which will launch the EFI shell.
+* In the EFI shell, run KeyTool.efi from the USB stick and add all Secure Boot keys from USB. Follow the step-4 from the section [Add Keys to OVMF](../README.secureboot.md#add-keys-to-ovmf) to inject the Secure Boot keys.
+
+Exit from the KeyTool.efi and built-in EFI shell to BIOS.
+
+Optionally you can confirm the injected keys like below:
+
+Under security tab,
+* Click on "Secure Boot" and then "Key Management" to confirm the injected Secure Boot keys (DB, KEK and PK).
+
+Under Save & Exit" tab
+* Click on "Save Changes & Exit".
+
+Now the keys are injected, remove the USB stick.
+
+Refer the section [Build the cip core image](README.m-com-x86.md#build-the-cip-core-image) to create secure boot enabled image,
+
+Once build is completed, flash the Secure Boot image to USB stick and insert the USB memory stick to M-COM device.
+
+Power on and Press F12 key to Enter BIOS setup.
+
+In the BIOS, Configure the device to boot from USB by following below steps
+
+Under "Boot" tab,
+
+* Select "Boot Option #1" as USB device from the "Boot Option Priorities" section.
+
+Under "Save & Exit" tab,
+
+* Click on "Save Changes & Exit". The M-COM board starts to boot the image from USB.
+
+After boot, check the dmesg for Secure Boot status like below:
+```
+root@demo:~# dmesg | grep Secure
+[    0.008368] Secure boot enabled
+```
-- 
2.39.2



