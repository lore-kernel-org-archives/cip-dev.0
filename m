Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEAFC4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 03:52:53 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.54462.1707100364832053907
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Feb 2024 18:32:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=S3HHuqKO;
 spf=pass (domain: gmail.com, ip: 209.85.210.174, mailfrom: schmitzmic@gmail.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e03b3f7286so258180b3a.3
        for <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 18:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707100364; x=1707705164; darn=lists.cip-project.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PqE6uH8/Cq6TCWIinemSe0QCaBK2NUC2RCn1iBCFHF4=;
        b=S3HHuqKOruGHYwaWzADsQy6WXkBxhkKQIldoRtRKZR2ay9yiQRQugXDCrXw+NDI7z9
         67TxwEeyOJVOM8VOUtoqJw7DIZfrtcjSQjqQ5pO8WXbXQchb434W32mO3jkqp9w5uhop
         TQGjlvjrJDmlv2wIbbA8q3OPzYTm4+6s2n5SFl5lGRFaAT2fUs7xY5fYKumoWFgWkeA2
         HOwRQIHwfdMitUBaI6i9Km0f1Z/jPrKVVjiAxf211YdPRrX8ojPJlb23l18Fu5Jh0wxh
         r9ODA3o0uGU/MeyYlvi0ysDJX2Xwnhq6Pct89ZOozQcjabEezgzH60mGnJuMGSZa+qWh
         Apgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707100364; x=1707705164;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqE6uH8/Cq6TCWIinemSe0QCaBK2NUC2RCn1iBCFHF4=;
        b=q/Ta4P0dmcffRgvXBIW+uqUroqvRKtvqKQdS1rABY0c35yp7+VyNRCAVmEm2roQ9Iy
         AuZr/GaqZ35NCFJM41CmwtlbtNVjP6PpvcsRamzmAh2mP55rlumoEzUAkO9KpQOqnNqF
         nVptomzMejd/lqg7A74AULuqVv8uWomeYR7hlfvTszNCOxcTQl/tqiEmNSZulc8Zrea0
         iiOUHaZcOWfjSm9BsNRTQHUY6oV03FyN+YAPUROxJXmRaIAdItIb7g31CbL0WVUysBTh
         DP1+YfJ29d6dfX3Gwn++gcJc4tcRpk0fTM8C66AQmaz61A5NR7UF2DVHYLbR/xPRmwFP
         Ac+Q==
X-Gm-Message-State: AOJu0YxTVEzCXxxgKGn1mty74gPib9qTvTlEHXgn+3so0cgmc8GLuPUd
	tJMzitnVTD2R8aJqciM9GNCPZvyEYQgKm019ylQCwTehIR7aZy7O
X-Google-Smtp-Source: AGHT+IEPRBZ8aEhOP+55baxn1zYfWFn8N0/EEv9JPS7OqFm9rR0QoylZUqHPdtvj2iqiQaEiIkqsjA==
X-Received: by 2002:a05:6a20:289d:b0:19b:81be:34e4 with SMTP id q29-20020a056a20289d00b0019b81be34e4mr9439625pzf.50.1707100364237;
        Sun, 04 Feb 2024 18:32:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXezBHIlyJOQ/bYNCP6CDaHuyj4OwZZYcDLha5EicTIEkJueTrd86bG5MXiGwXd03kfYEKQZtjC+7HBpGYC2nymy31qIPlkwDijv5QD3z8fW0fvIbNX8PH1YYKo3PbEIs3SSmr8SN0TVud4d07zZCNv4ol6oqS6R5wDixIXYklmFgmVnT+7YB/hDRlVrPXgX7EjXpIAyb/lDafnfHBLUhOwwA==
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id ln14-20020a056a003cce00b006e03b82016asm1652200pfb.33.2024.02.04.18.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:32:43 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id CD62236034E; Mon,  5 Feb 2024 15:32:39 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	Michael Schmitz <schmitzmic@gmail.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH RFC v2 3/8] m68k: include module.h to make use of exception handling in traps.c
Date: Mon,  5 Feb 2024 15:32:31 +1300
Message-Id: <20240205023236.9325-4-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240205023236.9325-1-schmitzmic@gmail.com>
References: <20240205023236.9325-1-schmitzmic@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 03:52:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14658

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


