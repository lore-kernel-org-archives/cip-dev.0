Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 725FAC08A0
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 61A1684BCF
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aFxsbXENLA8h for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 08:19:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A23B284B22
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:19:05 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 42B3A1C0357; Wed, 19 Feb 2020 09:19:04 +0100 (CET)
Date: Wed, 19 Feb 2020 09:19:03 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219081903.GF31996@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-22-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582034720-5249-22-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [PATCH 4.19.y-cip 21/23] arm64: defconfig: enable TYPEC_HD3SS3220 config option
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
X-List-Received-Date: Wed, 19 Feb 2020 08:19:06 -0000
X-Groupsio-MsgNum: 4409
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline

--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-02-18 14:05:18, Marian-Cristian Rotariu wrote:
> From: Biju Das <biju.das@bp.renesas.com>
>=20
> commit c24f6886b2ee321b50543d3683573689a1817336 upstream
>=20
> Enable support for the TI HD3SS320 USB Type-C DRP Port controller driver
> by turning on CONFIG_TYPEC and CONFIG_TYPEC_HD3SS3220 as modules.

No, just no.

Lets enable new code for your boards (cip-kernel-config repository),
but keep it disabled for other people. We don't want to break build by
mistake, or something like that.

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5M73cACgkQMOfwapXb+vI9zwCePaXbKFX7glwiEOX4bFuAI8Qo
vDwAn3mhoLA8VGQO5GiNhLWfO8bYHK8k
=G4uZ
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--

