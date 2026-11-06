Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2276.1793956082747091672
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2026 01:08:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=fVZP3c2J;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1793956079;x=1795165679;bh=po
	xlm13OEWuJFMKS/Bs0xxgyVyKh291ognZi/GF+jjU=;b=fVZP3c2JwfwghZapMKk0JDXygeYAp9no
	CaTr9f/FBUuwItqb2wKIizTO/qwFSvCpa1Tf51AbOG2t88NvwuICfmoQh/HC6/mM2G8UrLaZUShf/
	E/9B7Hx4QR/nSwKzZkEkFw6lFd9ht/VeQKy3Hpdm/VcU9flq2wmPN6m2YY4UBqEqMrQwTzMbCUIsR
	KCNhsQWv3a8he6PCAqoOQqoQNXyZYHr+RJ0zhVgFAuYyIvvolt0D8rzNHnkD7HGXT8OZpphN7jxM1
	/ik3CnmFKSgxbrdKCVNIRJcZWWGTIQyt3AdhJy+gc+yA0a2/qN4bk86F1WPHGIMcfTm4GlelL/gnB
	yQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6A697xBG2624313; Fri, 6 Nov 2026 18:07:59 +0900
X-Iguazu-Qid: 2rWgGCa8x9DvAFAboo
X-Iguazu-QSIG: v=2; s=1; t=1793956079; q=2rWgGCa8x9DvAFAboo; m=8aaoXxYVO5FYZwb5PFDt2eLFPUeikIKhDZJGV9TaQXE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jLYHM0rMjz4vyy; Fri,  6 Nov 2026 18:07:58 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][RFC PATCH 4/4] conf: bbb: Set U-Boot version for 'buster' to 2025.07
Date: Fri,  6 Nov 2026 18:07:45 +0900
X-TSB-HOP2: ON
Message-Id: <1793956065-3316-5-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 09:08:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24660
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
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


