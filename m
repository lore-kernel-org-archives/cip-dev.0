Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35DD2C08A0
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1E919203F4
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:20:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id od5iE01GDHrC for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 08:20:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id 3F68520017
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:20:48 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id C94F41C0141; Wed, 19 Feb 2020 09:20:46 +0100 (CET)
Date: Wed, 19 Feb 2020 09:20:46 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219082046.GG31996@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-17-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582034720-5249-17-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [PATCH 4.19.y-cip 16/23] usb: typec: hd3ss3220_irq() can be static
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
X-List-Received-Date: Wed, 19 Feb 2020 08:20:49 -0000
X-Groupsio-MsgNum: 4410
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Content-Disposition: inline

--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: kbuild test robot <lkp@intel.com>
>=20
> commit dd3fd317e2beb899cbffcf364de049b9f9a02db5 upstream.
>=20
> Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP =
port controller")
> Signed-off-by: kbuild test robot <lkp@intel.com>

This is not your fault and we should not attempt to fix it here, but
we normally require real, human names for Signed-off-by.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5M794ACgkQMOfwapXb+vI5CgCeOxB5VpHBzYJMWLpSuoagWm23
RhkAoJIduRvVNBw5dVvPyrGqL+Nl5GeY
=Tyha
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--

