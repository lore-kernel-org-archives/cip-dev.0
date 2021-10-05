Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C07FC433F5
	for <webhook@archiver.kernel.org>; Tue,  5 Oct 2021 06:47:38 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web12.22031.1633416457398517605
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 23:47:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
IronPort-SDR: 
 2N5u3xeHcXXk0pAdhV+7HcnYZQkdDh637QCY+mxxL7FRFkWpaeHkNRsB/Dab+C0zccNjXx5P6l
 g7WEzLmlI8KsnRZrRHPKvtBoRXvoX0F4lH39/a7OBwFQ7+QwFWiOwbzaYtEFWL/snMD0Snm7bZ
 +e47ld0f6Gfcgxl8+6jEbZEyK5EZZZAcrVavdVMz3z3bXd6eEeDBfVgsaJgOOLfF0LWo9Ls+bB
 dHkIEqyeftyPuoeNp7PQuWEAt9utBZgXQi10zgwTpsyWLshF/x2zZAhVWns7WGuIHmaneM8n5h
 aFvdrdHHPUmBTvlkp03tb2BU
X-IronPort-AV: E=Sophos;i="5.85,347,1624348800";
   d="scan'208";a="66651386"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 04 Oct 2021 22:47:35 -0800
IronPort-SDR: 
 LLkByXEY59c5CMlml69w9RWTzqLjjoldACmoFazyEMwBsqfhHq+WtExn6AXso4BaUZNfaG64qu
 BQB8v7cFA5HM+CKzK7k8x7YJCJBb5I6fd7QstKffHNYGW/3lPpGjAL1YPawQcBgfmOlTxWX196
 VoC1Pm6FdjvAD7YFUSZIYy9mKuucoQmTjXzi220HFBP6/egtbGDwe5n/e1DRTFVQxtXhobCxAY
 YHMAu5f8JOPfbF2QJFeABZd1RF8hfalyU9jkgi9HdWdIyBaJ/mse51D86Z8/BI7P+B6kyUSIFE
 4Io=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-dev] [PATCH] Uprevision cip-kernels to latest one
Date: Tue, 5 Oct 2021 12:17:03 +0530
Message-ID: <20211005064703.1202931-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Oct 2021 06:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6783

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update cip-kernels to latest one for 4.4 and 4.19 versions.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 ...19.195-cip52-rt20.bb => linux-cip-rt_4.19.206-cip57-rt22.bb} | 2 +-
 ...4.4.262-cip55-rt34.bb => linux-cip-rt_4.4.277-cip60-rt35.bb} | 2 +-
 ...{linux-cip_4.19.195-cip52.bb => linux-cip_4.19.206-cip57.bb} | 2 +-
 .../{linux-cip_4.4.272-cip58.bb => linux-cip_4.4.283-cip62.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.195-cip52-rt20.bb => linux-cip-rt_4.19.206-cip57-rt22.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.262-cip55-rt34.bb => linux-cip-rt_4.4.277-cip60-rt35.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.195-cip52.bb => linux-cip_4.19.206-cip57.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.272-cip58.bb => linux-cip_4.4.283-cip62.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.195-cip52-rt20.bb b/recipes-kernel/linux/linux-cip-rt_4.19.206-cip57-rt22.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.195-cip52-rt20.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.206-cip57-rt22.bb
index 4c9a735..e6af865 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.195-cip52-rt20.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.206-cip57-rt22.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "fee95d77599f5a0321ae818f63bf595f5e3015e674f2f428503267b8471379fb"
+SRC_URI[sha256sum] = "586ff1af1c0ee794794db4af40544391d8b2dde88417136e32e6105c6f9d77b3"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.262-cip55-rt34.bb b/recipes-kernel/linux/linux-cip-rt_4.4.277-cip60-rt35.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.262-cip55-rt34.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.277-cip60-rt35.bb
index 37f2018..0a2de66 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.262-cip55-rt34.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.277-cip60-rt35.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "5f8c3fe1ec1cb82e12a6929945f29bfd7dd432a81ad9891cd7490e86d7d91d7a"
+SRC_URI[sha256sum] = "ea4a5de21e6ad82001685bddcfaacd2eaaf524fea61dd774c2895c7adb3b934e"
diff --git a/recipes-kernel/linux/linux-cip_4.19.195-cip52.bb b/recipes-kernel/linux/linux-cip_4.19.206-cip57.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.195-cip52.bb
rename to recipes-kernel/linux/linux-cip_4.19.206-cip57.bb
index 05dc765..f23ab83 100644
--- a/recipes-kernel/linux/linux-cip_4.19.195-cip52.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.206-cip57.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "9eb4fb2a9b0065e3c8ac2a1045da7bc6377309dd7c01292985c3e978b8d61d8f"
+SRC_URI[sha256sum] = "a88ab84c6cf072743890a11e2f782540ecf1081167f3a2f34311060f99eda44d"
diff --git a/recipes-kernel/linux/linux-cip_4.4.272-cip58.bb b/recipes-kernel/linux/linux-cip_4.4.283-cip62.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.272-cip58.bb
rename to recipes-kernel/linux/linux-cip_4.4.283-cip62.bb
index e883794..bcb754d 100644
--- a/recipes-kernel/linux/linux-cip_4.4.272-cip58.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.283-cip62.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "e8300f194bd99866d5d1b467475270f2739aaf1e87536097465f636d37437ff9"
+SRC_URI[sha256sum] = "842c443e6adc43cebe73acb071a59a8c410cc6cd83488502f297ee1a995dbae6"
-- 
2.25.1


