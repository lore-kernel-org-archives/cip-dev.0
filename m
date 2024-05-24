Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE0EC25B75
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 00:24:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.5436.1716510292726496622
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 17:24:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=TsaDdAwg;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1716510290;x=1717719890;bh=Ob2VdFCIOzionbUoyaOr5x8IUU4IcGR+0mtuCnBCDrU=;b=Tsa
	DdAwg0Kz0QDo72jGhq0Zi3Gjsu+hhbLLIA+gPIWI8wBb/h4zFf3kMqFLNu0DT3JxEp5okqFqtyCJ5
	a9swh/ff8KxV5qAOvXDV9D+wMWiCt5p9XiuWS+gSsyfY1T+lx6vBUPsqkJ/n878E0V04ZPnJOQv/4
	RBPZMRAO7+3fb7mrJN4r5o7BfjqMr2d4xMQ2JAVI2JzICR5b40qYglDXM5uygcI+gmSLnZeUhyBXq
	QYFSROQ07g1zAMuZbsylm0CpWRlfTnr5dffTgFzbi0BrR6oXmmBRRntmzo3x3P98QPvOXRUeUUC0J
	hogE4Z5jQsyqyfLeJW+IxUljkR/82sw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 44O0Ooi23758536; Fri, 24 May 2024 09:24:50 +0900
X-Iguazu-Qid: 2yAbLYkr60BZYzNtT6
X-Iguazu-QSIG: v=2; s=0; t=1716510290; q=2yAbLYkr60BZYzNtT6; m=UOlCaxO+KgEFX+/CPv8OVyqlYSYJOyuM0bRa0372iGw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 44O0OnQe113554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 May 2024 09:24:49 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: biju.das.jz@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for linux-6.1.y-cip] usb: xhci-plat: Don't include xhci.h
Date: Fri, 24 May 2024 09:24:48 +0900
X-TSB-HOP2: ON
Message-Id: <1716510288-3420-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 00:24:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15939

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 4a237d55446ff67655dc3eed2d4a41997536fc4c upstream.

The xhci_plat.h should not need to include the entire xhci.h header.
This can cause redefinition in dwc3 if it selectively includes some xHCI
definitions. This is a prerequisite change for a fix to disable suspend
during initialization for dwc3.

Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/310acfa01c957a10d9feaca3f7206269866ba2eb.1713394973.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[iwamatsu: The original commnit of this has been applied to linux-6.1.y tree as
           bf3b0ab6fbae ("usb: xhci-plat: Don't include xhci.h") without
	   xhci-rzv2m.c. Therefore, this applied fixes for xhci-rzv2m.c only.]
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/usb/host/xhci-rzv2m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-rzv2m.c b/drivers/usb/host/xhci-rzv2m.c
index ec65b24eafa8..4f59867d7117 100644
--- a/drivers/usb/host/xhci-rzv2m.c
+++ b/drivers/usb/host/xhci-rzv2m.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/usb/rzv2m_usb3drd.h>
+#include "xhci.h"
 #include "xhci-plat.h"
 #include "xhci-rzv2m.h"
 
-- 
2.43.0



