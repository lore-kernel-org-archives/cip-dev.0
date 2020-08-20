Return-Path: <SRS0=U27u=B6=lists.cip-project.org=bounce+64572+5159+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7436BC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 08:25:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A6622CA1
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 08:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QxvgVmM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A6622CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5159+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kWASYY4521723xr8GdmEQtLY; Thu, 20 Aug 2020 01:25:14 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.106410.1597911913197352301
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Aug 2020 01:25:13 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 07K8PBNu031546; Thu, 20 Aug 2020 17:25:11 +0900
X-Iguazu-Qid: 34tMSeeoSnfSZQ0GCT
X-Iguazu-QSIG: v=2; s=0; t=1597911911; q=34tMSeeoSnfSZQ0GCT; m=6Yabheg7uotivSLYHxAd1lSFOiLnTah1Hc4KxHu80Oo=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 07K8PAGx002317;
	Thu, 20 Aug 2020 17:25:11 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 07K8PAEV024990;
	Thu, 20 Aug 2020 17:25:10 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 07K8PA3u019002;
	Thu, 20 Aug 2020 17:25:10 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH 2/2] ci: Add support for test image
Date: Thu, 20 Aug 2020 17:24:34 +0900
X-TSB-HOP: ON
Message-Id: <20200820082434.1302460-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ADAFpy05JnZiWrpNSkZomT2Hx4520388AA=
Content-Type: multipart/mixed; boundary="6dZRYKIjU9TmN8VFYa7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597911914;
 bh=IpP5Fbv41wi+y8NuqufzGR/tu+4SSJ1GDlQxS7yfQyM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QxvgVmM2gf1hDw7NmGTPs6jnqahMfJiXEn4aMlLChKtHClLNHeI9+kzqsMUS+dFj7Hr
 p1IBnmqYOStWHnAehkOUg7vzyk8WGnd6+c7AxRseaUZsEzriqWmiQWTJ6fgKVmHT7MVwp
 nUV5iEHDyY4HvDY38A17xfH6uE6KpRneKbc=

--6dZRYKIjU9TmN8VFYa7n
Content-Transfer-Encoding: 8bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e23345f..802dbcd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -68,3 +68,35 @@ build:qemu-amd64-base:
     extention: security
     use_rt: disable
     targz: disable
+
+# test
+build:simatic-ipc227e-test:
+  extends:
+    - .build_base
+  variables:
+    target: simatic-ipc227e
+    extention: test
+
+build:bbb-test:
+  extends:
+    - .build_base
+  variables:
+    target: bbb
+    extention: test
+    dtb: am335x-boneblack.dtb
+
+build:iwg20m-test:
+  extends:
+    - .build_base
+  variables:
+    target: iwg20m
+    extention: test
+    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
+
+build:hihope-rzg2m-test:
+  extends:
+    - .build_base
+  variables:
+    target: rzg2m
+    extention: test
+    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
-- 
2.27.0


--6dZRYKIjU9TmN8VFYa7n
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5159): https://lists.cip-project.org/g/cip-dev/message=
/5159
Mute This Topic: https://lists.cip-project.org/mt/76304033/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--6dZRYKIjU9TmN8VFYa7n--
