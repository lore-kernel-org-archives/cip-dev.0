Return-Path: <SRS0=NfF2=BN=lists.cip-project.org=bounce+64572+5079+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A4C433DF
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 10:12:23 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B60206D7
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 10:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Zt0ppBYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B60206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5079+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6e9bYY4521723xv9jzTBCyRb; Mon, 03 Aug 2020 03:12:23 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.8239.1596449541326609776
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2020 03:12:22 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 073ACILE030473
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2020 12:12:19 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.49.179])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 073ACHLE024687;
	Mon, 3 Aug 2020 12:12:17 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, daniel.sangorrin@toshiba.co.jp,
        jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add EFI_STUB to config
Date: Mon,  3 Aug 2020 12:12:17 +0200
Message-Id: <20200803101217.6961-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qkuJ2T2V3mXr9Q56tfdFGSTRx4520388AA=
Content-Type: multipart/mixed; boundary="Tc1PJtlG96AycrwoV9LZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596449543;
 bh=xPC7+Apfta2M5lpC6l6GGGtdHeEHsBjpmEHftjNLwFw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Zt0ppBYoGWrIByJZ+oiMoao3CNsOlyTL6eUZdF3WdsA0XliyzLyumXsHCXcHVGZgnTU
 /ZPM57xseSPK+O4EkYOaoEh0jrtNBuEYTs7/raH6iERFKfylMs+HubsVp7e/67brmBy6x
 AR4R5HGPJpfdxC+vOL9uqZi1H6vazz8L4ks=

--Tc1PJtlG96AycrwoV9LZ
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If EFI_STUB is not active booting QEMU with OVMF efi will fail
with the following error message `KVM internal error. Suberror: 3`.

OVMF efi is used in isar-cip-core to demonstrate secure-boot with
a unified kernel image.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 4.19.y-cip/x86/cip_qemu_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/4.19.y-cip/x86/cip_qemu_defconfig b/4.19.y-cip/x86/cip_qemu_defconfig
index 02732ae..8c05b4f 100644
--- a/4.19.y-cip/x86/cip_qemu_defconfig
+++ b/4.19.y-cip/x86/cip_qemu_defconfig
@@ -30,6 +30,7 @@ CONFIG_X86_CHECK_BIOS_CORRUPTION=y
 # CONFIG_MTRR_SANITIZER is not set
 CONFIG_EFI=y
 CONFIG_HZ_1000=y
+CONFIG_EFI_STUB=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
 CONFIG_HIBERNATION=y
-- 
2.20.1


--Tc1PJtlG96AycrwoV9LZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5079): https://lists.cip-project.org/g/cip-dev/message=
/5079
Mute This Topic: https://lists.cip-project.org/mt/75962579/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Tc1PJtlG96AycrwoV9LZ--
