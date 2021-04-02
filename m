Return-Path: <SRS0=Dk3X=I7=lists.cip-project.org=bounce+64572+6338+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8140C433ED
	for <cip-dev@archiver.kernel.org>; Fri,  2 Apr 2021 00:51:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC2660FDC
	for <cip-dev@archiver.kernel.org>; Fri,  2 Apr 2021 00:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC2660FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6338+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id V29qYY4521723xampdAMIRIs; Thu, 01 Apr 2021 17:51:12 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.9992.1617324670096018646
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Apr 2021 17:51:11 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 1320p7OI026863; Fri, 2 Apr 2021 09:51:08 +0900
X-Iguazu-Qid: 34tKsSMCiXGZYx1V9v
X-Iguazu-QSIG: v=2; s=0; t=1617324667; q=34tKsSMCiXGZYx1V9v; m=DLd4JEmxV945lphW+72hsqX1XRwBbT5fZcwrU9kdBic=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1511) id 1320p6sY010751
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Apr 2021 09:51:07 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id D13D11000FA;
	Fri,  2 Apr 2021 09:51:06 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1320p69e020180;
	Fri, 2 Apr 2021 09:51:06 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH] kas: Rename opt/targz-img.yml to opt/wic-targz-img.yml
Date: Fri,  2 Apr 2021 09:51:01 +0900
X-TSB-HOP: ON
Message-Id: <20210402005101.372005-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ckoHLkBVypfZd5pzpWIxJx1rx4520388AA=
Content-Type: multipart/mixed; boundary="ngmSQyyWV43Z09EhF5yX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617324672;
 bh=BNfsZSYhVoR+hRJ8ag+5x4oteikC9ThZ3KrdX34wIcA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=iucPw9lKZnQZlwchu2z5chkQdMlay7ua77bbg80Zba6UUFGPjPNGBv4xLkzWvH8FHen
 x2+WGfOKBgL/SsjOzQmJEZ3lUeo2n+cdcjj+py5lVYfd5DB0C5P78nf691sTISA4e0GQb
 UFOuMcqr8FisElfG/9YvMywfHYNtdVU8gIM=

--ngmSQyyWV43Z09EhF5yX
Content-Transfer-Encoding: 8bit

'wic-targz-img' was specified to IMAGE_TYPE in the original file. And there is 'targz-img' as a
similar function in ISAR.
This renames the file to clarify the functionality it provides.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml                               | 6 +++---
 kas/opt/{targz-img.yml => wic-targz-img.yml} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename kas/opt/{targz-img.yml => wic-targz-img.yml} (100%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 77d361c..d14c72f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,7 +5,7 @@ variables:
   release: buster
   extention: base
   use_rt: enable
-  targz: enable
+  wic_targz: enable
   dtb: none
   deploy: enable
 
@@ -29,7 +29,7 @@ default:
     - sudo rm -rf build/tmp
     - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
     - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
-    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
+    - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi;
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
 
@@ -68,7 +68,7 @@ build:qemu-amd64-base:
     target: qemu-amd64
     extention: security
     use_rt: disable
-    targz: disable
+    wic_targz: disable
     deploy: disable
 
 # test
diff --git a/kas/opt/targz-img.yml b/kas/opt/wic-targz-img.yml
similarity index 100%
rename from kas/opt/targz-img.yml
rename to kas/opt/wic-targz-img.yml
-- 
2.30.0.rc2


--ngmSQyyWV43Z09EhF5yX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6338): https://lists.cip-project.org/g/cip-dev/message=
/6338
Mute This Topic: https://lists.cip-project.org/mt/81792908/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ngmSQyyWV43Z09EhF5yX--
