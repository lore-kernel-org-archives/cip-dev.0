Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B61C27C5F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:20 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.42956.1717769237338188955
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JyV/LlvY;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso3087936a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769236; x=1718374036; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRqhDOpJPl4ZdR2btK2vHTpZbN6ka3HE2+e3GyIxtFM=;
        b=JyV/LlvYc2fsgHK6pJ5/95UVBHvArw5OYYrK46+MZEK6YjeyK0L2HSwJkUaL0p9oRA
         BBqEh9UDw+d9T4J0IQguTJmJHFa9lUfL8xDlHutOkeobe2IyMovwgQr9pUKL+2bRjLct
         8RtCvlMHz65wlRTaaMHRrKJWWnyzGIip8lj7O1yLi9SBuM1xY6jNBiqki241l9FaFjqd
         P1AK2u6aumnfY3fA5zRsL4SD1OZNEtEwW5ccncDGrk/7WflCQ0DHDsQzIxanzTI69bFX
         NM2Jn6a0/fDZ7Vq9gBH2G0kzvT/HgwpUReHSZvJtFCXRBY2YiJ40jtmyQWvium/WSMPA
         syBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769236; x=1718374036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRqhDOpJPl4ZdR2btK2vHTpZbN6ka3HE2+e3GyIxtFM=;
        b=I00OsOnyy27R35N8MS4kskOiyyMNrjnZO09mnkwjTWylb7FqEn/IM/1dFRufZ935N/
         o2dZNanM+PSxqcAKFllrvdMKAS3lZNrkSY+lzZxP4xXUDTqrAxH5D0o19ETCy/i+/7tD
         6qPZjKO03nRoyhG/NUypF9Tziqd3BTuT9jgc9IREAin/Fs/hnQyQHJgT6D2IApR6Pfsy
         h8qcevEfVPX58TiUnv2H+J0aN+EuOQzZnwA9SC4LcO8QL8UtiA96t9fSLzpLqMA/84L1
         s5gjzLOcqMzuO1p2QOU0PZ/rmPAtHyysqOgCthg86eQ3Y877Ms6mUJBpr5w3tkPwDskF
         dncw==
X-Gm-Message-State: AOJu0Yzem2rq3qDxH/arW/24pCAymg9YBMu0VsR2ySJb3o4Pown1/Azx
	BIWXqugR5k+3jwA4aK/aW2mG6wjC4mL1U8uwnU3wpJgyq0EV8bz6gebeRpyuunw=
X-Google-Smtp-Source: AGHT+IH0kNS5ILcq/HSNlYQP6mC3PvWM2TM+H1Ym8jnF2THSNWtMZ58+rhAbE3DiKW8kA9QmH7dzoQ==
X-Received: by 2002:a50:99d2:0:b0:57c:671d:8459 with SMTP id 4fb4d7f45d1cf-57c671d84d8mr159480a12.40.1717769235618;
        Fri, 07 Jun 2024 07:07:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 02/19] bitfield: add FIELD_PREP_CONST()
Date: Fri,  7 Jun 2024 17:06:54 +0300
Message-Id: <20240607140711.2497286-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16143

From: Johannes Berg <johannes.berg@intel.com>

commit e2192de59e457aef8d1f055a452131f0b3e5d097 upstream.

Neither FIELD_PREP() nor *_encode_bits() can be used
in constant contexts (such as initializers), but we
don't want to define shift constants for all masks
just for use in initializers, and having checks that
the values fit is also useful.

Therefore, add FIELD_PREP_CONST() which is a smaller
version of FIELD_PREP() that can only take constant
arguments and has less friendly (but not less strict)
error checks, and expands to a constant value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20230118142652.53f20593504b.Iaeea0aee77a6493d70e573b4aa55c91c00e01e4b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/bitfield.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 6093fa6db260..532442516bb4 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -112,6 +112,32 @@
 		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
 	})
 
+#define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
+
+/**
+ * FIELD_PREP_CONST() - prepare a constant bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * FIELD_PREP_CONST() masks and shifts up the value.  The result should
+ * be combined with other fields of the bitfield using logical OR.
+ *
+ * Unlike FIELD_PREP() this is a constant expression and can therefore
+ * be used in initializers. Error checking is less comfortable for this
+ * version, and non-constant masks cannot be used.
+ */
+#define FIELD_PREP_CONST(_mask, _val)					\
+	(								\
+		/* mask must be non-zero */				\
+		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
+		/* check if value fits */				\
+		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
+		/* check if mask is contiguous */			\
+		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
+		/* and create the value */				\
+		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
+	)
+
 /**
  * FIELD_GET() - extract a bitfield element
  * @_mask: shifted mask defining the field's length and position
-- 
2.39.2


