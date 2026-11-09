Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10708.1794196848149712510
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 20:00:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=pG6WlzOd;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1794196845;x=1795406445;bh=HH2RferN6LGMGfBQ2xpMBFsOUP7O3dz7WO6PuS+HUaA=;b=pG6
	WlzOd2vQY/oGEaOaP0gopsTzb3LictJX7Xco5XnKdM4N7vjRaZ2l+9XH41hZyX1EMPwOLnQRf2oHA
	LZ2OAecHp6WhE0AE9rob0w+PeaU8kfDsBuo9F62oIzzW/LEHyHJ/ynGadtlDrmJCgMvNvYbnsOzR0
	pvGgbMH8DA8Cfi//BePprrTuTqu8pzSV1VHWGUft4POSP0aWdgxIKc7hp+uZKq9Yi5D6bU3nqyGo9
	wUtBXz12Pl5dGtuJLdAnd7icR/hEfObpVp6dhLPwYl9C1z+JHRjL5owbnaboVbWvWT7re7HnQ+X0c
	Mtwv3BfekTuO7aLZZZq/tXiuPuf7a1Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6A940jjZ2912981; Mon, 9 Nov 2026 13:00:45 +0900
X-Iguazu-Qid: 2yAac6huvVb0JNHkLg
X-Iguazu-QSIG: v=2; s=1; t=1794196845; q=2yAac6huvVb0JNHkLg; m=xlwcgoAWQLTZH9pPSHEECrPZAg1fTI2su4NxlvnRuCY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNGKT02Vwz1xnk; Mon,  9 Nov 2026 13:00:45 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][PATCH] Kconfig: Sort supported boards by architecture
Date: Mon,  9 Nov 2026 13:00:42 +0900
X-TSB-HOP2: ON
Message-Id: <1794196842-2008-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 04:00:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24676
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index c5dc301..163813b 100644
--- a/Kconfig
+++ b/Kconfig
@@ -133,13 +133,13 @@ config KAS_INCLUDE_BOARD
 	default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
 	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
 	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
+	default "kas/board/rzt2h-evk.yml" if TARGET_RZT2H
 	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
 	default "kas/board/bbb.yml" if TARGET_BBB
 	default "kas/board/de0-nano-soc.yml" if TARGET_DE0_NANO_SOC
 	default "kas/board/iwg20m.yml" if TARGET_IWG20D
 	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
 	default "kas/board/beaglev-fire.yml" if TARGET_BEAGLEV_FIRE
-	default "kas/board/rzt2h-evk.yml" if TARGET_RZT2H
 
 comment "Kernel options"
 
-- 
2.55.0


