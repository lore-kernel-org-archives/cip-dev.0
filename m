Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81A0FC08A0
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6C3F385B97
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k7L-UT-MW9Aa for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 08:12:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6D16485B4A
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:12:36 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id EFE441C0141; Wed, 19 Feb 2020 09:12:34 +0100 (CET)
Date: Wed, 19 Feb 2020 09:12:34 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219081234.GD31996@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-16-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582034720-5249-16-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [PATCH 4.19.y-cip 15/23] usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller
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
X-List-Received-Date: Wed, 19 Feb 2020 08:12:37 -0000
X-Groupsio-MsgNum: 4407
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline

--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das@bp.renesas.com>
>=20
> commit 1c48c759ef4bb9031b3347277f04484e07e27d97 upstream.
>=20
> Driver for TI HD3SS3220 USB Type-C DRP port controller.
>=20
> The driver currently registers the port and supports data role
> swapping.

Ok, so this has few problems that are fixed by subsequent patches, but
I believe I see some more:

> +static enum usb_role hd3ss3220_get_attached_state(struct hd3ss3220 *hd3s=
s3220)
> +{
> +	unsigned int reg_val;
> +	enum usb_role attached_state;
> +	int ret;
> +
> +	ret =3D regmap_read(hd3ss3220->regmap, HD3SS3220_REG_CN_STAT_CTRL,
> +			  &reg_val);
> +	if (ret < 0)
> +		return ret;

This function claims to return "enum usb_role", but here it returns
errno from regmap_read.

> +static int hd3ss3220_dr_set(const struct typec_capability *cap,
> +			    enum typec_data_role role)
> +{
=2E..
> +	ret =3D hd3ss3220_set_source_pref(hd3ss3220, pref);
> +	usleep_range(10, 100);

Would udelay() make more sense here? Are your CPUs / timer subsystem
so fast that sleeping for 10usec is possible and reasonable to do?

Best regards,
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5M7fIACgkQMOfwapXb+vL2TgCfcsMReSQkMh8bnKcp9pORq2s9
7P0An2IjtzGji9l5c6rIMo6bof4mgYiX
=lz4o
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--

