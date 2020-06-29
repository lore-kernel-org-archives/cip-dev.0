Return-Path: <SRS0=s8dL=AK=lists.cip-project.org=bounce+64572+4857+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1118C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 12:54:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE2323D23
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 12:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lG81Msaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE2323D23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4857+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rAVIYY4521723xBYIi7locAj; Mon, 29 Jun 2020 05:54:05 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.17925.1593435243039191799
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 05:54:03 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 05TCs1ma007970
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 14:54:01 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.4.33])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05TCs0ce027155;
	Mon, 29 Jun 2020 14:54:01 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v2 1/6] kernel: add fat for qemu-amd64
Date: Mon, 29 Jun 2020 14:53:55 +0200
Message-Id: <20200629125400.13968-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
 <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: L4HjirdDCB02b3YOwyUnuKZSx4520388AA=
Content-Type: multipart/mixed; boundary="t8DoDJ3QITZbWgykyLUV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593435245;
 bh=H2Uvnv6ZlP2UnebxGRPOElcyYC9GzW4x2tkRcNf1lq0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lG81MsazZFOCGDSs38Kbzd1G6KP7w2/ynbpC/rpU8lM591vM1NCethsAyMawqVVD4OX
 Ns+pnA83oMMvIKr53uvnHd/lpdB5qex/DfgPRfy2V1wzYQVwDu60pocGedOTh3B1sIw3/
 Yql8KKb8vbW/hf5ydPFgUl6hVUWG6v6ic+4=

--t8DoDJ3QITZbWgykyLUV
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


--t8DoDJ3QITZbWgykyLUV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4857): https://lists.cip-project.org/g/cip-dev/message=
/4857
Mute This Topic: https://lists.cip-project.org/mt/75190451/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--t8DoDJ3QITZbWgykyLUV--
