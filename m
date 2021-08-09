Return-Path: <SRS0=NzJQ=NA=lists.cip-project.org=bounce+64572+6663+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B2C4338F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Aug 2021 10:29:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D23E6108F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Aug 2021 10:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D23E6108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OZjOYY4521723xKpfF1gS6x3; Mon, 09 Aug 2021 03:29:49 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.21009.1628504988761525661
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Aug 2021 03:29:49 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 179ATjqk012931
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 9 Aug 2021 12:29:46 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.4.54])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 179ATjRY026699;
	Mon, 9 Aug 2021 12:29:45 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] swupdate-config: Remove runtime dependency efibootguard-dev
Date: Mon,  9 Aug 2021 12:29:45 +0200
Message-Id: <20210809102945.17824-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AXBnY5JnGTZbrVFWStkuMI1qx4520388AA=
Content-Type: multipart/mixed; boundary="Fs6tCWr8xmwvpzAUc3kW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628504989;
 bh=VJZxvVCvVBloXnAeQuSoVAV9OtcexQxVvLkn0Mj/NNg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EK66aPQkYCm48Ixq/0Ek3+PPAxWgaUvBLcWCE7OKah9C/lytD0pifb4jyC+7VnfOhXQ
 DJuRbGLVcK9dXr81mNEbnqi9RsWHrE99RZT+Q6SviA1wHWmKlLT/NgHiAyiOPY9TRfdht
 2LuEsrGex9BEY/qI/+fyAMhUFELQx4fcC2Y=

--Fs6tCWr8xmwvpzAUc3kW
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

efibootguard-dev is only a build time dependency and
not an runtime dependency.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index dfa3579..e4879c7 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -38,7 +38,7 @@ KFEATURE_DEPS[luahandler] = "lua"
 
 KFEATURE_efibootguard = ""
 KFEATURE_efibootguard[BUILD_DEB_DEPENDS] = "efibootguard-dev"
-KFEATURE_efibootguard[DEBIAN_DEPENDS] = "efibootguard-dev"
+KFEATURE_efibootguard[DEBIAN_DEPENDS] = ""
 KFEATURE_efibootguard[DEPENDS] = "efibootguard-dev"
 KFEATURE_efibootguard[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_efibootguard.snippet"
 
-- 
2.20.1


--Fs6tCWr8xmwvpzAUc3kW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6663): https://lists.cip-project.org/g/cip-dev/message/=
6663
Mute This Topic: https://lists.cip-project.org/mt/84765287/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Fs6tCWr8xmwvpzAUc3kW--
