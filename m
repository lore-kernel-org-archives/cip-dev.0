Return-Path: <SRS0=8gNS=BW=lists.cip-project.org=bounce+64572+5110+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA47AC433DF
	for <cip-dev@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA832087C
	for <cip-dev@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vNmn6hbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA832087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5110+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AzdZYY4521723x9RJ0QsjSuZ; Wed, 12 Aug 2020 12:24:42 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.117.1597260280685889129
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2020 12:24:41 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2D04F1C0BD2; Wed, 12 Aug 2020 21:24:36 +0200 (CEST)
Date: Wed, 12 Aug 2020 21:24:35 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH] drm: of: Fix linking when CONFIG_OF is not set
Message-ID: <20200812192435.GA19363@amd>
References: <20200811144040.4398-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200811144040.4398-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QrEQsus1qhCkji9QcKJUGw5Wx4520388AA=
Content-Type: multipart/mixed; boundary="XCrvvNbbpEHreIkhw0JD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597260282;
 bh=Kh/vl73Q4BvkEF06dot23guIG+H5UC4pC8dYaC6cw7k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vNmn6hbeLRsCiqkd3oyGLdUeUMRrDXuNrwmPa20nS2kROE1SFuCRJ8Ib6DRue9lfbLg
 9YSEBGrr+eT5D2PdyeCXMwu7KBPFHrSvFXgDyMfe+KHY3zgr/I/Wwyf5FwdWh1Y3HS7uk
 q7yJ9efpW+S9RSPeWUfekFjGInoZE/9SC9Y=

--XCrvvNbbpEHreIkhw0JD
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I assume this patch is for 4.19-cip?

> commit 528d06d41b80a4acb2a9efd33bfc87495147f75e upstream.
>=20
> The new helper drm_of_lvds_get_dual_link_pixel_order() introduced in
> commit 6529007522de has a fallback stub when CONFIG_OF is not set, but
> the stub is declared in drm_of.h without a static inline. This causes
> multiple definitions of the function to be linked when the CONFIG_OF
> option isn't set. Fix it by making the stub static inline.

So this is pretty obvious, and I'll likely apply it.

Best regards,
								Pavel
							=09

> diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
> index 8ec7ca6d2369..b9b093add92e 100644
> --- a/include/drm/drm_of.h
> +++ b/include/drm/drm_of.h
> @@ -92,8 +92,9 @@ static inline int drm_of_find_panel_or_bridge(const str=
uct device_node *np,
>  	return -EINVAL;
>  }
> =20
> -int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port=
1,
> -					  const struct device_node *port2)
> +static inline int
> +drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
> +				      const struct device_node *port2)
>  {
>  	return -EINVAL;
>  }

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl80QfMACgkQMOfwapXb+vJqSQCfRF9JrOBpbh2wCSasqeYC+l0v
necAnjHgx+AOIoU4LqVI6ceuIR3a5boV
=rcAT
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

--XCrvvNbbpEHreIkhw0JD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5110): https://lists.cip-project.org/g/cip-dev/message=
/5110
Mute This Topic: https://lists.cip-project.org/mt/76127518/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XCrvvNbbpEHreIkhw0JD--
