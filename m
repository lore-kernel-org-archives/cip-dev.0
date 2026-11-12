Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8273.1794466781899593228
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 22:59:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=VFpAnIaG;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794466777;x=1795676377;bh=q9
	8AQT6fvMS00mhNcyV0gEomvzB3oTySDuJ/NRPfQFc=;b=VFpAnIaGg4yMFZk0TpTDnQ49EhX8Xkfx
	+7EdBS07I2I9KIukRPI1KAJOWdrrpiteo85HXQp9HMEuIW4Dk03ydBO6G96ITytMRvpz8vNnEtLmb
	rn0yWMIbvX0dB1OWlkDRs02z+LKxpb/D9p8TPxtpD7oEKDy+MKEYVcLP3kzDXW38QZo33Gkz+Acqz
	fwlR+i3VVfO1KPWHFJ6AHDmvSK2TDxglnbwwsBlAjqylQEHMtfRmh6AlXbLf3VwnNxZDwnwANXw7k
	k00vb1OPCx4231xNnVjRdU9ia6umHOShgoFSWRE3bGVa2Op6uEQOP6OIBA/wnH3tSP+DtiYm97QjU
	Tw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6AC6xaNQ1831264; Thu, 12 Nov 2026 15:59:37 +0900
X-Iguazu-Qid: 2rWhZY3xPka1kkZgw7
X-Iguazu-QSIG: v=2; s=1; t=1794466776; q=2rWhZY3xPka1kkZgw7; m=NW76BprQTP2uiM5ZkReIDA/MCJgR/kb7lGY166ab1CU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jQB8S48Xvz1xnj; Thu, 12 Nov 2026 15:59:36 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isa-cip-core][PATCH v3 7/8] conf: qemu-arm: Set U-Boot version for 'buster' to 2025.07
Date: Thu, 12 Nov 2026 15:59:17 +0900
X-TSB-HOP2: ON
Message-Id: <1794466758-28304-8-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 06:59:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24779
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v3:
  new patch.

 conf/machine/qemu-arm.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index e0fe960..b28b2cf 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -12,6 +12,8 @@ DISTRO_ARCH = "armhf"
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 
+PREFERRED_VERSION_u-boot-qemu-arm:buster = "2025.07"
+
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
 INITRAMFS_WATCHDOG_DEVICE = ""
-- 
2.55.0


