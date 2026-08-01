Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFABC5518C
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:13 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2472.1785575702951613018
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=jPT2+loK;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954dff6536so3647665e9.0
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575701; x=1786180501; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlNZwwd3tdwCdLXrpOoYqGmrbUiixLwYd5pZ+VVRapI=;
        b=jPT2+loKzDYu0qUrmX9A4xhGV0jeOp3sX1E2aD4kvZUCBrMlOhCKTABc2YbcXYZG2K
         liI40KZBJNd7gXiIayW+mPU/ETTmG/5BD40bpdnig2z4FzDXvLhU9kOkke57+fJsNGry
         QuXvP2Hkc13XwAgAD7PSIdVAq2K/L+47kjYigBXfkAfwkU0PMW0bTl//0gACJ+/rVJyt
         PkwYzpofK8bkoMX2S9/sezG16f1RMfBNQxsT9ERNwaSSeKNf1hyBGBU9HII74GlGYq2q
         RI25w1Mmsw3h8NFTnNPwYWq2dkZlyJJrmR+747IWEQi46M+1nrmFjdBa5GtMMm8xMp/a
         XW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575701; x=1786180501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nlNZwwd3tdwCdLXrpOoYqGmrbUiixLwYd5pZ+VVRapI=;
        b=E8EuH9Qh88c0oSZfG0i85sqfkXflwz4oXJdqaFxIudWYOcNC58w5teVxhxY0t4ya1r
         yXXyFL15GuwzEFrjVeRpHxsn5kMhJaQQWupOsAOr3q4zfnUrX9wCYY2t4AsosmkW1wVc
         sngogbUQfNR1mHXzJ/JpHNZmlHJnXko7huqFOABSq52wGCSF/oa+Hg/lVgHDhP4aEkgq
         wyStM7VAdXD1Caqr0BjvvH+dO+B9BPojswQtdXxwriQirI/cwr9U85PUL2QWBRov5+Vx
         8+Wowx5OANqgjpd8QAZOxC9K2Cux+TYvOIfiT9vwe4kwumNri430FiD7/KMw9UulhBQI
         rJ1w==
X-Gm-Message-State: AOJu0YxSm4o2zXBL4Eg/RxVjFDuL79jrZUJZq5LjHGyOY3v/KLABwTt8
	esOuIuvoot53Mq8GGD6LUbERMTRFd2YSUsS1e2Ud/dRvpDtHFEDBtDVgEEQ8gw==
X-Gm-Gg: AR+sD10g+kxlesuYbJCNTOz7iCPP4MdzQW76QUp1npcgk+u2wHS6MmrphhTtZxxImM4
	/SIMLDt09RvDqe9xF/IS4B7wTaFJmr3jaZTne8Mjoy/gTtbrQYK2j42+XiBAo0wx738VZZxaHLf
	onV3JFzROyxvElkmhE/diS7TBCPoAl63k3bnG77lkVU7msBegS6+EyoPoXOqdGECsysR+HFso0+
	L7btHEEvT5V5Sn3KGLb5o2M5vd+C8re9DoE8QoAWKh8g7DRcefBJC1n18prsnEOw1xhbCSl7E0E
	rhwXVJNWXf+NrjXecQoFFPKZl6P1PmS2g5mwMwZ3fXWsMkp6Wie0Kqx/idHpmObVDJ/2qFxPPqs
	nBHIvP9/njePekGeOoCePiHA63jkK/+PelrVx2P7E1CySKpZhz5F12u5HDn5ZlTfz1O7uanB8Oo
	wUbViFNeKvPq+MQKA7DyWxmFWj08dnL3ec7HQsOHy2p0Oqa7EJ7UJo5Wi2jKjYKCN6Q/xZ/1Ee6
	Ndxe8BhACILajI=
X-Received: by 2002:a05:600c:4ec9:b0:495:62bc:a022 with SMTP id 5b1f17b1804b1-4980c67474amr27708055e9.13.1785575700971;
        Sat, 01 Aug 2026 02:15:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/19] clk: renesas: cpg-mssr: Add number of clock cells check
Date: Sat,  1 Aug 2026 10:14:32 +0100
Message-ID: <20260801091458.14026-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23828

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7f0c422c7fbfd9294ff9321ada0c63561e5c6ea0 ]

The number of clock cells is not validated in the clock provider's
clk_src_get() callback.  Add the missing check.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/46e010659ffdffd5e3541369f3b65d43ebe236ec.1777562043.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index e4d42e24485d..ab4a1263b9fb 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -378,6 +378,9 @@ struct clk *cpg_mssr_clk_src_twocell_get(struct of_phandle_args *clkspec,
 	struct clk *clk;
 	int range_check;
 
+	if (clkspec->args_count != 2)
+		return ERR_PTR(-EINVAL);
+
 	switch (clkspec->args[0]) {
 	case CPG_CORE:
 		type = "core";
-- 
2.43.0


