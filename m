Return-Path: <SRS0=AJFr=L7=lists.cip-project.org=bounce+64572+6603+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AE6C07E95
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A8B61CA8
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 12:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A8B61CA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6603+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IRV6YY4521723x0LxAZQn8Xz; Wed, 07 Jul 2021 05:17:09 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.20219.1625660200027119963
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 05:16:40 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 167CGcH0029834
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:38 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 167CGaEd020405
	for <cip-dev@lists.cip-project.org>; Wed, 7 Jul 2021 14:16:38 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 7/9] ci: Add bullseye targets
Date: Wed,  7 Jul 2021 14:16:34 +0200
Message-Id: <5ca9b4dd2058e37eeb4ab4b080273301b3cbe796.1625660195.git.jan.kiszka@siemens.com>
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
X-Gm-Message-State: 46bpmgfWS2fe3efKjKSWvRjJx4520388AA=
Content-Type: multipart/mixed; boundary="ZrQAeFwFaHAsAN9UU7DK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625660229;
 bh=Ofn2eerxsVRYcBj1ZcfN50eWfCaX+VjE7ZkDEo3FWZE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NeFilDTW6MSKrdndOS8ed99/9p672kgpW4jTyUZtzYQbIotmM+jr2DnJ2KMGmiJ5eTV
 6rt9qag3VdftXA/SgqmGB5kb0uRJVgdHM5+TKAlovXbEYciqssjq7VAC9r4HQ5fDlW23m
 iRjeMsRz1f6B01pkPLCU4d4fD4zuQVkulds=

--ZrQAeFwFaHAsAN9UU7DK
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Build the physical targets for bullseye as well in order to test this
early.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2a9ae22..161916f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -8,6 +8,7 @@ variables:
   wic_targz: enable
   targz: disable
   dtb: none
+  bullseye: disable
   deploy: enable
 
 stages:
@@ -34,6 +35,7 @@ default:
     - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
     - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi;
     - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
+    - if [ "${bullseye}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
 
@@ -154,6 +156,7 @@ build:qemu-arm-test:
     wic_targz: disable
     targz: enable
 
+# secure boot images
 build:qemu-amd64-secure-boot:
   extends:
     - .build_base
@@ -186,3 +189,35 @@ build:qemu-amd64-secure-boot-swu:
     wic_targz: disable
     targz: disable
     deploy: disable
+
+# bullseye images
+build:simatic-ipc227e-bullseye:
+  extends:
+    - .build_base
+  variables:
+    target: simatic-ipc227e
+    bullseye: enable
+
+build:bbb-bullseye:
+  extends:
+    - .build_base
+  variables:
+    target: bbb
+    dtb: am335x-boneblack.dtb
+    bullseye: enable
+
+build:iwg20m-bullseye:
+  extends:
+    - .build_base
+  variables:
+    target: iwg20m
+    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
+    bullseye: enable
+
+build:hihope-rzg2m-bullseye:
+  extends:
+    - .build_base
+  variables:
+    target: hihope-rzg2m
+    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
+    bullseye: enable
-- 
2.26.2


--ZrQAeFwFaHAsAN9UU7DK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6603): https://lists.cip-project.org/g/cip-dev/message=
/6603
Mute This Topic: https://lists.cip-project.org/mt/84042870/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZrQAeFwFaHAsAN9UU7DK--
