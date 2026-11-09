Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10833.1794196937782109822
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 20:02:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Zu+zXPWt;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1794196935;x=1795406535;bh=qMxRj2fJ9vAFP8XB0Gg+Bu48rm051Px58fXeKHpikmc=;b=Zu+
	zXPWtgv0sedYEI8NTMu9BvsiBS2Ius1n1hT7vsL9zWg2keUe3tB4elyoK9GOFqk+VdCnwH5Sovsse
	p1sjXowTcUuVk4rw2f3wMrlxj8TuI0Jr+KSPaNRU52qtDhmQjOyqPmlAaVx/bSA8eX67ZR2qtH4ta
	7D95RIMgOfIi0IlPTOGlFdGzwfr3RZzmI4oJIaTB0NWbHP3PTN+HfD7jnFU3oKRELttDNJCyhjf+3
	qp2NOpCqv2cMw9DccrOfFkrkhCJ2LCdi03OabRIAFFExje4oFWre7aVuX2f+ZHBF93ktewBvtueH7
	btAD6OPznNA6vav/VXEA5g8DRTCxiBA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6A942ExO2962788; Mon, 9 Nov 2026 13:02:15 +0900
X-Iguazu-Qid: 2rWgtwVk7oVVEHCBm9
X-Iguazu-QSIG: v=2; s=1; t=1794196934; q=2rWgtwVk7oVVEHCBm9; m=/jl6bhTyBjuHc0VDIOr5PCQ77lAjeXwASsMp9KMZ9j4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNGMB41Zwz1xnj; Mon,  9 Nov 2026 13:02:14 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][PATCH] wic: de0-nano-soc: Fix serial console device name to ttyS0
Date: Mon,  9 Nov 2026 13:02:09 +0900
X-TSB-HOP2: ON
Message-Id: <1794196929-2063-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 04:02:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24677
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The serial console device filename for the DE0-Nano-SoC is ttyS0, not ttyO0.
This changes from ttyO0 to ttyS0.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 wic/de0-nano-soc-efibootguard.wks.in | 2 +-
 wic/de0-nano-soc.wks                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efibootguard.wks.in
index a1c1108..724f54f 100644
--- a/wic/de0-nano-soc-efibootguard.wks.in
+++ b/wic/de0-nano-soc-efibootguard.wks.in
@@ -17,4 +17,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
 
-bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
+bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyS0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/de0-nano-soc.wks b/wic/de0-nano-soc.wks
index df4bcec..a968bb3 100644
--- a/wic/de0-nano-soc.wks
+++ b/wic/de0-nano-soc.wks
@@ -11,4 +11,4 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/de0-nano-soc/u-boot-w
 part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot,dtb=socfpga_cyclone5_de0_nano_soc.dtb" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid 16d61432-ec24-42fa-a4b8-b2bc20a26f5e --use-uuid
 part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d --use-uuid
 
-bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --timeout=0 --append "rootwait console=ttyO0,115200"
+bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --timeout=0 --append "rootwait console=ttyS0,115200"
-- 
2.55.0


