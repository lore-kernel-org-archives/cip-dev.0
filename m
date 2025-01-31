Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191BDC02195
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 15:26:02 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.21722.1738337157648893459
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 07:25:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=eE87hSPY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202501311525554b169568640a7df8a6-gtlxgx@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202501311525554b169568640a7df8a6
        for <cip-dev@lists.cip-project.org>;
        Fri, 31 Jan 2025 16:25:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=VQXw2y3wgX1JgxqxQxeP6u9MfJMpuHHj4DjA5K3VSu4=;
 b=eE87hSPYz6emueDHPiKtmwG0YPdph3YbSXdJXEW65HEM+fzwC46qsS4UFO5OJLhi3Gnwr2
 oQT6ERH132F76RAMhmhi1IZd6tqbg5Rgvc1ahNA/P6E5faq34gDUIpWUiUHi2WNxz5OQ1SSP
 TZK/Fgagix5VR6eet/N50AiXjzp4XvR8xyPfr2PLcPwE37CPi7XOzsIM1cuU157JbqBtSQ8A
 xrwxeQPPsXHljYV8Eelm1T3ZbGkRn92q19zTpeS/5CZr8cfHw6g4toReSJn4Jeuk8GrR5urH
 DWMTQyYnUs4dXAsqDh6C+5HCyDwYTkLtsZKGwWyduErT5PTtLJvv9fVQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 3/4] kas/opt: add new option for security testing
Date: Fri, 31 Jan 2025 16:25:31 +0100
Message-ID: <20250131152553.270393-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
References: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 15:26:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17723

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Lava generates an directory, in LAVA called overlay, which contains
all scripts and tests of the test stage. The Device-under-test
needs to be instrumented with with this overlay.  LAVA provides the
possibility to download the overlay via http or NFS. We use curl
to download to the overlay from a http server.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml            |  2 ++
 kas/opt/security_test.yml | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 kas/opt/security_test.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index dd4baf4..d7055f2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -65,6 +65,7 @@ default:
     - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
     - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
+    - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
     - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
@@ -251,6 +252,7 @@ build:x86-uefi-secure-boot:
     use_rt: disable
     targz: disable
     watchdog: disable
+    security_test: enable
 
 build:qemu-amd64-swupdate:
   extends:
diff --git a/kas/opt/security_test.yml b/kas/opt/security_test.yml
new file mode 100644
index 0000000..73d22eb
--- /dev/null
+++ b/kas/opt/security_test.yml
@@ -0,0 +1,16 @@
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  lava-testing-add-curl: |
+    IMAGE_PREINSTALL += "curl"
+
-- 
2.47.0


