Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C76CD12AB
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.32512.1711528516087702052
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SmusL/5L;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso319999f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528514; x=1712133314; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlZNVeHKvbtBeNW38McajTNAPghlBWj9e5vgpxA3xF4=;
        b=SmusL/5LGcDnFRb7SLmrcY73trkUtzSS54yW4vRe16eyUFicz+GnrEzXnZYoolITTc
         vQ6413jHBNOBh5ueitnfXFxngfLVQK950UIGhZWRhQ3atjNNdrMshRxbicTrOWt/spWv
         k5gOnW+ZNHaZMFwvLGJHxhTfHWlQeID09mTCAXOGeTt/Jzs2ef0cOcBF3L3Stjlj9Ohe
         2j7KdctU4Srho15TQJ/WINj5mmftfrn9aKDULjuUVlZBF91tScd7rWCVtx9qSdI/vA6U
         xmdthuh7+uo56X3V32yjGT/hkbbx2W1QCIKLhjBhKwlnWXp1yVOejI1c/xwAsAq3Yhgr
         2lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528514; x=1712133314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlZNVeHKvbtBeNW38McajTNAPghlBWj9e5vgpxA3xF4=;
        b=Io1lzLbjZC1/7fwRy8b2LloxGJ5bmg7SFkxOtj5rGdV341r52etVmPJ1zY2OnLf9eo
         xmftjoJEPik0HxdkHBGGD7Mk49EP5F+QLiQG6UoLpkdqyMDZeauWpza6FOfKFaZCa/qD
         QRX/AVEaP87C7bNE05geejqSdGPGCZmCXYzXvQOc4wBpQ1TVEbnTmlgnzPNBs2IktaZJ
         27G8c1PbC1OibvJuBrUSvEYztU7gWu+1QN+8/CIACS4zGOrchyGt3lcKXXNU5d0PxrjA
         kaPuxUD3n9o4Yh+mSMw+3blNAWSQsPuVxajjRqKc7rZ56bmyoG/vDMc0ZVmD+M1H2zVB
         Olog==
X-Gm-Message-State: AOJu0YyULB6NOyl445ciq23zJlc3XCooZ+AtektMN1Yyyab9taNdJob/
	hTqwxzx1OYavTzMN/SUtXCiBx54YpDnCzpdJQBIXOMAS3cTwNF7VBazR1uwW5c4=
X-Google-Smtp-Source: AGHT+IGzZGDLKyT8UlrnpDtqNaFEN4bZ49ynBxXi5ruHheLbjMBG7notPeWekszwmiF6GKDUwY27SQ==
X-Received: by 2002:a5d:5505:0:b0:341:b5ca:9e9c with SMTP id b5-20020a5d5505000000b00341b5ca9e9cmr3110305wrv.25.1711528514538;
        Wed, 27 Mar 2024 01:35:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 04/13] irqchip/renesas-rzg2l: Use tabs instead of spaces
Date: Wed, 27 Mar 2024 10:34:59 +0200
Message-Id: <20240327083508.2229567-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15458

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c90b5c4e6554c1194d5f7cfe13dfd710a7661cab upstream.

Use tabs instead of spaces in definition of TINT_EXTRACT_HWIRQ()
and TINT_EXTRACT_GPIOINT() macros to align with coding style
requirements described in Documentation/process/coding-style.rst,
"Indentation" chapter.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index fe8d516f3614..cc42cbd05762 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -53,8 +53,8 @@
 #define IITSR_IITSEL_EDGE_BOTH		3
 #define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
 
-#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
-#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
+#define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
+#define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 struct rzg2l_irqc_priv {
 	void __iomem *base;
-- 
2.39.2


