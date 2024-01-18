Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83937C47DD3
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 17:59:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.20566.1705600787551115635
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 09:59:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 40IHxitP3236305; Fri, 19 Jan 2024 02:59:45 +0900
X-Iguazu-Qid: 2rWgwVXgOelVJ0GEpE
X-Iguazu-QSIG: v=2; s=0; t=1705600784; q=2rWgwVXgOelVJ0GEpE; m=iSyc/iocHRgqdkdonHAJsYS+MT9hjHBMRRJACEnMtr0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 40IHxhnZ850958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jan 2024 02:59:44 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/3] Generate CVE-reports only with manual trigger
Date: Thu, 18 Jan 2024 23:29:39 +0530
X-TSB-HOP2: ON
Message-Id: <20240118175942.1052089-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Jan 2024 17:59:41.0773 (UTC) FILETIME=[1C8197D0:01DA4A38]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 17:59:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14402

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

This series of patches enables generation of CVE-reports from a latest copy of
dpkg-status files stored in CIP project's s3 bucket only when they are manually
started in the pipeline.

The cve-checker.py script in debian-cve-checker repository [1] is used to generate
the CVE-reports from the dpkg-status of repsective targets.

[1] https://gitlab.com/cip-playground/debian-cve-checker

Sai Sathujoda (3):
  scripts/run-cve-checks.sh: Add script to generate CVE report
  scripts/deploy-cip-core.sh: Upload dpkg-status files to aws s3 bucket
  .gitlab-ci.yml: Run cve-checks job only when it is manually triggered
    in the pipeline

 .gitlab-ci.yml             | 14 +++++++++++++
 scripts/deploy-cip-core.sh | 12 ++++++++++++
 scripts/run-cve-checks.sh  | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100755 scripts/run-cve-checks.sh

-- 
2.30.2



