Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB55C44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 13:43:10 +0000 (UTC)
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch [109.224.244.102])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13751.1784295665698623891
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:41:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@monom.org header.s=protonmail header.b=GgFh0suk;
 spf=pass (domain: monom.org, ip: 109.224.244.102, mailfrom: wagi@monom.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org;
	s=protonmail; t=1784295022; x=1784554222;
	bh=qcSoK0xU7zs3rvlaTge2nY1/aMW3MYccyLk+16rrshU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GgFh0sukFZelZCvzSpA4IMjPyOo3WYGFj1HEXe5+1mtf7FU51sLp4jdqXB67uQvIL
	 FX1fOpny4WGbeiul6ussDqoIDL4hK01bBE8DWL9uSNcJo3hZNetUq2/JS56RvCKNOv
	 7snCMnSVBQYZ391IF6O7Z6LuPvbmaS20p9yChSft3WNbfZfthYjeg1pMJMR2yUjqiU
	 BVhM09emjmbSItOMxjz+DnCVS5dC/ubMmiEFnPXZikIG65fI1hqWL8DQsg60Let+B+
	 KZQPuwnGV6Zl/j7csgUnfGU4ldfh4liWdcfWRvExOmxCN20fxz+JTp53DUYsJvsqkt
	 J6Ky1YvguI0ow==
Date: Fri, 17 Jul 2026 13:30:15 +0000
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
From: Daniel Wagner <wagi@monom.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba, stable-rt@vger.kernel.org, cip-dev@lists.cip-project.org
Subject: v6.12-rt arm updates
Message-ID: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org>
Feedback-ID: 209527651:user:proton
X-Pm-Message-ID: fa1b6be5744de9d8b1c872143ab719f270fddb94
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 13:43:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23679

Hi,

I am about to update v6.12-rt and the arm section needs some updates.
Here is what I am going to do. Please let me know if there is something
wrong.

Thanks,
Daniel

###########################################################################
# ARM
###########################################################################
# https://lore.kernel.org/all/cover.1777964226.git.jan.kiszka@siemens.com/

# v6.12-stable material relevant for RT but no patches to drop from
# rt queue:
# 47c5d569d39d ("ARM: group is_permission_fault() with=20
is_translation_fault()")
# d5e8be7bea8d ("ARM: allow __do_kernel_fault() to report execution of=20
memory faults")
# 25ae6a5c473b ("ARM: fix hash_name() fault")
# fed889edca79 ("ARM: fix branch predictor hardening")

# landed in v6.12-stable, thus drop those
# (commit ids from v6.12-stable):
# 0001-arm-Disable-jump-label-on-PREEMPT_RT.patch
# 256d97d3587b ("ARM: 9459/1: Disable jump-label on PREEMPT_RT")

# arm-Disable-FAST_GUP-on-PREEMPT_RT-if-HIGHPTE-is-als.patch
# 1b645cd729ef ("ARM: 9461/1: Disable HIGHPTE on PREEMPT_RT kernels")

# Commits in upstream but not in v6.12-stable
ARM__enable_irq_in_translation_section_permission_fault_handlers.patch
#  59e4f3b45b96 ("ARM: ensure interrupts are enabled in __do_user_fault()")

0001-ARM-vfp-Provide-vfp_state_hold-for-VFP-locking.patch
0002-ARM-vfp-Use-vfp_state_hold-in-vfp_sync_hwstate.patch
0003-ARM-vfp-Use-vfp_state_hold-in-vfp_support_entry.patch
0004-ARM-vfp-Move-sending-signals-outside-of-vfp_state_ho.patch
#  f26bdbe1fa9f ("ARM: 9423/1: vfp: Provide vfp_state_hold() for VFP=20
locking.")
   #  b54cdbad4a39 ("ARM: 9424/1: vfp: Use vfp_state_hold() in=20
vfp_sync_hwstate().")
#  27035c23bad5 ("ARM: 9425/1: vfp: Use vfp_state_hold() in=20
vfp_support_entry().")
#  c0b5195bad63 ("ARM: 9426/1: vfp: Move sending signals outside of=20
vfp_state_hold()ed section.")

ARM__Allow_to_enable_RT.patch
#  c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")


