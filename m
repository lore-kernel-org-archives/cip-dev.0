Return-Path: <SRS0=O80b=BB=lists.cip-project.org=bounce+64572+4978+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DAEC433E1
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 21:39:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB9D2071A
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 21:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="U+3Fqj+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB9D2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4978+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Qu39YY4521723xKYSitAMGeD; Wed, 22 Jul 2020 14:39:10 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.29757.1595453948399949926
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 14:39:08 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 20C3C1C0BD8; Wed, 22 Jul 2020 23:39:02 +0200 (CEST)
Date: Wed, 22 Jul 2020 23:38:46 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 11/17] drm: of: Add drm_of_lvds_get_dual_link_pixel_order
Message-ID: <20200722213846.GA16146@amd>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
 <20200722163449.3513-12-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200722163449.3513-12-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hf2PT10WjLcEF5muYGDW4Oxrx4520388AA=
Content-Type: multipart/mixed; boundary="fgDXXWa3XlWoOEazJ84N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595453950;
 bh=7u3uciD1jXP3KQr0pOm0sOyLoUaxyxAJS+ZKWESpmRw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=U+3Fqj+KPYWe5Fnx6AuRjpdMo/UFLXz7s1Un8En+AyV/KFb4qHjq9FC5Q10WfdsZ/Gz
 mD+G776Cpffyqp2BjPK25izZziHRpx1pBjfK9BqFxuVdiPo8uF93Gv7FGFKNOs2Y21u/f
 DOlLQsbTnY08+IkEh/g5HU2E9n8Q5O0tmg4=

--fgDXXWa3XlWoOEazJ84N
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 6529007522ded00b8912c079250620fa7a732166 upstream.
>=20
> An LVDS dual-link connection is made of two links, with even
> pixels transitting on one link, and odd pixels on the other
> link. The device tree can be used to fully describe dual-link
> LVDS connections between encoders and bridges/panels.
> The sink of an LVDS dual-link connection is made of two ports,
> the corresponding OF graph port nodes can be marked
> with either dual-lvds-even-pixels or dual-lvds-odd-pixels,
> and that fully describes an LVDS dual-link connection,
> including pixel order.

There is double-free bug here, AFAICT:

> +	for_each_child_of_node(port_node, endpoint) {
> +		struct device_node *remote_port;
> +		int current_pt;
> +
> +		if (!of_node_name_eq(endpoint, "endpoint"))
> +			continue;
> +
> +		remote_port =3D of_graph_get_remote_port(endpoint);
> +		if (!remote_port) {
> +			of_node_put(remote_port);
> +			return -EPIPE;
> +		}
> +
> +		current_pt =3D drm_of_lvds_get_port_pixels_type(remote_port);
> +		of_node_put(remote_port);

You have put remote_port here.

> +		if (pixels_type < 0)
> +			pixels_type =3D current_pt;
> +
> +		/*
> +		 * Sanity check, ensure that all remote endpoints have the same
> +		 * pixel type. We may lift this restriction later if we need to
> +		 * support multiple sinks with different dual-link
> +		 * configurations by passing the endpoints explicitly to
> +		 * drm_of_lvds_get_dual_link_pixel_order().
> +		 */
> +		if (!current_pt || pixels_type !=3D current_pt) {
> +			of_node_put(remote_port);
> +			return -EINVAL;

And again here.

Now... it is only a problem in error path, so maybe easiest way is to
fix it in the mainline and then backport the fix here...

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8YseYACgkQMOfwapXb+vJj0wCfaOCr+C/LDbjHKET2qqItFa+9
vWIAoKSRcj803tElmohqy+WIdF+MMat4
=MbEG
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--fgDXXWa3XlWoOEazJ84N
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4978): https://lists.cip-project.org/g/cip-dev/message=
/4978
Mute This Topic: https://lists.cip-project.org/mt/75730029/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fgDXXWa3XlWoOEazJ84N--
