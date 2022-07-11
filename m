Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE86C43334
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 19:41:14 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web08.192.1657568464017967853
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 12:41:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=jDR99aWD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-202207111941012c5caba7b36ffd1325-fluh3e@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202207111941012c5caba7b36ffd1325
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Jul 2022 21:41:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DWDDXqFy8dDMpjCypxWPbIITxBBTeSgEFuE99wDPLG8=;
 b=jDR99aWDL3mF2vfIlgf5GzgeBQznq6/neK7w02BV8jNGYw4ixImp5RKywTXWHK/bydJhS2
 iQt5i7H31D90AxPy3PukwgVN2TjzPtlFYZE+an8MlodZiIs1OIjE3HFc0jr7vLJgu//R1nq9
 9tWSmLKm4vFOuaib9x3W2S1UC3NwQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 7/7] ci: Add qemu-arm target for secure boot
 with swupdate
Date: Mon, 11 Jul 2022 21:40:58 +0200
Message-Id: 
 <2c394ce6d2a572171347696befa2378f72499e52.1657568458.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1657568458.git.jan.kiszka@siemens.com>
References: <cover.1657568458.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 19:41:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8748

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b1a4dc0..3d39d1f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -230,6 +230,18 @@ build:qemu-arm64-secure-boot:
     targz: disable
     deploy: disable
 
+# secure boot images arm
+build:qemu-arm-secure-boot:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    wic_targz: disable
+    targz: disable
+    deploy: disable
+
 # buster images
 build:simatic-ipc227e-buster:
   extends:
-- 
2.35.3


