Return-Path: <SRS0=rlpg=CE=lists.cip-project.org=bounce+64572+5254+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4FAC433E1
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 07:21:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0E120767
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 07:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YvQqese3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0E120767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5254+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id oNgwYY4521723xoGlncjASbA; Wed, 26 Aug 2020 00:21:43 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7636.1598426500000483388
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 00:21:40 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B66651C0BB9; Wed, 26 Aug 2020 09:21:33 +0200 (CEST)
Date: Wed, 26 Aug 2020 09:21:32 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove temperature bound
Message-ID: <20200826072132.GA7244@amd>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
 <20200825132156.7839-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200825132156.7839-3-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ta1vKKMV0vWiuoxcpRBEAFLkx4520388AA=
Content-Type: multipart/mixed; boundary="2gHxcjQ8t3nYgLaFATTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598426503;
 bh=23GvcyQDkNiYuhl8vpqbudcNc70o9vxJsTwbKQZWLtA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=YvQqese3wBF+P4SkXHUMuUdIirAsza/F1iOAFgZ5StAh31rqOfNLeE+/CxYjr6VfhoD
 lyjVqUmxfXStRxsx2+memshkYVPUOTv9P1ZSmTExk6HojuqP0kFMSXVplgsYB72lhW7pq
 Ltti1/P5QWZwqa32MIw6NwOpEf2yR3+ALI4=

--2gHxcjQ8t3nYgLaFATTU
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-08-25 14:21:48, Biju Das wrote:
> From: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>
>=20
> commit 0f510a2457cbbba18a98492bab1bf540be57ebd1 upstream.
>=20
> The hardware manual states that the operation of the sensor is not
> guaranteed with temperatures above 125=B0C, not that the readings are
> invalid. Remove the bound check and try to deliver temperature readings
> even if we are outside the guaranteed operation range.

I'm tempted to ask "how was this tested?" :-).

Sometimes sensors have glitches producing very high values in normal
temperatures, and it such case clamping can be useful, but I'll assume
your sensor works ok.

Best regards,
								Pavel


> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -182,9 +182,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, =
int *temp)
>  				tsc->coef.a2);
>  	mcelsius =3D FIXPT_TO_MCELSIUS(val);
> =20
> -	/* Make sure we are inside specifications */
> -	if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
> -		return -EIO;
> +	/* Guaranteed operating range is -40C to 125C. */
> =20
>  	/* Round value to device granularity setting */
>  	*temp =3D rcar_gen3_thermal_round(mcelsius);

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9GDXwACgkQMOfwapXb+vJT0gCgvAQfI6ZwCQTPNiXOw0xTLaqx
NNsAoJcs6XZyfRG21dYF4hFsHJgkUEhJ
=W8ts
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

--2gHxcjQ8t3nYgLaFATTU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5254): https://lists.cip-project.org/g/cip-dev/message=
/5254
Mute This Topic: https://lists.cip-project.org/mt/76406706/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--2gHxcjQ8t3nYgLaFATTU--
