Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D07CAC59F
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 08:01:21 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.17467.1758096070251335294
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 01:01:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=QHMBf/nE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20250917080107e22a1aff84000207c2-xnk0xk@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250917080107e22a1aff84000207c2
        for <cip-dev@lists.cip-project.org>;
        Wed, 17 Sep 2025 10:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=bl1ReOkpO1dEwy4256LFivDsuFKHcc2Fr0jnEyLfwEE=;
 b=QHMBf/nE1q154TLOsk6GlxdNJ7h32j1tG0/H2bMA9vl3SYueSZogBUktETnzFyDLdXN+Hy
 QvM0JpPR7Cvkm/xfi3pEydLchtvGlX7GG4sXnQ87kVH92ztiAr2BU3ymplL5x5V8iwrPpLCt
 pyvZ2nFvVS53Pfv7SBHcUkXoPcXBuXFdY6bi5OCuJu7Y25R9GduKr+TOCB46+vVUakChnPH9
 hE79PJMhTyWZI/Tb4OGNFWhFrfLDS2f4ZvhGGuFhjzQjduL1f7OWDhPkCeiSH7I5FyUzyuCR
 yermJEQ0cNZO9ovR9tr804kvVCjVqFI3tw1QF7bM9ALfqVDvR5tyEDXA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/3] ci: Add job to build own lavacli container for tests
Date: Wed, 17 Sep 2025 10:01:05 +0200
Message-ID: <f8694e5ba24ace2dafd4df9fa859e0395d932917.1758096066.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758096066.git.jan.kiszka@siemens.com>
References: <cover.1758096066.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 08:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20067

From: Jan Kiszka <jan.kiszka@siemens.com>

This shall accelerate the startup of our lava tests by using a base
image which already contains all the required dependencies. That image
will be re-generated every months by a scheduled pipeline and stored in
the gitlab registry of the isar-cip-core repository by default.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml             | 13 +++++++++++++
 scripts/Dockerfile.lavacli | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 scripts/Dockerfile.lavacli

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d951e160..de082272 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -674,3 +674,16 @@ cve-checks:
       - cve-reports
 
 include: '.reproducible-check-ci.yml'
+
+lavacli-container:
+  stage: build
+  image: quay.io/buildah/stable:v1.41.4
+  tags:
+    - large
+  before_script:
+    - buildah login -u $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD $CI_REGISTRY
+  script:
+    - buildah build -f scripts/Dockerfile.lavacli -t $CI_REGISTRY_IMAGE/lavacli .
+    - buildah push $CI_REGISTRY_IMAGE/lavacli
+  rules:
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $LAVACLI_CONTAINER'
diff --git a/scripts/Dockerfile.lavacli b/scripts/Dockerfile.lavacli
new file mode 100644
index 00000000..763ed4dd
--- /dev/null
+++ b/scripts/Dockerfile.lavacli
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+FROM debian:stable
+
+ARG DEBIAN_FRONTEND=noninteractive
+
+RUN apt-get update && \
+    apt-get install -y --no-install-recommends gettext-base curl xmlstarlet lavacli
-- 
2.51.0


