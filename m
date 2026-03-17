Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B86EF33839
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:46 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73445.1773746265133131539
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gXm1vciz;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485345e1013so4920335e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746263; x=1774351063; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi2FuoBvmqMa8nTP04gCCQVLWqBaSpFmAXLO4hRLK7Q=;
        b=gXm1vcizqdBVtEbTbdscQ89UlgVsv614buHB+b4QEMT9xTQiRp+H6E7r9Wjz9/YwJn
         i51BDVlZWAycKrL3Q2IPQQ5WVMg5KDws62X4KFjN1cyr8x3OImRhBAeRuwiAox6ZSjN0
         sptgrfuAlQddR9NHECDmkTTQSV8NDume8meBnlHPSxDKi+pI0jxW5ZFxaCXNd2gODV2v
         w21fuFh8HQyMx1ApS1HTF3TgpzVE5jbxVCj0olzF6fd9Ki/5+ohnYPzHP8ZH1/ZyKPym
         OcadwOEFoq7a0ElYZKwTcEIXcIdgxhADXUJcWphzA3aXaMgNu/FrD/Op25yWRxpDg+pK
         AF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746263; x=1774351063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pi2FuoBvmqMa8nTP04gCCQVLWqBaSpFmAXLO4hRLK7Q=;
        b=Fld1pgkh+5sknXULo9YexiR7twsmYp60GIDNVOSBPYfVJ3CEoYQ5z97mENQtVHxgt2
         nWyg+/4PFajJXPJkJUvSmWgK4phyDFIad0g+36pvpta+jfwW51CjnKIhPgfMidsAztfV
         AGice231fLGr4NWGrua+YG8ZNPGMBrPSjlr32M1inlURsY1WfbwxF6LLP0+EkUVwNu8G
         9mAe2i2lOyJLW5JiJH1YqCHTtDtqmf0p836LBHgH1j+cZkCF4bWIfI9SgD1MwfparZk2
         4eK0iHsquchyc/4yEKZy59zLmVR2YvW7wrwSwZPHDxgZJZagGplxdaulVL46AcebuO9g
         xrRw==
X-Gm-Message-State: AOJu0YyurE/ToKZpnNwW08g293071ZT6EJP8XrCOBcZg+4vu0gGPh1+u
	acmMLRNehfvCy3yZRsqSocYgZvv8mj93eDJJ2PfSMS2Bunc+yh0vINEEdfOr7Q==
X-Gm-Gg: ATEYQzxM5g5cpwtSY93yfzcY67/xlioh/GAEM64UH3T1Wbl7m3egLvTY6s7JMXZboMo
	BkpFe+EhWPo3XUnU8rdekZuKYvqCgQYdK7xLJ12UinVvJS8l++lcHtMMBgmbV17wsNgc/Js4xDZ
	zKQzqhLfAP30pT/jwS51kzZQm9b5LuC+3H1GgVOK/EPS5tO/d09ESLYt4A6k9ZeHgcoHJcaZbR6
	AkZKd9MULhfeI9q36jNG0R/BmfXT5B8wfrpIloFFSMjqNzOm9xqryN8fQ83HsIaRaCRy06Yp1iL
	1CzjFlLU/iiQokXumqrHpf1cWooYgH3jspnZUC05Hk78vUsw/TgdWeaBfKBkRdluwwQH+9axKw+
	ERyz6SmS8CNRmFa+HFrP/RzAUEOaNDj2+EEYf73dbpqJal7hWTY7B5+3tYO/53+3gYu9kshXLVt
	EAPoSMijx7paJ0kiim3Cemzl1bhj+hn9NCAPL0AKXcUqQbdLWK
X-Received: by 2002:a05:600c:4f92:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-4856eadb12amr39552945e9.13.1773746261434;
        Tue, 17 Mar 2026 04:17:41 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:41 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 27/39] serial: rsci: Drop unused TDR register
Date: Tue, 17 Mar 2026 11:16:52 +0000
Message-ID: <20260317111718.281633-28-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22462

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 507a7ba917cd7ae043ba05db02089b152ae0aaa8 ]

Drop the unused TDR register-related macros.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-9-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 891c33eb5e9f..4fea7a3d74ec 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -35,12 +35,6 @@ MODULE_IMPORT_NS(SH_SCI);
 #define RDR_FPER		BIT(11) /* FIFO Parity Error */
 #define RDR_RDAT_MSK		GENMASK(8, 0)
 
-/* TDR (Transmit Data Register) */
-#define TDR_MPBT		BIT(9)	/* Multiprocessor Transfer */
-#define TDR_TDAT_9BIT_LSHIFT	0
-#define TDR_TDAT_9BIT_VAL	0x1FF
-#define TDR_TDAT_9BIT_MSK	(TDR_TDAT_9BIT_VAL << TDR_TDAT_9BIT_LSHIFT)
-
 /* CCR0 (Common Control Register 0) */
 #define CCR0_SSE		BIT(24)	/* SSn# Pin Function Enable */
 #define CCR0_TEIE		BIT(21)	/* Transmit End Interrupt Enable */
-- 
2.43.0


