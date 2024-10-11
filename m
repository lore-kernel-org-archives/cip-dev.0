Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B3BD24462
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 01:54:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.1979.1728611687309092699
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Oct 2024 18:54:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=ZRNXQuGb;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1728611685;x=1729821285;bh=bYzjtecV0/CTlHuPxieSJ/YpfRgAGXhp+7Qj2OsTF+M=;b=ZRN
	XQuGb39eqIpS3IY/ZOXKao5Qh+OYSieX4EVYoiPACIXcgtB3EYtdxZtyMyjUZ9obj+l+5zJ6uq/rW
	ebJrdvB4pbpeRz5JCGcsecBdIOBYGIbKqZLYCV7enQgwpuqoZRCBzUQ5gx19Osj+BeNCQYVTIrDsf
	3mbZel5GHSaSeCN8t/tU/ff0DPmXzzIeWHyaLEbntCh8/9k01scEszviUa0pKtOP5bGSUYRoHVRNb
	EfwxLbvgqcVT+pLpT+qAlkFKTKxzN4geAStYHK46aOETaS+y8ox4kdaskaA4mLINFpn0qldDzgrLn
	dKZUm6i5DyevlsocDYcI1joQk6FCuXQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 49B1sjq31904407; Fri, 11 Oct 2024 10:54:45 +0900
X-Iguazu-Qid: 2yAaj8ZU3hnBz6xOpW
X-Iguazu-QSIG: v=2; s=0; t=1728611684; q=2yAaj8ZU3hnBz6xOpW; m=JTjQJkI1AcY/Lo5zC8LEsoXhZ7QhBszCoZoiB/hYiko=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 49B1shif1516629
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:54:44 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip92, 5.10.226-cip53 and 6.1.111-cip29-rt16
Date: Fri, 11 Oct 2024 10:54:41 +0900
X-TSB-HOP2: ON
Message-Id: <1728611681-13614-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Oct 2024 01:54:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17026

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 ...6.1.107-cip28-rt15.bb => linux-cip-rt_6.1.111-cip29-rt16.bb} | 2 +-
 .../{linux-cip_4.4.302-cip91.bb => linux-cip_4.4.302-cip92.bb}  | 2 +-
 ...{linux-cip_5.10.224-cip52.bb => linux-cip_5.10.226-cip53.bb} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.107-cip28-rt15.bb => linux-cip-rt_6.1.111-cip29-rt16.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip91.bb => linux-cip_4.4.302-cip92.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.224-cip52.bb => linux-cip_5.10.226-cip53.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.107-cip28-rt15.bb b/recipes-kernel/linux/linux-cip-rt_6.1.111-cip29-rt16.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.107-cip28-rt15.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.111-cip29-rt16.bb
index ee3bd93..f424735 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.107-cip28-rt15.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.111-cip29-rt16.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5296cbb13076f4b7ac24fcb9220f1be5bcf1f28c7e5a00a71b84f67d5f85b35d"
+SRC_URI[sha256sum] = "486d7c3dc921101a9ec29e829b9d31dd0c1f46533591c7ace572cf201939e2cb"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip91.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip92.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip91.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip92.bb
index 1d76094..223dcbe 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip91.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip92.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "25b3bf1d260185ca61de9c13dc3bda6d179c07f992a6511adc504b35bf915801"
+SRC_URI[sha256sum] = "5eae4b20ea63eeaacdeb11fa8ba17a7beb965711ded3e8bc316ca8250b807cb4"
diff --git a/recipes-kernel/linux/linux-cip_5.10.224-cip52.bb b/recipes-kernel/linux/linux-cip_5.10.226-cip53.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.224-cip52.bb
rename to recipes-kernel/linux/linux-cip_5.10.226-cip53.bb
index ccc8b77..59aed56 100644
--- a/recipes-kernel/linux/linux-cip_5.10.224-cip52.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.226-cip53.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "7c3538b79831741991ffe373261264c313c712b9520e746f8336356a621d3246"
+SRC_URI[sha256sum] = "d85672e4b94d54c9e79dc7f35942354efbb5b463ee6be067bf36eb220f187f02"
-- 
2.45.2



