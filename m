Return-Path: <SRS0=lGIW=FF=lists.cip-project.org=bounce+64572+5925+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EA9C64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 09:21:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3E220674
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 09:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="xZukJn9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3E220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5925+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6sabYY4521723xcTiLtIfqsP; Tue, 01 Dec 2020 01:21:54 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7790.1606814513016894036
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 01:21:53 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9BF441C0BC5; Tue,  1 Dec 2020 10:21:49 +0100 (CET)
Date: Tue, 1 Dec 2020 10:21:49 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v2 4.4.y-cip 03/11] soc: renesas: Identify SoC and register with the SoC bus
Message-ID: <20201201092149.GA4219@duo.ucw.cz>
References: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201201083938.32688-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201201083938.32688-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pQqKJY0Gl3iYmC0qLmunxkkSx4520388AA=
Content-Type: multipart/mixed; boundary="VdWy07PhsbipMF3NHlid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606814514;
 bh=QGu5JBmWucOg7ETi0EvMomatD+SbO2hL8BLrOFBak64=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=xZukJn9MLyQ6lmXg5V5v068TpgcLvfZuuNOJNrfDH+QhPpGYNEVCh/1jb/4TKw9hO4N
 8jGYVnzDMos0sdKMFf/kEkp5u3NjU1XHxufzon8LhYqTS1BLXOSjitNPytV9SmU9nKsls
 vonujyAqlpsm64vZ7x90+KJdlShoVXJrjhw=

--VdWy07PhsbipMF3NHlid
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit 8d6799a9ba23acd675f3243580ee6f1756fb4381 upstream.
>=20
> Identify the SoC type and revision, and register this information with
> the SoC bus, so it is available under /sys/devices/soc0/, and can be
> checked where needed using soc_device_match().
>=20
> Identification is done using the Product Register or Common Chip Code
> Register, as declared in DT (PRR only for now), or using a hardcoded
> fallback if missing.

Just a minor nitpicks; no need to fix them for merge but maybe
consideration for mainline?

> +	soc_dev_attr =3D kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	np =3D of_find_node_by_path("/");
> +	of_property_read_string(np, "model", &soc_dev_attr->machine);
> +	of_node_put(np);
> +
> +	soc_dev_attr->family =3D kstrdup_const(family->name, GFP_KERNEL);
> +	soc_dev_attr->soc_id =3D kstrdup_const(strchr(match->compatible, ',') +=
 1,
> +					     GFP_KERNEL);
> +	if (chipid)
> +		soc_dev_attr->revision =3D kasprintf(GFP_KERNEL, "ES%u.%u",
> +						   ((product >> 4) & 0x0f) + 1,
> +						   product & 0xf);

If memory allocations fail here, would it be better to fail the probe?

Would it be better to return error if !strchr(match->compatible, ',')
instead of trying to kstrdup_const((void *) 1) and oopsing?

> +	pr_info("Detected Renesas %s %s %s\n", soc_dev_attr->family,
> +		soc_dev_attr->soc_id, soc_dev_attr->revision ?: "");

Revision is NULL is handled here, but family may well be NULL, too, if
allocation failed. It is not going to cause problems here, but...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX8YLLQAKCRAw5/Bqldv6
8kPpAJ91ZVNGauRY1CuRbjgEftdy4b87bQCgk1/HUHfFGk8QN6+a4WBWwrp2d7Y=
=S5HW
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--VdWy07PhsbipMF3NHlid
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5925): https://lists.cip-project.org/g/cip-dev/message=
/5925
Mute This Topic: https://lists.cip-project.org/mt/78628861/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VdWy07PhsbipMF3NHlid--
