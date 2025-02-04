Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906B2C02194
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 11:57:37 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.114810.1738670246667639980
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Feb 2025 03:57:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=dgEQKwLB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202502041157238593b3addc2970e13b-ygnrw0@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202502041157238593b3addc2970e13b
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Feb 2025 12:57:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=k6tqWfn/v2vKW68EN/rqaIuOx/Ui1CcEGVj0P43184A=;
 b=dgEQKwLBpEIvXHhwPOuZUFHOwgxKFe9lDVy5ifYsSOSt8LX9XkEdUVAbEqgpoj/l3v9W3R
 T69yLX89KN1OPVkN8vRv/nj7bS5eWZDx2JUJ3M0dfCJeYzmITLVDrxuZ5M6pLNGVer5Wmik6
 1lY5t2apTNhdvMXOR0vDprZx2WhMxarLh3KvuU83CbQExZlzQNB4msUzuZfla0SQzqx4ACOv
 V8r+jcMEPNH4Ue2y+EcJJdO/K9Xzrxz4OGTj0ukBNLunUu6ggWlR5wo1ZP5HJY5VjbfIWdkV
 GGwJoGcuUkSWRRm6M9ce6wPVNTDOQ0w77Owo4YBemExbCvovv5V8PDFQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	Sai.Sathujoda@toshiba-tsip.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4] kas/opt: add new option for security testing
Date: Tue,  4 Feb 2025 12:56:02 +0100
Message-ID: <20250204115722.48815-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250131152553.270393-4-Quirin.Gylstorff@siemens.com>
References: <20250131152553.270393-4-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 11:57:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17746

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Lava generates a directory, in LAVA called overlay, which contains
all scripts and tests of the test stage. The device-under-test
needs to be instrumented with this overlay.  LAVA provides the
possibility to download the overlay via http or NFS. We use curl
to download the overlay from a http server onto the target.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v4:
 - fixed description
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


