Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3949.1794223246215694890
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 03:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=McNj8BTN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20261109112043003953fbc500020744-jhvats@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20261109112043003953fbc500020744
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Nov 2026 12:20:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DHj/AJRXTBjUAaitClhNnoGPwE/Pk1mVfIcoNZs2VYY=;
 b=McNj8BTNUbaeYxB64x0DJoYPcFnMDRYG1Uqe5Y0Nu5H1w1n45xgxdmHTotBIs+CpgJWRcV
 w3n6xQsoG2ZV6nmOeApoeyQHHx5gwYcS3azyMOn0K2S9qTSJpsYEdBrNbOqCiIA1nNafMET0
 ++kZEAFxS2sx+pVPf2uczBaZLNpSKQHJcMFebqYggvsmgD8uoZo+yc40Q0alvG+EPNWUq3Cl
 qj8cHnNkPYHliiSIZ0Ci9lwLTx23oRVYuQwkknGprfIgsMEXWQxqBfl/xTHxPFG6j22u6tLz
 AuwTHeBoADDJDrH4znzsDUxvx9ZKSDewsN+bFr2yheOIcAkcZFRCwjdw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: Daniel Wagner <wagi@monom.org>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Pasquale Nieddu <pasquale.nieddu@siemens.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.12.y-cip v2 3/6] ARM: 9424/1: vfp: Use vfp_state_hold() in vfp_sync_hwstate().
Date: Mon,  9 Nov 2026 12:20:38 +0100
Message-ID: <377763a35f75050b6d0ce64f5b558f32d33b5992.1794223241.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1794223241.git.jan.kiszka@siemens.com>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 11:20:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24699
Content-Type: text/plain; charset="utf-8"

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit b54cdbad4a39bb3abc85ac151f4882b3d92c5d79 ]

vfp_sync_hwstate() uses preempt_disable() followed by local_bh_disable()
to ensure that it won't get interrupted while checking the VFP state.
This harms PREEMPT_RT because softirq handling can get preempted and
local_bh_disable() synchronizes the related section with a sleeping lock
which does not work with disabled preemption.

Use the vfp_state_hold() to synchronize the access.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/vfp/vfpmodule.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 63de164c7fc7b..1726db0500760 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -540,11 +540,9 @@ static inline void vfp_pm_init(void) { }
  */
 void vfp_sync_hwstate(struct thread_info *thread)
 {
-	unsigned int cpu = get_cpu();
-
-	local_bh_disable();
+	vfp_state_hold();
 
-	if (vfp_state_in_hw(cpu, thread)) {
+	if (vfp_state_in_hw(raw_smp_processor_id(), thread)) {
 		u32 fpexc = fmrx(FPEXC);
 
 		/*
@@ -555,8 +553,7 @@ void vfp_sync_hwstate(struct thread_info *thread)
 		fmxr(FPEXC, fpexc);
 	}
 
-	local_bh_enable();
-	put_cpu();
+	vfp_state_release();
 }
 
 /* Ensure that the thread reloads the hardware VFP state on the next use. */
-- 
2.47.3

