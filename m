Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE4CD343F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 00:01:32 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11237.1777888151173812364
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 02:49:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm2 header.b=QgoOExRO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1328765-202605040938580574c7358600020701-ytjgjt@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202605040938580574c7358600020701
        for <cip-dev@lists.cip-project.org>;
        Mon, 04 May 2026 11:38:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=97XKSo6jDtuOuAfx8aDy7zE8dlTpdtdMAzjd138AFfM=;
 b=QgoOExRO3kj9IA1Fx1Ac+VMPiX7z1dsetBffRmvdPHFVak8wHePUDYJUWRwRVBuXbJ1oAJ
 80JS+6tn9QhDM6dWJfdelh0lgsuaaHTTzGS800B0JSmm3S9d/ScHCN4hTuzvBvphi5tzmL6a
 7yLqAgTmXkU+yBN+mggkDSBOoOSusN4DmQeEncQ3Gj7cZTC7p21iB2p9FpaiahQCGqd8mNNY
 VNjdAvSRlrFJO37PlCYcUwJ0obojKh5jy0DuMFzQ4+0QAuBdn/bxsDKH1/iuIl/q9kzFCrHP
 1GRTkG62Ztdc/vWfN4+BSnnNYFQHjhyaHMA+iVmryzPwrov+H8SpAuzA==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.1.170-cip55, 6.12.85-cip22
Date: Mon,  4 May 2026 05:38:33 -0400
Message-ID: <20260504093833.739683-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 May 2026 00:01:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22914

Includes fixes for CVE-2026-31431.

Reference: https://security-tracker.debian.org/tracker/CVE-2026-31431

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb |  1 -
 recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb |  1 +
 recipes-kernel/linux/linux-cip_6.1.169-cip54.bb    | 10 ----------
 recipes-kernel/linux/linux-cip_6.1.170-cip55.bb    | 10 ++++++++++
 recipes-kernel/linux/linux-cip_6.12.83-cip21.bb    | 10 ----------
 recipes-kernel/linux/linux-cip_6.12.85-cip22.bb    | 10 ++++++++++
 6 files changed, 21 insertions(+), 21 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
 delete mode 100644 recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
 create mode 100644 recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
 delete mode 100644 recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
 create mode 100644 recipes-kernel/linux/linux-cip_6.12.85-cip22.bb

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb b/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
deleted file mode 120000
index 21dd76c..0000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.83-cip21.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
new file mode 120000
index 0000000..ed5ab00
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
@@ -0,0 +1 @@
+linux-cip_6.12.85-cip22.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb b/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
deleted file mode 100644
index 9033bd6..0000000
--- a/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2023
-#
-# SPDX-License-Identifier: MIT
-
-require linux-cip-release.inc
-
-SRC_URI[sha256sum] = "795cab37cff6fda51255915b419c83481d98624aac9ebbdf63b60da65f5489fa"
diff --git a/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb b/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
new file mode 100644
index 0000000..a339926
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
@@ -0,0 +1,10 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+require linux-cip-release.inc
+
+SRC_URI[sha256sum] = "2b0b200234b03aea3ed77de553935512ad42b25ee260e00745b0729ed892cf63"
diff --git a/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb b/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
deleted file mode 100644
index 9f1e5a0..0000000
--- a/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2025
-#
-# SPDX-License-Identifier: MIT
-
-require linux-cip-release.inc
-
-SRC_URI[sha256sum] = "e72ddfe5db1a6514bc564f54cc41503a1ba16e651c1f535f25b93eecde2d5f19"
diff --git a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
new file mode 100644
index 0000000..fecdba2
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
@@ -0,0 +1,10 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+require linux-cip-release.inc
+
+SRC_URI[sha256sum] = "b99c97c032e3516475e90853a3075274cdc64000699fb5425fcff39c3b998b93"
--
2.39.5


