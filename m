Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15D79C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 124FF85AA0
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:42:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YcLU1MOPrY+I for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 07:42:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 055238518E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:42:01 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 936F51C0141; Wed, 19 Feb 2020 08:41:58 +0100 (CET)
Date: Wed, 19 Feb 2020 08:41:58 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219074158.GA29804@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [PATCH 4.19.y-cip 00/23] Renesas RZ/G2E USB Type-C Backport
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Feb 2020 07:42:03 -0000
X-Groupsio-MsgNum: 4403
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patchset revolves around the following patch set from upstream:
> https://patchwork.kernel.org/cover/10969899/
>=20
> Unfortunately, the driver is using a slightly different version of the USB
> API. In upstream, the connection between the fwnode of the USB controller
> device tree node, that is the connector device tree node, and the USB
> peripheral device tree node is nicely done via some new function calls th=
at
> are basically some extensions to the graph traverse and graph discovery
> methods for the device tree parser. This is needed for role switch featur=
e.
>=20
> I tried to create the minimum set for the USB API extension and it should
> not affect at all the current behavior. All the modifications are additio=
ns
> and some rewritings of some of the current functions.
>=20
> I also backported some fixes where I have found them.
>=20
> Tested on Si-Linux EK874 (with RZ/G2E SoC) that we have in house.

Ok, so this does not look bad, but it affects other people's boards,
too. I went through it and will have some questions/comments.

Is someone else in -cip project using usb-otg? Are we reasonably sure
this won't cause problems elsewhere?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5M5sYACgkQMOfwapXb+vK9hACfYQ+lCAPHKgcfehzNH8aun+xu
ROUAn0UoQ8USFZ8e/VjxudahNK4Ec0nR
=llU8
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

