Return-Path: <SRS0=XbyQ=GV=lists.cip-project.org=bounce+64572+6096+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD0BC433DB
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 10:37:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E824722242
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 10:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E824722242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6096+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ffeuYY4521723xbaX3qTLNxw; Mon, 18 Jan 2021 02:37:08 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.31679.1610966227623559868
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 02:37:08 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 10IAb6w2003042
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jan 2021 11:37:06 +0100
X-Received: from md2dvrtc.fritz.box ([139.22.46.47])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10IAb54W008329;
	Mon, 18 Jan 2021 11:37:05 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org,
        kazuhiro3.hayashi@toshiba.co.jp
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][RFC 1/1] image: Move root password
Date: Mon, 18 Jan 2021 11:37:04 +0100
Message-Id: <20210118103704.18195-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210118103704.18195-1-Quirin.Gylstorff@siemens.com>
References: <20210118103704.18195-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EaKUU61jIGl1y3IpZchDW0Ndx4520388AA=
Content-Type: multipart/mixed; boundary="Z2TJuoLwwrTy1trXTn9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610966228;
 bh=Vp2azMeyXC2ULtPE086TvhVtH1+0GVzKeF+y7weOi5s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XnLOk6u0yfU0jTRl1KuLOmRBP/DNbVXKimH30FDXkHGLe9OPuRmlO3ZNjvGzZQcCsSA
 m6Bulm/INjBm2QrBKz0Zm5fG3zRa2K8vbSNsF+tIqWCchQQO9eXqoedqf1/hz03hWnbDw
 JsbaruWssl+XdTvB03K2LR85+OI6PGCXpMw=

--Z2TJuoLwwrTy1trXTn9g
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If cip-core is used upstream there is the possibility that the
root password is not set to a new value. Avoid this by moving the
password setting to the image.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml                                         | 4 ----
 recipes-core/images/cip-core-image-security.bb      | 3 +++
 recipes-core/images/cip-core-image.bb               | 8 +++++++-
 recipes-core/security-customizations/files/postinst | 6 ------
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 9514083..f2ed22e 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -41,7 +41,3 @@ local_conf_header:
     CONF_VERSION = "1"
   cross: |
     ISAR_CROSS_COMPILE = "1"
-  root_password: |
-    USERS += "root"
-    # 'root'
-    USER_root[password] = "oC3wEGl799tZU"
diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 61ddc39..23219cb 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -11,6 +11,9 @@
 
 inherit image
 
+# for customization and root password
+require recipes-core/images/cip-core-image.bb
+
 DESCRIPTION = "CIP Core image including security packages"
 
 IMAGE_INSTALL += "security-customizations"
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 2cecde3..0f62edd 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019 - 2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,6 +11,7 @@
 
 inherit image
 inherit image_uuid
+
 ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
 DESCRIPTION = "CIP Core image"
 
@@ -19,3 +20,8 @@ IMAGE_INSTALL += "customizations"
 # for swupdate
 SWU_DESCRIPTION ??= "swupdate"
 include ${SWU_DESCRIPTION}.inc
+
+# add root user and set passwort
+USERS += "root"
+# 'root'
+USER_root[password] = "oC3wEGl799tZU"
diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 3699ba2..682ceec 100644
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -4,12 +4,6 @@
 # Security Package configurations
 #
 
-echo "CIP Core Security Image (login: root/root)" > /etc/issue
-
-HOSTNAME=demo
-echo "$HOSTNAME" > /etc/hostname
-echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
-
 # CR1.7: Strength of password-based authentication
 # Pam configuration to  enforce password strength
 PAM_PWD_FILE="/etc/pam.d/common-password"
-- 
2.20.1


--Z2TJuoLwwrTy1trXTn9g
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6096): https://lists.cip-project.org/g/cip-dev/message=
/6096
Mute This Topic: https://lists.cip-project.org/mt/79920035/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Z2TJuoLwwrTy1trXTn9g--
