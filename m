Return-Path: <SRS0=YvLG=LI=lists.cip-project.org=bounce+64572+6508+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FECC48BE6
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 07:36:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C522060241
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 07:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C522060241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6508+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vqdFYY4521723xewlP5vkHu0; Mon, 14 Jun 2021 00:36:36 -0700
X-Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web11.27024.1623656195795030719
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jun 2021 00:36:35 -0700
IronPort-SDR: eMvj5ZVOebRfIOHdIfAIY7FFUU6RF5b1VTloHpuMF7VblzN7Tn3fLK3tVWqmmnDA8NOmsWBp1y
 QcdPy+ReZkooqGLfn++RaFATsbXArXxXfci0uKMqOFpyVtAnhYvUgwWZRAoA5R15hwI4/lDL5B
 jjvRhDevrMtEm9vjLHbnCnhEajFilCzF5DKQCuvFbV3PxG1PfLY1qtzNdMPkAQlQ4dd77r+syc
 hKW1Su7DYykfshfxF0WQsSrKE89wXwbmSo3VKFhPiKXuLER1QCQkaf9DGTbHA3BSpzMuPcBqv6
 1g4=
X-IronPort-AV: E=Sophos;i="5.83,272,1616486400"; 
   d="scan'208";a="62510428"
X-Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 13 Jun 2021 23:36:34 -0800
IronPort-SDR: OI8gOZ718tYdebbEqXLj/ipz09PauVgpHh325v/fXmP8/lkmO8hO5dbXhszK4SM3F4p0j5bbhb
 r2brsdceqW4I1Lk1cmKkue4qTTCNfB+gbLbxL+IvMN0PUDqKS1+B9pfzVHTubf48U/BfWdhdys
 dW221zZnqv4DKWRcAt8Jchn5mLtJDlZX5RA+2YrderxUxxe7Pum/byCGMIYfF1luPqnND7r+Ld
 42b0wULLAuivJfarTbMM7GNg1y8wwen2jQ7wwvD5/hEDJI8jgYak4PMjCRNBj41r4AiJOtPB6L
 sOE=
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev] [isar-cip-dev][PATCH] linux-cip-common.inc: Uprev the cip-kernel-config
Date: Mon, 14 Jun 2021 13:06:09 +0530
Message-ID: <20210614073609.1192915-1-Srinuvasan_A@mentor.com>
MIME-Version: 1.0
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: He6H5kDhPJZgfNfl3bhEXAT0x4520388AA=
Content-Type: multipart/mixed; boundary="8RaOikJwUPGQOXvga9xl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623656196;
 bh=TYboane63s4m/HO297K/X0kjorYxNafRSlhzaJ0VZeo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Us79yZOJMnxWXx95HVO25Rk5CyoZdxkKeJXKcy4RRWUbZXLp6OcNcjFNhPdKCWXUx2M
 7+mVCcL35qmF5zwbOYAzia94Wuy6ZaIqTeGRvnPPz2Qz5hzAZp0Kpps8K6KhD+9HKkN3y
 sv8Jnz3hNpKthQaL1jPh9EgHSMGrdgqp8w8=

--8RaOikJwUPGQOXvga9xl
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Srinuvasan A <srinuvasan_a@mentor.com>

Bump the cip-kernel-config revision for brings the Message Queue
support.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 464144c..021efcd 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
 
 SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
-SRCREV_cip-kernel-config ?= "f6ca8092aeafe22463bcaca17f26c284b15038d0"
+SRCREV_cip-kernel-config ?= "9fa9154c77ee8eeca534aa436c23582c0c59c39f"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
-- 
2.25.1


--8RaOikJwUPGQOXvga9xl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6508): https://lists.cip-project.org/g/cip-dev/message=
/6508
Mute This Topic: https://lists.cip-project.org/mt/83525386/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8RaOikJwUPGQOXvga9xl--
