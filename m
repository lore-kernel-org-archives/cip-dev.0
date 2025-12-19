Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4822BD78769
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 12:29:29 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15745.1766147361855812486
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 04:29:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HWZBUzlL;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736d883ac4so307949466b.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 04:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766147360; x=1766752160; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OWyS97SHUQxhMq/ePZlzNqTXwNVXrmhVM2Dc0J+UhU=;
        b=HWZBUzlLzhipreWnMJHAalnf9lY2it/QSEqDgqhhlxY+SACMSdxYpUaixOlqISjkCL
         Q7C9eeAccTtDs3ODMuSbDh2DIW5PZlWpHGGnxZJwRMDkjADouqNr/YuDnpqjBh595SEH
         8CHCALcwcDVwv8Ohgkg2+LKpkDANmOKhLI1/pyT4pfYWiThKMM1tgsOqekezXU3N+6/o
         lgN1/RPoCdrxEXXdx2rd/0IBoKEDO29XlGBizgDsUxVhrZQSZsglPtiIKfP2zlfogyVw
         TXPuw37nNRPp+5rQxPGbQWGBDBHwH/f85SGeOx6kDuHfmnT06ky26NNcdjLrjaB3ZdXT
         vkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766147360; x=1766752160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3OWyS97SHUQxhMq/ePZlzNqTXwNVXrmhVM2Dc0J+UhU=;
        b=g2MwUKKfcUMAqbNoVpfHmt/lChblXKi3AfYY1Dj3E8aGnVMs9HoN22Tu1QayYHZubd
         sAkVhVuQFyb1ka+WQ+W5Nz2FIQlKG/GCC2GlNOZf5MyzsK80n+OD2XBU5nilzekQ3xRH
         4GIUEUi1sUKJ8L1BUJ4PsfA2dx7b6cGID1X9zmBuwXyHpBS/T+x5n+MwJVp92O3VBZwZ
         dWeHI8S7e/GpY1z/96LBzCzyoZ+RrbrlC9q6UxB5PKwJ6yptoXhoLgCqHSmN6gtYd+Ks
         EZ5x5BquRelrrim0yfRtz+HpthCsLWi23Ihdqz7a/vPHS/ZNYv+dYMk/AGEH0LtBQkLB
         h5Xg==
X-Gm-Message-State: AOJu0Yw6zV6yy1FzIZVIzFea/zLWY8+nP8MBwOGDEnGspYveTECwNvm1
	Q4qDGt630GXrL45ahZDdIwEeXlcJsLv5SfbCS4lnOgE0WWom3TsFS5i2UainfA==
X-Gm-Gg: AY/fxX51kg6EEFDiPfVj3Dtp1bQaa0O4AILfnyo9XqF3G95lOZnLJg5NZNxdVmNoh3m
	e1vkb5nKj0qHLReqqLVeDvQcvrFL9jqR6iFCIldU7+YcKxbmhfnQruNf7pab3uR1z33Dvjsd1uV
	eutIpBmxp7e7x1NTB5PlqZU+Zdno0cM9l6xp4EkFORSOrgVc837d5xWt/kTy1t/dSZ3sM8mMCM8
	0BiGC46yuIBD7OrcvwuP06EAz8AB0EEJRItilnt11VKqWXTmm3Css9WXcl+psJhSeKGORzWs9Zj
	4CxXb4Ycs6EhMAhbx7in24fV35aecIKIyEB9iDIgLvTOoSI+gOvfDt2fKBuvgJkqU6oFP6C820o
	glEJGFgo/iH6XMNgLYMweoLLnxX5O8sJ8KnU6EatwoH4Zyesb9fh9qeeETWDCs+9fvur40UCBqW
	e+k58eSom3tmvPujmcdtYlvdFFk59iM8i3mw==
X-Google-Smtp-Source: AGHT+IG0vfKlIQ7x7vnbppU7d0Xml+b8vgS/QS4lHzsfXRKaPF8KwLOE5UeXcfV1lso/5P8dBQBhyg==
X-Received: by 2002:a17:907:706:b0:b7c:e758:a79d with SMTP id a640c23a62f3a-b803717dbf0mr262592366b.37.1766147359967;
        Fri, 19 Dec 2025 04:29:19 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bb1:f7ee:1376:35e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f511fesm223648666b.65.2025.12.19.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:29:19 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 5/5] arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI function
Date: Fri, 19 Dec 2025 12:29:11 +0000
Message-ID: <20251219122916.129256-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 12:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21179

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 4b9e0d8aa96c92be0073825344b661afc49242aa ]

The latest RZ/G3E pin control document (rev 1.2) recommends using
Schmitt input when PS0 pin used as NMI function.  Enable Schmitt input
for PS0 pin.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250817145135.166591-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 9f6716fa1086..08e814c03fa8 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -132,6 +132,7 @@ i2c0_pins: i2c0 {
 
 	nmi_pins: nmi {
 		pinmux = <RZG3E_PORT_PINMUX(S, 0, 0)>; /* NMI */
+		input-schmitt-enable;
 	};
 
 	scif_pins: scif {
-- 
2.43.0


