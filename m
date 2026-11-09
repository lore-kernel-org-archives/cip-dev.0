Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10684.1794196754379989278
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 19:59:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=EYv64vSY;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794196751;x=1795406351;bh=wt
	Aro1VT/5MeJy7lrlAJZk7gg6MAq3PTPidmRo2zQ2s=;b=EYv64vSYKx2SnN4XBtOUB+NoIdyXfl2A
	mz5PteqypVfdVO9eozly8SH4WCrIPD5uduFhfUJJOclqq5CROiUqAXPE3p0ychrTG6itGmqZyQoEM
	VxHU4bBX7PKd5omP2ONhXc8N+t0Bm+rQRLiRUqCEV9WhaMZs8IsS+/qlcK9klmViD7/yNqUY4Rbvz
	gD0jC84/sssCPIWna2qVkOrjp3N3NkkiSpWi4FGSfbNBuTyAVmdpiRdmKbcwO7uoY2zBHy5IDRKyj
	Y/n3OQlMilD6FHs+83r9seDSzs08PVchSHBvT4zUSsL0LYklmULGZ/ir7espiuPHRGTB6xWs5yoVU
	Ig==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6A93xAh33125926; Mon, 9 Nov 2026 12:59:11 +0900
X-Iguazu-Qid: 2rWg7mGwtARNf4u7Lm
X-Iguazu-QSIG: v=2; s=1; t=1794196750; q=2rWg7mGwtARNf4u7Lm; m=RXQkuXfIgQB9MPcjTjKsID01SpAtPTpmq77nu6+CV8c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNGHf25v9z1xnj; Mon,  9 Nov 2026 12:59:09 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][PATCH v2 3/4] conf: de0-nano-soc: Set U-Boot version for 'buster' to 2025.07
Date: Mon,  9 Nov 2026 12:58:47 +0900
X-TSB-HOP2: ON
Message-Id: <1794196728-1876-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 03:59:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24671
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v2:
  No update.

 conf/machine/de0-nano-soc.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/de0-nano-soc.conf b/conf/machine/de0-nano-soc.conf
index e4669b5..703ea1f 100644
--- a/conf/machine/de0-nano-soc.conf
+++ b/conf/machine/de0-nano-soc.conf
@@ -9,6 +9,8 @@
 DISTRO_ARCH = "armhf"
 DTB_FILES = "socfpga_cyclone5_de0_nano_soc.dtb"
 
+PREFERRED_VERSION_u-boot-de0-nano-soc:buster = "2025.07"
+
 IMAGE_FSTYPES ?= "wic"
 IMAGER_INSTALL:wic += "u-boot-de0-nano-soc ${SYSTEMD_BOOTLOADER_INSTALL}"
 IMAGER_BUILD_DEPS += "u-boot-de0-nano-soc"
-- 
2.55.0


