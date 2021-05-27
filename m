Return-Path: <SRS0=RHd0=KW=lists.cip-project.org=bounce+64572+6477+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28CC47089
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 13:25:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD95613DE
	for <cip-dev@archiver.kernel.org>; Thu, 27 May 2021 13:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD95613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6477+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OjaAYY4521723xjEBRZbH0Uj; Thu, 27 May 2021 06:25:06 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.6788.1622121904939104501
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 May 2021 06:25:05 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 14RDP3WG021282
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 27 May 2021 15:25:03 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.10.167])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 14RDHgb2007209;
	Thu, 27 May 2021 15:17:44 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 5/5] .gitlabci.yml: Add secure-boot and swupdate build
Date: Thu, 27 May 2021 15:17:41 +0200
Message-Id: <20210527131741.8828-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
References: <20210527131741.8828-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uUU2f0ouYDavseNC0C5LVsoXx4520388AA=
Content-Type: multipart/mixed; boundary="vscqzQGT2LREql6oxcgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622121906;
 bh=+STfhodPeNpwmlmAnaLycxfltvUMa7UFAzReGRjC5Iw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=n693kkWsB6i+4kOQPk8O3/prOI9SjrQchmJwlEkfpLrUNY3NZUb0td04Nq9nOxa3yL2
 iQm0WBHmRgxi7ZPvoJ3yJDQiFUhcGxlojXFu3Oc7GLeEATo36DfA3vf77EAbe4kpd6wKZ
 Omi3BGpzdG+e98r8oeVy2k0qsRpqcj04gTY=

--vscqzQGT2LREql6oxcgb
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml               | 11 +++++++++++
 kas/opt/ebg-snakeoil-swu.yml | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 kas/opt/ebg-snakeoil-swu.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 44ade3e..9d9ced0 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -173,3 +173,14 @@ build:qemu-amd64-swupdate:
     wic_targz: disable
     targz: disable
     deploy: disable
+
+build:qemu-amd64-secure-boot-swu:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    extention: ebg-snakeoil-swu
+    use_rt: disable
+    wic_targz: disable
+    targz: disable
+    deploy: disable
diff --git a/kas/opt/ebg-snakeoil-swu.yml b/kas/opt/ebg-snakeoil-swu.yml
new file mode 100644
index 0000000..e4dd98f
--- /dev/null
+++ b/kas/opt/ebg-snakeoil-swu.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+  includes:
+   - ebg-secure-boot-snakeoil.yml
+   - swupdate.yml
+
-- 
2.20.1


--vscqzQGT2LREql6oxcgb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6477): https://lists.cip-project.org/g/cip-dev/message=
/6477
Mute This Topic: https://lists.cip-project.org/mt/83124000/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vscqzQGT2LREql6oxcgb--
