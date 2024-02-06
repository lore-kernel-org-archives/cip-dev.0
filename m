Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A71C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 22:12:56 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.4834.1707253886408310373
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 13:11:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XtfdMm8j;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: schmitzmic@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d8aadc624dso46277145ad.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 13:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707253886; x=1707858686; darn=lists.cip-project.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PqE6uH8/Cq6TCWIinemSe0QCaBK2NUC2RCn1iBCFHF4=;
        b=XtfdMm8jUV2loBBkR5gks1ekIZAjyuryzLzTjCSLXoHvrD/jAMVUvbQntxHdqDqE2w
         gJYkN68m/aZY6GJ0D901Pu6pzfmipBZxAfae/pcB5FfP2rpRHtpbAuabXle30xCZAfwF
         /E6VSzuguMoNPG90w2rJ85Wh080N6lKNrWcmArgYurGUmFXZCLKnOMWmZM2YWhWVMRC5
         EiTvplvNl6eeqTt2Ta1dEO4YTUFnY72YRnTPwLaKoZEwMU9b4H/9s46YPrRI+KUOvZ/O
         Sp0Bhn+NtLO1+yXl+2l7EwOH+E8DVY7eJag0/6vlMeDLisru700hK1h1eRQdE31rrAFU
         DMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707253886; x=1707858686;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqE6uH8/Cq6TCWIinemSe0QCaBK2NUC2RCn1iBCFHF4=;
        b=OBMInyNU0EzpmUTVcoRcmUNDeekYWlkV1WSY3FbPHowXCNcgATKHZwZIcoDi84wWqV
         ImCxaqvP4iw5iBYtUYWboeEFWRTYCVdl83VzEodTKztmJDFfc4AV+rECzCSsMEqaYhG7
         EGj9I7AaoSeCzTIa9kKBK3toH1VegrcjCd1mYXQN3schTmfHh3keKjxyGc6QQ8Acrh+V
         JiDeWz6UBOZxtDagjGJcncrP5M5q11sh2a33gy/c51esadokCIvwQBiLdwc95JMq9+tS
         rv9oV2C0Vj+hlXxIF9JpC/gnxo3SPhTySMOv5cGsbLSzD8lyQdtrdDR5t9X2Z/pkCAcY
         tKJg==
X-Gm-Message-State: AOJu0YytwLVXAn7ab0P8VyiX/40RRwWIzfU2CGvDXn+1hObS6wxmUzHQ
	BpPgFDXuRqccNKn0q9+PRZ+q0JdsUi4qdWzITXn3Dyb3buSIrcXS
X-Google-Smtp-Source: AGHT+IGmwQSPPVAt+TE0g2WV2ikuAiWW1r5pv64s3VnqEsrnUBfJD2yzCMTBgUZsPlSokFKOt089Fg==
X-Received: by 2002:a17:903:2288:b0:1d9:a50f:90eb with SMTP id b8-20020a170903228800b001d9a50f90ebmr2527928plh.38.1707253884921;
        Tue, 06 Feb 2024 13:11:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVhe+1o7MZf0ZSLPDZ89G3eyIBq8NltOXhakk3m26xDrJwW4qI7QoVVnk8nsn8yXic0ptWCm4BtqEEpC63k7SXFYDWL0F7v6CpArw4roTs9lTrQ3VClGvkvr+sgbx23CMJ6S1K9xzafRTONIiq3PSrR3BtkPS9nEja//QnuY5ccxgszJXjtVlPsRVz7omfIXAElZLt8r/xgRSwb4gzb7BCSvA==
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id kv4-20020a17090328c400b001d9df9589e5sm1661523plb.10.2024.02.06.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:11:24 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 4072136031F; Wed,  7 Feb 2024 10:11:21 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	Michael Schmitz <schmitzmic@gmail.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH v3 3/8] m68k: include module.h to make use of exception handling in traps.c
Date: Wed,  7 Feb 2024 10:10:59 +1300
Message-Id: <20240206211104.26421-4-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240206211104.26421-1-schmitzmic@gmail.com>
References: <20240206211104.26421-1-schmitzmic@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 22:12:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14835

Backporting commit 513138a14063760e (m68k: Only force 030
bus error if PC not in exception table) to v4.4 by the CIP
project revealed a build error due to extable.h not yet
available.

extable.h was split off module.h in v4.8 (commit
0ef7653797addea8) so amend 513138a14063760e accordingly.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401302324.d3o6tgup-lkp@intel.com/
Cc: <cip-dev@lists.cip-project.org> # 4.4
Cc: Ulrich Hecht <uli@fpond.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index c547140b8325..2209214cf91c 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -29,7 +29,7 @@
 #include <linux/init.h>
 #include <linux/ptrace.h>
 #include <linux/kallsyms.h>
-#include <linux/extable.h>
+#include <linux/module.h>
 
 #include <asm/setup.h>
 #include <asm/fpu.h>
-- 
2.17.1


