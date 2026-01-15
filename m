Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885C1D33A1E
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:34:01 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31267.1768466034462528422
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Bhj1SS3v;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8707005183so106683966b.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466033; x=1769070833; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1FMug1rqHSfXRmYGjS0o4ut32rDcLx9hah87lor5ac=;
        b=Bhj1SS3v1oJGjz69YKhXMiHJH1cuvIx9ajFD7tDLi4sP/9gEqHmbJERxJ2BrDTr9Ry
         u4z2/kKBp3H7eKTne1kdmPKfgcWEY/tMPhFQFXmH4iGkxtRu2Yl30R/LkDMV0iFZ1rG7
         jEiyH7bUgu0XZ6rAjHV4TBs2Uelc2xcc0KjorNEmjAULeLvf6+r/9t2tOIFmYpC9+HhY
         8ckuLDQl8iaqCGEOIRUD78dxyC8I+cu4xutobuV4caXJ5RNpdrtOvd09gKFVHpd+2cP1
         TnxRPPyefZ5md2x7+7W6bAbU8C3YiUejuNBPDfCCGAq7QtFms0ip56FRAxYIo9o+jIk+
         lmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466033; x=1769070833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+1FMug1rqHSfXRmYGjS0o4ut32rDcLx9hah87lor5ac=;
        b=UVVwtZsktmAJLbR3WFA4QOcGr85pR/5kimS/cEVzE3QcgsymEDTb7WQVyaOX30OcIT
         bk9qzhSZ50FSNY9Hru5oO69Eh9gRfV2gaW0ZwGrnqVsOvT/KOt9oMkzCNy9H2WsEIK24
         l2MjDUJeowTvO/jzp8H7eFzL2+b1Irqfj+GS5LK7HEgNsz7ktRuacPq3921Hywhy7+Dx
         1ptA3qEMlvE9dXz9FuMyKOolG74cBoYn0FawIPuWheun1eLbzUfOeXrkx54cRR4wFw2A
         2Kq5K/NG9XEhg3CPSlUtVB04RLjBlB/eh1BzPOdjIu5Vn1KE93/AUBRbqfyN/27jWYVP
         PizA==
X-Gm-Message-State: AOJu0YxjiqB8zfTDLgzr1/dwn4rOqib8V98EN+1hOysTGSLx7CSb2xfe
	L7MJrq5s3uFGfIOZS3E/DANwSuEG+YE8R1X8edOxiXoiHT98W5cRrdhtsxWGal/JH6OklfX5+VT
	CAmJ6
X-Gm-Gg: AY/fxX7mUwVzsrHxT/jRrlbDjTpGgOuQt5THPsD0SK4pPr2PZYMcGmi0KCg1OudgTbD
	N2jocKJKarTRVlpH8c3o1j8UWmCVNJIh46XBv7KQm4Otw2MeFUhrieRrUb/6zDxWqC4aoI/oC/7
	u8Yl0Hf7zSPGIn1HtknpcEHpGhygTq4GXUFr87NWP7xyjyn9vki5NlvD8DIV0pjtdmzU5QYuLgx
	cV6j/7FDJrT+/WRxhmzuI4i1+KQTU+rUa+K+0Sp/cVnbvlLCt2PZj5aSkUpyAuArcOeVTK27e8N
	BfHn/3i5hODb03fiYBgp6POyrdcd2qgLxUyEanRYrGll87G9uxBbqvynE/zkCfIFSscQMgucnmW
	lXDdIXSgc1Rli8oKLo8HcKXjqdXY4HzjN23LJDKfkNvvOSyhJIf8174CqM9Sk7CN5hwnXpuSHzH
	i9n9yiLX9894zSY8WAyfT3s/MX1MhSNu1cNN9mANCMAuuVEColFLwL8yjxj/feQNs0iA==
X-Received: by 2002:a17:907:d716:b0:b7f:e703:fd77 with SMTP id a640c23a62f3a-b8760fe0a47mr392123666b.11.1768466032753;
        Thu, 15 Jan 2026 00:33:52 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:52 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 10/18] clk: renesas: rzg2l: Postpone updating priv->clks[]
Date: Thu, 15 Jan 2026 10:33:24 +0200
Message-ID: <20260115083332.1063820-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:34:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21571

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2f96afdffad4ef74e3c511207058c41c54a2d014 upstream.

Since the sibling data is filled after the priv->clks[] array entry is
populated, the first clock that is probed and has a sibling will
temporarily behave as its own sibling until its actual sibling is
populated. To avoid any issues, postpone updating priv->clks[] until after
the sibling is populated.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514090415.4098534-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by keeping the code from commit
 2f96afdffad4ef74e3c511207058c41c54a2d014]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index bd1b121fb84a..b447847610b0 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1400,9 +1400,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
-	priv->clks[id] = clk;
-
 	if (mod->is_coupled) {
 		struct mstp_clock *sibling;
 
@@ -1414,6 +1411,9 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 		}
 	}
 
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
+	priv->clks[id] = clk;
+
 	return;
 
 fail:
-- 
2.43.0


