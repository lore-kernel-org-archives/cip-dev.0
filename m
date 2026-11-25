Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35792.1795581965377001863
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 20:46:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=AgzhYp6K;
 spf=pass (domain: gmail.com, ip: 209.85.167.170, mailfrom: takuo.koguchi@gmail.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4d198f1a591so5255926b6e.2
        for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 20:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795581964; x=1796186764; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2e2uIwZsrHS9ixWWPgFWwK2wHA9gsxJ759z7pgoZzg8=;
        b=AgzhYp6KYZTgrWYi/IK+j1FWcHbf0GEOcOBBkO5kfya0sgY76DIAqt/S5ROCh4wYqU
         bLMeFiPyh2i8bz3CPu0b3kvPWUu1HJcVWps4uJoztZyMfcBPfZG1yCFygPsMFabrmnhd
         JdeXYJx1nm94vYLBFYzYtZ9AJ5N7qO3yoOFsabUpO6apnmAJnlw/bkHp96cKKr3oaprc
         T1kh77eglimlq/ZAoUikSdVvFhZWP44DhPoSvXzPejlExrY0hvx9XFpoNTOaznHBNiUU
         xFFZ6TB/mWnNt4a4Adaz8wBKDWp/y0kxa5lWM2RE7cwGU0H/jltviJ4d+OM7cdMQPmzm
         23cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581964; x=1796186764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2e2uIwZsrHS9ixWWPgFWwK2wHA9gsxJ759z7pgoZzg8=;
        b=1Sn2FhQq62FXMx+vLodYU8wo9KX3NJpJa8n4NeJnmWlIW2JI5TzPL83MmVmOKg4kPc
         8dvwV9j7uxRGHxRJcpNPrhQbZWLAeO3u/FEimxZMlyq0bnVBce/ugG9wKavqL0XG+Hqc
         YlIGbEdWwhmUx7250nKpl7+vNip9zHRWIF8gP/kSsb9KiuvQy+ufQ8X+PpnF6tX6Bvuq
         +In4v0L4fX8kBPv5Yhg6iMazZhv3rsffxr24NivQJo5UtGG0u5nMkLcdxsEFnOom5vNI
         C7w91BNoqN+XOH7GjNxTuvHQFYNGo46xp0TcFwxqMeUwloftkeFS66LnzjRMgu2nPdso
         CayA==
X-Gm-Message-State: APuU4Z+zU7Jg6hu6F8cda0qqpGQQRVbkREv9Ix3a/VXQgh1QLJYugy0I
	y5fyk0V2ZZ5nfD8iawKd6YVLzaNYdBqA0Md+yLGTaTE5fi1gdN5T+LB/s5j8Lijh
X-Gm-Gg: AZFdTZfTSF4lT4tRNrm72MEn6tS5vcAe6P2rPS4sFP/XA8afb9+LvsG7sy+/xB5wiF2
	+NmTcgNXVCFPa8qwRe5IGPRP2y0taa2Ne942imM44Eq4gbbSgq8s1ovAFTMUWglnwh/SIkTNYEg
	kQV3mn6LqHKn0OQLS/FFNgbLPKuB7MZeJhJj5PeeLp40BWOUT2HMPRtKUUZS6yzEpX04GbsjGWt
	C3UrOdc2+9KS3KS5YgpJuopqukB4KfDjiCy5H5OfQEdGAQHRgsLuLIB4NlYi71MbYobz95IP5kF
	5VQJIx0mlx2S7x6AODMimwN39oSAQ8DaFEMYI+mqIFLsaAaZ+0EcyGIZN/a861wt3iCGw9mAOco
	SfgbDJ/VvHg8lg+BaRRAP2vAJz1xki0fiXstgDzOQ2fwtu8P1bpBjWQ37wlSAlA7JIir5G3cdTK
	3vVbNpXN+07WgpXQJv+Vi9HKbwP7D/Hd/DVjJWYUzt9y5dpjUcPqDJaBSD1tc1CaHTwRAEJ6zCL
	pjbqaZrCGerxDUzFpQQA+umneKZWMOZGHZhLXnGXjkrXXPNF6i13C3R7HI1Z2PDD3FSZ/suyJWz
	yY/MbTq9mDh4uqd06e/E4J2g0h5yLiXgMPEhMw==
X-Received: by 2002:a17:903:19cb:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2f03f16d710mr157838455ad.47.1795581652129;
        Tue, 24 Nov 2026 20:40:52 -0800 (PST)
Return-Path: <takuo.koguchi@gmail.com>
Received: from koguchi-S5.. ([240f:7f:fd65:1:ab45:6585:2538:b62d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1a8asm78327855ad.24.2026.11.24.20.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:40:51 -0800 (PST)
From: Takuo Koguchi <takuo.koguchi@gmail.com>
X-Google-Original-From: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
To: cip-dev@lists.cip-project.org
Cc: rostedt@goodmis.org,
	Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
Subject: [PATCH] memcontrol: protect drain_local_stock() with get_cpu_var()
Date: Wed, 25 Nov 2026 13:39:00 +0900
Message-Id: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 06:26:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25069
Content-Type: text/plain; charset="utf-8"

On PREEMPT_RT, drain_local_stock() accesses the per-cpu memcg_stock
via this_cpu_ptr() without disabling preemption.

Accesses to memcg_stock from consume_stock() and refill_stock() are
already serialized using get_cpu_var()/put_cpu_var(). However,
drain_local_stock() still accesses the same per-cpu state without
equivalent protection.

As a result, drain_local_stock() may be preempted while operating on
memcg_stock, allowing another task running on the same CPU to observe
or modify the same per-cpu stock concurrently. This may result in
inconsistent updates of cached charges and stock counts.

Failures were observed as divergence between memcg accounting and
actual memory consumption. The divergence occurred in both positive
and negative directions, indicating corruption of accounting state
rather than a simple charge leak.

Under stress testing, the accounting divergence was reproducible and
was frequently accompanied by oops storms. Protecting
drain_local_stock() with get_cpu_var()/put_cpu_var() eliminated the
accounting divergence and the associated stability issues.

Use get_cpu_var()/put_cpu_var() in drain_local_stock() to serialize
accesses to the per-cpu memcg stock and make its protection consistent
with the other memcg stock users.

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
---
 mm/memcontrol.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f9d80952723c..9b298ce10a7a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1933,14 +1933,21 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 }
 
 /*
- * This must be called under preempt disabled or must be called by
- * a thread which is pinned to local cpu.
+ * Drain this cpu's stock.  Called directly by drain_all_stock() for the
+ * local cpu and as a work item for the other cpus.  Preemption is
+ * disabled here because neither caller guarantees it on PREEMPT_RT:
+ * drain_all_stock() only holds get_cpu_light(), which is a plain
+ * barrier() without CONFIG_SMP, and the work item runs in a preemptible
+ * kworker.  consume_stock() and refill_stock() run with preemption
+ * disabled, so this keeps every user of the per-cpu stock serialized.
  */
 static void drain_local_stock(struct work_struct *dummy)
 {
-	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
+	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
+
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+	put_cpu_var(memcg_stock);
 }
 
 /*
-- 
2.34.1

