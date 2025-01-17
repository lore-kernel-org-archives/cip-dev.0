Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6979EC02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 11:26:18 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.8815.1737113174224255471
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jan 2025 03:26:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=C8pmzQOl;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6C6F1087DED0
	for <cip-dev@lists.cip-project.org>; Fri, 17 Jan 2025 12:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737113171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=px0b4OmkxdisXPcg6WP/eXHpjH9RdGRVsvh7QLYsWBw=;
	b=C8pmzQOlbkJIvlBSG/w9qT6V+ZboLIs3W0tUuuxKJx4wMiHX5eIPA0gDzuYjxN4x2Hgu0f
	85GC9lqs+0AqDmJ3N/fS4qhSGWogJ6cKn9QeiiZMz5jNdZl6CBNnVS/2EFL6rIZQHxIpSG
	Pt8NXw93i6ZMEqBYvVgAtsyF3378EpBiFBL7rJwm5w7laZGwr3rwCvHlC5cZmhgqg4yMq8
	74t/UN1iNKpmcO0VH1pbWFrN0sRINa288LaLtGt3Aayyyhwj+Napiy1b7WH2fzZ7r+9Nzr
	IUsRU7CVdTUvZfwnWT/hjD7y1AMzOsxeCszNj7aEKC+ML/2ejOjMDdm47BG5qw==
Date: Fri, 17 Jan 2025 12:26:09 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Message-ID: <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
References: <ZvvRQmpIm4UHHhGS@duo.ucw.cz>
 <17FF38206FDF8135.11625@lists.cip-project.org>
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0mVe42i41SXemYu@duo.ucw.cz>
 <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjA7OyWcmmX1VYER"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jan 2025 11:26:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17547


--AjA7OyWcmmX1VYER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hello Pavel, kernel maintainers,
>=20
> > The memory allocator seems to be responsible to enable IRQ properly bas=
ed on
> > the "system_state" (regardless of GFP flags of its callers).
>=20
> I checked newer implementations of mm/slub.c especially about IRQ enable/=
disable behavior
> in order to see if any other kinds of fixes are available in newer RT ker=
nels than v4.14-rt.
>=20
> From v4.4-rt to v5.10-rt, its behavior is the same: __slab_alloc() disabl=
es IRQ (local_irq_save())
> then allocate_slab() enables IRQ under the following conditions.
>=20
> * v4.4-rt & v4.9-rt : gfpflags_allow_blocking(flags) || system_state =3D=
=3D SYSTEM_RUNNING
> * v4.14-rt & v4.19-rt : gfpflags_allow_blocking(flags) || system_state > =
SYSTEM_BOOTING
> * v5.4-rt & v5.10-rt : gfpflags_allow_blocking(flags) || (system_state > =
SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND)
>=20
> Interestingly, in v5.15-rt, significant changes are applied by the mainli=
ne patch series [1].
> The codes to enable/disable IRQs in both allocate_slab() and __slab_alloc=
() are moved
> to ___slab_alloc() [2][3] then adjusted a lot.

Ok, so [1] is too big to backport.

> Eventually, the most IRQ enable/disable codes are replaced with local_loc=
k_irqsave() and
> local_unlock_irqrestore() [4], which does NOT enable/disable IRQ actually.
> As the result, the most slab allocation functions (except some free funct=
ions) are
> fully preemptive from v5.15-rt. The GFP flags and system_state are no lon=
ger considered.
>=20
> Based on the above situation, I concluded that it's not possible to backp=
ort
> the changes for mm/slub.c above from the latest kernel into 4.4.y-cip-rt
> due to the significant functional changes and refactoring.

Yes, we have same conclusion here.

> Picking SYSTEM_SCHDULING and related changes up may be the only way
> to resolve the repeated WARNING issue in 4.4.y-cip-rt.

Ok, so you have a series that should fix the problem. Can you verify
that it indeed fixes the warning in your case then post the minimal
version of the patch here and to the realtime lists? No need for
series in submission format for now, just "this works for us".

If your analysis is correct, same bug should be present in 4.4-rt
=2E. 5.10-rt. Next steps would be to get nice series merged to 5.10-rt,
and then we can fix it in 4.19-rt and 4.4-rt.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AjA7OyWcmmX1VYER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ4o+UQAKCRAw5/Bqldv6
8qJOAJ0RbRMuweFu36gEPKjgf+98dyEgrgCeJGlunrNR9CDP6A1Ov16EFRbe7ao=
=O5DI
-----END PGP SIGNATURE-----

--AjA7OyWcmmX1VYER--

