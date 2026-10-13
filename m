Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B29CC6B1D
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.584.1791930932307467749
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2026 15:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=L4emJpp4;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1791930922;x=1793140522;bh=LO
	yxdyH0BtavBJ3fSI3DK3wrDbg686Ie3yct9DSaC+U=;b=L4emJpp4hiEkCIX92SmOP55my33SaBf3
	GzbM/7Q3TdDz6gMf0iOhg7CYp/r7/v9ggBVn9tALtNMxBfWPXVv+WlHmR+jSnFkWfbo3npaCSEb7U
	TyXQAG8i7tH/UokaWUjzYXOxwOLrm8PWQus07zCMP3dywf4VrPwPkIKIS4gcoT9Zk/iqLgX9qI52q
	0a6ebebiNWERAI671PEkZYFbrE0HxbdyVxAzuuXxD6Sk8j4X2icN8neGZS7FuX8xhheOyBDrX+lMp
	40xxcU8jGBba43uO6jgpUlmdRSMQBDZE9PB1VR3dmocWaHu9DimElROL1dkJEJgHVDQAyLlyR8Zil
	Nw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69DMZMht3813857; Wed, 14 Oct 2026 07:35:22 +0900
X-Iguazu-Qid: 2yAasLCAogyNPhTGYS
X-Iguazu-QSIG: v=2; s=1; t=1791930922; q=2yAasLCAogyNPhTGYS; m=U04nssht+Zu/PznFdJZpZp8U7s70GPoRRPwfHtLXoOU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j48L200dxzyPg; Wed, 14 Oct 2026 07:35:21 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, john.madieu.xa@bp.renesas.com,
        biju.das.jz@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 3/3] soc: renesas: rz-sysc: Convert to common field_get() helper
Date: Wed, 14 Oct 2026 07:35:19 +0900
X-TSB-HOP2: ON
Message-Id: <1791930919-10628-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 22:35:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24453

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 610c4408a2f7a09a00f656459e762ee1e21bbd7b upstream.

Drop the driver-specific field_get() macro, in favor of the globally
available variant from <linux/bitfield.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
[iwamatsu: Drop '#undef field_get']
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/soc/renesas/rz-sysc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index 19c1e666279b75..ae727d9c8cc523 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
@@ -16,8 +17,6 @@
 
 #include "rz-sysc.h"
 
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 /**
  * struct rz_sysc - RZ SYSC private data structure
  * @base: SYSC base address
-- 
2.55.0



