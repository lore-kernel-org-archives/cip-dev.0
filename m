Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EBFC61D96
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 07:01:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.14079.1700636486944027751
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Nov 2023 23:01:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3AM71OQF2306410; Wed, 22 Nov 2023 16:01:25 +0900
X-Iguazu-Qid: 2yAaLcf4ODe100lflo
X-Iguazu-QSIG: v=2; s=0; t=1700636484; q=2yAaLcf4ODe100lflo; m=S1C1j9w6W58VagO4xomXuTMIh1xvDMYWQtpbZGkeyh4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 3AM71N64888853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Nov 2023 16:01:23 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 0/3] Enable CVE check in isar-cip-core CI
Date: Wed, 22 Nov 2023 12:31:18 +0530
X-TSB-HOP2: ON
Message-Id: <20231122070121.326276-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Nov 2023 07:01:21.0232 (UTC) FILETIME=[B2CD9D00:01DA1D11]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 07:01:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13608

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

This series of patches enables CVE check in isar-cip-core CI by extracting
the latest dpkg-status files of deployed targets in aws s3 bucket. A weekly
scheduled pipeline runs a cve-checks job which generates CVE reports of respective
targets by using the cve_checker.py script in debian-cve-checker repository [1].

[1] https://gitlab.com/cip-playground/debian-cve-checker

Sai Sathujoda (3):
  .gitlab-ci.yml: Add cve-check stage in CI
  scripts/deploy-cip-core.sh: Upload dpkg-status file to aws s3 bucket
  scripts/run-cve-checks.sh: Add script to generate CVE report

 .gitlab-ci.yml             | 12 +++++++++++-
 scripts/deploy-cip-core.sh | 15 ++++++++++++++
 scripts/run-cve-checks.sh  | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100755 scripts/run-cve-checks.sh

-- 
2.30.2



