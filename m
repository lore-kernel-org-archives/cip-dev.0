Return-Path: <SRS0=eAVe=E6=lists.cip-project.org=bounce+64572+5838+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B686C2D0E4
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 09:37:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F18E2076B
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 09:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UwrXNKQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F18E2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5838+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TkziYY4521723xw52XfnTLuk; Tue, 24 Nov 2020 01:37:55 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.49638.1606210674744323555
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 01:37:55 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6C4F41C0B78; Tue, 24 Nov 2020 10:37:51 +0100 (CET)
Date: Tue, 24 Nov 2020 10:37:50 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/2] Add sound support to R8A774E1 SoC
Message-ID: <20201124093749.GA21989@amd>
References: <20201123105453.22074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201123105453.22074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gtloJ4ESaaWJts4FZBwUIhECx4520388AA=
Content-Type: multipart/mixed; boundary="bLin2aigUivaDGtazeAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606210675;
 bh=4xxYQTyD7kyHGcGwbyHCpxjJpSElJSaYtM74uVqCLy8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UwrXNKQYTGGmHxxLpqcbPiyZL00CVS05w5mG9AgIL7X6v+ErWZDMbfzDxf8ejbfmKlH
 IjoF8uKztlmWgwlh6AAZn18lIosjPC2p66If7waTnvEYCbS9Wj4eeJTOsnUaf2zLGn4Vt
 RtFDi3c4dipUcCU1qqmMu2JTzK/L88XXS3s=

--bLin2aigUivaDGtazeAe
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds sound support to Renesas R8A774E1 SoC.
>=20
> All the patches have been cherry picked from Linux v5.10-rc5.

Thanks, applied and pushed out.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+81G0ACgkQMOfwapXb+vJFQgCguc8f21CxrgPHmFUN0PtgWax3
tIEAoIUjO9FLL4PpRoyCDI0gOWWPCCzR
=h4R9
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

--bLin2aigUivaDGtazeAe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5838): https://lists.cip-project.org/g/cip-dev/message=
/5838
Mute This Topic: https://lists.cip-project.org/mt/78450804/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bLin2aigUivaDGtazeAe--
