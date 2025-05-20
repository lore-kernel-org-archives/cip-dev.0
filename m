Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66325C3DA6D
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 12:43:52 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.19995.1747745027086901000
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 May 2025 05:43:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=ZTXbf2uA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2025052012434487847dec6ea1e51801-juqgkk@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025052012434487847dec6ea1e51801
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 May 2025 14:43:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=FpvrcGftbUPJIa4UaXDi4foVV2Cs7QS57ntjW83T+us=;
 b=ZTXbf2uAX/817gmGmd649yeF8THZSQOyE8DSFqN3vL1z+/OlR0oW1GHuT2GgocpBbuYMsa
 /vBegaJlqMlmNLMo3PP7PIaT5ncli9zY0WIqBkOg/3n42ct+on0CZhr3RPO/L3mJd2fGT/IF
 /ifVMutrNwsj+H4DhjNh6SqhAwI48qt6RdOnz6piT9R+LUQiq9uFU6wLyaSVCd5P7duQ/QoS
 iAb8na2Ij1Fzg/fzhWpSjJiftOfeH8hAlYcxoJSvjktqX9RlwF/Q8HnCyY+ijXVoL9C5HWCk
 BEJp1xNjJqOoAJc7m0LB8+Zr6WGXzXgIhc+bl/TnPuGFXCG0+lLlY2KQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 4/4] trixie: Drop pinning on snapshot version
Date: Tue, 20 May 2025 14:43:42 +0200
Message-ID: <edb921ebbf2c4fd7e0612829c78dc240451295d2.1747745022.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1747745022.git.jan.kiszka@siemens.com>
References: <cover.1747745022.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 May 2025 12:43:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18925

From: Jan Kiszka <jan.kiszka@siemens.com>

Cross-build is working again, and trixie is in freeze now. Lift the
pinning to a specific snapshot. That also means to stop building a
patched dosfstools because our issue is now fixed upstream.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-common.inc  | 3 ++-
 conf/distro/cip-core-trixie.conf | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index d06eef05..0814b082 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2024
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -17,6 +17,7 @@ CIP_IMAGE_OPTIONS ?= ""
 
 IMAGER_BUILD_DEPS:append = " dosfstools-native"
 IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
+IMAGER_BUILD_DEPS:remove:trixie = "dosfstools-native"
 
 PREFERRED_VERSION_linux-cip-native ?= "${PREFERRED_VERSION_linux-cip}"
 PREFERRED_VERSION_linux-cip-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip}"
diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
index e8eff746..b133bbbb 100644
--- a/conf/distro/cip-core-trixie.conf
+++ b/conf/distro/cip-core-trixie.conf
@@ -14,7 +14,3 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "6.12.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
-
-# cross build currently broken, use working snapshot
-ISAR_USE_APT_SNAPSHOT = "1"
-ISAR_APT_SNAPSHOT_DATE = "20250309T000000Z"
-- 
2.43.0


