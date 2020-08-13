Return-Path: <SRS0=eO76=BX=lists.cip-project.org=bounce+64572+5116+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29600C433E3
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:08 +0000 (UTC)
Received: from web01.groups.io (unknown [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764F421744
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hq9dyIcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764F421744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5116+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yQRNYY4521723xn1SEnckwsU; Thu, 13 Aug 2020 04:42:59 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.5066.1597301347193284425
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2020 23:49:07 -0700
X-IronPort-AV: E=Sophos;i="5.76,307,1592838000"; 
   d="scan'208";a="54496358"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 13 Aug 2020 15:49:03 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.189])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DF4684009BE9;
	Thu, 13 Aug 2020 15:49:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: defconfig: Restore debugfs support
Date: Thu, 13 Aug 2020 07:49:00 +0100
Message-Id: <20200813064900.7509-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pHQsHR8LhbBLWuxVyrT2NauBx4520388AA=
Content-Type: multipart/mixed; boundary="jkHIz8fAaWhrqNoPXvax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597318979;
 bh=4i6nI6czRX+NUbiDSR4oGzFzN3m8C7Q4J3fSDD2HCgM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hq9dyIcl+dN5nfj6vcD63bH3bZzSDWU+VJRGUtekmmTQYnpvt6fwiSokJ71RK0Np25L
 U5jn1PyGB7YMyegx3tSTZPVWbr+QwMamdhGjlt69dz47s+S9sFlauSsHtHd5WKurCPCS2
 jkWinMJh3vC6dvZUWrzqm/jO2+w3T5VTE7s=

--jkHIz8fAaWhrqNoPXvax
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit fa2cdb1762d15f701b83efa60b04f0d04e71bf89 upstream.

Since commit 0e4a459f56c32d3e ("tracing: Remove unnecessary DEBUG_FS
dependency"), CONFIG_DEBUG_FS is no longer auto-enabled.  This breaks
booting Debian 9, as systemd needs debugfs:

    [FAILED] Failed to mount /sys/kernel/debug.
    See 'systemctl status sys-kernel-debug.mount' for details.
    [DEPEND] Dependency failed for Local File Systems.
    ...
    You are in emergGive root password for maintenance
    (or press Control-D to continue):

Fix this by enabling CONFIG_DEBUG_FS explicitly.

See also commit 18977008f44c66bd ("ARM: multi_v7_defconfig: Restore
debugfs support").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20191209101327.26571-1-geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 151fad5c0b8d..865d1696109f 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -226,3 +226,4 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
+CONFIG_DEBUG_FS=y
-- 
2.17.1


--jkHIz8fAaWhrqNoPXvax
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5116): https://lists.cip-project.org/g/cip-dev/message=
/5116
Mute This Topic: https://lists.cip-project.org/mt/76163657/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--jkHIz8fAaWhrqNoPXvax--
