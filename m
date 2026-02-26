Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF66FD9E12
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:42:53 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78970.1772134964864395121
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:42:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W4d8lPqr;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso22636215e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134963; x=1772739763; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcVpvbs6WuMf2IK+ihQlsdTVz+VKy+d41CptzvaOntI=;
        b=W4d8lPqrNfkl58HYej2rwpY1IV6UHVHW3Htzsn66jSqY2Q6CRbUF1GGqRXOHqEhrce
         W92bamXebZIbCVeqFexEGhnai0crEWqZZ43o5c/6An0YSnqfwJPBiFiY1ihD3GshbK+G
         zURRnj+j/8lEaS2/aCo3MYvTDKwYJRjrKKzuiV+KYh2Ma+B1/ipS4rTMu7DHvnimHvsW
         CP0MR0VtYPLYtjNtrtXeNtHo6CKan8CPQ/JIhbe4OafiNLexJIDnQjGh7VpSHcUy9wXf
         qHdtjkbHPXEAfphelsDMF9HR/Pg1bVfrc+uMWoDePpkFtQ6RPUHm+9bmmSY7vuwtKfyt
         i/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134963; x=1772739763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OcVpvbs6WuMf2IK+ihQlsdTVz+VKy+d41CptzvaOntI=;
        b=TvN+TJJaUz7/4ZxosFxzmzDpFOszz1YK9uPVLiw+B81byRIel7YtQSHAYrkXIYuP0r
         7IDl+jVAjZUjcifPvUBDC0isgUGPMn1Ew+eLYJPvJzedCe27rAj6YIYUVaTeZ8xhWb95
         2sesCDPxvgtG0zQ2LqvPyZ2XYUWBS+5Pd9buWlsajUmtK4netDdTGB19c0hC3LS2Jpz5
         4ad4mHsOYO1N/KQvOTTdWK9Nneqi3PsnvNqhjJpXsZFaikahTMC26n2w/qRRa9CYiNj1
         eLQXPtmvshSMwcTnOKkHbtgcxcopzGivmMqdYawIi1TWkXdiXwfhBUKrpsJ531cKsfzl
         7omw==
X-Gm-Message-State: AOJu0YwU9uuLyOANsLyn7+WGjAo7g88pv1v6Zufti54Ig+eaB5IiRsl0
	tooJZBJbGhOrz0JRtVVtlYbHtqvE5IGrrFYMMOt82ETNhzXER8zKdREFp2CIhxmg
X-Gm-Gg: ATEYQzwwrDvQ7iPAaOWkBKxyP28IMjESztJzppt5QgsJeCfPCdmFYq612r0M4bdkH2O
	q9FwTvLMWT/EKUbSxo9LNiQBJXKGKLNmTxAHsY3TsTNeY0lz9BwaIIxzR+kv3+Xd9JjrxoXMVao
	iI5okoZhEJM7j/JkH/yjmaB2PZS+qek9qQpddHkSKhqAPeG7+zDkw3mPekWV9VZVPpYMJeM9nvw
	tDizlyWJExM88AjNJXQ48sUXrvQhe9nSfawHW8XJ+xUi5Pr2cclN9sZ4WHtCt+vNUOIRon/U158
	GMaZ2yhi5jIHbBa5HTUTmBAVkymSbXzvcpCG5n7keU9ICRaIMKe53Ets5k+4bvTv+AL6zw9SPhN
	W3+lgxD9MsLYvcGcqGRS2TIhzDcb8YI1LwZN8yuOKeLjCHAFYfzUnZnWadt0gnZysgNTpPDsQUy
	yzeSWfS8owQJmxrnh2ZzKdrDrbYl6jLSRC1HbIbBa+qZxtOx8=
X-Received: by 2002:a05:6000:2689:b0:435:96e9:cde8 with SMTP id ffacd0b85a97d-4399d981433mr424059f8f.12.1772134963039;
        Thu, 26 Feb 2026 11:42:43 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c6100b8sm1854324f8f.2.2026.02.26.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:42:42 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 6/9] ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
Date: Thu, 26 Feb 2026 19:42:27 +0000
Message-ID: <20260226194237.449383-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:42:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22017

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit a472f0b157832fc91c83179b1628d8f660c84c82 ]

Remove trailing comma in the terminator entry for OF table. While at it,
add a space between the braces and comment block.

Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114075856.4751-3-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 5d3a318f5d09..d90a80ffdddb 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1259,7 +1259,7 @@ static int rz_ssi_remove(struct platform_device *pdev)
 
 static const struct of_device_id rz_ssi_of_match[] = {
 	{ .compatible = "renesas,rz-ssi", },
-	{/* Sentinel */},
+	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rz_ssi_of_match);
 
-- 
2.43.0


