Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8131.1794466780326428530
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 22:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=kK9eW93Z;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794466777;x=1795676377;bh=BW
	nt3o7WQ8frEJMV3qPQSFSOl3O0lkSs1dr5JvnZ8LM=;b=kK9eW93ZLB3o1oY1nzBaKQhkGVQiYdNB
	e6wJV9qFzMRzeAzHLMFIjfgjHgnqjDTTja8QvOYUCrehtoe+G+ri5EpRlnIr9la8TMQlXGnVvsheb
	FxEHtnbV8S9mC78n1mQosaaXGi3fLDy09F+C2wdNgDK2/Rl/ZTnizgWKx7guAPVxhb1WDLKb/RD00
	CD9xGC9efn5irMVRDiplfAafHFgT/J37q7NFf2x6lNnGhfVebYEA3uobWxwIPE6VYleQYOv4bpisd
	3VS4SplMtsE1pFNsevWY9ZpT2wIsB7kma1hEjNpfKIuQVAiIV3njCq/F7zH431JK5Hz2O2oy7NhQ1
	Kw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6AC6xbDO1831278; Thu, 12 Nov 2026 15:59:37 +0900
X-Iguazu-Qid: 2rWhtz9mOD4BeOhybo
X-Iguazu-QSIG: v=2; s=1; t=1794466777; q=2rWhtz9mOD4BeOhybo; m=ssv8/fepZXm4Ku9MlCfUwLV9Jn6CzaeZ2P7NvX6EaAI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jQB8S6syVz4vyn; Thu, 12 Nov 2026 15:59:36 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isa-cip-core][PATCH v3 4/8] conf: de0-nano-soc: Set U-Boot version for 'buster' to 2025.07
Date: Thu, 12 Nov 2026 15:59:14 +0900
X-TSB-HOP2: ON
Message-Id: <1794466758-28304-5-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 06:59:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24777
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v3:
  no update.
v2:
  no update.

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


