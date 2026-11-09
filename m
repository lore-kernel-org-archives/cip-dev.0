Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3866.1794223245922302624
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 03:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=JvnWPXAu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20261109112043391af5490b00020711-pd953o@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261109112043391af5490b00020711
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Nov 2026 12:20:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/0DXf56UaExGgjGPHO0ejRA9Q7KkE1nLn4rxyFpilbw=;
 b=JvnWPXAulGzbmvtF9MtLlmRjY1x+GNN2v1/18kdTEn0rTi9uasAO+4gJraywEqdSM4cZFS
 5cwjEMhTsCXKFhhgWKD80HRVqziiLE/r1Mxbn/Vw4fcycucxnqeIJrG8THES6vogK4FnELzX
 8BDNIf6c01TLQgHPq6GJF9czu7wf5sguD21RGKzLjo0eGChPMPMZewjsZJrKzEOxq0f52diP
 WQZikHRh+piWUF7r+aue7QB/pWUDRUfzFiGL0DXgKpNc3r61ch7rIt/zH7DVF796X+HNjRvt
 xmS9ivAdRkhHnyzgMnkefAJP+GVsicYjWtYJhGF14+/XD7cyxxKy8Nfg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: Daniel Wagner <wagi@monom.org>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Pasquale Nieddu <pasquale.nieddu@siemens.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.12.y-cip v2 2/6] ARM: 9423/1: vfp: Provide vfp_state_hold() for VFP locking.
Date: Mon,  9 Nov 2026 12:20:37 +0100
Message-ID: <aed1bc5df07b76215c06e47504cf5c12134e7b69.1794223241.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1794223241.git.jan.kiszka@siemens.com>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 11:20:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24703
Content-Type: text/plain; charset="utf-8"

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit f26bdbe1fa9f79fa8cb0d0bf39303c3573c60552 ]

kernel_neon_begin() uses local_bh_disable() to ensure exclusive access
to the VFP unit. This is broken on PREEMPT_RT because a BH disabled
section remains preemptible on PREEMPT_RT.

Introduce vfp_state_hold() which uses local_bh_disable() and
preempt_disable() on PREEMPT_RT. Since softirqs are processed always in
thread context, disabling preemption is enough to ensure that the
current context won't get interrupted by something that is using the
VFP. Use it in kernel_neon_begin().

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/vfp/vfpmodule.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index b68efe643a12c..63de164c7fc7b 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -55,6 +55,34 @@ extern unsigned int VFP_arch_feroceon __alias(VFP_arch);
  */
 union vfp_state *vfp_current_hw_state[NR_CPUS];
 
+/*
+ * Claim ownership of the VFP unit.
+ *
+ * The caller may change VFP registers until vfp_state_release() is called.
+ *
+ * local_bh_disable() is used to disable preemption and to disable VFP
+ * processing in softirq context. On PREEMPT_RT kernels local_bh_disable() is
+ * not sufficient because it only serializes soft interrupt related sections
+ * via a local lock, but stays preemptible. Disabling preemption is the right
+ * choice here as bottom half processing is always in thread context on RT
+ * kernels so it implicitly prevents bottom half processing as well.
+ */
+static void vfp_state_hold(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
+}
+
+static void vfp_state_release(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
+}
+
 /*
  * Is 'thread's most up to date state stored in this CPUs hardware?
  * Must be called from non-preemptible context.
@@ -837,7 +865,7 @@ void kernel_neon_begin(void)
 	unsigned int cpu;
 	u32 fpexc;
 
-	local_bh_disable();
+	vfp_state_hold();
 
 	/*
 	 * Kernel mode NEON is only allowed outside of hardirq context with
@@ -868,7 +896,7 @@ void kernel_neon_end(void)
 {
 	/* Disable the NEON/VFP unit. */
 	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
-	local_bh_enable();
+	vfp_state_release();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
-- 
2.47.3

