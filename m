Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F434C021B5
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 08:53:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.85319.1740387186906557146
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 00:53:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51O8r4q82495135; Mon, 24 Feb 2025 17:53:04 +0900
X-Iguazu-Qid: 2yAbyr8UoKCmTkCDWk
X-Iguazu-QSIG: v=2; s=0; t=1740387183; q=2yAbyr8UoKCmTkCDWk; m=61K51Cb9X1rCyuowTkGGRfmChWrHxok8KLCs5HTjWMo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 51O8r3VI4133030
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 17:53:03 +0900
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 1/2] .reproducible-check-ci.yml: Upload wic files for reproducibility test
Date: Mon, 24 Feb 2025 04:00:51 -0500
X-TSB-HOP2: ON
Message-Id: <20250224090052.260495-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Feb 2025 08:53:00.0417 (UTC) FILETIME=[81D91F10:01DB8699]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 08:53:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17890

From: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>

Currently only the individual partition images are checked in the
reproducibility test. Now let's check the reproducibility of entire
disk image too.

Signed-off-by: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 59fc216..7bf1ac6 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -33,12 +33,14 @@
     # Build 2nd time
     - !reference [.build_base, script]
     - mv build/tmp/deploy/images/${target} image2
+    # Compress artifacts
+    - tar --ignore-failed-read -cJf image1.tar.xz image1/*.wic* image1/*.swu
+    - tar --ignore-failed-read -cJf image2.tar.xz image2/*.wic* image2/*.swu
   artifacts:
     expire_in: 1 day
     paths:
       - scripts/repro-tests.sh
-      - image*/*.wic.p*
-      - image*/*.swu
+      - image*.tar.xz
 
 .repro-test:
   image:
@@ -55,6 +57,10 @@
   before_script:
     - apt update && DEBIAN_FRONTEND=noninteractive apt install -y diffoscope
   script:
+    - mkdir image1
+    - tar -xJf image1.tar.xz --strip-components=1 -C image1
+    - mkdir image2
+    - tar -xJf image2.tar.xz --strip-components=1 -C image2
     - ./scripts/repro-tests.sh --release ${release} --target ${target} --extension ${extension} image1 image2
   artifacts:
     when: always
-- 
2.39.5



