Return-Path: <SRS0=TNiU=LI=lists.cip-project.org=bounce+64572+6510+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA30CC48BE6
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 10:31:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734F6611CA
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 10:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734F6611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6510+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aQFmYY4521723x5gkr92YV7H; Mon, 14 Jun 2021 03:31:00 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.28132.1623666658977640991
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jun 2021 03:30:59 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 15EAUt98010746
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jun 2021 12:30:56 +0200
X-Received: from [139.25.68.37] ([139.25.68.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 15EAUtBh019804;
	Mon, 14 Jun 2021 12:30:55 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] efibootguard: Set a non-zero default timeout
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
        "A, Srinuvasan" <Srinuvasan_A@mentor.com>
Message-ID: <44e0f50c-4e8c-8db7-ff7a-9796aa5ade93@siemens.com>
Date: Mon, 14 Jun 2021 12:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lBRZ2jJX7DDDRdVG3ehNx7rFx4520388AA=
Content-Type: multipart/mixed; boundary="8EqJ1fZOelW9w3TebQjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623666660;
 bh=onq+WpOCP6kwsCohK9FBPn/M/6osKNzjXprPXwQwrAc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qNusZy7Pse6TiHgEb9dN5cbjKzkw1fA6R5itv3V0iVmypCvYjZAvNWBiXZVrBppNBm7
 1LMr1joNHJBoSsGXzsO56g/qjyUS7Y/a2jSJko3TLMuYi0UuTV0g+LSCifqwy/in9fH24
 MnTWdUK5h9P9w3nTP9OmCtN69DURVJbw3/g=

--8EqJ1fZOelW9w3TebQjR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

From: Jan Kiszka <jan.kiszka@siemens.com>

This was zero by default because of problems with the iTCO support for
QEMU. Those are fixed now with v0.8.

Also permit overriding WDOG_TIMEOUT from now on.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/efibootguard.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index d5a0e39..705a76d 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -21,7 +21,7 @@ local_conf_header:
     SWUPDATE_BOOTLOADER = "efibootguard"
 
   efibootguard-wic: |
-    WDOG_TIMEOUT = "0"
+    WDOG_TIMEOUT ?= "60"
     WICVARS += "WDOG_TIMEOUT"
     IMAGE_TYPE ?= "wic-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
-- 
2.26.2


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--8EqJ1fZOelW9w3TebQjR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6510): https://lists.cip-project.org/g/cip-dev/message=
/6510
Mute This Topic: https://lists.cip-project.org/mt/83526699/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8EqJ1fZOelW9w3TebQjR--
