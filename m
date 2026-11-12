Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8271.1794466779276161344
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 22:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=cHrNk7t8;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794466776;x=1795676376;bh=58
	cVA+t9cFKf6OAlBy9iJBCso7kbEA5bvc3L34/AB6U=;b=cHrNk7t8zJCgu/xpEvZanx9AxnwJjlne
	HyJvpMad1j32qMxKpiqAZKBpmuf0gZHqdXV7nsrRdAm2nMiq8w/o9sivZ/sSA9qRDCk3aN2lwJXUQ
	OaYq3wEpaiH0oufiV3uEkxqpE+z8A1RvqWtKlAARcIfR7xhqB4Ah/0zXv/iV9sp5RZz4AyXi8jQoc
	x6K2riAdmD1OgwrbHBqNbFhuFonNCACAEfqJI8sahnHbFZk8cuVc1zy1jazBf2nNxtWJvqCsjy6OT
	0I+lF0OPB1psYJ7tjwRkTiakm3Jej+e5QoAioKZ7WzLM4xYqRR6p35Bjx903ACyfpTbxsGLUFZahn
	NQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6AC6xZ9q3695774; Thu, 12 Nov 2026 15:59:36 +0900
X-Iguazu-Qid: 2yAbufPsidQ7xzLCcQ
X-Iguazu-QSIG: v=2; s=1; t=1794466775; q=2yAbufPsidQ7xzLCcQ; m=GwUWBnOGmGwy53FJpOL2EOKEa8zuKvKg3z/QnJNBxaQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jQB8R2ybCzyPQ; Thu, 12 Nov 2026 15:59:35 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isa-cip-core][PATCH v3 3/8] dosfstools: Set debian suite to which the patch is to be applied
Date: Thu, 12 Nov 2026 15:59:13 +0900
X-TSB-HOP2: ON
Message-Id: <1794466758-28304-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 06:59:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24775
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch can be applied only to
bullseye and bookworm. Therefore, this specifies 'bookworm' and 'bullseye'
as the suites to which the patch is to be applied.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v3:
  new patch.

 recipes-devtools/dosfstools/dosfstools_latest.bb | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-devtools/dosfstools/dosfstools_latest.bb
index d0ac128..1c94301 100644
--- a/recipes-devtools/dosfstools/dosfstools_latest.bb
+++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
@@ -16,12 +16,15 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
 CHANGELOG_V="<orig-version>+cip"
 
 SRC_URI = "apt://${BPN}"
-SRC_URI += "file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"
+SRC_URI:append:bullseye = " file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"
+SRC_URI:append:bookworm = " file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"
 
 do_prepare_build() {
 	deb_add_changelog
 
 	cd ${S}
-	quilt import ${WORKDIR}/*.patch
-	quilt push -a
+	if [ -f ${WORKDIR}/*.patch ]; then
+		quilt import ${WORKDIR}/*.patch
+		quilt push -a
+	fi
 }
-- 
2.55.0


