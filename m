Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051BCC52D7C
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 11:17:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.43905.1723461434863639953
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 04:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 47CBHB471087287; Mon, 12 Aug 2024 20:17:11 +0900
X-Iguazu-Qid: 2rWglMZvTWJadhhFmj
X-Iguazu-QSIG: v=2; s=0; t=1723461431; q=2rWglMZvTWJadhhFmj; m=c87zeWA6qdrAqZqMAlnI0SC49Xlu2hM0DsVVQHpkbdM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 47CBHAFl3239339
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 20:17:11 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/3] Updates to sync with latest debian-cve-checker
Date: Mon, 12 Aug 2024 16:46:02 +0530
X-TSB-HOP2: ON
Message-Id: <20240812111605.1246549-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Aug 2024 11:17:08.0737 (UTC) FILETIME=[2BAF0710:01DAECA9]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 11:17:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16778

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series of patches update the latest image reference for
debian-cve-checker after being moved under cip-project. Suite
information is included in the name of dpkg status files uploaded
for various targets.

sai ashrith sathujoda (3):
  scripts/run-cve-checks.sh: Extract suite from dpkg status file name
  scripts/deploy-cip-core.sh: Include release name in dpkg status
    filename
  .gitlab-ci.yml: Update debian-cve-checker image reference

 .gitlab-ci.yml             | 2 +-
 scripts/deploy-cip-core.sh | 6 ++++++
 scripts/run-cve-checks.sh  | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.30.2



