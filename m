Return-Path: <SRS0=La7+=CM=lists.cip-project.org=bounce+64572+5409+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10161C2D0A6
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:46:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA041208C7
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 20:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Tzvwc5AG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA041208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5409+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id T1HcYY4521723xBUwAFxSTCE; Thu, 03 Sep 2020 13:46:50 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.23802.1599166009631301061
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 13:46:50 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0EDDB1C0B76; Thu,  3 Sep 2020 22:46:47 +0200 (CEST)
Date: Thu, 3 Sep 2020 22:46:45 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 2/4] serial: sh-sci: Terminate TX DMA during buffer flushing
Message-ID: <20200903204645.GB24361@duo.ucw.cz>
References: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903142719.13010-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200903142719.13010-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: y2ocZRC7axtPp3CxvTcQ3Vmax4520388AA=
Content-Type: multipart/mixed; boundary="9HjBNm3aFM9Xru7RIui1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599166010;
 bh=mdM/1uvi/RVWEhfPRgLsyrIAT4CjRHRAODK7Lvz+WWo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Tzvwc5AGKFiXR6U7WdpFVEb6kuUDycMsmRlXyXnnb2ZYY5TPuoEYRPXKu1emBaxnTgh
 oc2L1NUCDgJaGaj1qqbRTeSnJl584udwaPb3rPNu4y4dwJI6eEcmXtPj1mXSUtnoWrdb4
 ssfJwMRIZyea+dxPQ+ikV0l6NYDByM4qfr0=

--9HjBNm3aFM9Xru7RIui1
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline

--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit 775b7ffd7d6d5db320d99b0a485c51e04dfcf9f1 upstream.
>=20
> While the .flush_buffer() callback clears sci_port.tx_dma_len since
> commit 1cf4a7efdc71cab8 ("serial: sh-sci: Fix race condition causing
> garbage during shutdown"), it does not terminate a transmit DMA
> operation that may be in progress.
>=20
> Fix this by terminating any pending DMA operations, and resetting the
> corresponding cookie.

What is the impact of the bug? DMA running during reboot, but not
doing any harm?

Anyway, this looks okay to me.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1FWNQAKCRAw5/Bqldv6
8u2hAJwN58gSytLSLZNNytDuMkJzQC6tCACgrzHm2nCup36vzKITdYNWAzpNw8E=
=AvyV
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--

--9HjBNm3aFM9Xru7RIui1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5409): https://lists.cip-project.org/g/cip-dev/message=
/5409
Mute This Topic: https://lists.cip-project.org/mt/76607962/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--9HjBNm3aFM9Xru7RIui1--
