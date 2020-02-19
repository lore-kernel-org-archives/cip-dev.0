Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97BF3C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 21:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 872FB84647
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 21:40:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DKppZtr4CK4g for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 21:40:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0A0868461B
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 21:40:23 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 9E7D51C013D; Wed, 19 Feb 2020 22:40:21 +0100 (CET)
Date: Wed, 19 Feb 2020 22:40:21 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219214021.GC17284@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-17-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219082046.GG31996@amd>
 <OSAPR01MB50286A8EFD6ED76AC8BB33B8AE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB50286A8EFD6ED76AC8BB33B8AE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
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
X-List-Received-Date: Wed, 19 Feb 2020 21:40:23 -0000
X-Groupsio-MsgNum: 4420
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline

--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > From: kbuild test robot <lkp@intel.com>
> > >
> > > commit dd3fd317e2beb899cbffcf364de049b9f9a02db5 upstream.
> > >
> > > Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C
> > > DRP port controller")
> > > Signed-off-by: kbuild test robot <lkp@intel.com>
> >=20
> > This is not your fault and we should not attempt to fix it here, but we
> > normally require real, human names for Signed-off-by.
>=20
> I will drop this in v2.

You can merge it with the previous patch, or you can keep it as is, it
is your choice. If mainline is okay with it, it should not create
problems for us, even if it is a bit non-standard.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5Nq0UACgkQMOfwapXb+vJu5ACdETF3oGIPA81GPzhIsq/zO+uy
ekMAoJCU3m05dDgbB0uQqIGppzhgsn9U
=ncMi
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

