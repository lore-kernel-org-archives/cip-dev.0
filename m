Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C86FFD8752
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:57 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73768.1773747407031993492
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gO7asDVd;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48541edecf9so61509155e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747405; x=1774352205; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/mIySWt7GcZv3IqZNVm+NpPza5/LTKJrgitxWuvOrU=;
        b=gO7asDVd34CiaBGgXxykLel5cNp9tGMR2+lwXXoftpp2fuqiIP5aaXgLxVeQXwvvFG
         wUhPGzt8qzl1YkqqYl7s3khnfmIVuI0Y/Q6piUplV2Aya+weU8WSOp5LQxhO/itCDX6/
         JDPw/N60/RBROmrEQD9yWOdageRGPxny7EIVSwqj3OHdJkoUfz6mxky9hL/9eSmKOT7a
         jLjR6fhMApY2ihoA1nVz4VR/C878bJynIYIEcAMDcxQquBUoA7cSJWDAQ5m6wcKWpHQE
         TNJ6ot6efYn/qwuW1DpztD5Uq4Y2YJ5kdQoDnwqiFSlpock+/ZwEsTYjVs4UuhwtsS9C
         /SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747405; x=1774352205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/mIySWt7GcZv3IqZNVm+NpPza5/LTKJrgitxWuvOrU=;
        b=orqy2c3hTIrB7jWOiaG5m7k8qKXRINI4i089xy7qpIdCzEaB7Oay42DnQtWu8MhmmD
         QAB5w9B6JXDgZ+Vc3JzXbt21MxJAajShV3Ak5WpGzeMcxG80YMhTsOfUkfWXKyIGZbgi
         io4S+4x62923iBcIHf7YXRd8DfO5zYZ6fJDsDyvqyYGx8CNStEqPE02BY63Yrwetn0fj
         YU4NW8Lac34rj1BFDySaebHeOZ6cndtIY+49E/qtnS620/3OUnD4g3lwF2o5qWEcHei8
         uSkSWnBdrCuoOQqLRC9NMmWln3QaW9BaM6xJtVot/KDnqkHQCiF0L/xqKlN8Fvniy28u
         ivpw==
X-Gm-Message-State: AOJu0Yy7svJuQXW+DPI4OHUTXL1Ur9hH7+gDihh2p+UvVRIrc2Ijh6q3
	Rcbl+GZCbl+1aoWeu2bUa35GAIhRAM0vN4TVqKIloTtKpHCsKhDwTt/TUlrDWg==
X-Gm-Gg: ATEYQzyLUyEgR+sLriXtRUlLSbCfri1ZleZqLafwEj/1cqqKigUQw7qI8p2BDnVdmXc
	1UzzXiTnH7qVwF53ZZ+gumFY91ZIfYfXFvKFPzFyBKQiulzxV04TPYYs++weuRvwqwmehL4GD8c
	HvCqme4xwetEBGLhsHQ68x7LqubwepMU6fmt/G9pWLrcoWYvjL8RE2CzXQCfyVpsnIrJn5J+90m
	wwejosUyOGYi5qEAD2aVY3W1JCtUrQzC3JN854s36AhKfpY1GT/FuQp84BlxLoo1uB4CHyCi2dc
	DRgYm23u6TFGvE3ItXPm1g5WtSNVWdGkKQtNRPXSApu/RLsKEgzViOHVfeECdOKZggpupSpSwAg
	7Q/GcCDt+UZIBdZUZKpXklwjdY33BaTzkfbB4UvfTm2D1AFJlK+EWi8l++9DzP62LKTLkk6uYhy
	YshMQIyDkZCPxeIqJtISOzEZoXeXtbcYUTPJhoZf+ZS2/kBPps
X-Received: by 2002:a05:600c:524b:b0:485:2c61:9459 with SMTP id 5b1f17b1804b1-485570ce1b9mr293023695e9.8.1773747404971;
        Tue, 17 Mar 2026 04:36:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:44 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/11] dt-bindings: clock: renesas,r9a09g047-cpg: Add USB3.0 core clocks
Date: Tue, 17 Mar 2026 11:36:28 +0000
Message-ID: <20260317113643.311192-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22475

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit a24cd110e664396061b0a72930734bf419bf88c4 ]

Add definitions for USB3.0 core clocks in the R9A09G047 CPG DT bindings
header file.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250909180803.140939-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g047-cpg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g047-cpg.h b/include/dt-bindings/clock/renesas,r9a09g047-cpg.h
index a27132f9a6c8..f165df8a6f5a 100644
--- a/include/dt-bindings/clock/renesas,r9a09g047-cpg.h
+++ b/include/dt-bindings/clock/renesas,r9a09g047-cpg.h
@@ -20,5 +20,7 @@
 #define R9A09G047_SPI_CLK_SPI			9
 #define R9A09G047_GBETH_0_CLK_PTP_REF_I		10
 #define R9A09G047_GBETH_1_CLK_PTP_REF_I		11
+#define R9A09G047_USB3_0_REF_ALT_CLK_P		12
+#define R9A09G047_USB3_0_CLKCORE		13
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G047_CPG_H__ */
-- 
2.43.0


