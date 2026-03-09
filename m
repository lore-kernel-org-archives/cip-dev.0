Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD3F417F7
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:09 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15567.1773066368801615819
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nF239tx3;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so98465675e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066367; x=1773671167; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PxXG++yLxudQZ9C4rnDIBd1gNdgXCqUoq/Eqju8308=;
        b=nF239tx3hDxcGEOwPoRd0wbW6iQFccfGy4aVIraabdDSsg2oDzWBoXYK24TSc4SuxD
         b/hSFkZVZp5YdAoBDFZ5BCCOZn+p0sSKrmeKUAz/+FgiRYceulZJRIl8XU0AlyUsDnqd
         BXg7YwAmUiJgOyCjdgYKw5CHV5qdQt8VaKJ6e3kTCMfUvuP1ZzSoIYKeqGsfFi6OV7Ov
         0k/hTLZlbn1pXDephCPhe9FX1J/q6EhILua3l7ml5Ck3w2/HC8B+7MqwWenuxHcqc82Z
         9bIzvtONxnEVt7kFKKwwHRY1FXgG/THKlb6EN3xzZ2g1jIYytabWDFO3xg7nXF+ZhGgH
         aOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066367; x=1773671167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PxXG++yLxudQZ9C4rnDIBd1gNdgXCqUoq/Eqju8308=;
        b=DpPyWX2pAxOjE4cOr2pURmyDaSqVLsbfOarJ1+ZB5BBe/xb33N/BAJiUeR7+0c5RCp
         0HzMogg8M7RVAttpYlLiy3ZzS56bmjd7Fy+1tMK/ZBOHhw0Zn7duYARiwnAr82iKB4YP
         RmjYPRplOZy2HhXIG5foA5ptMzCQ+hpYEKsIMUvjo4S7USe2w1jcvNEi1ztJxg50mdm+
         o31eIgwRZGtrwdvB/tCUb0/nRcylsLO4pab5gTxJNudOJM5Q5JjLEwYObY062Lxh3yTk
         HLs97xkOPIvtcG01+rJxyPK3lI67ssrWApfCADxdVfcSZQq0aecsu6MW2h1nCA+qh0QZ
         tANg==
X-Gm-Message-State: AOJu0Yzx05i/JByDvnoUjkGMcg/mUiSh6Kpoha8yLwRnNFUQ98lDfZNx
	TeIx8YUCDK6iLRXHPhS8ZjU+hNzlbqc9eJHdR0rzZnfQPuvNz6+p8l8ZcxEazQ==
X-Gm-Gg: ATEYQzzRGrNq0ofKSirHcE3LknJRWROmJyWIUoEOiOov2vsEERgRg1yXYnpD3BiIX5z
	wP0TfONFGKHY85dWlaTtDQoi1a8IeWSZfyLytRA7AqKhHTm8lFmpRwgiYeGnQpC+SyPufSmMkY7
	QrcIRMsQOvV1PzWgA/t2ZVCX7bLETlWpZrUzYdS/NpotwX28Z6Pyg45HPeFP24aGeRs8cAHB31N
	Nmd4KZ3TVWO3xlFl8Bk2sqVrs2NgZnogJtu9XnPQhxKIKVLCWNKmzhaoM4vZpOhb/Fhsg9uqkCd
	es+9n+Tya6aizw8AZc7p20ZJLeegozIlrJITyHR2R0xF/y/EIpBb5UcyuKUVrH706zAtaIAWeX3
	GeNrVfL4KVIg1WwQx7tO8YSl4+UcbKxoQ8JK38cOxeQZQWrtF7yumdMXVcWH1wEh0SX5CsRxOED
	C3wzn90QMHaef3Tsu3spj1g9YML+fyCDQ=
X-Received: by 2002:a05:600c:3f05:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-4853f723386mr31331775e9.15.1773066366726;
        Mon, 09 Mar 2026 07:26:06 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:06 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 28/29] bitfield: Add FIELD_MODIFY() helper
Date: Mon,  9 Mar 2026 14:25:28 +0000
Message-ID: <20260309142549.987737-29-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22196

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
index 63928f173223..6d9a53db54b6 100644
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
@@ -156,6 +156,23 @@
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


