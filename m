Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A899C10F15
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 09:44:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.12860.1714038257349844791
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 02:44:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 43P9iFOT3641123; Thu, 25 Apr 2024 18:44:15 +0900
X-Iguazu-Qid: 2yAblVO8DqQAt9AAzv
X-Iguazu-QSIG: v=2; s=0; t=1714038254; q=2yAblVO8DqQAt9AAzv; m=QLf4qMeaXEXPaAN4XIk2V4SwTiAm8a7VdxX9cD3QgJo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 43P9iDQX1436208
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:44:14 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v4 0/3] Integrate Delta Update with rdiff_image and delta handler
Date: Thu, 25 Apr 2024 15:14:41 +0530
X-TSB-HOP2: ON
Message-Id: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 25 Apr 2024 09:44:12.0189 (UTC) FILETIME=[20C694D0:01DA96F5]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 09:44:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15747

These series of patches enable the support for delta update for the root file system with swupdate's 
rdiff_image and delta handler(zchunk).

A couple notes about the implementation:
- In this patchset, Delta update is only supported for the root file system.
- The newly added delta-update.bbclass handles the creation of the delta update artifacts.
- The update handler type i.e rdiff_image or delta handler is set in the variable "DELTA_UPDATE_TYPE"
in the swupdate.yml file along with some variables required for each handler.
- The creation of delta artifact for the rdiff_image handler requires a reference image (against which 
the delta is computed). Currently the reference artifact file (.squashfs/.verity) is passed to the 
build system by placing the artifact in the path "${TOPDIR}/previous-image" and setting the name of the
artifact in the variable DELTA_RDIFF_REF_IMAGE in the swupdate.yml file.
- zchunk based delta update is only supported for sid onwards.

Changes in v4:
- Create only 1 .swu file, either delta or complete swu.
- By default complete update swu is created.

Changes in v3:
- Rebase to current next branch (61e998e1e0541e2713c05fcbf21df39fbc882a0a)
- Set "${TOPDIR}/previous-image" as the path for the previous image artifact for rdiff update.
- README updates to verify delta update.

Changes in v2:
- Removed zchunk support for bookworm (due to use of backports). Currently zchunk based update only supported in Sid.
- Removed delta-update.yml file. Related variables have default values and can be set in manually swupdate.yml file.
- Using .squashfs file (.verity file in the case of Secure boot) for rdiff delta creation instead of .wic file.
- rdiff is set as default for delta update type, the build system looks for the v1 artifact in a default path (image-v1/<artifact_name>).
- Created a separate template file for sw-description of delta update.
- Renamed delta_update.bbclass to delta-update.bbclass.

Adithya Balakumar (3):
  Add Delta update support with rdiff_image and delta handler
  swupdate.bbclass: Generate swu for delta updates
  doc/README.swupdate.md: Update steps to test Delta software Update

 classes/delta-update.bbclass                | 97 +++++++++++++++++++++
 classes/swupdate.bbclass                    | 27 +++++-
 conf/layer.conf                             |  2 +-
 doc/README.swupdate.md                      | 59 +++++++++++++
 kas/opt/swupdate.yml                        |  5 ++
 recipes-core/images/swu/sw-description.tmpl |  5 +-
 6 files changed, 189 insertions(+), 6 deletions(-)
 create mode 100644 classes/delta-update.bbclass

-- 
2.39.2



