Return-Path: <SRS0=2IVU=HD=lists.cip-project.org=bounce+64572+6158+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB433C433E0
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 16:24:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777F564DAF
	for <cip-dev@archiver.kernel.org>; Mon,  1 Feb 2021 16:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777F564DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6158+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id p7dGYY4521723xAeQOEYUaBq; Mon, 01 Feb 2021 08:24:33 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.36634.1612196668045931441
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Feb 2021 08:24:29 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 111GOQAC032296
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 1 Feb 2021 17:24:26 +0100
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.15.10])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 111GOPdj017026;
	Mon, 1 Feb 2021 17:24:25 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 1/2] swupdate: Secure-boot fix paths
Date: Mon,  1 Feb 2021 17:24:24 +0100
Message-Id: <20210201162425.31726-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210201162425.31726-1-Quirin.Gylstorff@siemens.com>
References: <20210201162425.31726-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aSoddSdZbD9Wl6HdyUwhPu4ox4520388AA=
Content-Type: multipart/mixed; boundary="On5Buixfh6KEPcJWJvmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612196673;
 bh=fiWZ1OTgR05tyUILl5yySwxEAqIhUzGEL4D0WMVzJwc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wgXZy4MW3JDfVsF8kERWWvnn3O6W7V/8PpzqZUHwz8xNK+EaaVT0ZEG5VWMBqj5ySrr
 6Jqgb4kLiR3AM5bmTyl+1rBM2wqq8B+PkodUGmrgffIc/MspnqJYbNP10u/WL7gQR6fI7
 7i1d72SFBRbMOyBp+9lQ6VtDHmlPucVCRNU=

--On5Buixfh6KEPcJWJvmt
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/secureboot.inc | 2 ++
 recipes-core/images/swupdate.inc   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/images/secureboot.inc b/recipes-core/images/secureboot.inc
index 3e284e0..f048497 100644
--- a/recipes-core/images/secureboot.inc
+++ b/recipes-core/images/secureboot.inc
@@ -9,6 +9,8 @@
 # SPDX-License-Identifier: MIT
 #
 
+FILESEXTRAPATHS_prepend := "${THISDIR}/files/secure-boot:"
+
 EXTRACT_PARTITIONS = "img4"
 ROOTFS_PARTITION_NAME="img4.gz"
 
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index a88ed14..6708a7e 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -9,8 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-FILESEXTRAPATHS_prepend := "${THISDIR}/files/secure-boot:"
-
 EXTRACT_PARTITIONS = "img4"
 ROOTFS_PARTITION_NAME="img4.gz"
 
-- 
2.20.1


--On5Buixfh6KEPcJWJvmt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6158): https://lists.cip-project.org/g/cip-dev/message=
/6158
Mute This Topic: https://lists.cip-project.org/mt/80289769/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--On5Buixfh6KEPcJWJvmt--
