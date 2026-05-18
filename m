Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51723CD4F54
	for <webhook@archiver.kernel.org>; Tue, 19 May 2026 02:18:11 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5747.1779100969637954645
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2026 03:42:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm1 header.b=eLufsR71;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1333022-202605181032404505aa96ba00020786-to5nr5@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202605181032404505aa96ba00020786
        for <cip-dev@lists.cip-project.org>;
        Mon, 18 May 2026 12:32:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=uMMOo9LeMsX3TIwrwVF/dheVhqZ+a+kClnkYobXTkyU=;
 b=eLufsR71RXPNYJ4v7vilDCM9ySx7eNQ3rBc2Dk1f65/ey04GGgxx9/tKntRSrVxM6cmcnT
 hB0vc2iS6HT4ZCd8FcvRWTDdMyqRYNbRyr7rOxePBqCR28f7ZCIPdJQKz1pfsXugisj4XSOv
 ILUch2Hn4v1xOUqUineRkhdsy0R77IaiVFigTllyqIJJFnYi1ZpxDwu3pq3Bi0U4akHLtKmg
 3N8k2S28QB98sCrJmFOQmMbjrF9XwFS9o74q/z3DsgpmVc/iqlEKv/fiV86amF3IgVbyiF0o
 RFHSr7xjmnTgM9y+e0Ek/6EutWt+u0BxAnMTZEXohvLaGRYNhHfzGxoQ==;
From: Gourav Singh <gouravsingh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gouravsingh@siemens.com>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to 5.10.256-cip73, 6.1.173-cip56, 6.12.88-cip23, 4.19.325-cip130-rt47
Date: Mon, 18 May 2026 16:02:26 +0530
Message-Id: <20260518103226.1527605-1-gouravsingh@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 May 2026 02:18:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22978

Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 ...25-cip130-rt47.bb => linux-cip-rt_4.19.325-cip132-rt48.bb} | 4 ++--
 recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb            | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb            | 1 +
 ...inux-cip_5.10.254-cip72.bb => linux-cip_5.10.256-cip73.bb} | 4 ++--
 ...{linux-cip_6.12.85-cip22.bb => linux-cip_6.1.173-cip56.bb} | 2 +-
 ...{linux-cip_6.1.170-cip55.bb => linux-cip_6.12.88-cip23.bb} | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip130-rt47.bb => linux-cip-rt_4.19.325-cip132-rt48.bb} (54%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
 rename recipes-kernel/linux/{linux-cip_5.10.254-cip72.bb => linux-cip_5.10.256-cip73.bb} (54%)
 rename recipes-kernel/linux/{linux-cip_6.12.85-cip22.bb => linux-cip_6.1.173-cip56.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.1.170-cip55.bb => linux-cip_6.12.88-cip23.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip130-rt47.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb
similarity index 54%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip130-rt47.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb
index 4ab07e3..59489cf 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip130-rt47.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2025
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@

 require linux-cip-release.inc

-SRC_URI[sha256sum] = "15950e3c757037ceaf02d19f64519618fa7f1119905e6f975f7ae3658c1d5b6e"
+SRC_URI[sha256sum] = "65230ec52117a1896b2ec285cfca7ecc0cdf09441613e23cd7dea590d92e0859"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
deleted file mode 120000
index ed5ab00..0000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.85-cip22.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb b/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
new file mode 120000
index 0000000..306c2a9
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
@@ -0,0 +1 @@
+linux-cip_6.12.88-cip23.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb b/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
similarity index 54%
rename from recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
rename to recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
index b4beedc..4d2fec6 100644
--- a/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2023
+# Copyright (c) Siemens AG, 2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@

 require linux-cip-release.inc

-SRC_URI[sha256sum] = "59e32e7cedd32bfc3a42e673898384f23931219911e4ca6a4215a375393944e6"
+SRC_URI[sha256sum] = "b911f12ba8975ab4c114713c03275662457190fd9709148a4ad735705019e7f8"
diff --git a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip_6.1.173-cip56.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
rename to recipes-kernel/linux/linux-cip_6.1.173-cip56.bb
index fecdba2..1138c23 100644
--- a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.173-cip56.bb
@@ -7,4 +7,4 @@

 require linux-cip-release.inc

-SRC_URI[sha256sum] = "b99c97c032e3516475e90853a3075274cdc64000699fb5425fcff39c3b998b93"
+SRC_URI[sha256sum] = "0332d054d7ab7f74506184d1616ac9dd9d77ef2f33c3de1f7128466ec0d8d933"
diff --git a/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb b/recipes-kernel/linux/linux-cip_6.12.88-cip23.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
rename to recipes-kernel/linux/linux-cip_6.12.88-cip23.bb
index a339926..f61cbf9 100644
--- a/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.88-cip23.bb
@@ -7,4 +7,4 @@

 require linux-cip-release.inc

-SRC_URI[sha256sum] = "2b0b200234b03aea3ed77de553935512ad42b25ee260e00745b0729ed892cf63"
+SRC_URI[sha256sum] = "c7044d8f5135c80bb32c5f194a940b1bdf8904cd80eea1aee90588be0e12d59d"
--
2.39.5


