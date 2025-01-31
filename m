Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE3C0218F
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 13:28:11 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.18666.1738330081654857209
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 05:28:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=O+qYLNLg;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BBFE10382D08
	for <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 14:27:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738330079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N74rBdrJZRv5uWAY8kwoMrbvuPjjM+IO4wQHdltBnyU=;
	b=O+qYLNLgvzCuylUxTN9Qtulm+h7RuvVgJkufYW12Rv0oflnAXu0QEkcl6QhzPV5vXakJ9Z
	U8fu+L6qTdlEryFsRKMSTwyiR8mw1RL4qKSzGEIRZIwYQnzKyeC6Ci14Cmb76dPlYzEist
	U+oXk6HsNIFDKueskHNu/0njQ6p0XmDTC3vU56TTEC6RrRAebswzkhC9U+FHZ3eNaaNhGG
	5MjhIUeIapVZ9pzWr1Ww/6LRGOIqUSAuBGSOG4t1ohF3K68fiUR17lroAbOtLmZEHHGXLM
	bNdK4ZMe7kE80CZzmC+i8xbdLh09fOZZxAg7KjsY1ZQOztSxkFwTgZLroE360g==
Date: Fri, 31 Jan 2025 14:27:56 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Message-ID: <Z5zP3BaPnG5x/d6/@duo.ucw.cz>
References: <Z0mVe42i41SXemYu@duo.ucw.cz>
 <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
 <TYCPR01MB11385BAF7D5C56CC8CC378440E1E12@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z5FPtY4aUHqMoL4w@duo.ucw.cz>
 <181D46DD0F426F98.25327@lists.cip-project.org>
 <TYCPR01MB1138502709ED426B37B76CAD4E1E82@TYCPR01MB11385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2CQv3mJZA6c6WaEx"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1138502709ED426B37B76CAD4E1E82@TYCPR01MB11385.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 13:28:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17720


--2CQv3mJZA6c6WaEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > (1) Apply 0001 - 0016 to v4.4-rt and v4.9-rt (but not acceptable for -c=
ip-rt)
> > (2) Implement another flag like "system_is_scheduling" above then apply=
 it to
> > v4.4-rt and v4.9-rt (Again, no need to suggest (1)(2) to v4.14-rt or la=
ter because
> > SYSTEM_SCHEDULING is already there)
> > [...]
> > First, I'd like to make a draft of (2) then confirm the repeated WARNIN=
Gs do
> > NOT occur with that.
>=20
> I have created the patches (2) based on your idea.
> Please check the attachments then let me know if you have any comments.
>=20
> I confirmed that the repeated WARNING never occurs with the v4.4-rt + the=
 patches.
> (20,000 reboots on VM, 7,000 on x86 64bit machine)
>=20
> If no comment, I'll send the patches to both cip-dev and -rt lists.

Thanks for the series. Code looks good to me.


> Between v4.14-rt and v5.10-rt, allocate_slab() is responsible to enable

"to enable" -> "for enabling"?

> IRQ before running the following slab allocation functions if
>     system_state >=3D SYSTEM_SCHEDULING

slab -> SLAB, more than once.

> However, SYSTEM_SCHEDULING is introduced[1] in the mainline v4.13 and
> it's not comfortable to backport all related changes into older RT kernels

comfortable -> reasonable?

> from functional compatibility and longer term maintenance perspectives.
>=20
> Thus, as an alternative (but not-mainlined) way, introduce an extra flag

not-mainlined -> non-mainline

> "system_scheduling" which becomes true at the same point as
>     system_state =3D SYSTEM_SCHEDULING
> in the mainline so that the existing system_states and users of them

"so" -> ", so"

> are not affected.
>=20
> allocate_slab() will use this flag for its IRQ control by the upcoming ch=
ange.


> +++ b/init/main.c
> @@ -110,6 +110,14 @@ bool early_boot_irqs_disabled __read_mostly;
>  enum system_states system_state __read_mostly;
>  EXPORT_SYMBOL(system_state);
> =20
> +/*
> + * true is equal to system_state >=3D SYSTEM_SCHEDULING in the mainline.

"true is equal to" -> "This corresponds to"


> This patch resolves the problem in 4.4 & 4.9 PREEMPT_RT kernels that

"the problem" -> "problem"

> the following WARNING happens repeatedly due to broken context
> caused by running slab allocation with IRQ disabled unintendedly.

"unintendedly" -> "by mistake"?

> [Problem details]
>=20
> On PREEMPT_RT kernels < v4.14-rt, after __slab_alloc() disables
> IRQ with local_irq_save(), allocate_slab() is responsible to

"to" -> "for".

> re-enable IRQ only under the specific conditions:

"re-enable" -> "re-enabling".

> (1) gfpflags_allow_blocking(flags) OR
> (2) system_state =3D=3D SYSTEM_RUNNING
>=20
> The problem happens when (1) is false AND system_state =3D=3D SYSTEM_BOOT=
ING

"SYSTEM_BOOTING" -> "SYSTEM_BOOTING,"

> caused by the following scenario:

> 1. Some kernel codes invoke the allocator without __GFP_DIRECT_RECLAIM
>    bit (i.e. blocking unallowed) while SYSTEM_BOOTING

"invoke" -> "invokes"
"unallowed" -> "not allowed"

> 2. allocate_slab() calls the following functions with IRQ disabled
> 3. buffered_rmqueue() invokes local_[spin_]lock_irqsave(pa_lock) which
>    might call schedule() and enable IRQ if failed to get pa_lock

"IRQ if failed", "IRQ, if it failed"

> 4. The migrate_disable counter, which is unintended to be updated while
>    IRQ disabled, is accidentally updated after schedule() then

"unintended to be updated while IRQ disabled" -> "not intended to be update=
d with IRQs disabled"

> The behavior 2-5 above has been certainly obsereved[1] using ftrace.

"certainly" -> "".

> The condition (2) above may intend to make the memory allocator

"may intend" -- ??

> [How resolved in newer RT kernels]

"How resolved" -> "How this is resolved"

> [How this patch works]
>=20
> An simple option is to backport the series[3], which is possible

"is to" -> "would be to"

> and has been verified[4]. However, the series pulls multiple kinds of

"the" -> "that"
"multiple kinds of" -> ""

> functional changes like SYSTEM_SCHEDULING and adjustments for it,
> early might_sleep() and smp_processor_id() supports, etc.
> Therefore, this patch uses an extra (but not mainlined) flag

"mainlined" -> "mainline"

> "system_scheduling" provided by the prior patch instead of
> instroducing SYSTEM_SCHEDULING, then use the same condition as

"instroducing" -> "introducing"
"use" -> "uses"

With those, you can add

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2CQv3mJZA6c6WaEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5zP3AAKCRAw5/Bqldv6
8p1tAJ9slvMNsQxPWOksr4RDS9d/bRbRSACdHgMSth9VBoaN2vq22BeT0Hqjr0Q=
=AcPR
-----END PGP SIGNATURE-----

--2CQv3mJZA6c6WaEx--

