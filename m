Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE2C47DDB
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 05:01:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.8952.1706763661534816971
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 21:01:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 41150qkt4162787; Thu, 1 Feb 2024 14:00:53 +0900
X-Iguazu-Qid: 2yAbTaOOqAOtvYkHMV
X-Iguazu-QSIG: v=2; s=0; t=1706763652; q=2yAbTaOOqAOtvYkHMV; m=nBMCrCtZMBO9ujKPhlWJoZO/+hFBK3W/zmLTTZq7g3Q=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 41150p2n4111235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Feb 2024 14:00:51 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        pavel@denx.de
Cc: biju.das.jz@bp.renesas.com, yuki.saito@toshiba.co.jp
Subject: [PATCH v2 0/1] clk: Fix for restructuring for no reparent case
Date: Thu,  1 Feb 2024 14:00:22 +0900
X-TSB-HOP2: ON
Message-Id: <20240201050023.1490448-1-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 05:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14574

With v6.1.72-cip13 + Zynq UltraScale+ MPSoC ZCU102, we observed that
Ethernet does not work when it's speed is 100Mbps.
This issue happens after d94c14f6fa34f2b8b33e5957f5b8dfb5aaf56b1e is
backported to the clk framework, which is not a part of linux-6.1.y
and probably is one of the dependencies of versa3 clk generator support
for Renesas SoCs. See the patch series "Add versa3 clk generator support".

In mainline, a fix for the backport commit above is provided:
be8fa5fd0a48fd2decc4de81ffe72bb3ceacecd9.
This should be applied to linux-6.1.y-cip as well.
With v6.1.72-cip13 + this patch, we confirmed the ZCU102 Ethernet
works at 100Mbps.

v1->v2:
* Fix wrong commit time. No change in the patch / comments.

Marek Szyprowski (1):
  clk: Fix best_parent_rate after moving code into a separate function

 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.30.2



