Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8128.1794466779110975828
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 22:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=l3P7RfKh;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794466777;x=1795676377;bh=oW
	igUMXM9/tf485Loggrv3NkaFEP6xj9HmpwZseIlBM=;b=l3P7RfKhlQLCP4SYPnUzVynOtVu7Jh+8
	6EykilYcDieMCaagOIjg4vobIipYs57JnGblL4BAB5IRytlpHt/IAshEAiLDxCTEkI4s3NVowQ607
	2djCn2qvb3fc1g3F2xdhv/Fj7l/iJ5XINgIsMxAz6p6j8NrrKHnac+/aECXojwIhvK6cmAZmFsIfT
	4fTu6RjJ5iN7of5+DQONI5fXPVgrLNNHVxjGsVgsYGddJC3ICFLZU24mq4npeKBPKLDLLHoyqb60M
	meL84FIL/98D+THNhE7tva9HeibhGhkvUo2p6NBPeIXPk+UZXlwpxG0ciqC6AAY4vTmcduitBuIu7
	fA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6AC6xalO421433; Thu, 12 Nov 2026 15:59:37 +0900
X-Iguazu-Qid: 2yAbgtIaJA9T2k1YsH
X-Iguazu-QSIG: v=2; s=1; t=1794466776; q=2yAbgtIaJA9T2k1YsH; m=1MmT4z0MMsI44re0pNHEM6VfqrAlmiD2ZwsZzkQ1Ks4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jQB8S4GzmzyPQ; Thu, 12 Nov 2026 15:59:36 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isa-cip-core][PATCH v3 5/8] conf: bbb: Set U-Boot version for 'buster' to 2025.07
Date: Thu, 12 Nov 2026 15:59:15 +0900
X-TSB-HOP2: ON
Message-Id: <1794466758-28304-6-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 06:59:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24772
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v3:
  no update.
v2:
  no update.

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


