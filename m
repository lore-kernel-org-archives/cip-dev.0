Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E0DE81DE9
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 12:58:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.11989.1696597131854305425
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Oct 2023 05:58:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 396CwlPn3712819; Fri, 6 Oct 2023 21:58:49 +0900
X-Iguazu-Qid: 2rWh1lnDMJmYrH4rxI
X-Iguazu-QSIG: v=2; s=0; t=1696597127; q=2rWh1lnDMJmYrH4rxI; m=iooEwj/lqatTL0+gGJsl5Hr4jyu50nv6iNwFeqYUKP4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 396Cwjjc2918995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 6 Oct 2023 21:58:46 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/2] Enable SWU file in reproducible test
Date: Fri,  6 Oct 2023 18:28:43 +0530
X-TSB-HOP2: ON
Message-Id: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Oct 2023 12:58:44.0025 (UTC) FILETIME=[D649EA90:01D9F854]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Oct 2023 12:58:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13298

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

This patch series include swu file in reproducible tests, and also
disabled signed SWUpdate because it generates signatures which are by
nature contains randomnes in it and so skipped it for reproducible
tests.

venkata pyla (2):
  reproducible-check-ci: Include swu files in reproducible tests
  reproducible.yml: Disable signed swupdate in reproducible tests

 .reproducible-check-ci.yml | 1 +
 kas/opt/reproducible.yml   | 1 +
 scripts/repro-tests.sh     | 1 +
 3 files changed, 3 insertions(+)

-- 
2.20.1



