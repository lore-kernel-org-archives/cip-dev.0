Return-Path: <SRS0=8NAb=CS=lists.cip-project.org=bounce+64572+5429+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE11C31E51
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F0F21D43
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 04:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gspphJNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F0F21D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5429+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id J4tEYY4521723xMaIF0nqb3H; Tue, 08 Sep 2020 21:44:47 -0700
X-Received: from wens.tw (wens.tw [140.112.194.72])
 by mx.groups.io with SMTP id smtpd.web11.6577.1599626683757804090
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 21:44:44 -0700
X-Received: by wens.tw (Postfix, from userid 1000)
	id 24AB5601E8; Wed,  9 Sep 2020 12:44:33 +0800 (CST)
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	JohnsonCH.Chen@moxa.com,
	victor.yu@moxa.com,
	wens@csie.org
Subject: [cip-dev] [PATCH 4.4.y-cip 10/11] ARM: omap2plus_defconfig: Enable support for ti-cpufreq
Date: Wed,  9 Sep 2020 12:42:32 +0800
Message-Id: <20200909044233.4115-11-wens@csie.org>
In-Reply-To: <20200909044233.4115-1-wens@csie.org>
References: <20200909044233.4115-1-wens@csie.org>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: I8LXx0Odb4Wi6mXgn1pEfZhvx4520388AA=
Content-Type: multipart/mixed; boundary="TLgKvqlpCT6tdrzFS3GX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599626687;
 bh=Qq1l35iqp+UI3pHNy0Gwyjs0rxu/eq2n4pRbftPuEbY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=gspphJNBpP7UnOGboFrM0zWa53WLi6c/A6ZQ6WmApX1wrclSNK+9AW82QBDzJjAoJVe
 An00tyC34nl7cIJM7M6LjW/GcvqpgIrgmbHGCJ61bN5Ppb59G82WEAGyc1sVid1C1+nDg
 pFAtsZlVTDa/a7VwX5H4g/1gMzEAjIzTTtQ=

--TLgKvqlpCT6tdrzFS3GX
Content-Transfer-Encoding: quoted-printable

From: Dave Gerlach <d-gerlach@ti.com>

commit 69c8ab148006a2ec7ac1a1f08945e95febc1c132 upstream.

AM335x, AM437x, DRA7xx, and AM57xx platforms all now depend on
ti-cpufreq driver to enable proper OPPs for use with cpufreq, so
enable the same.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Reviewed-by: Lukasz Majewski <lukma@denx.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap=
2plus_defconfig
index 09ebd37e01e02..c6eec207dcbd8 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -69,6 +69,7 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
 CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
 CONFIG_CPUFREQ_DT=3Dy
+CONFIG_ARM_TI_CPUFREQ=3Dy
 # CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
 CONFIG_CPU_IDLE=3Dy
 CONFIG_BINFMT_MISC=3Dy
--=20
2.28.0


--TLgKvqlpCT6tdrzFS3GX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5429): https://lists.cip-project.org/g/cip-dev/message=
/5429
Mute This Topic: https://lists.cip-project.org/mt/76726433/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--TLgKvqlpCT6tdrzFS3GX--
