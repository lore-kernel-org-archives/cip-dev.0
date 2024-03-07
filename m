Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557ABC54E58
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 07:45:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.18219.1709797556747996047
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 23:45:57 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4277jsgB691735; Thu, 7 Mar 2024 16:45:54 +0900
X-Iguazu-Qid: 2rWgdkpBNJHdBEFK5t
X-Iguazu-QSIG: v=2; s=0; t=1709797553; q=2rWgdkpBNJHdBEFK5t; m=2CU9x66r/4Azk5W21u9rxG2gxcMHSUToL8ARA4rWlho=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 4277jqUN1216140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Mar 2024 16:45:53 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v1 0/6] Integrate Delta Update with rdiff_image and delta handler
Date: Thu,  7 Mar 2024 13:16:06 +0530
X-TSB-HOP2: ON
Message-Id: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Mar 2024 07:45:48.0384 (UTC) FILETIME=[78563600:01DA7063]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 07:45:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15255

These series of patches enable the support for delta update for the root file system 
with swupdate's rdiff_image and delta handler(zchunk). For now, I send this as an RFC, 
as this needs to be reviewed by a broader audience.
 
A couple notes about the implementation:
- In this patchset, Delta update is only supported for the root file system.
- The newly added delta-update.bbclass handles the creation of the delta update artifacts.
- The update handler type i.e rdiff_image or delta handler is set in the variable "DELTA_UPDATE_TYPE" 
in the newly added delta-udpate.yml file along some variables required for each handler.
- The creation of delta artifact for the rdiff_image handler requires a reference image 
(against which the delta is computed). Currently the reference image (.wic) file is passed to the 
build system by path to the file from the project's root directory in the variable DELTA_RDIFF_REF_IMAGE 
in the delta-udpate.yml file.

Adithya Balakumar (6):
  conf: Use bookworm backports for enabling delta handler in swupdate
  swupdate-handler-roundrobin: Increase revision for Delta Handler
    support
  swupdate: Enable Delta handler in swupdate
  Add Delta update support with rdiff_image and delta handler
  swupdate.bbclass: Generate swu for delta updates
  doc/README.swupdate.md: Update steps to test Delta software Update

 classes/delta_update.bbclass                  | 90 ++++++++++++++++++
 classes/swupdate.bbclass                      | 35 ++++++-
 conf/distro/cip-core-bookworm.conf            |  3 +
 conf/distro/debian-bookworm-backports.list    |  1 +
 ...eferences.swupdate-bookworm-backports.conf | 12 +++
 doc/README.swupdate.md                        | 95 +++++++++++++++++++
 kas/opt/delta-update.yml                      | 21 ++++
 .../swupdate-handler-roundrobin_0.1.bb        |  2 +-
 recipes-core/swupdate/swupdate_2023.05.bb     |  3 +
 9 files changed, 259 insertions(+), 3 deletions(-)
 create mode 100644 classes/delta_update.bbclass
 create mode 100644 conf/distro/debian-bookworm-backports.list
 create mode 100644 conf/distro/preferences.swupdate-bookworm-backports.conf
 create mode 100644 kas/opt/delta-update.yml

-- 
2.39.2



