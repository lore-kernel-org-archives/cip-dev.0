Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C07AC3065B
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 06:45:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.13643.1719816322451869668
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Jun 2024 23:45:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4616jK8l1517098; Mon, 1 Jul 2024 15:45:20 +0900
X-Iguazu-Qid: 2yAaDGEE0dfaEbg6LO
X-Iguazu-QSIG: v=2; s=0; t=1719816319; q=2yAaDGEE0dfaEbg6LO; m=uxQ5Wz8MX8epMnwdjJS37l6LiP7aePABFpetwFoH5yo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4616jJl74109484
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 15:45:19 +0900
From: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] doc/REAME.secureboot.md: Add MCOM specific secure boot details
Date: Mon,  1 Jul 2024 12:10:05 +0530
X-TSB-HOP2: ON
Message-Id: <20240701064005.1651999-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Jul 2024 06:45:17.0708 (UTC) FILETIME=[3C3404C0:01DACB82]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Jul 2024 06:45:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16352

Add separate section to configure and verify secure boot on MCOM device.
This section includes the detailed steps to enable secure boot via BIOS
and inject keys using Keytool.efi and finally the verification part.

Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.secureboot.md | 85 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 3ae4154..7917207 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -322,7 +322,28 @@ The following keys need to be enrolled onto the device:
 
 The enrollment can typically be achieved with the help of
 [efi-updatevar](https://manpages.debian.org/bookworm/efitools/efi-updatevar.1.en.html)
-on the device. Otherwise, consult the manual of the specific UEFI Firmware.
+on the device.
+
+If the device supports built in EFI shell then the enrollment of keys can also be done by KeyTool.efi tool like below:
+
+Format the USB memory stick
+
+```
+host$ sudo mkfs.vfat <usb device>
+host$ sudo mount -t vfat /dev/<usb device> /mnt/
+```
+
+Copy the KeyTool.efi binary and self signed Secure Boot keys to USB stick
+
+Here the folder "keys" contains Secure Boot keys(DB, KEK and PK).
+```
+host$ sudo apt install efitools
+host$ sudo mkdir -p /mnt/efi/boot
+host$ sudo cp /usr/lib/efitools/x86_64-linux-gnu/KeyTool.efi /mnt/efi/boot/KeyTool.efi
+host$ sudo cp -r keys /mnt/
+host$ sudo umount /mnt
+```
+Launch KeyTool.efi binary from the built in EFI shell and follow step-4 from the section [Add Keys to OVMF](#add-keys-to-ovmf) to inject Secure Boot keys. Otherwise, consult the manual of the specific UEFI Firmware.
 
 Use the recipes [secure-boot-key](###secure-boot-key) to provided the keys
 to the signing script contained in
@@ -334,3 +355,65 @@ During building a efibootguard based wic image the scripts contained in
 the recipe ebg-secure-boot-signer can be used to sign the bootloader and
 unified kernel image(UKI). If the keys are stored in a HSM the script can
 be exchanged to sign the artifacts in a more secure way.
+
+### Secure Boot configurations and verification on M-COM(X86)
+
+**Note:**
+* All the steps are specific to M-COM RT X86 V1 device hence consult device specific manual for other devices for Secure Boot verification.
+
+Copy KeyTool.efi and UEFI keys into USB stick as mentioned in [Secure boot key enrollment](#secure-boot-key-enrollment)
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
+* In the EFI shell, run KeyTool.efi from the USB stick and add all Secure Boot keys from USB. Follow the step-4 from the section [Add Keys to OVMF](#add-keys-to-ovmf) to inject the Secure Boot keys.
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
+Flash the Secure Boot image to USB stick and insert the USB memory stick to M-COM device.
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



