Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4975EE7FF4
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 08:27:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.53919.1694420853385779122
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 01:27:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CC8061C0004; Mon, 11 Sep 2023 10:27:30 +0200 (CEST)
Date: Mon, 11 Sep 2023 10:27:30 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] Request for reviews for 4.4-st44 4.4-cip79
Message-ID: <ZP7PcjqsgXlrMHj7@duo.ucw.cz>
References: <1583308606.3395319.1693820637255@webmail.strato.com>
 <ZPXC40QtoXU/EYpO@duo.ucw.cz>
 <342239032.350330.1693989175762@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jV5Z/a8xgvN2L6kt"
Content-Disposition: inline
In-Reply-To: <342239032.350330.1693989175762@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 08:27:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13017


--jV5Z/a8xgvN2L6kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for the reviews!
>=20
> > On 09/04/2023 1:43 PM CEST Pavel Machek <pavel@denx.de> wrote:
> > Most look okay to me. I'd not put too much work with READ_ONCE
> > annotations or qla2xxx warning tweaks, they don't really fix any real
> > bugs. "ext2: Drop fragment support" probably does not hurt, but surely
> > does not fix anything. I guess we can keep it when -stable took it,
> > but...
>=20
> I'm inclined to include such things if they are trivial to adjust because=
 I think it will save time fixing up future patches.
>=20
> > "usb: ohci-at91: Fix the unhandle interrupt when resume" is wrong, it
> > should do ohci_resume() once, not twice.
>=20
> Correct, I'll fix that up.
>=20
> > "netfilter: conntrack: Avoid nf_ct_helper_hash uses after free" is at
> > least incomplete -- nf_conntrack_helper_init() does not set the hash
> > to NULL in the error path. (Mainline does not have that bug, and code
> > change a lot there).
>=20
> Seems like that applies to all backports between 4.14 and 5.10, at least.=
 I'll leave that out for now and ask stable about it.

Thank you!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jV5Z/a8xgvN2L6kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7PcgAKCRAw5/Bqldv6
8vk8AKDDMZyaXTztS5CDyq7gzVPVRZ+rygCfbtNUysnjsAfAhQX0Hn93EdLlE30=
=Mz2U
-----END PGP SIGNATURE-----

--jV5Z/a8xgvN2L6kt--

