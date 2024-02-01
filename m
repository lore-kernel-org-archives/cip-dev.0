Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512D4C48286
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 22:22:44 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web10.6661.1706820217179205786
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Feb 2024 12:43:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ErlyIVLN;
 spf=pass (domain: gmail.com, ip: 209.85.161.54, mailfrom: schmitzmic@gmail.com)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-598699c0f1eso969672eaf.2
        for <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 12:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706820216; x=1707425016; darn=lists.cip-project.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqE6uH8/Cq6TCWIinemSe0QCaBK2NUC2RCn1iBCFHF4=;
        b=ErlyIVLNN25fMw+A2JzIgSuZR4cAjPg+YSGWze0HR5wf30lEOY9XWhOlFtom1Ej8NJ
         ny1zUj+SsL8DL6pI4787XTFsRGpWfLyzYoGtTWrPvK6f7oYmpyG01HefPPmF39MywWkN
         cZOluSEOheJsiiK1sM0R/mt6eIGaD1zjXu463c0YV3lCw9L35dHGHEWfiIBZS4PAUAYk
         YIbud/WvSrom/3+g55eNTR3dNEcmxRYSL0nmRDyVsH9ixV5Hqnnxm+e+WSV55yXUszYM
         iu8QRHqa7evvADa6zf/E8KepwPE0671SQb+nnxFu/BHOMyHNgl32FQ2DbOqpGBX2oT7E
         oiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706820216; x=1707425016;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqE6uH8/Cq6TCWIinemSe0QCaBK2NUC2RCn1iBCFHF4=;
        b=IiFGABqorwzwCsPWuaP48p9/+PQLzBM6h25iVvFx4AjlpnV0TZdAVtJzj7LBPaxN3V
         hlz4ArpBLgdBPvswNTB154dch+SIfN7UJkKb+TuN4LLNKjlw1EKFaEBjyY0MMBUQaCHP
         PUvp+165K/2OBszi+Mljeef1kT6QnsGCCO8xauh14oCUa7lh93K0nchaBh26EUG7eYt4
         rROgTcDYCXv2Xae1aiArWIq2fyNd6t3vuHVskD9sMiNPVvm7olHk3ZUXFH9nV/UW2Pqz
         8hS5h58Od+n8slFBySC/jfnH+NjFP55Qxa1ASHyBPmDsS3mI7UouYN9kUyFz2UQq7xbJ
         RakA==
X-Gm-Message-State: AOJu0YwDJ5wqHrOYAKkZV7viOHdqXOq8hUjmT6GZLLBkATyLw3fzYhai
	z8OYJJtqM/QIwH3EbolD377SAb4dsPpoAK+Wlf/pLmyPdl0wF+VI
X-Google-Smtp-Source: AGHT+IElUOpekOWXInWPuFamxcNU9k2n56BCl4uiPwqSeuPqOByMHhac26XcajXOoDDuLtfCmEwtPQ==
X-Received: by 2002:a05:6359:4c25:b0:16b:9480:41c8 with SMTP id kj37-20020a0563594c2500b0016b948041c8mr2715859rwc.1.1706820216251;
        Thu, 01 Feb 2024 12:43:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVxTkcQEsDuA7Qso2jciEebYEiXSAgj8RN9c7v682ZB1gi6DXWik7/BKFc+ISQ0qrIvZntEF0zoiW2y+PD7t/J4DSBlasjSpBSJkm0LsZgj7kaNnYdXMFD3Cmzq33yOovyEkp6R02tZx2yFXr+1xZHRLQ==
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id d32-20020a631d60000000b005d30550f954sm270803pgm.31.2024.02.01.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:43:35 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id E662A36031A; Fri,  2 Feb 2024 09:43:30 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: schmitzmic@gmail.com,
	cip-dev@lists.cip-project.org,
	Ulrich Hecht <uli@fpond.eu>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: include module.h to make use of exception handling in traps.c
Date: Fri,  2 Feb 2024 09:43:29 +1300
Message-Id: <20240201204329.24202-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 22:22:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14598

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


