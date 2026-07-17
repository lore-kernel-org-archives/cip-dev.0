Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C2C4452A
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 13:43:29 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14059.1784296559390711186
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:55:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=wUrPlUje;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=8teemIv7;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Fri, 17 Jul 2026 15:46:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784295985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6yiIX/RmGHsSjDTg3/B0hv5zvL90f0Is3yNRDum9Bqo=;
	b=wUrPlUjemnEbnY782WXHevmp5Tg8AXyih11A3sW5MRthpr0HfTlaCMJJQS/ghpr9bnovuf
	MoRRVO+lJzhm8Ltst2mW0Vc3BCS3z7+in74YCw71NfNK4PzcdCEM9e77V/f8wiTBbfjfW+
	9iCp15Qw/42Hpo3AXmPc/xXML7AbFNKzchMNeMPeH2kB8WA6YLBYTItoPJGierayxfzPRU
	FCv70+2N2B0j92fOREV4G6Ah+psCoQAi9Rk55ojBPE//rZBAyrkTcCabM2ErKwx3A7oH5h
	B9upVmyVIvOa/lwq0O4SXSpH/B/Yh+QBLf48FkmhIEsjhHg2FDQOM43iAU5Jqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784295985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6yiIX/RmGHsSjDTg3/B0hv5zvL90f0Is3yNRDum9Bqo=;
	b=8teemIv7Nx72b8ZPvGwMbngpyqek5dmFITasJYNqZp8/fnVEBku+mfOApLpgyZIRoXS9Ce
	B3oQGHP4GmcFu3CA==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba, stable-rt@vger.kernel.org,
	cip-dev@lists.cip-project.org
Subject: Re: v6.12-rt arm updates
Message-ID: <20260717134624._f9g97lg@linutronix.de>
References: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org>
MIME-Version: 1.0
In-Reply-To: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 13:43:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23682

On 2026-07-17 13:30:15 [+0000], Daniel Wagner wrote:
> Hi,
Hi,

> I am about to update v6.12-rt and the arm section needs some updates.
> Here is what I am going to do. Please let me know if there is something
> wrong.

not sure how to read this below, I try my best.

> Thanks,
> Daniel
> 
> ###########################################################################
> # ARM
> ###########################################################################
> # https://lore.kernel.org/all/cover.1777964226.git.jan.kiszka@siemens.com/
> 
> # v6.12-stable material relevant for RT but no patches to drop from
> # rt queue:
> # 47c5d569d39d ("ARM: group is_permission_fault() with 
> is_translation_fault()")
> # d5e8be7bea8d ("ARM: allow __do_kernel_fault() to report execution of 
> memory faults")
> # 25ae6a5c473b ("ARM: fix hash_name() fault")
> # fed889edca79 ("ARM: fix branch predictor hardening")

Those few should have entered via -stable.

> # landed in v6.12-stable, thus drop those
> # (commit ids from v6.12-stable):
> # 0001-arm-Disable-jump-label-on-PREEMPT_RT.patch
> # 256d97d3587b ("ARM: 9459/1: Disable jump-label on PREEMPT_RT")
> 
> # arm-Disable-FAST_GUP-on-PREEMPT_RT-if-HIGHPTE-is-als.patch
> # 1b645cd729ef ("ARM: 9461/1: Disable HIGHPTE on PREEMPT_RT kernels")
> 
> # Commits in upstream but not in v6.12-stable
> ARM__enable_irq_in_translation_section_permission_fault_handlers.patch
> #  59e4f3b45b96 ("ARM: ensure interrupts are enabled in __do_user_fault()")

You should be able to drop a few of those and replace them with what I
have in v6.18
	https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-6.18.y-rt-patches&id=73c8e8d7a75fcc8b9026385e64990f3d5ec8a40d

> 0001-ARM-vfp-Provide-vfp_state_hold-for-VFP-locking.patch
> 0002-ARM-vfp-Use-vfp_state_hold-in-vfp_sync_hwstate.patch
> 0003-ARM-vfp-Use-vfp_state_hold-in-vfp_support_entry.patch
> 0004-ARM-vfp-Move-sending-signals-outside-of-vfp_state_ho.patch
> #  f26bdbe1fa9f ("ARM: 9423/1: vfp: Provide vfp_state_hold() for VFP 
> locking.")
>    #  b54cdbad4a39 ("ARM: 9424/1: vfp: Use vfp_state_hold() in 
> vfp_sync_hwstate().")
> #  27035c23bad5 ("ARM: 9425/1: vfp: Use vfp_state_hold() in 
> vfp_support_entry().")
> #  c0b5195bad63 ("ARM: 9426/1: vfp: Move sending signals outside of 
> vfp_state_hold()ed section.")

And this needs to stay

> ARM__Allow_to_enable_RT.patch
> #  c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")
> 

Sebastian

