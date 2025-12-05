Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF74D2F7FE
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:15:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6505.1764944143097773645
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:15:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5B5EFe373238448; Fri, 5 Dec 2025 23:15:41 +0900
X-Iguazu-Qid: 2yAaGFzRaE4QRF3EJs
X-Iguazu-QSIG: v=2; s=0; t=1764944140; q=2yAaGFzRaE4QRF3EJs; m=MyUWSv1CJEwCNZwfAe19PplAVpcNSQdwTMvQbsDgwFw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dND1S0hDbz1xnc; Fri,  5 Dec 2025 23:15:39 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1 0/3] Fix Reproducible build tests in the CI
Date: Fri,  5 Dec 2025 09:29:24 -0500
X-TSB-HOP2: ON
Message-Id: <20251205142927.4087770-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Dec 2025 14:15:37.0845 (UTC) FILETIME=[A1173A50:01DC65F1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:15:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20911

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Recent updates to the CI for moving to trixie based build and tests led 
to the reproducible build test in the CI to break. This patchset fixes 
the issues in the reproducible build tests in the CI and while at it 
also fixes a bug in the reproducible build test script that came to 
light because of the issues.

Now, I did do a test run[1] with these patches and found the reproducible build 
test still fails but the failure is due to a reproducibility issue 
(best discussed in a separate thread) and not a CI issue.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2195307991  

Adithya Balakumar (3):
  .reproducible-check-ci.yml: Align with recent changes in
    deploy-cip-core.sh
  scripts/deploy-cip-core.sh: Check for the existence of the broken swu
    file before uploading
  scripts/repro-tests.sh: Remove return value from run_diffoscope
    function

 .reproducible-check-ci.yml | 2 +-
 scripts/deploy-cip-core.sh | 4 +++-
 scripts/repro-tests.sh     | 9 ++-------
 3 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.39.5



