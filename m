Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6748CA0EE8
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 10:31:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.19337.1755167472666581149
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Aug 2025 03:31:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 57EAVAdG3270136; Thu, 14 Aug 2025 19:31:10 +0900
X-Iguazu-Qid: 2rWhWAeBobjL8wbvn7
X-Iguazu-QSIG: v=2; s=0; t=1755167470; q=2rWhWAeBobjL8wbvn7; m=Jha729E6xTEoLHMILxiTWTTzdleLWiVd06j10OU7UsQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 57EAV9vL2622394
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 19:31:09 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v2 0/5] Add support for delta kernel binary update
Date: Thu, 14 Aug 2025 15:51:10 +0530
X-TSB-HOP2: ON
Message-Id: <20250814102117.2608463-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2025 10:31:07.0194 (UTC) FILETIME=[8B4741A0:01DC0D06]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 10:31:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19742

This patch series enables the delta kernel binary updates along with rootfs. 
When rdiff is selected by default it generates deltas for both kernel and rootfs.

In this v2 series, I just re-ordered the patches, no other changes.

Shivanand Kunijadar (5):
  swupdate-handler-roundrobin: Update revision for rdiff_file handler
    support
  delta-update.yml: Add previous image kernel file for rdiff delta
    update
  Add delta update support for kernel binary update using rdiff_file
    handler
  .gitlab-ci.yml: Add linux.efi to previous image folder
  README.swupdate.md: Modify readme for kernel binary delta update
    support.

 .gitlab-ci.yml                                |  1 +
 classes/delta-update.bbclass                  | 33 ++++++++++++++-----
 classes/swupdate.bbclass                      | 24 ++++++++++----
 doc/README.swupdate.md                        |  9 +++--
 kas/opt/delta-update.yml                      |  1 +
 recipes-core/images/swu/sw-description.tmpl   |  7 ++--
 .../swupdate-handler-roundrobin_0.1.bb        |  2 +-
 7 files changed, 55 insertions(+), 22 deletions(-)

-- 
2.39.5



