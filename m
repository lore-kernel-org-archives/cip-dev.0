Return-Path: <SRS0=xvSi=OY=lists.cip-project.org=bounce+64572+6775+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C23C433F5
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 13:27:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE49861153
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 13:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE49861153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id m4kuYY4521723xn279ZDfx1G; Mon, 04 Oct 2021 06:27:18 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.9306.1633354037133830357
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 06:27:17 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 194DRE0v003773
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Oct 2021 15:27:14 +0200
X-Received: from md2dvrtc.fritz.box ([139.22.41.233])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 194DRDNo019631;
	Mon, 4 Oct 2021 15:27:13 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com,
        jan.kiszka@siemens.com
Subject: [cip-dev] [PATCH v2] kas/opt/swupdate: Change assignment of IMAGE_TYPE and WKS_FILE
Date: Mon,  4 Oct 2021 15:27:13 +0200
Message-ID: <20211004132713.1827767-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <be00776f-c1c5-9c84-c904-2d8e17cc298d@siemens.com>
References: <be00776f-c1c5-9c84-c904-2d8e17cc298d@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xhikSInHFie8JQ3rUQputtUEx4520388AA=
Content-Type: multipart/mixed; boundary="Pop5HOL6zKGKvpukvkMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633354038;
 bh=E6TI7GgLp58hE2Jm22xgBFsTZbF/fTrqASio8CgJyEI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=XTxi1vSibY9GgBVKS6qOXQxPGx4XTuCURzZRRfp2vMdHkZTEMErmoVx21n4xhr9ePuh
 7bUDQn/zHshkaAH8UNAgMByItY0MBDxMgWgpOX7DS5YLfrYQ+Y05I+5ez0xZvwqMyW5Uc
 q1xnj76pQA4I/xUALuv/DhuIFBydHgH04To=
Message-ID: <20211004132713.1pD4Tn_o_EIvb6768Oq-kKwaQ_HfPcHKbq2dNp9yQKI@z>

--Pop5HOL6zKGKvpukvkMl
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Replace the default assignment to ensure the generation of the
swu file. As stated in [1]: If multiple `?=` assignments are used
the first of those assignments ends up getting used.

This fixes [2].

[1]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value
[2]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 7d86ad5..bd0f6e4 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -19,5 +19,5 @@ local_conf_header:
     IMAGE_INSTALL_append = " swupdate"
 
   wic-swu: |
-    IMAGE_TYPE ?= "wic-swu-img"
+    IMAGE_TYPE = "wic-swu-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
-- 
2.30.2


--Pop5HOL6zKGKvpukvkMl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6775): https://lists.cip-project.org/g/cip-dev/message/=
6775
Mute This Topic: https://lists.cip-project.org/mt/86066250/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Pop5HOL6zKGKvpukvkMl--
