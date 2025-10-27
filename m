Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A349CCF9EA
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 09:27:13 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.27796.1761557223422727720
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 02:27:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BqTqakV1;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471b80b994bso62832375e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761557221; x=1762162021; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/FMQaN/m0Ands2Vv4xlqbkKTwG4/3LXKEq3shC1e6w=;
        b=BqTqakV1oBmZfJQob9CTBS9FnUbJOqW60Swht0bCICH6jT82djkfLtK1b6Cbz9d1HM
         FChwxK6AQ9kOKtyx6M7K6SPAovz8jVpPWnVxkybWCHuYzpwe9i+iQaioVTzlqjhw+Bco
         Gh8wL5Kt3DuESWSPv40T4c9y6vblxd0FDlVJWchG5/4Xt3IniS4t8ILndREdnaKBBh1V
         avik+nmnFkliD29lUB3Vp6ANEBZSAyJKf41GTrnKsE4lHNOhJx6lc22uvLidwAIHkonQ
         fpnAvWi6Xryd594S3K3xp/8BNkctjiNYowgkvgeamO3BThDxIALO3TANKJwaArLap+SB
         8wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557221; x=1762162021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/FMQaN/m0Ands2Vv4xlqbkKTwG4/3LXKEq3shC1e6w=;
        b=ow9q44U2hBrfKpYSYmJBalhlABDP4IK+IzDY/Md7jCzBE3my8ghRMNTCEKItRSLzmm
         6qp/cakynV4DIMjFM8uMZCENB8ntJBg1PQb6pRAGQrb93nsJborSGeRmukK3/yQ+R+Q0
         4yf8gf5/AW4mJK3EQaVqqemsCqwU3+Z04wMonM07hwEMMjHp3PGENqIRbiTSUR7W7hYb
         7UlYib/Ck/8iO7oaSKLmcIZrMtj9HtJqt4M1N0QPyhHU3M1+HadcKN3IAd/WkyJ65USs
         gel1+SfcMB2CqzeSlxslU9EEUt/R4opox7/kAuVvi+s/S1h7puSxIhdbpmZQCzznhOzV
         QPyg==
X-Forwarded-Encrypted: i=1; AJvYcCWvEYJQxiiahHJGvio6mfmKMHsd+aZ6u354KI40kxBfoT0/lddE5FnuqMqjnkrU+Je9676lIU+g@lists.cip-project.org
X-Gm-Message-State: AOJu0YyhQDB7kuJfCHl06jB3cyikc+4CejqyGvHAd/kMO7xfTTObTjN/
	urj+aETLmms8kADeCS/zR4iOe3loHIylE4djhNRG3LBsLixPw9AP4gmr88tA3G+Qr24=
X-Gm-Gg: ASbGncvU56wttaq6TupyDW+SkPwA3l1719qecTW8Rjl9v5Q70DHwwSyXlIDqla7bmHo
	86JqX2roeQL4OPDEEp1AM6+7Bb8Y83YFfppET95zn5dPPpML45LrC/bMZIohWzHUdAlW8j2SBic
	ryuLWdjca4TjpuYwEEsapyItR/sqj5HAF6B8gUfj8Aa1D+ZeoykkgnXtD2tVoDpMtMKEsYOlw7Z
	3zd6pW3iXTDq+ITlMM5lCnOmhNUrNKTJiklEOaHemTBb0cG0f+a0xQdeHTxQBz7aBb7iHEyqH2J
	KYWhawTOJr85plvNP63L5qq21b5zztwcnnWrGD+OEUEUjBv8zokPx2k0oF3Vl9ofzXasPiyk7aJ
	M386qA6m6aqJ+74LntB/tb79oLq1h8wBUacQHSfB9Fw0i6/9+Ghg9vUybQroby1q5/h0UzkhLtw
	SypNUmQjDGsZg8yUU/LlQbW+mRTMaHfW9MNWfhkRVXIx6K3/NfoegnOhmQJxD3qNs7UHaqbA==
X-Google-Smtp-Source: AGHT+IErJpBeJYKTiEf+RVf213UNmtbf8KZ0QpDh+vMVDLYS+OWqO1RB0R1JyrOJ/kv+IKtMzoqr1Q==
X-Received: by 2002:a05:600d:4347:b0:475:faaa:8620 with SMTP id 5b1f17b1804b1-475faaa892dmr24610775e9.20.1761557221270;
        Mon, 27 Oct 2025 02:27:01 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:83af:5b2:a2ec:e92e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4cba64sm124980465e9.14.2025.10.27.02.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:27:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip] mm: page_alloc: Add kernel parameter to select maximum PCP batch scale number
Date: Mon, 27 Oct 2025 11:26:58 +0200
Message-ID: <20251027092658.84955-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 09:27:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20241

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid
too long latency") introduced default PCP (Per-CPU Pageset) batch size as
a configuration flag. The configuration flag is CONFIG_PCP_BATCH_SCALE_MAX.

The ARM64 defconfig has CONFIG_PCP_BATCH_SCALE_MAX=5. This defconfig
is used by a high range of SoCs.

