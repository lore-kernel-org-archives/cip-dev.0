Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F54C44515
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 01:51:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13480.1784598696944762213
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 18:51:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=JCppgd26;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1784598694;x=1785808294;bh=
	hcKkrG5DBJ08ZpR+YRILg6riZBNq6V8XePwPk2yKudg=;b=JCppgd26GNKV6VLsCUTF6cOPRjmstC
	iOh4BrvFlQuRFSEc0/KTHisIB+wx4Ex8lqPAZ8k047qPaVbCTUYB8DIkzeWFyyyg6rECZNQnCvy4i
	TFqLu3DN8/1fs3rLz5FJTYUAR2l/R2yQs/rziahYcKcDsUqyRamOffW5OmRhYzYnilKPRWhGRyuRw
	qQNMeelZbUVbIzm98ZsP2hmKi0Du1ArYNUK8eMC7hwxDCl1VSUQ8ZIHTqBq74R5QXhQWrE6pJjtgP
	xG78NfpYkmngdZUcaV6tsAcmfCygCBDZHpFjvbNcS8T1zqkdJyK2wFtVbi4o6ZUbw4u3GY5PEJdIq
	CPbQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 66L1pYAY667601; Tue, 21 Jul 2026 10:51:34 +0900
X-Iguazu-Qid: 2yAb9zXy0SD2o7mYiW
X-Iguazu-QSIG: v=2; s=1; t=1784598694; q=2yAb9zXy0SD2o7mYiW; m=qXZK0KmdXR6xgJTNikL2YQhgGOQ7iS2YJT4QlWYLcmU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h40jd4c50zyQJ; Tue, 21 Jul 2026 10:51:33 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, tommaso.merciai.xr@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH v2 6.1.y-cip] i3c: master: dw: stop hardcoding initial speed
Date: Tue, 21 Jul 2026 10:51:32 +0900
X-TSB-HOP2: ON
Message-Id: <1784598692-26475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 01:51:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23690

From: Jack Chen <zenghuchen@google.com>

commit 510d2358c466bf6588034f0d3b2266eed2bc0a51 upstream.

Bus-speed could be default(12.5MHz) or defined by users in dts.
Dw-i3c-master should not hard-code the initial speed to be
I3C_BUS_TYP_I3C_SCL_RATE (12.5MHz)
And because of Synopsys's I3C controller limit (hcnt/lcnt register
length) and core-clk provided, there is a limit to bus speed, too.
For example, when core-clk is 250 MHz, the bus speed cannot be
lowered below 1MHz.

Tested: tested with an i3c sensor and captured with a logic analyzer.

Signed-off-by: Jack Chen <zenghuchen@google.com>
Link: https://lore.kernel.org/r/20230216151057.293764-1-zenghuchen@google.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

This fixes a build error in “drivers/i3c/master/dw-i3c-master.c” caused
by a Renesas backport patch.

```
  CC      drivers/i3c/master/dw-i3c-master.o
In file included from ./include/vdso/const.h:5,
                 from ./include/linux/const.h:4,
                 from ./include/linux/bits.h:5,
                 from ./include/linux/bitops.h:6,
                 from drivers/i3c/master/dw-i3c-master.c:8:
drivers/i3c/master/dw-i3c-master.c: In function ‘dw_i3c_clk_cfg’:
drivers/i3c/master/dw-i3c-master.c:534:40: error: ‘I3C_BUS_TYP_I3C_SCL_RATE’ undeclared (first use in this function); did you mean ‘I3C_BUS_SDR3_SCL_RATE’?
  534 |         lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~
./include/uapi/linux/const.h:34:46: note: in definition of macro ‘__KERNEL_DIV_ROUND_UP’
   34 | #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
      |                                              ^
drivers/i3c/master/dw-i3c-master.c:534:16: note: in expansion of macro ‘DIV_ROUND_UP’
  534 |         lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
      |                ^~~~~~~~~~~~
drivers/i3c/master/dw-i3c-master.c:534:40: note: each undeclared identifier is reported only once for each function it appears in
  534 |         lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~
./include/uapi/linux/const.h:34:46: note: in definition of macro ‘__KERNEL_DIV_ROUND_UP’
   34 | #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
      |                                              ^
drivers/i3c/master/dw-i3c-master.c:534:16: note: in expansion of macro ‘DIV_ROUND_UP’
  534 |         lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
      |                ^~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:250: drivers/i3c/master/dw-i3c-master.o] Error 1
make[3]: *** [scripts/Makefile.build:503: drivers/i3c/master] Error 2
make[2]: *** [scripts/Makefile.build:503: drivers/i3c] Error 2
make[1]: *** [scripts/Makefile.build:503: drivers] Error 2
make: *** [Makefile:2025: .] Error 2
```

 drivers/i3c/master/dw-i3c-master.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index d6585d0a20c50..8af2229df82ae 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -531,7 +531,7 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
 		hcnt = SCL_I3C_TIMING_CNT_MIN;
 
-	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
+	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
 	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
 		lcnt = SCL_I3C_TIMING_CNT_MIN;
 
@@ -541,7 +541,8 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_I2C_SLAVE_PRESENT))
 		writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
 
-	lcnt = DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period);
+	lcnt = max_t(u8,
+		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
 
-- 
2.53.0



