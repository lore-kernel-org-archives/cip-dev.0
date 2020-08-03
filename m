Return-Path: <SRS0=7TXD=BN=lists.cip-project.org=bounce+64572+5083+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA2FC433E1
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 20:57:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7090922C9F
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 20:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OdlMZhwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7090922C9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5083+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iihHYY4521723xViygfH7q5W; Mon, 03 Aug 2020 13:57:08 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5775.1596488226869024765
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2020 13:57:07 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 815991C0BD7; Mon,  3 Aug 2020 22:57:01 +0200 (CEST)
Date: Mon, 3 Aug 2020 22:57:00 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] drm: of: Fix double-free bug
Message-ID: <20200803205700.GA16969@amd>
References: <20200803111441.3157-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200803111441.3157-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SzxKi2UXgsXlr0YmX5IoEnbdx4520388AA=
Content-Type: multipart/mixed; boundary="rtFeuPmCEF0JKLjhmeBW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596488228;
 bh=vFz24FKV+guNSDDRmwvnpvCp4wBTMapMm6f9TaifRng=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OdlMZhwZmcb1Q1u0CYFOkZcZUYYbriq33+hMHRXeEUp6uU/fJXdNwcwuMcpRT4iAnfk
 UtY2zQhLvMchPfiaBN1P9lx4ZtdWnHTemWGJx1X3zSrYlFArEyJJIBFWhd9arD0O8ZzBR
 dZgw2UBW1OpgDvfMl0d8n4vZVTGb4hJa6pY=

--rtFeuPmCEF0JKLjhmeBW
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 4ee48cc5586bf519df19894273002aa8ef7b70ad upstream.
>=20
> Fix double-free bug in the error path.

Looks good to me. I can apply it if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8oehwACgkQMOfwapXb+vLdhgCffB6AD1/IZuLy7L6cV3ODfGcY
D8gAnAvbvrNV0ldHYDwdHlcbqKhlVeOm
=SU5D
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--rtFeuPmCEF0JKLjhmeBW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5083): https://lists.cip-project.org/g/cip-dev/message=
/5083
Mute This Topic: https://lists.cip-project.org/mt/75963411/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--rtFeuPmCEF0JKLjhmeBW--