The Renesas RZ/G3S SoC is a single CPU SoC, with L1$ (I-cache 32Kbytes,
D-cache 32 Kbytes), L3$ (256 Kbytes), but no L2$. It is currently used in
a configuration with 1 GiB RAM size. In this configuration, starting with
commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid too
long latency") the "bonnie++ -d /mnt -u root" benchmark takes ~14 minutes
while previously it took ~10 minutes. The /mnt directory is mounted on SD
card. Same behavior is reproduced on similar Renesas single core devices
(e.g., Renesas RZ/G2UL). bonnie++ version used was 1.04.

Add a new kernel parameter to allow systems like Renesas RZ/G3S to
continue have the same performance numbers with the default mainline
ARM64 config. With pcp_batch_scale_max=5 (the default value) the bonnie++
benchmark takes ~14 minutes while with pcp_batch_scale_max=0 it takes
~10 minutes.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Hi,

This patch was posted as RFC at [1] but got no feedback. Starting with
kernel v6.17 the behaviour was restored by commits:

18ebe55a9236 ("mm/readahead: terminate async readahead on natural boundary")
38b0ece6d763 ("mm/filemap: allow arch to request folio size for exec memory")

However, these commits are not fixes and depends on other updates and
cleanup done on memory management subsystem b/w versions v6.9 and v6.17.

Please give your feedback.

Thank you,
Claudiu

[1] https://lore.kernel.org/all/20241126095138.1832464-1-claudiu.beznea.uj@bp.renesas.com/

 .../admin-guide/kernel-parameters.txt         |  6 +++++
 mm/page_alloc.c                               | 26 ++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8724c2c580b8..4fba1837d7ca 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4734,6 +4734,12 @@
 			for debug and development, but should not be
 			needed on a platform with proper driver support.
 
+	pcp_batch_scale_max=n
+			Format: <integer>
+			Range: 0,6 : number
+			Default : CONFIG_PCP_BATCH_SCALE_MAX
+			Used for setting the scale number for PCP batch scale algorithm.
+
 	pdcchassis=	[PARISC,HW] Disable/Enable PDC Chassis Status codes at
 			boot time.
 			Format: { 0 | 1 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 752576749db9..468e63b8b979 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -163,6 +163,20 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 #define pcp_spin_unlock(ptr)						\
 	pcpu_spin_unlock(lock, ptr)
 
+static unsigned int pcp_batch_scale_max = CONFIG_PCP_BATCH_SCALE_MAX;
+#define MAX_PCP_BATCH	6
+
+static int __init setup_pcp_batch_scale_max(char *str)
+{
+	get_option(&str, (unsigned int *)&pcp_batch_scale_max);
+
+	if (pcp_batch_scale_max > MAX_PCP_BATCH)
+		pcp_batch_scale_max = MAX_PCP_BATCH;
+
+	return 1;
+}
+__setup("pcp_batch_scale_max=", setup_pcp_batch_scale_max);
+
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -2376,7 +2390,7 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	 * control latency.  This caps pcp->high decrement too.
 	 */
 	if (pcp->high > high_min) {
-		pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
+		pcp->high = max3(pcp->count - (batch << pcp_batch_scale_max),
 				 pcp->high - (pcp->high >> 3), high_min);
 		if (pcp->high > high_min)
 			todo++;
@@ -2426,7 +2440,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 		count = pcp->count;
 		if (count) {
 			int to_drain = min(count,
-				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
+				pcp->batch << pcp_batch_scale_max);
 
 			free_pcppages_bulk(zone, to_drain, pcp, 0);
 			count -= to_drain;
@@ -2554,7 +2568,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int batch, int high, bool free
 
 	/* Free as much as possible if batch freeing high-order pages. */
 	if (unlikely(free_high))
-		return min(pcp->count, batch << CONFIG_PCP_BATCH_SCALE_MAX);
+		return min(pcp->count, batch << pcp_batch_scale_max);
 
 	/* Check for PCP disabled or boot pageset */
 	if (unlikely(high < batch))
@@ -2586,7 +2600,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 		return 0;
 
 	if (unlikely(free_high)) {
-		pcp->high = max(high - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
+		pcp->high = max(high - (batch << pcp_batch_scale_max),
 				high_min);
 		return 0;
 	}
@@ -2656,7 +2670,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	} else if (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) {
 		pcp->flags &= ~PCPF_PREV_FREE_HIGH_ORDER;
 	}
-	if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
+	if (pcp->free_count < (batch << pcp_batch_scale_max))
 		pcp->free_count += (1 << order);
 	high = nr_pcp_high(pcp, zone, batch, free_high);
 	if (pcp->count >= high) {
@@ -2999,7 +3013,7 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
 		 * subsequent allocation of order-0 pages without any freeing.
 		 */
 		if (batch <= max_nr_alloc &&
-		    pcp->alloc_factor < CONFIG_PCP_BATCH_SCALE_MAX)
+		    pcp->alloc_factor < pcp_batch_scale_max)
 			pcp->alloc_factor++;
 		batch = min(batch, max_nr_alloc);
 	}
-- 
2.43.0


