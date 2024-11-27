Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA2D609D7
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 11:13:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.69813.1732705984372950238
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 03:13:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8C3451C00A0; Wed, 27 Nov 2024 12:13:01 +0100 (CET)
Date: Wed, 27 Nov 2024 12:13:01 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Message-ID: <Z0b+vQuFaslkQS1o@duo.ucw.cz>
References: <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <ZvvRQmpIm4UHHhGS@duo.ucw.cz>
 <17FF38206FDF8135.11625@lists.cip-project.org>
 <180912E61C832DB4.10466@lists.cip-project.org>
 <OS7PR01MB11391AD929FD666A73DAC5C48E12E2@OS7PR01MB11391.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nRVMOWhjfkAwgsP+"
Content-Disposition: inline
In-Reply-To: <OS7PR01MB11391AD929FD666A73DAC5C48E12E2@OS7PR01MB11391.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 11:13:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17289


--nRVMOWhjfkAwgsP+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hello Pavel, kernel maintainers,
>=20
> > (2) "Fix" memory allocation callers' behavior while kernel initializati=
on
>=20
> Finally, I got traces of the callers using early might_sleep() which can =
be
> enabled by the patch set[1] I shared.
> Please check the attachments. (I used VirtualBox)
>=20
> * bootlog_normal_*.txt: Normal kernel boot logs (successful boot)
> * bootlog_panic_*.txt: Kernel boot log when the problem occurs
>=20
> Steps to get the logs:
>=20
> 0. Get v4.4-rt source tree
> 1. Apply "1_early-might-sleep", which are temporally backported from v4.1=
4-rt
>    to enable early might_sleep()[1]
> 2. Apply "2_allocate-slab", which is a partial change backported from v4.=
14-rt
>    so that allocate_slab() always enables IRQ from SYSTEM_SCHEDULING
> (With this kernel, I confirmed the problem does not occur)
> 3. Apply "3_debug" which consists of the followings:
>   * Revert the patch 2 just to reproduce the problem for testing
>   * Panic immediately when the migrate_disable counter is broken to get l=
ogs
>   * Don't limit ___might_sleep() outputs by past time. Note that this is a
>     necessary change to get the BUG messages for all invalid contexts
>     detected while kernel booting. Without this, I only got two BUG messa=
ges.
> 4. Build the kernel with the following configurations
>   * arch/x86/configs/x86_64_defconfig
>   * CONFIG_PREEMPT_RT_FULL=3Dy
>   * CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
>=20
> Seeing "bootlog_normal_*.txt", around 20 BUG messages from ___might_sleep=
()
> are printed every boot. (The total number of the messages slightly change=
s)
> My understanding is all the points the BUG messages are printed should ca=
ll
> the memory allocator not allowing blocking, and can break the migrate_dis=
able
> counter which causes the repeated WARNINGs eventually.

Thanks for detailed analysis. Indeed fixing 20 different callers does
not look too great.

> "bootlog_panic_*.txt" is an example of kernel log when the problem occurs.
> vmalloc() from tcp_init() breaks the counter in this pattern.
> In other devices, different initcall functions may break the counter too.
>=20
> I can identify the codes that call memory allocator without allowing bloc=
king
> by investigating more details of the call traces I got.
> However, I'm really wondering if we should do it and change all such func=
tions
> to allow blocking only in proper timings in order to avoid the problem.
> If possible, I prefer the solution (1): Backport the early might_sleep()
> patch series and condition change for allocate_slab() intead of modifying
> multiple initcall functions.

Would we need whole series, or would some subset be enough? Hmm. If we
are adding STATE_SCHEDULING it will be intrusive. Does not look great,
either.

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nRVMOWhjfkAwgsP+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ0b+vQAKCRAw5/Bqldv6
8tzpAJsGavEf9Kl64nvvOy3//GfH6NhIzACfSBW0hrw/HMtOzkd0fvl9vPV4o2Y=
=iFae
-----END PGP SIGNATURE-----

--nRVMOWhjfkAwgsP+--

