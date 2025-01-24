Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A63CC02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:21 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.7427.1737709217400105111
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CEMbd1Rg;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4368a293339so20393005e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709216; x=1738314016; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwTM5alHxiV99WoSjSGaeY10FKz85c0VVLpWvkRdO+c=;
        b=CEMbd1Rgm9Qb8MlieGZHCLBbEa/ptJ05SUFYpRW152UyaIGLl/wueez0f7ePew4x0N
         mYRE4enhM8Eui+aGRGfcvRzkk/9sWMsWVH+YUwcOEsfSfAs5uQYcAQSkDUowLpuI6SEU
         i2AxLg8vF3rEER0l4z6R56MS81HbDfYFjGBqaQXde3yUBRYTHady/uoxBl0txDZXD9ag
         4U10w/+ie+tDNMT2Ke4jUuxeSucxCwtRcznkfRRW1DXRDhKXDAhIwpryTrGq6kA8zLUn
         2ImmbGby1wAr3hZReHcadcf7gaX1P99xR0aJ3YJ6BZ7ulbDJ3kuNUi781tMOG80KFhpk
         3JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709216; x=1738314016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwTM5alHxiV99WoSjSGaeY10FKz85c0VVLpWvkRdO+c=;
        b=lU/fE6MQisW8QW/SphEah2VTcn6kkGIJtTIcmOFiwlbUf+jalHJKnjEsFKw2nZM2Xn
         qh9B78zENpBrT028y5zEKzAldNWnhC3KgF/RD16P6a0nh6u+pVBcnQTHEJam6mmL984/
         sSvf+x2Cz8qfRfzSElZQzXjpjVSk6iZUhJJsd+RSPV6xzTnerojBgTUu5DLngDkW2N6h
         ZU7sriudPJn2KuEWecXFa7IwCEXGFBKE14s/03bystRt4P25asBhjzYCQ/UAoIutX70d
         t0hxJZfZQW1ydSQZ8EFMcMhiF+pzZt0d7mWFZC/IDZoJfDv804AecyCqW2VgeuFOVmKx
         mxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSKUPBOMV+GpLhMh7wtUvLiaZ2unTpKuVSlxjjaAej0FJaa8OrihMEIL/PriEL4nvFFAhgGJmz@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywvj/u6FXCwNB5rRZVnvRGsEj6dgInQLOMjkArGXnKAEgczCUcr
	k55vH5okOx6TFo0/cNKeO8Dx9NWV7AVDU0hQP5kFubGG1XmjA6zSl6uVIay4NpTqHhpljH/daGA
	S
X-Gm-Gg: ASbGncuBjQJCLr21slk0r7uRdMvWOY2vL/dsnM8vhHNpsFm9wmJFwpx5o0MFlOU4WHO
	V4C0SFa3Pg3suR+r7x+VlMUOT+Zdz77Ih7GLmFGXZAFEJjzB2gEHicazhmiXi5V81JbS0QTOrM9
	XmkkkTtTdIEh1Cevx3QsHhbFjpRszczZek7fLuAcAXy1WY2JWvzJot0uyf4e/l53NXTsUODlyep
	XY8C/OANlRjNGDEFNmhY1gQGWb83VzH65zVtb3TUcTobmNLeJ0rPUr2e6lkq2X342HpznFyygNY
	kVGd0X/WKmWiuu5cexYy0Q6t+PQRhouBfw==
X-Google-Smtp-Source: AGHT+IFVciKsQVUxHhfCYQsT1nx62EZlXCGBTZi3tN3N6hkc+c3RnXms+PuTYMC/C4XcQfWhmYIbLA==
X-Received: by 2002:a05:600c:5027:b0:435:294:f1c8 with SMTP id 5b1f17b1804b1-4389143164dmr231913195e9.28.1737709215835;
        Fri, 24 Jan 2025 01:00:15 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:14 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 04/14] clk: renesas: r9a08g045: Add clock, reset and power domain support for the VBATTB IP
Date: Fri, 24 Jan 2025 10:59:55 +0200
Message-ID: <20250124090008.1401077-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17626

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c8bd9bd6446fa034a1877b553bf118606b37c025 upstream.

The Renesas RZ/G3S SoC has an IP named Battery Backup Function (VBATTB)
that generates the RTC clock. Add clock, reset and power domain support
for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240614071932.1014067-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: dropped PM domain part as it is not ready yet]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c3e6da2de197..55e7d42dc472 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -215,6 +215,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
 static const struct rzg2l_reset r9a08g045_resets[] = {
@@ -231,6 +232,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
 static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
@@ -238,6 +240,7 @@ static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_IA55_PCLK,
 	MOD_CLK_BASE + R9A08G045_IA55_CLK,
 	MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
+	MOD_CLK_BASE + R9A08G045_VBAT_BCLK,
 };
 
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
-- 
2.43.0


