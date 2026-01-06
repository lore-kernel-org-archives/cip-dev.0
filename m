Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB8CDC17A
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88503.1767701186761134810
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AkIkgWTI;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so7511985e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701185; x=1768305985; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ/A/NidVuKj4W+YRuICrnezFPQtRlzqudUC8/PT9LM=;
        b=AkIkgWTI3hvNXDJZhIMPnb+duXmiNTHQ/pRjtRdtmHOTs7U4vkYkdJcGxnxVujGfuT
         q34CMuesk9xiiAdUq18YdEv874htHywFWzQ7FXDATbgXBSeCIOQo4KJtak0x38866jy8
         iBQEqgOa4g7CHc/wxj/GDCjtvfPQlGJRcFKFTNAvz1TodhkXP9B0WzdwcrS8BVIF3s4k
         0b98MRKX1ueu7XVMzPYhtomvFAas1FCvv63DUdIi2CUnOLtJWYRWZePTCyklcJB8BtyC
         na/ODNGQCl0vD0paR0T8k4YvnaL7e9GvCcRN7+JG66LjAHVUHbSH6SIbhFh5IAMVD8SO
         3ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701185; x=1768305985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fJ/A/NidVuKj4W+YRuICrnezFPQtRlzqudUC8/PT9LM=;
        b=bUDlTflmGtv47ydt2CGfpuZd2BtxD4cqQJ+rXL4vXGWEyseqkav3JVtX1u65Feumva
         2Lv1OUSqbrEn6oFNOXUtB4tSW4fgh8FxAnWv73lTvPjNWdQT6Nll3V1gUtXBvGVRqQg4
         j7lYZWyFnSbwBsUU7+rR+QYgrKtrTmNYaC6diK3c7FWCm2u/XR6+hdBfgoN0IcNDLUq+
         IgBsUzBpMFS+OPLcwCvf24+Q8DCKgnwrBT5BtZWMjZaMschrNAu3xs4unPmhRrk0aXO/
         nJFZhz8gs/JuCzDmXAA9LbQ7p8ug1mJxlzLhCRZdhjWHfP8M0ZgylH+rlAe4wl5rpnEj
         0xmQ==
X-Gm-Message-State: AOJu0YznwTZwuwx3H+DpPdsSpwtHfS57/eMFpSDVMFi9s+b2D3o27kY9
	NDVeg04OOIYH1rDuw7ONB2dybqk3JKP3UJHlJHfVI1O6XAe9En5QuOW9b3WQXw==
X-Gm-Gg: AY/fxX4tp7bKwUf2B204FzWThKXdsKVt+lVEBURuhgsaCwyECs2sOjIyItKTs01GuWX
	vW96x/eVtyrWleITQd9ONlXRI9PgWH9CghygMh1Uv+0rSvRr87fRNdd/csVHXJPu2P+hyS30Kgc
	gWE1ed+n3v7wUg0qfLHJdZcsk1M//9GlZ0NpfDNrRU/RLS4eVBk7TB2h3BjByP+Br4i/vRTYxYp
	IaAoJQuL2BBQAltu/QGOXamdjRw3NsXoFZSeN3CQizr8OgAS0eF1EnyS6hlJGvrJVoWr4fjHlx1
	h7fUPMEsvZsxLiVLA2u1pZZBsR0Rae7KownxZ0PCCIUhLdO2mU7SZYEPcjgEwnttfqUhdrnRAI2
	4AcPPs2Di2V4DAtbkEFrK1UOVo1TduQZnU1AtVZHgjYkVCktghKobK1t7nzE7+YjPkoZXcUIbEF
	nvpMRnwEfYsjzHSWfsdw==
X-Google-Smtp-Source: AGHT+IE2/f5gs12uL4fjTVZ2pspbqgs3wN9qkUUeUGP/6ggoxoTQlMWe79eY8MTjWjR3bJMFtrn/JQ==
X-Received: by 2002:a05:600c:5297:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d7f063147mr35764975e9.3.1767701184854;
        Tue, 06 Jan 2026 04:06:24 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:24 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 12/13] arm64: dts: renesas: r9a09g047e57-smarc: Fix gpio key's pin control node
Date: Tue,  6 Jan 2026 12:06:09 +0000
Message-ID: <20260106120618.181104-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21372

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3e5df910b592d47734b6dcd03d57498d4766bf6c ]

Adding pin control node to the child won't parse the pins during driver
bind. Fix the issue by moving it to parent node.

This issue is observed while adding Schmitt input enable for PS0 pin on
later patch. Currently the reset value of the PIN is set to NMI function
and hence there is no breakage.

Fixes: 9e95446b0cf9 ("arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250817145135.166591-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index ae4f35298036..fbcccf075b3a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -92,10 +92,10 @@ &i2c0 {
 };
 
 &keys {
-	key-sleep {
-		pinctrl-0 = <&nmi_pins>;
-		pinctrl-names = "default";
+	pinctrl-0 = <&nmi_pins>;
+	pinctrl-names = "default";
 
+	key-sleep {
 		interrupts-extended = <&icu 0 IRQ_TYPE_EDGE_FALLING>;
 		linux,code = <KEY_SLEEP>;
 		label = "SLEEP";
-- 
2.43.0


