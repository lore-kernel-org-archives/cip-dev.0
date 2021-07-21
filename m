Return-Path: <SRS0=c7m+=MN=lists.cip-project.org=bounce+64572+6623+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F9C6377A
	for <cip-dev@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86F761263
	for <cip-dev@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86F761263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6623+4520388+10495289@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id S3PoYY4521723xiDL7woql4B; Wed, 21 Jul 2021 14:04:13 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.444.1626901451122835661
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jul 2021 14:04:12 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 16LL49Zw004970
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 21 Jul 2021 23:04:09 +0200
X-Received: from [167.87.2.111] ([167.87.2.111])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 16LL48rf025631
	for <cip-dev@lists.cip-project.org>; Wed, 21 Jul 2021 23:04:08 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] ci: Fix bullseye deployment
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <4021bf9f-ace2-938a-9a3c-a17c10d2ea5b@siemens.com>
Date: Wed, 21 Jul 2021 23:04:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NNdy2xmZjZNgEcs4oqlRL9IFx4520388AA=
Content-Type: multipart/mixed; boundary="4G0fyVTZKlBFYuYmNox7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1626901453;
 bh=WUfHqcy7DTj+ZPTFtuetrVxxZsQ/RTY0MKhfu8zFSMU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qYwnQGiIBGytfan4evjXqGcawh4w/Yp2ng4isrGABWC0IGtN9yzZTS6UVJfk5u8aUVf
 tIdd8cn1wFbnuluRPYMhTyi2SdQA2/E+xWAZ9iFebiTxLP6yk3dyntA3SPB3wdRxoyPO3
 zCYUCHQ0gySuQc7ySc9nwjPD8nbDyxrjveY=

--4G0fyVTZKlBFYuYmNox7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

We actually already had a switch to select the release. So drop the
extra one for bullseye and use release, also fixing the deployment file
name this way.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 161916f..3e98f79 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -8,7 +8,6 @@ variables:
   wic_targz: enable
   targz: disable
   dtb: none
-  bullseye: disable
   deploy: enable
 
 stages:
@@ -35,7 +34,7 @@ default:
     - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
     - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi;
     - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
-    - if [ "${bullseye}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
+    - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
 
@@ -196,7 +195,7 @@ build:simatic-ipc227e-bullseye:
     - .build_base
   variables:
     target: simatic-ipc227e
-    bullseye: enable
+    release: bullseye
 
 build:bbb-bullseye:
   extends:
@@ -204,7 +203,7 @@ build:bbb-bullseye:
   variables:
     target: bbb
     dtb: am335x-boneblack.dtb
-    bullseye: enable
+    release: bullseye
 
 build:iwg20m-bullseye:
   extends:
@@ -212,7 +211,7 @@ build:iwg20m-bullseye:
   variables:
     target: iwg20m
     dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
-    bullseye: enable
+    release: bullseye
 
 build:hihope-rzg2m-bullseye:
   extends:
@@ -220,4 +219,4 @@ build:hihope-rzg2m-bullseye:
   variables:
     target: hihope-rzg2m
     dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
-    bullseye: enable
+    release: bullseye
-- 
2.26.2

--4G0fyVTZKlBFYuYmNox7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6623): https://lists.cip-project.org/g/cip-dev/message=
/6623
Mute This Topic: https://lists.cip-project.org/mt/84366341/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4G0fyVTZKlBFYuYmNox7--
