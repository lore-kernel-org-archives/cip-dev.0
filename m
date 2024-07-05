Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39005C3814E
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 07:16:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.12322.1720163813197433620
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 00:16:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4657GoXq071685; Fri, 5 Jul 2024 16:16:50 +0900
X-Iguazu-Qid: 2rWgK3ox5gW41AzczF
X-Iguazu-QSIG: v=2; s=0; t=1720163810; q=2rWgK3ox5gW41AzczF; m=YGBrl3KOnxSJv+Q713IXpHnVbK+O43Jxl1G6MWRMH8A=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 4657Gnbs3415994
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 16:16:50 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 2/2] README.m-com-x86.md: Add M-COM board specific details
Date: Fri,  5 Jul 2024 12:41:29 +0530
X-TSB-HOP2: ON
Message-Id: <20240705071129.1374609-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705071129.1374609-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20240705071129.1374609-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2024 07:16:46.0250 (UTC) FILETIME=[4B83A8A0:01DACEAB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 07:16:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16383

From: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>

Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/boards/README.m-com-x86.md | 112 +++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 doc/boards/README.m-com-x86.md

diff --git a/doc/boards/README.m-com-x86.md b/doc/boards/README.m-com-x86.md
new file mode 100644
index 0000000..a72dd09
--- /dev/null
+++ b/doc/boards/README.m-com-x86.md
@@ -0,0 +1,112 @@
+# ISAR CIP Core: Instructions for M-COM RT X86 V1
+
+## Build the CIP Core image
+
+Set up `kas-container` as described in the [top-level README](../../README.md).
+Then build the image:
+
+```
+$ ./kas-container build kas-cip.yml:kas/board/x86-uefi.yml:kas/opt/6.1.yml:kas/opt/bookworm.yml
+```
+
+After the build is finished, insert a USB stick and flash the image. 
+
+
+**Note:** please make sure to diable watchdog by setting timeout as "0" for SWUpdate and Secure Boot images.
+
+## Software Update and verification
+
+Build the Software update enabled image,
+```
+host$ ./kas-container menu
+```
+Select below things,
+
+* Generic x86 machine booting via UEFI
+* Kernel 6.1.x-cip
+* Bookworm (12)
+* Security extensions
+* Set EFI Boot Guard watchdog timeout in seconds to "0"
+* Click on Build to build the image
+
+Copy the .swu file generated from the above build to temporary folder, which will be used for swupdate.
+
+Create second image(RT Kernel image) by selecting all the options mentioned above and additionally select RT Kernel option.
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
+Build the Secure Boot enable image,
+```
+host$ ./kas-container menu
+```
+Select below things,
+* Generic x86 machine booting via UEFI
+* Kernel 6.1.x-cip
+* Bookworm (12)
+* Security extensions --> select Secure boot support
+* Set EFI Boot Guard watchdog timeout in seconds to "0"
+* Click on Build to build the image
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



