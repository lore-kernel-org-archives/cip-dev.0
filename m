Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF11CDC176
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88530.1767701187476283527
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nNX9Ax00;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso8356375e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701186; x=1768305986; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UKtnqWf7+fTgAx6eIVZJqjXywpxnZ/QI5GAA188VdI=;
        b=nNX9Ax00S4kZp/zjtREyDCZnf1jOyVkWbbHWRVVTdSpQ2DZQefhqkxiOd9NipNLJX3
         nb4qc3HR6jIQ67FynPbVZMQCDQw6I2yGuiFq6SXZLLHXhwOQ6YZbmlK1hZKfsPvKE/GK
         C6xHiUUEhVlzHiH7K26+mjrXmhKTUQbEMQ8BjJHcMbyJ9BN7MtNhyoo2AmfkB8J7YRpm
         kTIeAeYEOXkkfKjewqusbeBmPascPZCl8vJWS01sKRavqDH5STU+YJiDZH01TB2Iz5uP
         22Cp3+rksIqoD9nELAQRytp90OAsyxp1OKUx1W8C/vNOsMNG/VogTq4T8+NCZxlkd4lb
         ahYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701186; x=1768305986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7UKtnqWf7+fTgAx6eIVZJqjXywpxnZ/QI5GAA188VdI=;
        b=D4ITvqAJ2VhRrHavWSkAWEAmH9ET4+mEgb1xq+jLuHYXqshUUA+Xp8XwZsdcixrG5E
         m4ycainUl39H1kAswRMslF0CedhVNCEmKb4Mf5gfqmq8JQfVmWItaxY34u+ZO9ytLf+l
         PYF+IycKDdF9BARxQ2CBuXOCTU2KvIBxP+KvQbzOxVvxt9QiGHG7cx87rTmOh9XYjcVq
         wHpR4uCyhN2B4ZlllLNFonES/DtjbFD7tT33qb9GbwgSH3ph7LlyEmSQBfqe7FuAQP/S
         TA2rYpqSHDy/72zvTjxmpyK607Fa9nxOtRfDM0W+n6NYybhWfBd7EZRCZ8pyuXrBD799
         WjCg==
X-Gm-Message-State: AOJu0YzH75FF2WQ88C7nKuTvUQ9+I/lKSoGBrBi7VIiYZJEf7eUUZn5g
	Xw8aSqM+8sEfc9LKfrzyePkufFHANEarWCLbKzyo6C4kJxFtWmglj16HqXowCw==
X-Gm-Gg: AY/fxX48RGptcooI83QnSlpzkjs90sBuZ834sPZ98OMU6Rr7KxkS8IqGPqxmAd6Bfn0
	XN7o/XHs52C39NArjRjBsN63UqUFgdw67QCHcVfBkV5+KSQ557oc6tNOSQBRH2CR/4gksJaaT0j
	mq05XpzZIkyir8i4Kfreku5/pRYvS/3Zl1edNJXCtNm1DRILrqi4JHJCyaR3KSvvOC3H/Y65wD/
	eYTV+v/oUBXp+HvEaEAU0OhRMbqLeDuuRI60qfsYWn3njltJCa9UCT+I9wQiaL5g+VTAW42bqDh
	o6FOJypog39OZveA2Ae5/4IzO+wj5YY4vqlRkB/Ai/Ps3bvC3ZMj1/gRxAKQtiv/ko3hYDB6HAi
	3d866fhjtzU/gt4M+HsUzgZv5Acp5bBiCkNSRAcqLtyJ688OPwZ7ALxQkUTW59kCYnAhWt5N/qt
	EPzep7teARDbPyi148rw==
X-Google-Smtp-Source: AGHT+IEg+7AyQ+4N9QeCJKEzuGuOwr7vVzL3MG2WljhqyK/LWWKeSJQZPLHwqB6yv2UW55KP8wZMUQ==
X-Received: by 2002:a05:600c:638d:b0:477:63b5:6f39 with SMTP id 5b1f17b1804b1-47d7f09cad0mr30161295e9.19.1767701185420;
        Tue, 06 Jan 2026 04:06:25 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:25 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 13/13] arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI function
Date: Tue,  6 Jan 2026 12:06:10 +0000
Message-ID: <20260106120618.181104-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21373

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
index fbcccf075b3a..d20ab1183d89 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -139,6 +139,7 @@ i2c0_pins: i2c0 {
 
 	nmi_pins: nmi {
 		pinmux = <RZG3E_PORT_PINMUX(S, 0, 0)>; /* NMI */
+		input-schmitt-enable;
 	};
 
 	scif_pins: scif {
-- 
2.43.0


