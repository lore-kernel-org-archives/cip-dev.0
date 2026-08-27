Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801EC5DF9D
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 06:23:05 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30490.1787811782195877314
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 23:23:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=j9r8/PyI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-202608270622598119e84aea0002079d-0vc7b4@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202608270622598119e84aea0002079d
        for <cip-dev@lists.cip-project.org>;
        Thu, 27 Aug 2026 08:23:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wlGH5kiCAWo88nePI5E88f18+B1oe8f/YzPUcrZ/Ork=;
 b=j9r8/PyIUS+NEy1fiGCgXYNjOMOPgKWjrRMnulSinBwSjjkXXVloB5CYC/H2+aZHKTJiGB
 xeAmFzksCCYcvabB+iEqjn+t1BVk0EmI71mBxaYTVqRNM5NEh8ASSpjQhmbEtMH5fYvSpU3w
 iMl7UzMhcWzy/M9RD/4g9P2uiu8sqZZ7buLfd5U9je6eLE5d3O4Kana7XANFndOwKjkBjSmT
 12NCuHM/q23Q2EeeVrvdqFtqy8PvguMGn6FgZDQyXkTXwpELD3NrJoobYBc9KF+uC9JurBZQ
 bDTX/s+Uik3bpA4kE3enOdSRijWGGwDIgr0yonYIr56C1H+eZySfuKwg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Michael Adler <michael.adler@siemens.com>
Subject: [isar-cip-core][PATCH v3 5/5] ci: Select rootless runner
Date: Thu, 27 Aug 2026 08:22:57 +0200
Message-ID: <8ac169b99e9160cdf83333b2575a49867f834260.1787811777.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787811777.git.jan.kiszka@siemens.com>
References: <cover.1787811777.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2026 06:23:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24033

From: Jan Kiszka <jan.kiszka@siemens.com>

We need to explicitly select a runner that is launching build containers
in unprivileged mode. This is primarily due to the bug in kas 5.4 which
breaks the parallel start of multiple kas-isar containers on the same
host. At the same time, such tagging allows us to phase out the
privileged runner at some point in way that would clearly block legacy
jobs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml             | 8 ++++----
 .reproducible-check-ci.yml | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9aa186c6..8dbe62d2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2025
+# Copyright (c) Siemens AG, 2019-2026
 # Copyright (c) Toshiba Corporation, 2020
 #
 # Authors:
@@ -53,7 +53,7 @@ default:
       when: never
     - if: $CI_COMMIT_BRANCH != "master"
   tags:
-    - large
+    - large-rootless
   variables:
     base_yaml: "kas-cip.yml:kas/board/${target}.yml"
   script:
@@ -917,7 +917,7 @@ cve-checks:
   needs: []
   image: registry.gitlab.com/cip-project/cip-core/debian-cve-checker:build-latest
   tags:
-    - large
+    - large-rootless
   script:
     - scripts/run-cve-checks.sh
   rules:
@@ -936,7 +936,7 @@ lavacli-container:
   stage: build
   image: quay.io/buildah/stable:v1.41.4
   tags:
-    - large
+    - large-rootless
   before_script:
     - buildah login -u $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD $CI_REGISTRY
   script:
diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 4f4649ee..de9f3fbd 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -21,7 +21,7 @@
     extension: security
   stage: build
   tags:
-    - large
+    - large-rootless
   rules:
     - if: $CI_PIPELINE_SOURCE == "schedule" && $REPRODUCIBLE_BUILDS
   script:
-- 
2.47.3


