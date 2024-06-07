Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2884CC27C75
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:11 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.43039.1717769343249075063
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GwKAZz3O;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so798270e87.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769341; x=1718374141; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSHkEWYYpFN2gEe1WBEPlS/X35QGVe9hjuaMhfDNB+0=;
        b=GwKAZz3O6sJXmJOQTypNzXTHhemBfj4rssce/D6ica57a1hBCjhEwv8aVtlHjePaWC
         fBNeCIqUYnqQT0S6oI5Ec082sXr+9bVVxn8UN1xz3jJS1V0w1blrTlN8vzwKaTylgzBa
         q1HupMBdEfuQQEVi+nOCd1tNtnNe+KK486ZAWcWoRJOzpGai2Ek0lsQsTIlILFwzXYiv
         Cv5yGydCEJZVtp0eYP8gopLqYHdJbvdZ6iijeZBmkD+gJOtXdmmLpwF4BNK3OuiM+sSB
         CtZpRld2XXWc76XxEpcBEk58WGKLUSmYotnRaKZYafMMl7BK3Q0EtJjuxdsk1vfTt6G1
         jrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769341; x=1718374141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSHkEWYYpFN2gEe1WBEPlS/X35QGVe9hjuaMhfDNB+0=;
        b=VFe8uTXpCakTtci/USxvTB8TiiN3B4jJHeTD1SQhwME+Jdp0E3Ojf9+PiuNjeUQsGY
         Md0mTTD3dykLi8Mwu5MtzHIPZMDNW2mpFoRGG6VUq/+bBe6ycf2Bt8aJgp6JPIhrfUsD
         U94Lyq8GPgWfoM8oiyxcbJ1ee9rzrybDGmnYtv35AiqUhtUSaWpMatIli16xxtDcH2jS
         UQzlYDq611sZ4ctMLXocxMN52wPf+bri1xoU2HIp3RgWJU89J2IxAJNs3ww9D/Qfu0QU
         CiRn/EbzFW4Rx00REEROz0/Q+lLSmW9UJGfH7TRw9obwHMHbhy7RSMXlC8pUG13DMgxH
         yM+g==
X-Gm-Message-State: AOJu0YyFjlGTRlFYCS4upc8FHPSV9kTXHJxuWHmKeTFniNun0SVp58I2
	9cWaJGSkeh5N+lq6s3OlKiZq44sCWGMdkqKDmCG2Jo0EAqHxMln8jn5KFvjVn0C/+9azAW8q5Y/
	i
X-Google-Smtp-Source: AGHT+IG5u2q6NtdbXK4N0MqBOg0fnPMQ/UJHsi+qKbLpqJW9mbuviLxbdrF60NGuRUNeUrNkDKl45w==
X-Received: by 2002:a05:6512:220a:b0:52b:f6ab:6f75 with SMTP id 2adb3069b0e04-52bf6ab71b4mr95534e87.29.1717769341371;
        Fri, 07 Jun 2024 07:09:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 02/17] bitfield: add FIELD_PREP_CONST()
Date: Fri,  7 Jun 2024 17:08:41 +0300
Message-Id: <20240607140856.2497508-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16163

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
index c9be1657f03d..ebfa12f69501 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -115,6 +115,32 @@
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


