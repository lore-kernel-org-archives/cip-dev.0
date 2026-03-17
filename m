Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CA1FD709D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73442.1773746258730292411
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ao2v5Oz2;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso50010955e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746257; x=1774351057; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzGZ5/rIZMSyvy3llRxHygUGk8zmt3p77IOfp6qQAas=;
        b=Ao2v5Oz27XvR4kvqwPBdWbiHH+xbGKEDgsoC+fbpMBkHJgT7an0JMA+C7xdjt+jCNM
         oTj1IRyzgPRIHRGhUKPdDNI4pk9w8cHP3kEmVouL6Im6UicnT1vcJX52QekZCxRzaVjN
         n6UOz74KuPZRQUpU0Ij5pHwfeF17IraxdkLrFKGutKvtcwClK+Y/C4UnqWrc5ILP8UhI
         8yBmybQkhOY+dhro3G/VgFxsfuuNCU7D/HdWDv5Rc0oyuQDfHNktNmG3mLmApzu7WdJU
         oqCf699hEeWIG+eTDyWFYjhVPICqmXCieLiTDRfCdjJL2uVkXMfKbU2ARlKvXLcvQJxB
         Za+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746257; x=1774351057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wzGZ5/rIZMSyvy3llRxHygUGk8zmt3p77IOfp6qQAas=;
        b=WA1SPR3goHa52ZQLJzCGEu8Ri4oNv23s9ynuFyvMLIyUK+rlzZFPTJGXgjaWwJq9XY
         gOIvL2bNHvJzsdXwr4u99E/S7Q0SeyCuQtgHCwVwNHM1ra2qf7x6T5MHfAefmnBDA/Dl
         Lp17c+ePsNsNXrPPGS/Sr7AWnrK2YOk5m9/KTajFRqMxRJQvtw2sxhHDO5UHxpboUWWq
         ajRtgpwNpBsDZqSBqvmiDwVPDcfdiy/LF7WMO2ypYsM+d0F1lbZG47ltguEWZT0j4ehx
         POZq/2UfXYwOtgezDOS3LSYcFJI8rdgKvTK+CK7aox5EEFX0+WVQsDt1IWku/GYFRPOY
         pyYA==
X-Gm-Message-State: AOJu0YxZyJy7iKnNjXSArbK8V76Zf1ozIft5jpMfCXZw0Usg/yfBvcIa
	e252xVywkhizt6KhnzMQhWcfXp4itPDGWNtS0u2eccu7eP3EcSVz5wxM1eUSlA==
X-Gm-Gg: ATEYQzyaGS2eGBRCWiAU4fBWIfvpQ0BgMvMtdLnrrRawOn4EA2z4rrsgsCeCI+e8UHF
	uVjhfC6I93PfTQ/QKx1Ha89DX0jlEgDVzVUqcvlAEHv4V+W6/0TZ2HBOdRplHKpK0UxqEiznwc9
	N9Bo6wLTNPd3Jkjtft7J6wWbDnSSlTcBLZImrZQXBdobu4Str8U/0FDJO/CvBBMLMFH0877K78V
	G+NPJxEu3iDbNA5NLzM1CkykxmT0le2XdSwsCzNDlxjR+yEL4UM1s5q7liohoxLW1wXKoYk5xZZ
	hXvl4VSxUATFixxl45cKCeFdDUMAd5WqvXtyf7n5N500ZfKscDtE4m5Z500QDuVxF5tbB2wEhD4
	lhLcrWHn4FQKTn8wIWTxo9tsPU4EQh3VYa344ImDZqrTNXh1V3HXQzjU7MrGe1E7XQO7hRUWIDi
	3tC27L/HyPVMtXIxEh6SbaVrHUNWrbyxY2xrrPc4bE+qm6DBhKQRiCfkioIXU=
X-Received: by 2002:a05:600c:a15:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-48556710fd5mr287800435e9.33.1773746256811;
        Tue, 17 Mar 2026 04:17:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:36 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 21/39] bitfield: Add FIELD_MODIFY() helper
Date: Tue, 17 Mar 2026 11:16:46 +0000
Message-ID: <20260317111718.281633-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22454

From: Luo Jie <quic_luoj@quicinc.com>

[ Upstream commit a256ae22570ee4c3427fdc703a58a89afee6a332 ]

Add a helper for replacing the contents of bitfield in memory
with the specified value.

Even though a helper xxx_replace_bits() is available, it is not
well documented, and only reports errors at the run time, which
will not be helpful to catch possible overflow errors due to
incorrect parameter types used.

FIELD_MODIFY(REG_FIELD_C, &reg, c) is the wrapper to the code below.

	reg &= ~REG_FIELD_C;
	reg |= FIELD_PREP(REG_FIELD_C, c);

Yury: trim commit message, align backslashes.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/linux/bitfield.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ebfa12f69501..d0dfb2d86ec1 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -8,6 +8,7 @@
 #define _LINUX_BITFIELD_H
 
 #include <linux/build_bug.h>
+#include <linux/typecheck.h>
 #include <asm/byteorder.h>
 
 /*
@@ -38,8 +39,7 @@
  *	  FIELD_PREP(REG_FIELD_D, 0x40);
  *
  * Modify:
- *  reg &= ~REG_FIELD_C;
- *  reg |= FIELD_PREP(REG_FIELD_C, c);
+ *  FIELD_MODIFY(REG_FIELD_C, &reg, c);
  */
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
@@ -155,6 +155,23 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
+/**
+ * FIELD_MODIFY() - modify a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_reg_p: pointer to the memory that should be updated
+ * @_val: value to store in the bitfield
+ *
+ * FIELD_MODIFY() modifies the set of bits in @_reg_p specified by @_mask,
+ * by replacing them with the bitfield value passed in as @_val.
+ */
+#define FIELD_MODIFY(_mask, _reg_p, _val)						\
+	({										\
+		typecheck_pointer(_reg_p);						\
+		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: ");		\
+		*(_reg_p) &= ~(_mask);							\
+		*(_reg_p) |= (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask));	\
+	})
+
 extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
-- 
2.43.0


