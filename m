Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01395D6EBF7
	for <webhook@archiver.kernel.org>; Fri, 29 Nov 2024 10:20:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.113469.1732875646566996959
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Nov 2024 02:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 101E51C00DE; Fri, 29 Nov 2024 11:20:44 +0100 (CET)
Date: Fri, 29 Nov 2024 11:20:43 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Message-ID: <Z0mVe42i41SXemYu@duo.ucw.cz>
References: <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <ZvvRQmpIm4UHHhGS@duo.ucw.cz>
 <17FF38206FDF8135.11625@lists.cip-project.org>
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y6KSVRmkaNc6bsoH"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Nov 2024 10:20:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17301


--y6KSVRmkaNc6bsoH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >  	if (gfpflags_allow_blocking(flags))
> > >  		enableirqs =3D true;
> > >  #ifdef CONFIG_PREEMPT_RT_FULL
> > > -	if (system_state =3D=3D SYSTEM_RUNNING)
> > > +	if (system_state > SYSTEM_BOOTING)
> > >  		enableirqs =3D true;
> > >  #endif
> > >  	if (enableirqs)
> >=20
> > Ok, so this looks very simple, but without SYSTEM_SCHEDULING change,
> > this will be nop and will not fix anything.
>=20
> Yes.
>=20
> > So you already have the backported series. Could you share it so we
> > can take a look?
>=20
> The backported series are in the directory "1_early-might-sleep" in the
> tarball attached to the last email.
> Could you check that? (or do you need email format instead of tarball?)

Aha, I see the series now.

> Please note that only one patch ef284f5ca5f1 (3/17) [1] for arm64 is not
> included yet because it would take a bit longer to check its dependency.
> Also, note that "2_allocate-slab" is also required to backport but it's n=
ot
> a part of the might_sleep() patch series.
>=20
> You can see the most patches (14/17) are just to adjust system_state chec=
ks in
> existing codes accordingly to the newly introduced SYSTEM_SCHDULEING.
> Core parts of the series are:
> * [01/17] init: Pin init task to boot cpu initially [2]
> * [16/17] init: Introduce SYSTEM_SCHEDULING state [3]
> * [17/17] sched: Enable might_sleep() and smp_processor_id() checks early=
 [4]

Agreed. And only 1/17 is really fixing things up, right? Others are
really only better diagnostics / enabling checks early. If 1/17 is
enough to fix your WARNING in 4.4-rt, we can certainly take that.

Best regards,
								Pavel

=46rom 281a5658e492149f73e4403fda8a1786ae93d52a Mon Sep 17 00:00:00 2001
=46rom: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 16 May 2017 20:42:32 +0200
Subject: [PATCH 01/19] init: Pin init task to the boot CPU, initially

Some of the boot code in init_kernel_freeable() which runs before SMP
bringup assumes (rightfully) that it runs on the boot CPU and therefore can
use smp_processor_id() in preemptible context.

That works so far because the smp_processor_id() check starts to be
effective after smp bringup. That's just wrong. Starting with SMP bringup
and the ability to move threads around, smp_processor_id() in preemptible
context is broken.

Aside of that it does not make sense to allow init to run on all CPUs
before sched_smp_init() has been run.

Pin the init to the boot CPU so the existing code can continue to use
smp_processor_id() without triggering the checks when the enabling of those
checks starts earlier.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170516184734.943149935@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
(cherry picked from commit 8fb12156b8db61af3d49f3e5e104568494581d1f)
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 init/main.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/init/main.c b/init/main.c
index 9933fca3a5c8..6c745aff6669 100644
--- a/init/main.c
+++ b/init/main.c
@@ -386,6 +386,7 @@ static __initdata DECLARE_COMPLETION(kthreadd_done);
=20
 static noinline void __init_refok rest_init(void)
 {
+	struct task_struct *tsk;
 	int pid;
=20
 	rcu_scheduler_starting();
@@ -395,7 +396,17 @@ static noinline void __init_refok rest_init(void)
 	 * the init task will end up wanting to create kthreads, which, if
 	 * we schedule it before we create kthreadd, will OOPS.
 	 */
-	kernel_thread(kernel_init, NULL, CLONE_FS);
+	pid =3D kernel_thread(kernel_init, NULL, CLONE_FS);
+	/*
+	 * Pin init on the boot CPU. Task migration is not properly working
+	 * until sched_init_smp() has been run. It will set the allowed
+	 * CPUs for init to the non isolated CPUs.
+	 */
+	rcu_read_lock();
+	tsk =3D find_task_by_pid_ns(pid, &init_pid_ns);
+	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
+	rcu_read_unlock();
+
 	numa_default_policy();
 	pid =3D kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES);
 	rcu_read_lock();
@@ -993,10 +1004,6 @@ static noinline void __init kernel_init_freeable(void)
 	 * init can allocate pages on any node
 	 */
 	set_mems_allowed(node_states[N_MEMORY]);
-	/*
-	 * init can run on any cpu.
-	 */
-	set_cpus_allowed_ptr(current, cpu_all_mask);
=20
 	cad_pid =3D get_pid(task_pid(current));
=20
--=20
2.30.2


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--y6KSVRmkaNc6bsoH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ0mVewAKCRAw5/Bqldv6
8jvuAJwKbgoLCeWi+y3qvdNINH7KOsvB4wCghBdjYwf3F4kn+kFKUUa1PGplW/M=
=1xVh
-----END PGP SIGNATURE-----

--y6KSVRmkaNc6bsoH--

