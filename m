Return-Path: <SRS0=r1AO=AG=lists.cip-project.org=bounce+64572+4823+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1BFC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B532065F
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EGsYaYRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B532065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4823+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 61rRYY4521723x59A4g9s08A; Thu, 25 Jun 2020 07:10:21 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.11411.1593094219592760648
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 07:10:20 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 05PEAHMN026959
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 16:10:18 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05PEAFXU000356;
	Thu, 25 Jun 2020 16:10:17 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core RFC 1/7] kernel: add fat for qemu-amd64
Date: Thu, 25 Jun 2020 16:10:09 +0200
Message-Id: <20200625141015.31719-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dDK9gvfQZtt1kPt54x1PaKYbx4520388AA=
Content-Type: multipart/mixed; boundary="0hrWgzztZxpdn56zJ4Y0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593094221;
 bh=926fQKxoHjqCuTJhtZoF+FssvaG0awseGFrCF77qFdo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EGsYaYRmm50Wnu2RJzlAjdxEWrkUIO4dBVsugJkn/zNeJQ9Btj0DiywMBQObP+JTkce
 1+YPx7nyAzv0dAND54d/luR+7JQEarshz2cTdLs6NoElYigt/eFNioxHF6yroMVYeV5N7
 ISW/GKfUj+SVc8GiP1C2ynNBTXlPzqEMHyw=

--0hrWgzztZxpdn56zJ4Y0
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add a fat configuration to access FAT Partitions on the qemu-amd64
target.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/files/qemu-amd64_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/recipes-kernel/linux/files/qemu-amd64_defconfig b/recipes-kernel/linux/files/qemu-amd64_defconfig
index 7487152..5449317 100644
--- a/recipes-kernel/linux/files/qemu-amd64_defconfig
+++ b/recipes-kernel/linux/files/qemu-amd64_defconfig
@@ -351,3 +351,9 @@ CONFIG_CRYPTO_DEV_CCP=y
 # CONFIG_XZ_DEC_ARM is not set
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
-- 
2.20.1


--0hrWgzztZxpdn56zJ4Y0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4823): https://lists.cip-project.org/g/cip-dev/message=
/4823
Mute This Topic: https://lists.cip-project.org/mt/75103449/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0hrWgzztZxpdn56zJ4Y0--
