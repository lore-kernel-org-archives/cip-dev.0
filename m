Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC60CA0EE0
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 13:56:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.101993.1755093384011012761
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 06:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 57DDuLu41465608; Wed, 13 Aug 2025 22:56:21 +0900
X-Iguazu-Qid: 2rWhyCKR9nA680sACW
X-Iguazu-QSIG: v=2; s=0; t=1755093380; q=2rWhyCKR9nA680sACW; m=0SvGEuGvgjXmX62ug+6OxSq9rw0Tc7/YsxQb8FVX5lY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 57DDuJxd3183657
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 22:56:20 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 0/5] Add support for delta kernel binary update
Date: Wed, 13 Aug 2025 19:16:25 +0530
X-TSB-HOP2: ON
Message-Id: <20250813134630.3943194-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Aug 2025 13:56:17.0629 (UTC) FILETIME=[0A74D0D0:01DC0C5A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 13:56:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19728

This patch series enables the delta kernel binary updates along with
rootfs. When rdiff is selected it generates deltas for both kernel and rootfs.

In the CI, we just change PV value to 2.0 for the second image and there
is no change (code) in the kernel binary at the moment. Do you think building
the second image with RT kernel is appropriate here to verify delta
kernel updates? 

Shivanand Kunijadar (5):
  delta-update.yml: Add previous image kernel file for rdiff delta
    update
  Add delta update support for kernel binary update using rdiff_file
    handler
  README.swupdate.md: Modify readme for kernel binary delta update
    support.
  swupdate-handler-roundrobin: Update revision for rdiff_file handler
    support
  .gitlab-ci.yml: Add linux.efi to previous image folder

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



