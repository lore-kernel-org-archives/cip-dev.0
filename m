Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC8FCE7D0E
	for <webhook@archiver.kernel.org>; Tue,  1 Oct 2024 10:36:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.77914.1727778971299296705
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Oct 2024 03:36:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B49531C00AB; Tue,  1 Oct 2024 12:36:08 +0200 (CEST)
Date: Tue, 1 Oct 2024 12:36:08 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Message-ID: <ZvvQmOGIelaOpoYU@duo.ucw.cz>
References: <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+BrmXgh03pVbq08"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Oct 2024 10:36:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16942


--C+BrmXgh03pVbq08
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Dear kernel maintainers, and all CIP members,
>=20
> I'm facing a problem while running 4.4 CIP RT on x86 machines.
> Let me report the things I observed so far.
> It's appreciate if you can look at them once and give me your
> feedback.

First, sorry for taking a bit long to react.

> =3D=3D=3D Reproducibility of the problem =3D=3D=3D
>=20
> I can reproduce this problem only while kernel booting (before mounting r=
ootfs).
> The problem happens very rarely and randomly.
> Only one time in around 1,000-10,000 reboots.

But this sounded very scary. Fortunately, you did good job debugging
it.

> =3D=3D=3D What triggers the WARNING =3D=3D=3D
>=20
> The WARNING is printed at the following code.
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/blob/v4.4.302-cip89=
-rt50/kernel/cpu.c?ref_type=3Dtags#L197
>

Ok, but the root cause is here:

> By taking more traces of the functions called around the IRQ enabled,
> local_lock_irqsave() or local_spin_lock_irqs() called inside
> buffered_rmqueue() enable IRQ by calling schedule().
>=20
> * https://gitlab.com/cip-project/cip-kernel/linux-cip/-/blob/v4.4.302-cip=
89-rt50/mm/page_alloc.c?ref_type=3Dtags#L2346
> * https://gitlab.com/cip-project/cip-kernel/linux-cip/-/blob/v4.4.302-cip=
89-rt50/mm/page_alloc.c?ref_type=3Dtags#L2378
>=20
> Here is an example of (manual) tracing of local_lock_irqsave()
> including inlined functions when the problem happens.
>=20
> get_page_from_freelist() @ mm/page_alloc.c
>   buffered_rmqueue()
>     local_lock_irqsave() @ include/linux/locallock.h
>       get_local_var() @ include/linux/percpu.h
>         migrate_disable() ***
>       __local_lock_irqsave()
>         __local_lock_irq()
>           spin_lock_irqsave() @ include/linux/spinlock_rt.h
>             spin_lock()
>               rt_spin_lock() @ kernel/locking/rtmutex.c
>                 rt_spin_lock_fastlock(slowfn=3Drt_spin_lock_slowlock, do_=
mig_dis=3Dtrue)
>                   might_sleep_no_state_check()

### here. You may not sleep with irqs disabled.

>                   migrate_disable() ***
>                   slowfn() # rt_spin_lock_slowlock(mg_off=3Dtrue)
>                     migrate_enable()  ***
>                     schedule() # IRQ enabled & context switch occurs

### and here. This is where real failure occurs.

Can you enable "CONFIG_DEBUG_ATOMIC_SLEEP" to maybe get better
diagnostics?

>                     migrate_disable() ***
>                     ...
>=20
> The question here is whether calling local_[spin_]lock_irqsave() in
> IRQ disabled context is allowed or not. IIUC, invoking schedule()
> when IRQ is disabled should be a context violation.
>


> Ref: https://wiki.linuxfoundation.org/_media/realtime/events/rt-summit201=
7/using-coccinelle_julia-cartwright.pdf
>=20
> =3D=3D=3D What calls get_page_from_freelist() with IRQ disabled =3D=3D=3D
>=20
> According to additional traces, it's clarified that kmem_cache_alloc()
> can call get_page_from_freelist() with IRQ disabled. Here is the
> trace:

I believe get_page_from_freelist(GFP_ATOMIC, ...) is okay thing to do
with irqs disabled.

> =3D=3D=3D Queries =3D=3D=3D
>=20
> I'm still trying to check more detailed behavior and the main cause of
> the problem, but it's quite helpful if you give the following information:
>=20
> * Whether you hit the same or similar problems so far

No.

> * Clarification about my guess in the sections above:
>   * Calling local_[spin_]lock_irqsave() with IRQ disabled causes context =
broken

I believe that's ok.

>   * Anything wrong in the sequence inside kmem_cache_alloc()
> * Other kind of traces I should take
> * Other parts of kernel that I should investigate
> * Patches or discussions in newer RT kernels relatedly to the problem
> * Other devices I have to try to reproduce the problem

Let me take one more look at the traces.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C+BrmXgh03pVbq08
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvvQmAAKCRAw5/Bqldv6
8mRXAJ0c5Xy0eBnN6Q3mPqWgCGT32Kv9kgCfWI8y9hukfADl4kji27/56WvSrKI=
=Wsg2
-----END PGP SIGNATURE-----

--C+BrmXgh03pVbq08--

