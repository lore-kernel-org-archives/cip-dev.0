Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3948.1794223246215531436
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 03:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=acOWH76R;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20261109112043b3f1bd779500020774-intbrs@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20261109112043b3f1bd779500020774
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Nov 2026 12:20:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cXvzfMAorblgOrBk+dFvrzcyjjJIfBczeW57VMsIUqY=;
 b=acOWH76RwopnpleUYdqOIdPiKZpX0C/mhr4agbX5mfid+uHI5NIVtQ2ZGq7ClQHIySrwYy
 koqmS5QTQ7pHCCHujZ6cPRp3k47SZTwN2BfRQj9M4MGQjqYlg2wP8myGMYXxHxZfdCsxRqVD
 UIhEuv6yuR3fEbdL9lHFpdGpaQuDYt2aSaUd+4Z3seFe1wUzREXrbshsyh5wSgyCiIT1s8aQ
 iZml/Jh86WbegVZLym1pA+x0eRJsLE51mD/Csku7g1TeGp40fx1xRf9qmxSzHcNYffdb2l43
 sJHdAual02DI2WBXRynew9xPn5WNYFWbkVUXIV+Y/iCNZsdx4kpCtHEw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: Daniel Wagner <wagi@monom.org>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Pasquale Nieddu <pasquale.nieddu@siemens.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.12.y-cip v2 4/6] ARM: 9425/1: vfp: Use vfp_state_hold() in vfp_support_entry().
Date: Mon,  9 Nov 2026 12:20:39 +0100
Message-ID: <a06173f2f2befdce036a27bbb3451e93975fcd5c.1794223241.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1794223241.git.jan.kiszka@siemens.com>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 11:20:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24700
Content-Type: text/plain; charset="utf-8"

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 27035c23bad54ed552c6741210dd1c4fa50cb386 ]

vfp_entry() is invoked from exception handler and is fully preemptible.
It uses local_bh_disable() to remain uninterrupted while checking the
VFP state.
This is not working on PREEMPT_RT because local_bh_disable()
synchronizes the relevant section but the context remains fully
preemptible.

Use vfp_state_hold() for uninterrupted access.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/vfp/vfpmodule.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 1726db0500760..28dafae7758b8 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -708,7 +708,7 @@ static int vfp_support_entry(struct pt_regs *regs, u32 trigger)
 	if (!user_mode(regs))
 		return vfp_kmode_exception(regs, trigger);
 
-	local_bh_disable();
+	vfp_state_hold();
 	fpexc = fmrx(FPEXC);
 
 	/*
@@ -787,7 +787,7 @@ static int vfp_support_entry(struct pt_regs *regs, u32 trigger)
 			if (!(fpscr & FPSCR_IXE)) {
 				if (!(fpscr & FPSCR_LENGTH_MASK)) {
 					pr_debug("not VFP\n");
-					local_bh_enable();
+					vfp_state_release();
 					return -ENOEXEC;
 				}
 				fpexc |= FPEXC_DEX;
@@ -797,7 +797,7 @@ bounce:		regs->ARM_pc += 4;
 		VFP_bounce(trigger, fpexc, regs);
 	}
 
-	local_bh_enable();
+	vfp_state_release();
 	return 0;
 }
 
-- 
2.47.3

