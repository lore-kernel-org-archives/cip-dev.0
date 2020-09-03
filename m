Return-Path: <SRS0=tM/V=CM=lists.cip-project.org=bounce+64572+5403+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A18C433E9
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 17:23:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808B020716
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 17:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KOoChUlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808B020716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5403+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yVbrYY4521723xw4qGf6RQ8X; Thu, 03 Sep 2020 10:23:42 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.19417.1599153820280750019
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 10:23:41 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A9F4C1C0B7A; Thu,  3 Sep 2020 19:23:36 +0200 (CEST)
Date: Thu, 3 Sep 2020 19:23:35 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/6] RZ/G1H add support for Ether/[H]SCIF{A|B}
Message-ID: <20200903172335.GA7795@duo.ucw.cz>
References: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QrEj0FTncLYEuobfhx6nwUUAx4520388AA=
Content-Type: multipart/mixed; boundary="CSRhj1F4izT1B7m7T4Un"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599153822;
 bh=j3leglNSIY7kQ3CH2JF+o2dWD51DctFtlsFbbmuO/Q8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KOoChUlIXyrF/Sxr+Gp+0IiQ/2/jGfE+AR9ZsRuFUvLWQVMZNWi8anf3DgQgoo/NJTV
 5IbVCpQftPx2lFVSlLQRziQ3frZomzJbnxJ9GlJexfyvbI/oesomgu9vlUBd7b0/YfObO
 DnMKhYk1/tkb9KyLNpi8sfrz6XYkS/Y86bM=

--CSRhj1F4izT1B7m7T4Un
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for ETHER/[H]SCIF{A|B} to
> R8A7742 SoC and alongside adds camera daughter board dts
> which fits on iwg21d-q7 development platform.
>=20
> Patches 1/6, 3/6, 5/6, 6/6 have been cherry picked from
> upstream kernel, patch 2/6 is a hookup patch to enable=20
> eth on R8A7742 SoC and patch 4/6 is a fixup patch.

This series looks okay to me.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1EmlwAKCRAw5/Bqldv6
8kH5AKCiYmh2CHGCiwR7rocCWLL8DYFIzgCfVMjZi9ViDbtPtTmBFPgkj/wW15g=
=Yzk/
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--CSRhj1F4izT1B7m7T4Un
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5403): https://lists.cip-project.org/g/cip-dev/message=
/5403
Mute This Topic: https://lists.cip-project.org/mt/76608365/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CSRhj1F4izT1B7m7T4Un--
