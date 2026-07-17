Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028F5C4452B
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 13:43:20 +0000 (UTC)
Received: from mail-106105.protonmail.ch (mail-106105.protonmail.ch [79.135.106.105])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14179.1784296507296287183
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:55:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@monom.org header.s=protonmail header.b=Wv5wnm0D;
 spf=pass (domain: monom.org, ip: 79.135.106.105, mailfrom: wagi@monom.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org;
	s=protonmail; t=1784296504; x=1784555704;
	bh=XbbKwQtzllT+hNtNfJ6fNiWJkBJHrUcs/sT1JUcNXog=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Wv5wnm0D9irRottqxaUGkebpHOUCVSe6tq9gY8/EuBu0rvNfBP1De0Z81l9oW+wyE
	 gzYQq8qDRtYX3MwKhK3wSsm8IWd8sraLQkdFW4WhUzTKOHVV7buvZYSdI/aAbXGsRk
	 uTlHCxL1M6eHid4V/efcEho52hjyibGEA9OrIl9ei/GMs5RlZ3GPC75M0fsf2allqP
	 XeJxx5brk6GvOAqjTQpEWfeiAOsem7/6RIrE9YRwmy1xck7vnznMdsAo2aTjdsXBxK
	 hIaozxJESTZaQ+D29gbKyusXI8198mUJTdAWOelElRSNNE93LK0ZLo4+umV3yA8a7h
	 KGZK84iKqRGvw==
Date: Fri, 17 Jul 2026 13:54:58 +0000
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
From: Daniel Wagner <wagi@monom.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba, stable-rt@vger.kernel.org, cip-dev@lists.cip-project.org
Subject: Re: v6.12-rt arm updates
Message-ID: <141ef3cb-361d-432c-a7ba-af010406283c@monom.org>
In-Reply-To: <20260717134624._f9g97lg@linutronix.de>
References: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org> <20260717134624._f9g97lg@linutronix.de>
Feedback-ID: 209527651:user:proton
X-Pm-Message-ID: 23abad78c1b6f681fed7e6cc8bb449ffe99bc9a0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 13:43:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23681

On 7/17/26 3:46 PM, bigeasy@linutronix.de wrote:
> not sure how to read this below, I try my best.

Yeah, sorry, it's a bit random notes.

>> # v6.12-stable material relevant for RT but no patches to drop from
>> # rt queue:
>> # 47c5d569d39d ("ARM: group is_permission_fault() with
>> is_translation_fault()")
>> # d5e8be7bea8d ("ARM: allow __do_kernel_fault() to report execution of
>> memory faults")
>> # 25ae6a5c473b ("ARM: fix hash_name() fault")
>> # fed889edca79 ("ARM: fix branch predictor hardening")
>=20
> Those few should have entered via -stable.

Right, nothing to do here. I just mentioned them here, because they were=20
mentioned as dependency in in Jan's backport RFC series.

>> # landed in v6.12-stable, thus drop those
>> # (commit ids from v6.12-stable):
>> # 0001-arm-Disable-jump-label-on-PREEMPT_RT.patch
>> # 256d97d3587b ("ARM: 9459/1: Disable jump-label on PREEMPT_RT")
>>
>> # arm-Disable-FAST_GUP-on-PREEMPT_RT-if-HIGHPTE-is-als.patch
>> # 1b645cd729ef ("ARM: 9461/1: Disable HIGHPTE on PREEMPT_RT kernels")

I've dropped those.

>> # Commits in upstream but not in v6.12-stable
>> ARM__enable_irq_in_translation_section_permission_fault_handlers.patch
>> #  59e4f3b45b96 ("ARM: ensure interrupts are enabled in __do_user_fault(=
)")

I've replaced the downstream patch with the commit mentioned...
> You should be able to drop a few of those and replace them with what I
> have in v6.18
> =09https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/=
commit/?h=3Dlinux-6.18.y-rt-patches&id=3D73c8e8d7a75fcc8b9026385e64990f3d5e=
c8a40d=09

... which is what you have done here as well. The main difference is=20
that v6.12-stable ships 'ARM: 9459/1: Disable jump-label on PREEMPT_RT'

The resulting v6.12-rt queue is

0001-ARM-ensure-interrupts-are-enabled-in-__do_user_fault.patch
0001-ARM-vfp-Provide-vfp_state_hold-for-VFP-locking.patch
0002-ARM-vfp-Use-vfp_state_hold-in-vfp_sync_hwstate.patch
0003-ARM-vfp-Use-vfp_state_hold-in-vfp_support_entry.patch
0004-ARM-vfp-Move-sending-signals-outside-of-vfp_state_ho.patch
ARM__Allow_to_enable_RT.patch


