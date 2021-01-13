Return-Path: <SRS0=69QN=GQ=lists.cip-project.org=bounce+64572+6082+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2197DC433E0
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 21:25:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722772225E
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 21:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722772225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6082+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id o3mAYY4521723xcUy2ybe2nH; Wed, 13 Jan 2021 13:25:28 -0800
X-Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web08.3418.1610573128257693468
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 13:25:28 -0800
IronPort-SDR: qgNjV/YzmNTsB2bBuTAwPkD8Y9Ip9TPpZuU1CG7Kf3WG4lymWxovKuOqFZySYakMth0QCCIIkW
 kKBOeYVghRrFabeTIO5Ehz6zC91Tfv1mXbpZoVYI5kQ8g0ieKeRiDbhoZ/EKXZP67HBPGUhLqk
 GTWN0Z8EuopcqJfQRWKPHqa85aj1DhUg7qqeX8dhSKWQE2X/adyHwRpCi5RliAJAwK7FE3h0I4
 nkTMTkyZOS9rjhl8qRcRC0QAa6D2jC/Vy58hIhblTDdvnGcSzH/I21JVLCkBAmZr2LDcny/gCR
 n78=
X-IronPort-AV: E=Sophos;i="5.79,345,1602576000"; 
   d="scan'208";a="57035816"
X-Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 13 Jan 2021 13:25:26 -0800
IronPort-SDR: 6v7FBXGrrLX+YLiCZ6dwcxC2/h9eF6+oi6d7SvQP7+9+YuX0WNBWdAS1bacAh5sTJN3oj65IjU
 ND06qxdMidvpawNNIwCPn8bJistng1EIGc2blnYj+ikCPmjnzSxOtZEEYrooxEMSX/jwJM24bk
 JJ7LcB/X9zenyAfzeKl73UB6B/WfuYsYVkC/7u9tv0i+v9XWxzns+H96taIKiUJm2i50ufpLQS
 36t3mAu8n41y0qjT7TSrFtFNjbienpMAzkD2TxugPifp8t6KW3x9ksoTwgyX45qanmTaN/AkOY
 U94=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <quirin.gylstorff@siemens.com>, Vijai Kumar K
	<Vijaikumar_Kanagarajan@mentor.com>
Subject: [cip-dev] [isar-cip-core][PATCH] linux-cip-common: Add files directory to FILESEXTRAPATHS
Date: Thu, 14 Jan 2021 02:55:05 +0530
Message-ID: <20210113212505.15175-1-Vijaikumar_Kanagarajan@mentor.com>
MIME-Version: 1.0
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: d9S3QtqOD9pq3dMXZqBctqhvx4520388AA=
Content-Type: multipart/mixed; boundary="6S6mEWQgxf8LiB8jImCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610573128;
 bh=EyTfRHjnACGH07xxeOlItyEW7AIRUSMutPhphZ5IKYM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=uMlAPhmVJLr8KWPnYfwmlT7rTTvZA6DFKJM/9R9AZq2AJul8A8Zjta0m5DS1lGC/oyc
 J0v6nVK6lkyReImcvZt8gi7YkNuN8nB/Sn+JcLKhKlM4V1l9Gw0w7H6zhRhcUDsbzeAI7
 7+NaFIZTGUeRMougPq97YSGyvKNHlpS4pa8=

--6S6mEWQgxf8LiB8jImCM
Content-Type: text/plain

Add recipes-kernel/linux/files directory to searchpath.

Files like preempt-rt.cfg are not accesible when you use
the linux-cip-rt-common.inc file in linux recipes defined
in other layers.
This makes the linux-cip-rt-common.inc file unusable in
other layers.

Fix that by adding recipes-kernel/linux/files to
FILESEXTRAPATHS.

Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 6db1d1d..f35168f 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -9,6 +9,8 @@
 # SPDX-License-Identifier: MIT
 #
 
+FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}/files:"
+
 KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
 
 def conditional(variable, checkvalue, truevalue, falsevalue, d):
-- 
2.17.1


--6S6mEWQgxf8LiB8jImCM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6082): https://lists.cip-project.org/g/cip-dev/message=
/6082
Mute This Topic: https://lists.cip-project.org/mt/79661830/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6S6mEWQgxf8LiB8jImCM--
