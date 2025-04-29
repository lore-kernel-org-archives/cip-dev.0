Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D6C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:57 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.20344.1745934473831282581
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lBSHdTkC;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso1306633766b.0
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934472; x=1746539272; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DfyPrTkqokTB7cvtjn4FaAiLkpW8bINfd5WZZMHGMI=;
        b=lBSHdTkCA5V6uQ2OaQVkrdnTnmIhJO6YowsKV9kQhNsdZW3krMPJH3nS1FIUbXHSth
         S1CiA3hgagdYzQ9XabnrJHlDLU59S25eNRUfgG2MVAMEgqKhZfPQVaYvL7jY+IXX85cz
         VwT/Gju6vqnzpudGnqJbDMVwB+37PMmIziydvXWBZY7DjqJGfN01G0a3xx9AFonLnxNe
         G8HQ7CTpG35Gl9WHRmPGWKPrJbDr/vLOYHRhl2FMJ4dNKitZ99NlamQmhZPJ+jreYuZk
         PTAdCJC5nObLAs46EtJixcctLBTQmTBhQQRCMFVvMZ+jB587BodvI809Uu3HxpgsQY+p
         wZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934472; x=1746539272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DfyPrTkqokTB7cvtjn4FaAiLkpW8bINfd5WZZMHGMI=;
        b=gA6ab1NpGSKWrE8dnJUcoyuK5IwhTfrhk7caixJmDENoT+lVwJa8SBesk44ERDaomk
         xCpu6f9grwyq9j//Opnj5+riaA4eR4O9y89kfmxsjwAVnH+d4gxyBB/mmeM8Wgl0P0Hd
         GYGoNPv3qEbZpoF8HArRvZuUV3LMw1xbtXZH8OE+y8BPhHqeIny/3+OjffiG/kIfhlw+
         Pe5kqR3Cp4f6mSl6q2gTo0XOKUYrcgLObNoBs+tbptkpEJhSJujegb85gmPFndsWi+Xd
         YBeVWW2hKAc//CEGsdvIOANf3a5K/sjay5stjvGAvyjxT91bNqiLUCihLFx8O94griJk
         PLmA==
X-Forwarded-Encrypted: i=1; AJvYcCWWPtIyuskvjVFhIhVJpFS7RM935eoadRIM2QcCa31O2yzcD3dVNq9S0j9/1CDjf+fxXrZq8h9/@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyu5PWMhotNQfWfh8DaRDllwqR709w77jjyQozaVbP3I+p6TmYB
	dyHcvWpnlqpmrGKrPxFGBtu/xrlD+2+8J+gumY6DnsJAcQOGAkXUNKprqtzU6fhN368vU7qlAIa
	1
X-Gm-Gg: ASbGncvWmjGqYROK8w2o0mizhIj2/sSXdgvBvUvRYFt/3HddPCiwc8yJ6ANvsm+PmTK
	Byd1CsXRfL7jWsYU+H/YDDIIkGaogT5LebR8rytMqncHXgVRwH3fPFgWnNudCblsqSt6cJfkCKP
	ZjKxJ3x9c5L4NngvSDw2wHaktiuHHKZkDvc1J24wbXtNjzuJdx8Nw5AFN7AOMg8SACBvvQ+PJeD
	bPbvaF9zo4VDBBXInKShutq9eTkn6+t7YSVM45lAGu55Cv5IDPb2hzp6GMijeIRaq+i5p6gprR7
	dNoXOp5i/tQ6op/n9jxvBeodnXU/ZYce79mN2u2maI4XYNwC38O4Cij6846epLkT/YcdDO0=
X-Google-Smtp-Source: AGHT+IH+WK1mlY6lWroVgvJk5njj7sCCjyoYNHu1hSe9RHOow9jV13HFt4C3DCOn6FPg5L+TLg/5HQ==
X-Received: by 2002:a17:907:9410:b0:ac1:df32:ac27 with SMTP id a640c23a62f3a-acec4f81256mr333236566b.53.1745934472127;
        Tue, 29 Apr 2025 06:47:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 13/21] dt-bindings: i2c: renesas,riic: Fix 'unevaluatedProperties' warnings
Date: Tue, 29 Apr 2025 16:47:19 +0300
Message-ID: <20250429134727.2429662-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18726

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 4e2a2ed96adcb6151a15ea40db933d97f2ae7aaa upstream.

With 'unevaluatedProperties' support implemented, there's a number of
warnings when running dtbs_check:

arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dtb: i2c@10058000: Unevaluated properties are not allowed ('resets' was unexpected)
	From schema: Documentation/devicetree/bindings/i2c/renesas,riic.yaml

The main problem is that bindings schema marks resets as a required
property for RZ/G2L (and alike) SoC's but resets property is not part
of schema. So to fix this just add a resets property with maxItems
set to 1.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 731db24bb99a..552db6c50e1d 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -49,6 +49,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.43.0


