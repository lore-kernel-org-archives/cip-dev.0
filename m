Return-Path: <SRS0=BM8r=GV=lists.cip-project.org=bounce+64572+6092+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4814CC433DB
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 10:36:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B72B22241
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 10:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B72B22241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6092+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zi5ZYY4521723xuEgHnaT0Or; Mon, 18 Jan 2021 02:36:02 -0800
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.31689.1610966161721153955
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 02:36:02 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 10IAZxw9029211
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 18 Jan 2021 11:36:00 +0100
X-Received: from md2dvrtc.fritz.box ([139.22.46.47])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10IAZwgi032291;
	Mon, 18 Jan 2021 11:35:59 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 1/4] swupdate: enable cross-compile by setting PKG_CONFIG_PATH
Date: Mon, 18 Jan 2021 11:35:55 +0100
Message-Id: <20210118103558.18100-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210118103558.18100-1-Quirin.Gylstorff@siemens.com>
References: <20210118103558.18100-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: F6RKesUPIdaOrZEk39yKPglFx4520388AA=
Content-Type: multipart/mixed; boundary="7VYOXU5vRvb9JDksoaPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610966162;
 bh=LeGgYi/DK1pD4U49DCQcJXcqsi1ckOLv4FIp5IS6kPQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=YTh74hjGvkIPTqcbVhS1p6JZzznhioYmWf67sEcaagzRc+3PNr3hUCYTvOe0ozMUUDf
 2nSqgyWjmTdz5JA49Jb7Uf6sjtq8gVr5sXKHiZhGHXobO9eTG7p04qVMchYuIimc9Ika6
 PZjWnChWo3ZqmJ614sgMGjPvKLIL+oXXhNM=

--7VYOXU5vRvb9JDksoaPx
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If cross compiling should be used the configuration path
for pkgconfig needs to be adapted for the target architecture.

Add pkg-config as build dependency.

Fix typo in swupdate.bb.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass               | 2 +-
 recipes-core/swupdate/files/debian/rules.tmpl | 1 +
 recipes-core/swupdate/swupdate.bb             | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index 42f0654..208d240 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -15,7 +15,7 @@ inherit kconfig-snippets
 
 BUILD_DEB_DEPENDS = " \
     zlib1g-dev, debhelper, libconfig-dev, libarchive-dev, \
-    python-sphinx:native, dh-systemd, libsystemd-dev, libssl-dev"
+    python-sphinx:native, dh-systemd, libsystemd-dev, libssl-dev, pkg-config"
 
 KFEATURE_lua = ""
 KFEATURE_lua[BUILD_DEB_DEPENDS] = "liblua5.3-dev"
diff --git a/recipes-core/swupdate/files/debian/rules.tmpl b/recipes-core/swupdate/files/debian/rules.tmpl
index 54cca57..ec83a88 100755
--- a/recipes-core/swupdate/files/debian/rules.tmpl
+++ b/recipes-core/swupdate/files/debian/rules.tmpl
@@ -2,6 +2,7 @@
 
 ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
 export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
+export PKG_CONFIG_PATH=/usr/lib/$(DEB_HOST_GNU_TYPE)/pkgconfig
 export CC=$(DEB_HOST_GNU_TYPE)-gcc
 export LD=$(DEB_HOST_GNU_TYPE)-gcc
 endif
diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
index dd02cc2..b4d64fe 100644
--- a/recipes-core/swupdate/swupdate.bb
+++ b/recipes-core/swupdate/swupdate.bb
@@ -8,7 +8,7 @@
 #
 # SPDX-License-Identifier: MIT
 
-hDESCRIPTION = "swupdate utility for software updates"
+DESCRIPTION = "swupdate utility for software updates"
 HOMEPAGE= "https://github.com/sbabic/swupdate"
 LICENSE = "GPL-2.0"
 LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
-- 
2.20.1


--7VYOXU5vRvb9JDksoaPx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6092): https://lists.cip-project.org/g/cip-dev/message=
/6092
Mute This Topic: https://lists.cip-project.org/mt/79920020/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7VYOXU5vRvb9JDksoaPx--
