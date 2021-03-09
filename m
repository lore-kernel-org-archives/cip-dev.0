Return-Path: <SRS0=hB4J=IH=lists.cip-project.org=bounce+64572+6260+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B07FC433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 20:39:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C720C64F4B
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 20:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C720C64F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6260+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bkKTYY4521723xKDqqvGoztA; Tue, 09 Mar 2021 12:39:18 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.416.1615322357545992694
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 12:39:17 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EFE991C0B78; Tue,  9 Mar 2021 21:39:14 +0100 (CET)
Date: Tue, 9 Mar 2021 21:39:14 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 21/40] arm64: dts: renesas: r8a774c0-cat874: Add support for AISTARVISION MIPI Adapter V2.1
Message-ID: <20210309203914.GA9574@amd>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210309163656.20944-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4RW6hqWknt5KJ8EqoPF93BJnx4520388AA=
Content-Type: multipart/mixed; boundary="IHi0escNcI9DvYJ4eZxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615322358;
 bh=h6Mj24yasVeoo/DLlsSiqVs0EfTTQfynb5+T/htniIA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nDNg9XrayH6ireiw0srRyRcR9StoaXde7wLgkmbgWvIp/hCj/2JRQwQWVcrrmrqNquc
 1TGyct3A54sIHrtyofBO2qQyTdlSgNe+bnaZGFz41fSdU9t+cmdkhxhCNxglS/UEa2B6s
 yP7k4EGUDn37V4rZF+okcHkW/95d0ZNvqbM=

--IHi0escNcI9DvYJ4eZxx
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +		imx219_ep: endpoint {
> +			clock-lanes =3D <0>;
> +			data-lanes =3D <1 2>;
> +			link-frequencies =3D /bits/ 64 <456000000>;
> +			/* uncomment remote-endpoint property to tie imx219 to
> +			 * CSI2 also make sure remote-endpoint for ov5645 camera
> +			 * is commented and remote endpoint phandle in csi40_in
> +			 * is imx219_ep
> +			 */

This needs to be normal comment style, and it needs to contain
sentences. And it may be better to provide #ifdef for the alternate
configuration.

> +			/* remote-endpoint =3D <&csi40_in>; */

Best regards,
							Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBH3PIACgkQMOfwapXb+vIP0gCggpWBpEdDVN1oXXU4I7FmLz9x
P5IAn3Y6g93rphAYRN8ATfs44cvKcQgl
=Ebx2
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--IHi0escNcI9DvYJ4eZxx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6260): https://lists.cip-project.org/g/cip-dev/message=
/6260
Mute This Topic: https://lists.cip-project.org/mt/81205369/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--IHi0escNcI9DvYJ4eZxx--
