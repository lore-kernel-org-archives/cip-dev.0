Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC32CC5DF87
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 00:02:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.590.1787270530772040919
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Aug 2026 17:02:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=B53CojwQ;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1787270517;x=1788480117;bh=sClJ0FUMgdILvVBI1k9waum/hJjd/yCUrrTTK9YqD2M=;b=B53
	CojwQLb9sAoLcYhmxz3/UBzf685dDqYaZK5ziPtZH8s8HsS9kRjHnB8ZPtbIw36Gvg9E16gOnvHtR
	OjL7NphCGy4GCCUr0Q+/HInj/KVshZSD0EpZ+xwt5+/pBtchU8JdXT2eePi00i/2Mej5505KHLU3G
	XN3Bx3qPeopdcw7sRHnEPaCJeQDKqrxU+iuDX6FOiWrtQ7fj7VfkYP1/2aTSyOiC3/QUVLBiS4J6b
	zXmsWfmsk7ZPBHVt14dgZQAycWs6kmu+o9wzVclGLvbEsomzhWALtS8JTv/g0qYc5ZNj4xx9T7+Tm
	HVyltPctW3SHd3GTMoooAFkPQNQ4n/A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 67L01uUN734966; Fri, 21 Aug 2026 09:01:56 +0900
X-Iguazu-Qid: 2rWhQ0zwwRehBSdJJr
X-Iguazu-QSIG: v=2; s=1; t=1787270516; q=2rWhQ0zwwRehBSdJJr; m=4RiQbYnSPsoPs3nMT3DGKya72wEusAmI8IwkIVRLUkQ=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hR0pp6GCfz1xnf; Fri, 21 Aug 2026 09:01:54 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, biju.das.jz@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip] serial: rsci: Fix symbol namespace of MODULE_IMPORT_NS()
Date: Fri, 21 Aug 2026 09:01:53 +0900
X-TSB-HOP2: ON
Message-Id: <1787270513-25812-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 00:02:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23955

In linux-6.1.y, the namespace specified in MODULE_IMPORT_NS() does not
require a string. This removes the quotes from the namespace name.

Fixes: f590c816c238 ("serial: sh-sci: Add support for RZ/G3E RSCI")
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/tty/serial/rsci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 74f931af6d2ad..4a73a8a476027 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -15,7 +15,7 @@
 #include "serial_mctrl_gpio.h"
 #include "rsci.h"
 
-MODULE_IMPORT_NS("SH_SCI");
+MODULE_IMPORT_NS(SH_SCI);
 
 /* RSCI registers */
 #define RDR	0x00
-- 
2.51.0



