Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2275.1793956082213588405
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2026 01:08:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ePaL/0jf;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1793956079;x=1795165679;bh=L/
	ByAtlNKh7cDIMu19mgWj4VCfOyabp5n/pB23Dvel4=;b=ePaL/0jfXs9DsMWsI4WRVzDglEq3h/xd
	g17jel870FfQqXdaXNlVMopv050powFs4poRha3afvN7wb7BbxssrIRWyRbENNKp3JoRbKX9t6jiq
	Ckt4YaNONSOKuDAxzsAUSZSDgdnT/IuJoe/9Xq82J76ULsCgboKFqhbc/qIRgnmFhGNp1RLRwsjy3
	9PDLRVz8a+BU6nEpaQeBIQXCGop5fnKWU3Fvkc0vyXKmH9+OPmG1YClpk3PuKtaNsRI75wyghSrjk
	182WrrcPEWWQPZLjaoKwnjc6anmhDB2sGhhaYXjdonjm830S5qHKgmby/E6Q/WvD77JvqCy5VqoK5
	wQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6A697xUb2484877; Fri, 6 Nov 2026 18:07:59 +0900
X-Iguazu-Qid: 2rWgAJSOTl9EkVjlZ2
X-Iguazu-QSIG: v=2; s=1; t=1793956079; q=2rWgAJSOTl9EkVjlZ2; m=EpWXlnmxxrvXU7Pgy4zHEAHqhdiaHfotPceqlrax7To=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jLYHM0YJpz4vyn; Fri,  6 Nov 2026 18:07:58 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][RFC PATCH 3/4] conf: de0-nano-soc: Set U-Boot version for 'buster' to 2025.07
Date: Fri,  6 Nov 2026 18:07:44 +0900
X-TSB-HOP2: ON
Message-Id: <1793956065-3316-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 09:08:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24658
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
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


