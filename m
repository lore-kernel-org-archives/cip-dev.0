Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8270.1794466779051239722
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 22:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=xbFJ8WYQ;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794466776;x=1795676376;bh=8r
	/+edMvxsyX9/zeMf6XBZ7afXi9nV/BSLmZk1vZ30Q=;b=xbFJ8WYQIgD09LBlYSy2ev+tvlYYDJIC
	YlsT29xhi/m1IY2jFeLfBrf8djjNTW1L1vVJpUcjHzEOv9sKlXHoev6CJ/eXB0gF8gua++fLsObGk
	VTNN6SnYZO6BLaNkPzvLMEQfTgkxD+dzBlDHgVv2IgQGHGXbvm6sZj6Od83vSdjsjjj0EMeNXqX52
	7jaRxXM505SL6EykJZGlusP32im4U6cq8AD4LVyZ8HNfTwmzTuZEgk+ofzAaIvuAKTLT4sHtcToeK
	pGcZ7/da+G32gbMDiciv24SdoJyQXb5WIpUVDE2/G9RQXsy0nh/LViheiOH6/I6xsVt+laB/2Fu6c
	nQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6AC6xamL196938; Thu, 12 Nov 2026 15:59:36 +0900
X-Iguazu-Qid: 2yAb6Z6JvSF5yYxy6O
X-Iguazu-QSIG: v=2; s=1; t=1794466776; q=2yAb6Z6JvSF5yYxy6O; m=ummN/YMsagsotqh4OkxTm/OmGBevikT8OCFUF9DiEYo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jQB8S2l4RzyPQ; Thu, 12 Nov 2026 15:59:35 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isa-cip-core][PATCH v3 6/8] conf: qemu-arm64: Set U-Boot version for 'buster' to 2025.07
Date: Thu, 12 Nov 2026 15:59:16 +0900
X-TSB-HOP2: ON
Message-Id: <1794466758-28304-7-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 06:59:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24776
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v3:
  new patch.

 conf/machine/qemu-arm64.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 314d143..e6679f5 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -11,6 +11,8 @@ DISTRO_ARCH = "arm64"
 IMAGE_FSTYPES ?= "ext4"
 IMAGE_FSTYPES:append:ftpm-stmm = " qemu-emmc"
 
+PREFERRED_VERSION_u-boot-qemu-arm64:buster = "2025.07"
+
 USE_CIP_KERNEL_CONFIG = "1"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
-- 
2.55.0


