Return-Path: <SRS0=Hsyz=L7=lists.cip-project.org=bounce+64572+6604+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B0C07E95
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E60761C9A
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E60761C9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6604+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YLPmYY4521723xArxPwOprJI; Wed, 07 Jul 2021 05:17:17 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web10.20225.1625660200142584593
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:40 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 167CGcj1018251
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:38 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEc020405
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:38 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 6/9] Add bullseye image option
Date: Wed,  7 Jul 2021 14:16:33 +0200
Message-Id: <b778aed3da1673393438479a74a75fd40a18c3f7.1625660195.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625660195.git.jan.kiszka@siemens.com>
References: <cover.1625660195.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DE4R7pKA1QnbsGVwgatycAvMx4520388AA=
Content-Type: multipart/mixed; boundary="5VJT8eTGGPFr70VknIPK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660237;
 bh=ffOMYRour0iJ0CDPoUlh4SHRaq1z2WYDl4K2LM+ELBQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=S44SpOCuGq0jmdqBkYz/fIQhzgORoGpKN5KuX4/Q1mPKg6zSR1zsqQp/N89H4Vdr0Y0
 txR3VQLAxXGeXA74v2blZTwp3xqPLjxuhql++FVrIHyC9NsJqVyWTnRC2+KSdHIJ7TvBI
 bQ8WTJrYHZoKIVRKmyZBiDn89RswFENgpzs=

--5VJT8eTGGPFr70VknIPK
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to build isar-cip-core for upcoming Debian 11. Default
remains Debian 10 for now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-bullseye.conf | 16 ++++++++++++++++
 kas/opt/bullseye.yml               | 15 +++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 conf/distro/cip-core-bullseye.conf
 create mode 100644 kas/opt/bullseye.yml

diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
new file mode 100644
index 0000000..38014b4
--- /dev/null
+++ b/conf/distro/cip-core-bullseye.conf
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require conf/distro/debian-bullseye.conf
+require cip-core-common.inc
+
+PREFERRED_VERSION_linux-cip ?= "4.19.%"
+PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
diff --git a/kas/opt/bullseye.yml b/kas/opt/bullseye.yml
new file mode 100644
index 0000000..24a4c84
--- /dev/null
+++ b/kas/opt/bullseye.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+distro: cip-core-bullseye
-- 
2.26.2


--5VJT8eTGGPFr70VknIPK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6604): https://lists.cip-project.org/g/cip-dev/message=
/6604
Mute This Topic: https://lists.cip-project.org/mt/84042871/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5VJT8eTGGPFr70VknIPK--
