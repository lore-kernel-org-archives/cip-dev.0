Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16344.1795787659972838496
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Nov 2026 05:54:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=shivanand.kunijadar.v45@mail.toshiba header.s=key2.smx header.b=wwLYBAYx;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: shivanand.kunijadar.v45@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;i=
	shivanand.kunijadar.v45@mail.toshiba;s=key2.smx;t=1795787656;x=1796997256;bh=
	ns1c1Gy5Sh1VuoDoHYlx9pcdWdAbUIj/xaJGrlCeSsM=;b=wwLYBAYxZ35XyTmctWkR7LlynZnRsF
	Qbw01zQL/olLJH4CAMt2ztxbXZedKw4edN34wx+Mug0sAUZyaNuBdZzRYODeShs0QTZmNu9nMx2uo
	GR8Z6LxJhLhQ1mZjII7ShgNw0Ubyj14c+kVw/+yuqUaOrhT2G06nDvWrnMoxfU5+D4/vj4wJ3CvMD
	QOHw2xjr3ylrMBFu02nZTDVfD+LK4fUfpzZOIALGEdWWbhpC8cWRe0hNdyv4szEoalceLt2Ru7zr8
	GZh7NXTojJZNIEfWInmfUY6V+n9G1oRPyIWPMs2y/qOEmvQsK8GK3D+45NbA8/DihhwMc3ExoklpX
	+WpA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6ARDsGC71689159; Fri, 27 Nov 2026 22:54:16 +0900
X-Iguazu-Qid: 2rWhMeKcnoY8B8Z4We
X-Iguazu-QSIG: v=2; s=1; t=1795787656; q=2rWhMeKcnoY8B8Z4We; m=BI6WF93ciUu5p5irZFahBA+j9PMocvKcEB4ilhq6TGo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jbZf011F5z4vym; Fri, 27 Nov 2026 22:54:15 +0900 (JST)
From: shivanand.kunijadar.v45@mail.toshiba
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>,
        kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
Subject: [isar-cip-core][PATCH] factory-reset: Fix unconditional stop_watchdog() invocation
Date: Fri, 27 Nov 2026 19:09:41 +0530
X-TSB-HOP2: ON
Message-Id: <20261127133941.368623-1-shivanand.kunijadar.v45@mail.toshiba>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Nov 2026 13:54:14.0037 (UTC) FILETIME=[C95A6C50:01DD7E76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 27 Nov 2026 13:54:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25229
Content-Type: text/plain; charset="utf-8"

From: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>

Invoke stop_watchdog() only when start_watchdog() has been called previously.
Prevent unnecessary stop_watchdog() execution when the watchdog is inactive or
when a factory reset has not been triggered.

Signed-off-by: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>
---
 .../files/factory-reset-script.tmpl                             | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
index 3216dc9..e9c76d9 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
@@ -93,6 +93,6 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
         esac
         log_end_msg "Reset device: $target_device"
     done
+    stop_watchdog
     log_end_msg "Factory Reset"
 fi
-stop_watchdog
-- 
2.39.5


