Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66876D33A18
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:34:01 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31270.1768466036157240095
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UxpEUWIq;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so1006616a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466034; x=1769070834; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy9IWmv2Dt/PdUwVMuAxpHSx3CGecWBAo6FwgD+V21c=;
        b=UxpEUWIqsI8v8Z6gAxKDsQR/a+31QeIX7YRnQOg97sQbH82d/EoXbbIxDydrKes+/+
         MPLYoV0LNLMrUCMaN/k02Q3smDNbdlxg/1TgJYi3SYy9l1Z3bDmd/Fos6BLyKqRkQ2gb
         Z5xou/1WY67Ni8zBL6CxoxtnHwrj8TkGbiK2icK7YMKX+nDolMftv/3EEn/EEp7X4jFl
         3fQgGOlHCSs2fYNULg2wHw7hKTIm/Xmoqg/dXLy+M01QgX718fzv0MQ27qtRTpztHZqz
         9wVepttUlRz+dykqKblt71Mwvu/rCifYNK5QvGwoAtC9j81vCpQc18LVdWXFMr0U8j33
         HH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466034; x=1769070834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wy9IWmv2Dt/PdUwVMuAxpHSx3CGecWBAo6FwgD+V21c=;
        b=fAw1MR5sTMiJ0fYCX7sFLwpbLRHnuNJ5ihq4ZrtKPORZB4RsYJ7cUk7M8NXlA71wII
         6N6G9/YSE6BPsVDU0i3w12LAP1D73lPbKE6ISIdK15SkhvJK5CiSGpZMhbDgYJBFNVFW
         wK0sZyzueqh7LW2k97SYyt1ILtf9Vx8YjAxFqQy0YdQjBU1SDfK5QN4jcuolyo5S+qAP
         pYCjztxDSz0pR9DTxYYZOKY2inWF4S9zMUCrPSxp0+7NwB0wEhHkN/J6/khZ7AJ/IeZT
         h0wwski67bOrpMvjf7fwN3RaxhigbqOzEFW/MTHJXr2NX9As0E9hY/3OO9QDWKA3rDll
         srGQ==
X-Gm-Message-State: AOJu0Yw8Oaw4WYs/IqN0eE8YFw3/Qx5vv7CcdOBz4zlbwidn3/v5+vhX
	GcQrjeWrBHmywCI4otnTEETzW4ubxUtbxZymaX5oxSYqiVor27gDtTCDDLZXY3FIvzljZcTj5sa
	Z/7Rg
X-Gm-Gg: AY/fxX4nc+ufvdvx3glDtDGq0FXKjMrqMuRhMkbawgbjZgMJC72IuSE8zoKxA60riT3
	Jth+Ka/H1R4WRzQrPT3nzjYZLJj1m6+fbAAB/C4V//9h1ycql/n5+L7FZVLNlVKrN9V79jiSTKt
	dV33WvU84m/7Kjiv1KURgJTahxnUc84/IOT7XCufKAsHv9pZihkeO6sALYHbk6wC1unvE/HOwm5
	08ep/TuIrfaDMnOgvwhcX0PLQt03mCOxX0SY6hc57WfxxJVGBxPi+Szlm7IrWqfu53koEom83z1
	HRVGdv6S+iy5njAj2cdF1lqmhYgqiIMXiiSz2+laEnmUTBip9Q3lS0i9tc6hNWvzJTPm69pqbuu
	aNRqO6912G5rQNaQKU9qzKwktSoFFcKIVjDuFw9Tbo+aaDRe6JomsEkybNAh4dIoO5638PprJuX
	BAqvkotOxf3z6NFA85kmnV5hu9Dad9bzTmsOF5p0lmr26yyqXPDylJeRvv96tAImaRJw==
X-Received: by 2002:a17:906:6a21:b0:b87:4c37:7fd8 with SMTP id a640c23a62f3a-b87612797f9mr442736666b.49.1768466034542;
        Thu, 15 Jan 2026 00:33:54 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:53 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 11/18] clk: renesas: rzg2l: Move pointers after hw member
Date: Thu, 15 Jan 2026 10:33:25 +0200
Message-ID: <20260115083332.1063820-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:34:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21572

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a68ea80f85bbf7b69f69ef9e17e3e1be14d948c8 upstream.

Reorder the pointer members in struct mstp_clock so they appear immediately
after the hw member. This helps avoid potential padding and eliminates the
need for any calculations in the to_mod_clock() macro. As struct clk_hw
currently contains only pointers, placing it first also avoids padding.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250514090415.4098534-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index b447847610b0..015fbfb8351b 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1194,19 +1194,19 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
  * struct mstp_clock - MSTP gating clock
  *
  * @hw: handle between common and hardware-specific interfaces
+ * @priv: CPG/MSTP private data
+ * @sibling: pointer to the other coupled clock
  * @off: register offset
  * @bit: ON/MON bit
  * @enabled: soft state of the clock, if it is coupled with another clock
- * @priv: CPG/MSTP private data
- * @sibling: pointer to the other coupled clock
  */
 struct mstp_clock {
 	struct clk_hw hw;
+	struct rzg2l_cpg_priv *priv;
+	struct mstp_clock *sibling;
 	u16 off;
 	u8 bit;
 	bool enabled;
-	struct rzg2l_cpg_priv *priv;
-	struct mstp_clock *sibling;
 };
 
 #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
-- 
2.43.0


