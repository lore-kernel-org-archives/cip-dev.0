Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392DEC44502
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19084.1782820141907257348
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QeZs+veu;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-474303f3c72so1243776f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820140; x=1783424940; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNxzmM6614tDS2dZBF4nAi7JTnnL5HpZ4TcQeAY3V9I=;
        b=QeZs+veuu1hrQYpwzv8El6W4VXHCPp8cIrUDoxJgM6GwhOsXorfvxEMPCckZsGSsQE
         DoCKAbD05n8UFVuuGzfecPEhjpxSmXAeMUp6cT/na5SgXz9RHo+r/qwJ4rO8Tq4LSCG8
         si8NlIubOGRtP2woH0XT5UdWAhhO60KttliupmO9u3cYRa0mOwWPrOdR89x4+AhOdQ81
         97KEbGxxVrERooeolo4bfER1T5HARQXJ9+5OfzFWCVQdiQqvoSlLKQ/ABkRbFtgxZUT6
         6xiC/Kp+4hE43+6DAPTuGpY+rBuem3reeo8uL7H6XWz9Nzh2MyTK9Y2oSezFFs5B5T6S
         UIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820140; x=1783424940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cNxzmM6614tDS2dZBF4nAi7JTnnL5HpZ4TcQeAY3V9I=;
        b=Vz/7kyHp5up8EtLRkg1u7P1AKtjoL68HGrGthvmn+0GCSxvcy6/9+591cIoLQyByo+
         zYF+aT04eAhtXCmoQo39XZJv8bh5xy+It6FVSgV+UsSHh8YebmWu9OVKUSzqiIM7IAn9
         e166wWedEDklT4XjlesFCfeQQx2kX9RTH3L3X+mcXX1ikqpFxzl0Nz5U51QN8ZNcoYbm
         VppB3o0PkYEa4sTxs25GBECZZCwzrayV0yCJeJAtA00xR60ZP6REnh3N1/J41jEE3GVz
         7SCSD1CYpv1lSA3DlEp2NSv9PwIEdjTZU6XxhwefiSZ0ai45s1xpNsPjGNJrw9UTZdh9
         Jn7g==
X-Gm-Message-State: AOJu0YzcI+NPhRuoIXwmY7UvHRX9+/ulkTDjkCyzB43kwp/dejrd0gs7
	A0ohgPJCfJEFgI4/u6uc2s19wJSQ7rnLb1L2UsEVOS7u8KtO1sJXlslkXmawVq5m
X-Gm-Gg: AfdE7cnAVQ0Q3WsT2O3zjfH4or2Jfezh3ONCTXT8M9T+DvHoDVmCV3a2x77jyH+fQoj
	CB47OrxKPOODHmfh7wlvcHHES20XZHA3o7gpXFejp/AErPEwSsmpN/KiaqqGXS8sZIdGWkvgflC
	KvVBkXkkVG5QbbG+RiRjEefeEJuiqhw6R7Szdts7W2ptQ1zkP3HEWnKCqkV79pomlRT4ldpoArf
	ORnRrhlJulbdN3NCGolAn+nAJRsa4fPOlTXbW8i70XqrvbCbty4LIlEmMAd3NzrUz6FNH7FI1sw
	ufMAb8fceK3Dpxcz+G3jpyoCyMZcGmeH9gIxyvOozuKrHBERm8AbIVUvaxjrgC5QLqHfwarNN7W
	eH9i8Q+WNkIQULnaodFqCmZe/+B9XeBu9uRuoUFbq19iTAsoGnbCJ5Om1R6lmRhLtHKB4Hp7U2h
	k/yAAfiMSLKaVwFcyZx+zVlYTehU/9FNXAMGnvIA==
X-Received: by 2002:adf:e005:0:20b0:460:70ae:f1af with SMTP id ffacd0b85a97d-4765a1cabc9mr144766f8f.27.1782820140021;
        Tue, 30 Jun 2026 04:49:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:59 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 31/39] clk: renesas: rzg2l: Consolidate DEF_MUX() and DEF_MUX_FLAGS()
Date: Tue, 30 Jun 2026 12:47:50 +0100
Message-ID: <20260630114813.92739-32-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23355

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 44c1733331eb691493c29839520ed31edda34d8d ]

Define DEF_MUX() using DEF_MUX_FLAGS(), to reduce duplication.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/46e2713f39cc5efc4b05a65723e0781a9dd8291c.1777562043.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 0e63b62e8435..33f54ba0e64e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -178,22 +178,19 @@ enum clk_types {
 		 .invalid_rate = _invalid_rate, \
 		 .max_rate = _max_rate, .flag = (_clk_flags), \
 		 .notifier = _notif)
-#define DEF_MUX(_name, _id, _conf, _parent_names) \
+#define DEF_MUX_FLAGS(_name, _id, _conf, _parent_names, _flag) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
 		 .num_parents = ARRAY_SIZE(_parent_names), \
-		 .mux_flags = CLK_MUX_HIWORD_MASK)
+		 .mux_flags = CLK_MUX_HIWORD_MASK, \
+		 .flag = _flag)
+#define DEF_MUX(_name, _id, _conf, _parent_names) \
+	DEF_MUX_FLAGS(_name, _id, _conf, _parent_names, 0)
 #define DEF_MUX_RO(_name, _id, _conf, _parent_names) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
 		 .num_parents = ARRAY_SIZE(_parent_names), \
 		 .mux_flags = CLK_MUX_READ_ONLY)
-#define DEF_MUX_FLAGS(_name, _id, _conf, _parent_names, _flag) \
-	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
-		 .parent_names = _parent_names, \
-		 .num_parents = ARRAY_SIZE(_parent_names), \
-		 .mux_flags = CLK_MUX_HIWORD_MASK, \
-		 .flag = _flag)
 #define DEF_SD_MUX(_name, _id, _conf, _sconf, _parent_names, _mtable, _clk_flags, _notifier) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, .sconf = _sconf, \
 		 .parent_names = _parent_names, \
-- 
2.43.0


