Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40E8C4452B
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 13:43:39 +0000 (UTC)
Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14609.1784297881061802081
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 07:18:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@monom.org header.s=protonmail header.b=SAS/K6ww;
 spf=pass (domain: monom.org, ip: 185.70.43.97, mailfrom: wagi@monom.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org;
	s=protonmail; t=1784297878; x=1784557078;
	bh=cAs0tv9YwBjDiL82Q3cICzEx9b52YgKptif7g/7ck1w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SAS/K6wwXwnxVPQrIZv2rfe/TkYfa6yrCg+XACyr8iQule4w3G9JOxGVDxPKDgwfK
	 xhvUfMAM4N3wI4Aw2ZgaRXLeOj9QITxuSKGK/uQHbIfJXUIjmIgUBtuSZTN4V4WfpU
	 ur5nQckqneeRkq083qgyS0UNkQAYpqJ1j+SWkxPaJtvNcKnXea/YqwlDoVD2POExHv
	 g8KQfEK0OsdijdIUXvZXrQd3N4G1lJRGzQ7HAZqy5/6rNW1+xLXcqRntFZUFiuMnh6
	 7tgLoeHOSBYUtoga4zuCJoM2tR7d6Iu2kgjvPlHEkSNeuw3tnm2nFlWyJ/dZN0xA+Y
	 I6dXqCiLPcp1A==
Date: Fri, 17 Jul 2026 14:17:54 +0000
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
From: Daniel Wagner <wagi@monom.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba, stable-rt@vger.kernel.org, cip-dev@lists.cip-project.org
Subject: Re: v6.12-rt arm updates
Message-ID: <3706c5f1-53af-460e-9409-fa1b78706645@monom.org>
In-Reply-To: <20260717140336.krBy6oQT@linutronix.de>
References: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org> <20260717134624._f9g97lg@linutronix.de> <141ef3cb-361d-432c-a7ba-af010406283c@monom.org> <20260717140336.krBy6oQT@linutronix.de>
Feedback-ID: 209527651:user:proton
X-Pm-Message-ID: 8f2cef08f4da1841c18d72d0cc2148f69324cccb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 13:43:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23684

On 7/17/26 4:03 PM, bigeasy@linutronix.de wrote:
> On 2026-07-17 13:54:58 [+0000], Daniel Wagner wrote:
>>>> # Commits in upstream but not in v6.12-stable
>>>> ARM__enable_irq_in_translation_section_permission_fault_handlers.patch
>>>> #  59e4f3b45b96 ("ARM: ensure interrupts are enabled in __do_user_faul=
t()")
>>
>> I've replaced the downstream patch with the commit mentioned...
>>> You should be able to drop a few of those and replace them with what I
>>> have in v6.18
>>> =09https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.gi=
t/commit/?h=3Dlinux-6.18.y-rt-patches&id=3D73c8e8d7a75fcc8b9026385e64990f3d=
5ec8a40d
>>
>> ... which is what you have done here as well. The main difference is
>> that v6.12-stable ships 'ARM: 9459/1: Disable jump-label on PREEMPT_RT'
>=20
> It does? Not as of v6.12.95.

You are right, I was looking at the wrong tree. I am adding it back.

>> The resulting v6.12-rt queue is
>>
>> 0001-ARM-ensure-interrupts-are-enabled-in-__do_user_fault.patch
>=20
> This looks like 59e4f3b45b96a ("ARM: ensure interrupts are enabled in __d=
o_user_fault()")

Correct.

So here my updated queue (the comment points to the upstream
version of the patch):

0001-ARM-ensure-interrupts-are-enabled-in-__do_user_fault.patch
# 59e4f3b45b96 ("ARM: ensure interrupts are enabled in __do_user_fault()")

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

0001-arm-Disable-jump-label-on-PREEMPT_RT.patch
# 56d97d3587b ("ARM: 9459/1: Disable jump-label on PREEMPT_RT")

ARM__Allow_to_enable_RT.patch
#  c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")


