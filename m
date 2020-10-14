Return-Path: <SRS0=vs49=DV=lists.cip-project.org=bounce+64572+5574+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55608C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F712054F
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EFkjDFLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F712054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5574+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5biLYY4521723xeJl3b5tGvR; Wed, 14 Oct 2020 02:22:33 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7927.1602667351596289861
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2020 02:22:32 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 75D9D1C0B8B; Wed, 14 Oct 2020 11:22:27 +0200 (CEST)
Date: Wed, 14 Oct 2020 11:22:26 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 41/50] PCI: rcar: Add endpoint mode support
Message-ID: <20201014092226.GA1866@amd>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-42-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201012141933.9652-42-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: T4qlUyPPoVfm2hIPL8OOUjHQx4520388AA=
Content-Type: multipart/mixed; boundary="DvAdocxvO8hm3rkVNlQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602667353;
 bh=EaWuqDZ8zLY1MBs2Nr6shhd3bx7tpC9A3XiGWkrUz7k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EFkjDFLGGrc26k3GSR/nP7B/n6bO6CtYQ7xiQ9CYz5tk5QbYfhxnJS9DP06ceflm4PV
 mqthwS27MtIqHSC16SunuhUntFY30HdNVBKMExm4yFLgnBukayE7yOfTfr84WrJ9FLj7d
 tTp1vrbu61ASQSDv8H3N/y2Npm2YBLrAHJ0=

--DvAdocxvO8hm3rkVNlQD
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 2a6d0d63d99956a66f6605832f11755d74a41951 upstream.
>=20
> Add support for R-Car PCIe controller to work in endpoint mode.

> +		ep->ob_window[i].phys_base =3D res->start;
> +		ep->ob_window[i].size =3D resource_size(res);
> +		/* controller doesn't support multiple allocation
> +		 * from same window, so set page_size to window size
> +		 */

Comment not according to CodingStyle.

> +	memset(&win, 0x0, sizeof(win));
> +	memset(&res, 0x0, sizeof(res));

Plain 0 would be enough


> +	val |=3D ASTINTX;
> +	rcar_pci_write_reg(pcie, val, PCIEINTXR);
> +	usleep_range(1000, 1001);
> +	val =3D rcar_pci_read_reg(pcie, PCIEINTXR);

This is crazy. Either you need exact timing or you don't, but I don't
believe usleep can guarantee microsecond accuracy.

(And you probably don't need it, right?)

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+Gw1IACgkQMOfwapXb+vIouACZAVOHCcbtRKPPwDykZVLuOiql
c0wAnRLSEu34G0abNQ7Uu+0To9b0x7im
=nFUA
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

--DvAdocxvO8hm3rkVNlQD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5574): https://lists.cip-project.org/g/cip-dev/message=
/5574
Mute This Topic: https://lists.cip-project.org/mt/77461723/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DvAdocxvO8hm3rkVNlQD--
