Return-Path: <SRS0=32sm=O2=lists.cip-project.org=bounce+64572+6792+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17311C433EF
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 10:14:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D76E60FF2
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 10:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D76E60FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JfExYY4521723xD0wKWX3ZQv; Wed, 06 Oct 2021 03:14:51 -0700
X-Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web10.9951.1633515290609365409
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 03:14:50 -0700
IronPort-SDR: lGCmMU3nvDyTvNhGsDwCdqWVFqsZJzLwrZgJTg50q9h7Rm4rW4YAatA54xhb/C+2O/9PpSIH7k
 VqHgGmokDsN6Ho0uZoUqi2i+UNvyZqNpRixY6qcr0zsBq9QHPDoC8xFBg2z1/dYhMoEweCtUpR
 0cbmv/k1ejSObCHWCaljEHCKNkwJ2c3cVnoiWnoeUKTVSkJ1AiFHGBQnaaneDFAcvo6an5mGVb
 9pbWN427Dj9i9rvMI0BZYH2VS05/jQcGLq6VE3hfBmRmN1LPo9uWh4HK4WdavgLM6yPqh+k5mA
 7jYiLzz+u+12PnbvjiS28Vsw
X-IronPort-AV: E=Sophos;i="5.85,350,1624348800"; 
   d="scan'208";a="69276314"
X-Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 06 Oct 2021 02:14:49 -0800
IronPort-SDR: gCf+CIWB6+br2pHVqQ6YY5JY6RqKUqdPgp7lcKAaZNqZ2XxBsv4qPi2S4JGx6xzEfo5wgJsr5G
 PQVtzayBJKEEtNHpPZKgWJyawQpc/GBe/5C+tFZll8OhodakItain1ti5vmqpSUCfYNRLnFiY3
 C6x9mkiuG6fXWL99IMT3Kqek1hglhysGJAWDbgosAmm/rP/KCHj7+Q/wVOECC2VITM53q3rJwm
 2pdHM2NgTrXTOMKfzdBcJndz4xi5Jz0fnyaEYXlztXDyeTs8rxp2grqz/TZ4UAjYEl1h0yNGki
 i6o=
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev] [isar-cip-dev] [PATCH] Uprevision the ISAR to latest one
Date: Wed, 6 Oct 2021 15:44:22 +0530
Message-ID: <20211006101422.1976005-1-Srinuvasan_A@mentor.com>
MIME-Version: 1.0
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: o9atZrIjPN1Yy3ZiXa6bQU3Cx4520388AA=
Content-Type: multipart/mixed; boundary="ChBhW2nCypa7OrcKSoy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633515291;
 bh=nljIjJn+AwMbF7Kwhnihl4ADyFd9y03pp5ub2CYBe5s=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=CYoQrzwtFNDwEEtlxh60SywBpLlQPenAG687bc1d58+aaZy3m3SzxcZs2YJGV8LlCHG
 MxXh27AiMj9YHKyavRgYa6tq89181FqXPygQpHIPpJIAqs8mbuDprnlw1n9qUPUaW+yH+
 ejxrqg4sUFBQBXhK3R1kjIzf1cxv5ToB9Xk=
Message-ID: <20211006101422.QmLVbhCDQekIN7px6u0Kqwl3M1U0uhft10caExsgjFk@z>

--ChBhW2nCypa7OrcKSoy0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update to latest ISAR.

When we build the images with efibootguard wic plugin it is expecting
the KERNEL_IMAGE and INITRD_IMAGE variable, but it is removed in
Upstream ISAR due to cleanup the unused variables.

Ref: https://github.com/ilbers/isar/commit/6fa0197ac36a86b2ae5c27f5b7804dd9a46d3c0b

But those variables we used in downstream layer with efibootguard wic
plugin hence added required WIC variables in efibootguard.yml to genereate successful wic images.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 kas-cip.yml              | 2 +-
 kas/opt/efibootguard.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 8522957..4eadaa7 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 03124cca669f50b682336a0bdf4ede5a4238e144
+    refspec: 9b31dae3284127d4aed4b9331af1b1c3c31152f5
     layers:
       meta:
 
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 705a76d..580c315 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -22,7 +22,7 @@ local_conf_header:
 
   efibootguard-wic: |
     WDOG_TIMEOUT ?= "60"
-    WICVARS += "WDOG_TIMEOUT"
+    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
     IMAGE_TYPE ?= "wic-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
 
-- 
2.25.1


--ChBhW2nCypa7OrcKSoy0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6792): https://lists.cip-project.org/g/cip-dev/message/=
6792
Mute This Topic: https://lists.cip-project.org/mt/86115871/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ChBhW2nCypa7OrcKSoy0--
