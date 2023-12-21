Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845ACC4706C
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 12:04:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.49477.1703160269976147589
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Dec 2023 04:04:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3BLC4RWO041497; Thu, 21 Dec 2023 21:04:27 +0900
X-Iguazu-Qid: 2rWgDz21tdUjDMORQ9
X-Iguazu-QSIG: v=2; s=0; t=1703160266; q=2rWgDz21tdUjDMORQ9; m=sHBmg+NhXfP8ds96jzO1PONj+7O9OhOviDwU9nR5Joc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 3BLC4PpC3638862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Dec 2023 21:04:26 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/3] Generate CVE-reports during a tag release
Date: Thu, 21 Dec 2023 17:34:20 +0530
X-TSB-HOP2: ON
Message-Id: <20231221120423.2388639-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Dec 2023 12:04:23.0895 (UTC) FILETIME=[D67E8E70:01DA3405]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 12:04:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14185

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

This series of patches enables generation of CVE-reports from a latest copy of
dpkg-status files stored in CIP project's s3 bucket whenever a tag is released.
This is to follow IEC 62443-4-1 SM-11 requirement where security related issues
are addressed along with their severity prior a release.

debian-cve-checker repository [1] is used to generate the CVE-reports from the
dpkg-status of repsective targets.

Sai Sathujoda (3):
  scripts/run-cve-checks.sh: Add script to generate CVE report
  scripts/deploy-cip-core.sh: Upload dpkg-status files to aws s3 bucket
  .gitlab-ci.yml: Add cve-checks job which runs when a tag is pushed

 .gitlab-ci.yml             |  7 +++++++
 scripts/deploy-cip-core.sh | 12 ++++++++++++
 scripts/run-cve-checks.sh  | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100755 scripts/run-cve-checks.sh

-- 
2.30.2



