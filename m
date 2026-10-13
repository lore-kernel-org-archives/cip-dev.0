Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666B0CC6B15
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.585.1791930932307549883
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2026 15:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=PyBwln6T;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1791930923;x=1793140523;bh=sAAbiQj28tJ8iPPMZMwlc+ay0cBorP0ycKulTWqIf64=;b=PyB
	wln6TqHwfNQSugovYaz9n8lt/8eZs4GudN2VAFKsull38sA3oGQD9j3HrgA5/Za1o7c0O3te+vIxU
	7IdFXYpy6DmPqNBQFKfGotYDQUArUAvoW+ekq1bFP+hLMHxaZgEHcQTSzeDpZdpTxiyxCfvABa/eU
	phs8LbSPqs34hncEonU72KFDQiEHOOzs1UKTn09T36DjAwrruAyO6RCNmE80oqSQsBawrwAtm+T52
	Gauemq5JhDros9h89KtDgVydLny/P0oxRMEBqKCs4JOFKzEqho+eZc2ex5K6Dq1dWhfs5kfOsDCMW
	sUbOCS/rhK6ezToeW9858BBlwh3fVKw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69DMZMAF3813858; Wed, 14 Oct 2026 07:35:22 +0900
X-Iguazu-Qid: 2yAasLCAogyNPhTGYT
X-Iguazu-QSIG: v=2; s=1; t=1791930922; q=2yAasLCAogyNPhTGYT; m=pvfEnGNRTa00NAUgTDyFAMnmBahXAL6WxjAUg4hPmOg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j48L14gxrzyPZ; Wed, 14 Oct 2026 07:35:21 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, john.madieu.xa@bp.renesas.com,
        biju.das.jz@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 1/3] irqchip/renesas-rzv2h: Remove duplicate field_get()
Date: Wed, 14 Oct 2026 07:35:17 +0900
X-TSB-HOP2: ON
Message-Id: <1791930919-10628-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 22:35:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24450

The LTS commit 94cad2c26306 ("bitfield: Add non-constant field_{prep,get}()
helpers") causes a duplicate definition of field_get().
This removes field_get() from irq-renesas-rzv2h.c, where the modification
was made.

```
  HDRTEST usr/include/asm/resource.h
drivers/irqchip/irq-renesas-rzv2h.c:115:9: error: ‘field_get’ redefined [-Werror]
  115 | #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
      |         ^~~~~~~~~
In file included from drivers/irqchip/irq-renesas-rzv2h.c:12:
./include/linux/bitfield.h:297:9: note: this is the location of the previous definition
  297 | #define field_get(mask, reg)                                            \
      |         ^~~~~~~~~
```

Fixes: e4b95469c6a1 ("irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume")
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 0e0c3b3e85bd28..b7a41479950593 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -112,8 +112,6 @@
 #define ICU_NUM_BE				4
 #define ICU_NUM_A55ERR				4
 
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 /**
  * struct rzv2h_irqc_reg_cache - registers cache (necessary for suspend/resume)
  * @nitsr: ICU_NITSR register
-- 
2.55.0



