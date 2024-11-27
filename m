Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48B6D609D8
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 11:23:29 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.69970.1732706604384625081
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 03:23:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 384B01C00A0; Wed, 27 Nov 2024 12:23:22 +0100 (CET)
Date: Wed, 27 Nov 2024 12:23:21 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Message-ID: <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
References: <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <ZvvRQmpIm4UHHhGS@duo.ucw.cz>
 <17FF38206FDF8135.11625@lists.cip-project.org>
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I2pGLYwX4NjIIb2t"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 11:23:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17290


--I2pGLYwX4NjIIb2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for very detailed analysis.

> =3D=3D=3D Changes in conditions where allocate_slab() enables IRQ =3D=3D=
=3D
>=20
> * v4.4-rt =3D> v4.9-rt : Not change
> * v4.9-rt =3D> v4.14-rt : A change in system_state check
> * v4.14-rt =3D> v4.19-rt : No change
>=20
> Here is the change in v4.14-rt.
> This is not provided as a separated commit but as a change in the
> existing commit ("mm: Enable SLUB for RT") in v4.9-rt[3] and v4.14-rt[5].
>=20
>  	if (gfpflags_allow_blocking(flags))
>  		enableirqs =3D true;
>  #ifdef CONFIG_PREEMPT_RT_FULL
> -	if (system_state =3D=3D SYSTEM_RUNNING)
> +	if (system_state > SYSTEM_BOOTING)
>  		enableirqs =3D true;
>  #endif
>  	if (enableirqs)

Ok, so this looks very simple, but without SYSTEM_SCHEDULING change,
this will be nop and will not fix anything.

> At the same time, the following patch series are applied as well in v4.14=
-rt.
>=20
>   "[patch V2 00/17] init: Enable might_sleep() and smp_processor_id() deb=
ugging early" [6]
>   =3D> That's why I was not able to get any output of might_sleep() previ=
ously!
>=20
> One of the patches above introduces SYSTEM_SCHEDULING[7], which is just to
> make a new timing to enable might_sleep().
> However, this results in the behavior of allocate_slab() is changed signi=
ficantly:
>=20
> [Conditions that allocate_slab() enables IRQ]
>                    Until v4.9-rt                  From v4.14-rt
> SYSTEM_BOOTING     gfpflags_allow_blocking(flags) gfpflags_allow_blocking=
(flags)
>                                :                              :
>                                :                              v
> SYSTEM_SCHEDULING              :                            Always
> (*)                            v                              |
> SYSTEM_RUNNING               Always                           |
> ...                            |                              |
>                                v                              v
>=20
> With v4.4-rt and v4.9-rt, the problem always occurs **before** SYSTEM_RUN=
NING(*),
> so I'm believing the problem does not occur by applying the patch series =
and
> condition change above.
> Those changes are not "fix" actually but just "hiding" the problems that
> some initialization codes invoke memory allocator without allowing
> blocking.

Well, I'm afraid proper "fix" would be to upgrade to 6.12 :-). So we
may want to live with bugs hidden.

> =3D=3D=3D Check with v4.4-rt + backported patches =3D=3D=3D
>=20
> Fortunately, it's not so complicated to apply the might_sleep() patch ser=
ies
> to v4.4-rt, so I tried to backport them then check if the problem occurs.
>=20
> * v4.4-rt + backported patches : Not occurred (22634 reboots)
> * 4.4.y-cip-rt + backported patches : (WIP) Not occurred (around 500 rebo=
ots yet)
>=20
> As the problem occurs one time in 100~1000 reboots with the normal v4.4-r=
t,
> so I may be able to say the problem does not occur by applying the
> changes.

So you already have the backported series. Could you share it so we
can take a look?

> (2) "Fix" memory allocation callers' behavior while kernel initialization
>=20
> Instead of backporting.
> It's mostly clarified that there are some wrong behavior in some
> initialization codes that call memory allocator (GFP flag usage?)
> within SYSTEM_SCHEDULING ~ SYSTEM_RUNNING.
> It would be one of the ways to resolve the problem to fix such behavior.
> However, it will need more investigations (the early might_sleep() enable=
d by
> the backports may be useful for this :) ) and the feasibility is still un=
clear.
> Also, I'm guessing there is no upstream works corresponding to such
> fix.

This would require fixing 20 callers you identified in the next
email, right? I guess it is not easy to prototype this?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--I2pGLYwX4NjIIb2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ0cBKQAKCRAw5/Bqldv6
8q1/AJ4zWRGq9q+L7U7LFXmG5uLmr7UyawCgo1CnXvtYQ+xfY5x2xEYrW/Bg+zI=
=AYsu
-----END PGP SIGNATURE-----

--I2pGLYwX4NjIIb2t--

