Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10794.1794196754798897222
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 19:59:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=bLpjgAo2;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794196751;x=1795406351;bh=Gx
	eouBiKsM/66P16VEV5kmdF3hlN9QfA1MOo709rl4M=;b=bLpjgAo2BLm0v3+cAajKQsFdLVbZviq7
	7txbGZLsEobejzeKb2Rnh+CuDPT4/y0wNbi3bZ2yVzqAyRGMhLVYRto0mAa5l5iofgPGtNqpQrPZ3
	bSVCpDVC9Kyz15YNOsFqvUcfgfJuBujjG9AlOMabxbADwLOvB7xurxH3bYct+sfQkwDSMjGdCNgC7
	/+NnMZiws3r0V1IjIIUqq8tpAIzxGhqwkCrqMlYMttZTvjfdyuvV46v7J+rkxXM1/+4Qe6Gt1m5Y8
	YlaaWEQMBucboRbI4nOu2hW9jKsD+CxxAXUuPVehF5duxVWtZIKJAJYQ35MkzqoIjwo5t9O1OLVA3
	Sg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6A93xAn62670249; Mon, 9 Nov 2026 12:59:11 +0900
X-Iguazu-Qid: 2yAb07c3DCdgsznIwj
X-Iguazu-QSIG: v=2; s=1; t=1794196750; q=2yAb07c3DCdgsznIwj; m=GbXn7FqGDM0g1jKpvY5TExwjuI5PrUOTRXwzcCI2orY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNGHf4P9kzyPQ; Mon,  9 Nov 2026 12:59:10 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][PATCH v2 4/4] conf: bbb: Set U-Boot version for 'buster' to 2025.07
Date: Mon,  9 Nov 2026 12:58:48 +0900
X-TSB-HOP2: ON
Message-Id: <1794196728-1876-5-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 03:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24675
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v2:
  No update
  
 conf/machine/bbb.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index 40af2dc..f3ab6bc 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -9,6 +9,8 @@
 DISTRO_ARCH = "armhf"
 DTB_FILES = "am335x-boneblack.dtb"
 
+PREFERRED_VERSION_u-boot-bbb:buster = "2025.07"
+
 IMAGE_FSTYPES ?= "wic"
 IMAGER_INSTALL:wic += "u-boot-bbb ${SYSTEMD_BOOTLOADER_INSTALL}"
 IMAGER_BUILD_DEPS += "u-boot-bbb"
-- 
2.55.0


