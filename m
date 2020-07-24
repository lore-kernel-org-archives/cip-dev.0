Return-Path: <SRS0=zL0g=BD=lists.cip-project.org=bounce+64572+5003+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBD8C433E8
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:01:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE602074B
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="J1V2+6lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE602074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5003+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fqjtYY4521723xdXrK83pDpU; Fri, 24 Jul 2020 08:01:52 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web11.7923.1595602910267547655
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 08:01:50 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 06OF1mXY020633
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2020 17:01:48 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.3.170])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 06OF1lbm027266;
	Fri, 24 Jul 2020 17:01:47 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v3 1/6] kernel: add fat for qemu-amd64
Date: Fri, 24 Jul 2020 17:01:42 +0200
Message-Id: <20200724150147.8253-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200724150147.8253-1-Quirin.Gylstorff@siemens.com>
References: <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
 <20200724150147.8253-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vt8xQIhiaqbq8byy8YnDDJngx4520388AA=
Content-Type: multipart/mixed; boundary="nWSW5Jtc2zds9ASUkVU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595602912;
 bh=/+FYiwEZ7CpabHxTGFAgX4zaCwQuL1vmb7Z6jJXnOb8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=J1V2+6lzfhUmJitSfQeaSLazqWblJ1zdlu4yr51G2H1nCSCus8O0iBLyn0XkcMrbOt+
 iEoP7Rm/iIzUOv0BuWpLHUihY4AOYBWiB55cYu3blIV76xvdoRn5mv89DXeZeyAI2p4bu
 BXTbbcaMFVUzye4LaTwCxhfYAbWBCSjh5uM=

--nWSW5Jtc2zds9ASUkVU7
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


--nWSW5Jtc2zds9ASUkVU7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5003): https://lists.cip-project.org/g/cip-dev/message=
/5003
Mute This Topic: https://lists.cip-project.org/mt/75767901/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nWSW5Jtc2zds9ASUkVU7--
