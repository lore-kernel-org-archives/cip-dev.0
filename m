Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E52C2A062
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 01:03:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55123.1767574998808349108
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Jan 2026 17:03:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=V+xHCaUs;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1767574983;x=1768784583;bh=
	DNwD3I6UJAbFWlw5UcKnsyTuZh8+JOdi3c0IYHyz/os=;b=V+xHCaUsVp4krJcjqzuNHVPZnZmhKj
	jx6hnLbXR/hNwxIkHHvW7OUuoBHIceyyOEOVxnYwjFMyJBAlhqn0eWzFUDC7DIUa1gL8l2+QhalVM
	pMYQKsQmlho5f49uGoPUEDZo+IECnpgRQnJltUcf9Gq+IPL64YpR0W5XEiO0JcN/sweFbmOPsKpYe
	lZ9NVmRp/bk/GPldb6eO2m7WXedkKmBLjgpVRDgB9k1OQckcIkcpKENqoHUPCk7rGTd6rClpiHLLW
	h5gVeiPqmCOVH95rnaivcxTP1Wgg+Hw6v5i14NEl0MLsVmGEXzY72rWgUijmVG+rdmu9f4AZHtSkf
	Dl3w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 605132uG3326267; Mon, 5 Jan 2026 10:03:02 +0900
X-Iguazu-Qid: 2yAaYMbrivEC6pDlog
X-Iguazu-QSIG: v=2; s=0; t=1767574982; q=2yAaYMbrivEC6pDlog; m=dOJO2+5N5XGEdD8ZNxPBv6Jlw82V6U+W12JuSMDUF3A=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dkwyY2S8vz1xnZ; Mon,  5 Jan 2026 10:03:00 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@kernel.org, biju.das.jz@bp.renesas.co,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build error caused by is_gen4()
Date: Mon,  5 Jan 2026 10:02:46 +0900
X-TSB-HOP2: ON
Message-Id: <1767574966-5745-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 01:03:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21304

is_gen4() is undefined because it was modified by commit: f0b37f2cb224 
("can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info").
This replaces is_gen4() with 'gpriv->info->shared_can_regs'.

```
drivers/net/can/rcar/rcar_canfd.c: In function ‘rcar_canfd_reset_controller’:
drivers/net/can/rcar/rcar_canfd.c:874:14: error: implicit declaration of function ‘is_gen4’ [-Wimplicit-function-declaration]
  874 |         if (!is_gen4(gpriv)) {
      |              ^~~~~~~
drivers/net/can/rcar/rcar_canfd.c: At top level:
```

Fixes: f88ba5098e83 ("can: rcar_canfd: Fix CAN-FD mode as default")
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b58895084ea2a..99d0cbe863213 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -851,7 +851,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
 	/* Set the controller into appropriate mode */
-	if (!is_gen4(gpriv)) {
+	if (!gpriv->info->shared_can_regs) {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
 					   RCANFD_GRMCFG_RCMC);
@@ -880,7 +880,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 		}
 
 		/* Set the controller into appropriate mode */
-		if (is_gen4(gpriv)) {
+		if (gpriv->info->shared_can_regs) {
 			/* Do not set CLOE and FDOE simultaneously */
 			if (!gpriv->fdmode) {
 				rcar_canfd_clear_bit(gpriv->base,
-- 
2.51.0



