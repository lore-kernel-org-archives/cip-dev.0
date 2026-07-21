Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5EEC4451C
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 03:32:38 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22376.1784639550947565646
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 06:12:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@monom.org header.s=protonmail header.b=e2dJ+yjU;
 spf=pass (domain: monom.org, ip: 185.70.43.27, mailfrom: wagi@monom.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org;
	s=protonmail; t=1784639192; x=1784898392;
	bh=E5A5b0327Pu+h0l7FQGtboYgL7vm9ILo4n76903TrDg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e2dJ+yjUBhhaRIR/z7KNBstAYou9qsAzHZv9N5+CXgkxlnpxA+6sqeQUK4Fel1tDW
	 gNnse513fi90ddrjIRiBads0Cy72wNsMnsGLQpMwZQGTiEEOcEsLgiMAiqZMw3WO18
	 6A5NtebyGcOpjOIzioOI2fLWS4YSnVCj7DmkTaNph0bGMedD043OlDoWxnWNAIuMbf
	 C8AqBeIUydzs2RztZTAz1+JjyrBSOcyL5g7NQQDsJkIR81vn8qY5A/00+eqYgXbg9o
	 5/AEoh/9eSOgrMvoMz3BeDRLNNDywmp7puUCcAM3BS73f5z/opQY+8sfQNHKM6U8xb
	 G4XJ7dFaLzihg==
Date: Tue, 21 Jul 2026 13:06:24 +0000
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
From: Daniel Wagner <wagi@monom.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba, stable-rt@vger.kernel.org, cip-dev@lists.cip-project.org
Subject: Re: v6.12-rt arm updates
Message-ID: <72dcc63c-9786-488e-a840-f383533f2fbc@monom.org>
In-Reply-To: <20260717142210._ukh1yBD@linutronix.de>
References: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org> <20260717134624._f9g97lg@linutronix.de> <141ef3cb-361d-432c-a7ba-af010406283c@monom.org> <20260717140336.krBy6oQT@linutronix.de> <3706c5f1-53af-460e-9409-fa1b78706645@monom.org> <20260717142210._ukh1yBD@linutronix.de>
Feedback-ID: 209527651:user:proton
X-Pm-Message-ID: fbc4539bb5c48b7fbe5d12fc288f30e1c04a6985
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 03:32:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23706

On 7/17/26 4:22 PM, bigeasy@linutronix.de wrote:
> On 2026-07-17 14:17:54 [+0000], Daniel Wagner wrote:
>> So here my updated queue (the comment points to the upstream
>> version of the patch):
>=20
> This looks okay. Your delta should be
> =09https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/=
diff/?h=3Dlinux-6.18.y-rt&id=3D868deefc37dfbdfe93d760155e0c84f5f3363cc2&id2=
=3D90a16cd5d693a75843b766d0efa17f1bc0149931
My diff looks a bit different, due to the backport of a bunch of arm=20
cleanup patches. I've pushed the result to

   v6.12-rt-next
   v6.12-rt-patches-next

It all runs fine in my test setup. Any objections to release this?


