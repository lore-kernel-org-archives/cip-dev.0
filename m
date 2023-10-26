Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8D0C25B6F
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 08:30:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.65830.1698309003915198733
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Oct 2023 01:30:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 39Q8U2i92133143; Thu, 26 Oct 2023 17:30:02 +0900
X-Iguazu-Qid: 2rWgVgutxemCLenG5r
X-Iguazu-QSIG: v=2; s=0; t=1698309001; q=2rWgVgutxemCLenG5r; m=owLiNnwGtw//+XZQStVHyVs7ZX1ZYCIqs+F+6F5iVoo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 39Q8U0lN3458883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Oct 2023 17:30:01 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/3] Enable swu file in repro tests
Date: Thu, 26 Oct 2023 13:59:56 +0530
X-TSB-HOP2: ON
Message-Id: <20231026082959.16939-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
References: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Oct 2023 08:29:57.0795 (UTC) FILETIME=[9A917F30:01DA07E6]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 08:30:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13457

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

The following path series enables SWU file in repro tests and fixes
repro problems in swu file.

repro problems in swu file:
 - signatures in swu file is not reproducible #80
 - linux.efi file in swu file is not reproducible due to file timestamps
   are not matching.

venkata pyla (3):
  reproducible-check-ci: Include swu files in reproducible tests
  swupdate.bbclass: make signed swupdate file reproducible
  swupdate.bbclass: Use root privileges when creating swu file

 .reproducible-check-ci.yml | 1 +
 classes/swupdate.bbclass   | 4 ++--
 scripts/repro-tests.sh     | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.20.1



