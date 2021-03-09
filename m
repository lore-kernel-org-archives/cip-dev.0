Return-Path: <SRS0=UjMp=IH=lists.cip-project.org=bounce+64572+6258+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E6CC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 19:42:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D5065226
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 19:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D5065226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6258+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CAlqYY4521723xRqK0gHwM6D; Tue, 09 Mar 2021 11:42:24 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.14867.1615318943203137216
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 11:42:23 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA2DF1C0B78; Tue,  9 Mar 2021 20:42:19 +0100 (CET)
Date: Tue, 9 Mar 2021 20:42:19 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 14/40] media: i2c: imx219: Fix power sequence
Message-ID: <20210309194219.GA7900@amd>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210309163656.20944-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: h15EKjDDsBtem2rugVMyoN54x4520388AA=
Content-Type: multipart/mixed; boundary="KV2K0OpBSp20XutiUljM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615318944;
 bh=gu7a9EU/Hz82Bk6cNsRcqxySUC9/xGGMz5bDk8xLK44=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sKC57EbABJIJ1p00uINpJDEkPR1Zdcr9zmz/huFukLpGA6tsVyE4t4NQ3a7vsurwEpi
 uXB98AxVSsT25IKofjqtZnyjw9QG1X+pHATrL1tLeCLYbGcbBbxp36fFgW/YLHLgp27HT
 MgQT50j/1SSCb4TOHGWl0S5GV2VfCaswprE=

--KV2K0OpBSp20XutiUljM
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> With this commit the sensor is able to enter LP-11 mode during power up,
> as expected by some CSI-2 controllers.
>=20
> [1] https://publiclab.org/system/images/photos/000/023/294/original/
> RASPBERRY_PI_CAMERA_V2_DATASHEET_IMX219PQH5_7.0.0_Datasheet_XXX.PDF
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/media/i2c/imx219.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index c67b2cf5c32c..f1ae93569542 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -1224,6 +1224,23 @@ static int imx219_probe(struct i2c_client *client)
>  	/* Set default mode to max resolution */
>  	imx219->mode =3D &supported_modes[0];
> =20
> +	/* sensor doesn't enter LP-11 state upon power up until and unless
> +	 * streaming is started, so upon power up switch the modes to:
> +	 * streaming -> standby
> +	 */

/*
 * Sensor...

would be the usual commment style.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBHz5sACgkQMOfwapXb+vJnMQCgunBmd7gr2hFdvvB1yX8R3gg/
0ZUAniohpf+Nra1qTbFPTfACqVCwYjBm
=f2k/
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

--KV2K0OpBSp20XutiUljM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6258): https://lists.cip-project.org/g/cip-dev/message=
/6258
Mute This Topic: https://lists.cip-project.org/mt/81205358/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KV2K0OpBSp20XutiUljM--
