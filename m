Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B71CCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:05 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10043.1762416716323281418
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Qb2mxGiS;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477632d45c9so3112655e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416715; x=1763021515; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow4QaYv7aCZBl/kZX/vWP7QiG3ufZxzLH+BGiLZZQMA=;
        b=Qb2mxGiSalx83ySRY6x2MITfKdHQJzppiwE0tstTmJaDQslEzQbVVvuxd/NFextTpp
         etge3bhl/ZuptlwMNi5ApuDvKbnQuMT5h8lYDGxu/ha+Xaii/cwdau9WljE9AQXtwT+q
         W+V78q/lkGWS1w6haepAqRpI3XgZEeUIygm2NV58LU/OcGbaaNhgOFqReOCG2puxpmbP
         eykhIrqVtSGckqlABdJ3hHyIX7XkoIt2PI3WwykKo/4AiM1IlELU6NWbTYpynQiLaMhv
         WPbo5Kmj/B5qlFgvnxW1jQRr3bF7ztrYEzzB2TcxGGys/M++4gmPOOUn8NScrSDwj/zZ
         b4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416715; x=1763021515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow4QaYv7aCZBl/kZX/vWP7QiG3ufZxzLH+BGiLZZQMA=;
        b=r0kM15HFWyleQ0kee/NvhisuHRU5DMLnx08zRYXr178RdVaVwCo0a6ltFA6c3rUGM9
         E9h4J7MZBk2i3qnLimDj2cAWM2sv9dOBG1neofSHlwUBYffILf6L5+ppzZ5VFfGEvbFn
         z+CWWzYYOBL8YhBn9m6W7iH2mLShpDho9yDBZvEp6YTBGhVSOaFkdslrmPpZ+gggzZp2
         3fPEe5LZq4izYeyXP2CsK872iQk1qTwUb/8kYk5ptEbWyTHs4REyX+Mb2DTIzkhJ4noM
         I4jBgeM9Xx16b3lG+NxaabXf8XSNkMh5IdyMMmKsp6JXByShf5DHFLVLj+quO0FYLGUC
         DWbA==
X-Forwarded-Encrypted: i=1; AJvYcCXmpf4iFWXaUXH0J/rpGx7fey7TfmhF/oDEjVFgxq4CcohjkDueo1u6sLmKhncSRkhoPdWg+eRl@lists.cip-project.org
X-Gm-Message-State: AOJu0YzzZHx44F5vkN7RzjrlMVEMCEjDg7eVzp2gG1okWCi4zfkWLbnU
	fkOJfQ4RuI3PKEtSDskiwNdmm15l6VfK9ojCKD9M4Zvr5KbvUOdqj12qs0h3MYRxEkw=
X-Gm-Gg: ASbGncubPBqC7ZOYGGgPKPfNqLur9O1pBgCcjM6/qhOcWtbOPsDUuKxDDIoCyOFaKP1
	VdKrAyW6BE4dF89ZGWIjx7H6LslN0Zsv3nOqN8RqE0Yjapd6k12sAUGOifhF3u2HxJrM57if2/m
	nsqhEype9Chwk5CObNh7Wc5CO2PEKoYJPBJxgo0rACpR0tWCO5VX/dFVSle2eqR7FxrOpGQi6D/
	PBW7T30av3ZCbNHReubzNR5po+UE7Vu+Nb030VUXtfuN57hTjdSYL9oc52+7ePzSeM6e3+pm3jp
	SoSp62DarNZN5m8vTGRvWaDBasQlctAFiQZbRIFZLIz738jh+Cfpknhg1l12v2VbUooaPTu2+yz
	nUOb33EPC52FAw4S1F31rME0RrFXe2moJvOspTcuAjtHlWFBgWfBcWE+wEY8beP4DqGkapMJWNq
	PaSYfwaBBDDdHNRE6qzt73SSe0j9rSbA==
X-Google-Smtp-Source: AGHT+IH47MdsKascKATEd7wYctKFgF/VT6PiA77wNnB43cgT/1o1nfA+AJwepGXeeMs1ZpCNde22EQ==
X-Received: by 2002:a05:600c:1d9e:b0:475:dc85:4667 with SMTP id 5b1f17b1804b1-4775cdc0f6bmr53938625e9.15.1762416714633;
        Thu, 06 Nov 2025 00:11:54 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:53 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 14/23] clk: renesas: rzg2l: Postpone updating priv->clks[]
Date: Thu,  6 Nov 2025 10:11:23 +0200
Message-ID: <20251106081132.2574638-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20407

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
[claudiu.beznea: fixed conflict by keeping code from v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 0d7e0fa73fff..96535174407a 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1390,9 +1390,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
-	priv->clks[id] = clk;
-
 	if (mod->is_coupled) {
 		struct mstp_clock *sibling;
 
@@ -1404,6 +1401,9 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 		}
 	}
 
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
+	priv->clks[id] = clk;
+
 	return;
 
 fail:
-- 
2.43.0


