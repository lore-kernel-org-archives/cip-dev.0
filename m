Return-Path: <SRS0=GH8n=CJ=lists.cip-project.org=bounce+64572+5338+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD3DC433E7
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:21:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC04F20936
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 09:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="uAvVAa6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC04F20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5338+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sGyGYY4521723xUzt8qgduBg; Mon, 31 Aug 2020 02:21:28 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.49630.1598865687240013134
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 02:21:27 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07V9LOm7025226
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2020 11:21:24 +0200
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.39.104])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07V9LMgR030412;
	Mon, 31 Aug 2020 11:21:24 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH 3/3] linux-cip Switch to gitlab source and update to 4.19.140-cip33
Date: Mon, 31 Aug 2020 11:21:22 +0200
Message-Id: <162be0421d8f27072b2476f95c6d2df9aa09b5f6.1598865682.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1598865682.git.jan.kiszka@siemens.com>
References: <cover.1598865682.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6Grji4hN3UZSjfn2z1iowXyVx4520388AA=
Content-Type: multipart/mixed; boundary="BBYXSqfI4JY4Dn5i2M3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598865688;
 bh=ihmyzVREAlXbD00JQRLlgJgRLlI0/RBsJP0dvPKus3o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uAvVAa6B4FJ/9/tPQIPUlQqeSmFfwuwvLsFVl1piSX6oWdFZuU3lw1S4s/kpVUkG14u
 04dMFXDP3KjjDY7hVlBtc6aLeOT83/s1+J4Ti1lqgOycl5EZlVJ41t/F232SM6UxXKiTx
 YatUpIINxts5WDCzktxsbgedYRspI34C+7c=

--BBYXSqfI4JY4Dn5i2M3C
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

The switch is needed as kernel.org snapshot tend to fail too often.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc                     | 4 +++-
 recipes-kernel/linux/linux-cip-rt-common.inc                  | 2 --
 recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb      | 2 +-
 recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb       | 2 +-
 ...inux-cip_4.19.138-cip32.bb => linux-cip_4.19.140-cip33.bb} | 2 +-
 recipes-kernel/linux/linux-cip_4.4.230-cip47.bb               | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.138-cip32.bb => linux-cip_4.19.140-cip33.bb} (67%)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 0c76835..7e09090 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -20,10 +20,12 @@ def conditional(variable, checkvalue, truevalue, falsevalue, d):
 require recipes-kernel/linux/linux-custom.inc
 
 SRC_URI += " \
-    https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-${PV}.tar.gz \
+    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/archive/v${PV}/linux-cip-v${PV}.tar.gz \
     "
 
 SRC_URI_append = " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", \
     "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config", \
     "file://${KERNEL_DEFCONFIG}",d)}"
 SRCREV_cip-kernel-config ?= "ca24d965adf77730caf1cd32bdfcffd69e369502"
+
+S = "${WORKDIR}/linux-cip-v${PV}"
diff --git a/recipes-kernel/linux/linux-cip-rt-common.inc b/recipes-kernel/linux/linux-cip-rt-common.inc
index d182358..dffb77b 100644
--- a/recipes-kernel/linux/linux-cip-rt-common.inc
+++ b/recipes-kernel/linux/linux-cip-rt-common.inc
@@ -13,8 +13,6 @@ require linux-cip-common.inc
 
 SRC_URI += "file://preempt-rt.cfg"
 
-S = "${WORKDIR}/linux-cip-${PV}"
-
 do_prepare_build_prepend() {
     cat ${WORKDIR}/preempt-rt.cfg >> ${WORKDIR}/${KERNEL_DEFCONFIG}
 }
diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb b/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
index 7414f23..820c1ab 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt13.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "3c3e49c4ad0dae3de409d51a5b8f6df163f7cc54350764d7c019741947a383db"
+SRC_URI[sha256sum] = "b827f45b8f97b71b3917c84b43fd6593030d01ea7261d3be6c15a76250308743"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb b/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
index 8881071..e13fc14 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt30.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "d1ff83665455830129f9a2197000abbe7440d30e29b37504c82324c777f0ebf5"
+SRC_URI[sha256sum] = "e7a0c7b8e4d91f52cbc2ee17a546d1afbc5fcfed95ba44dd113e534fab3a157e"
diff --git a/recipes-kernel/linux/linux-cip_4.19.138-cip32.bb b/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb
similarity index 67%
rename from recipes-kernel/linux/linux-cip_4.19.138-cip32.bb
rename to recipes-kernel/linux/linux-cip_4.19.140-cip33.bb
index 59afd8e..9e958c0 100644
--- a/recipes-kernel/linux/linux-cip_4.19.138-cip32.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "6b4dce2ff494b9a4cab212af855b78048756dc6ea3f136e25552b0e832e93eb6"
+SRC_URI[sha256sum] = "f6a9aec6848a5897c90bafda5a9eba010c03d5d0cf99508adfb1cf7a2f4af9e5"
diff --git a/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb b/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
index 2303d49..af49441 100644
--- a/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "8e91374801da67bc240b08cd0d61a1b528c23c870cf73ba33cc8f02198f6c531"
+SRC_URI[sha256sum] = "3ff33e497064ba8e7d9b5e1ee575c6a936154fa8216774782cbc0db2e4b71cdf"
-- 
2.26.2


--BBYXSqfI4JY4Dn5i2M3C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5338): https://lists.cip-project.org/g/cip-dev/message=
/5338
Mute This Topic: https://lists.cip-project.org/mt/76530564/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BBYXSqfI4JY4Dn5i2M3C--
