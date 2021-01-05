Return-Path: <SRS0=RhtV=GI=lists.cip-project.org=bounce+64572+6031+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA859C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:39:01 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C9E22CB3
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C9E22CB3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6031+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id N0dLYY4521723x4h9YW0uPRv; Tue, 05 Jan 2021 08:39:00 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.8194.1609864739442953491
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 08:38:59 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DF7D31C0B78; Tue,  5 Jan 2021 17:38:55 +0100 (CET)
Date: Tue, 5 Jan 2021 17:38:55 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/8] Optimize pinctrl and add QSPI[01] pins for RZ/G2{H,M,N,E}
Message-ID: <20210105163855.GA361@amd>
References: <20210105151057.12752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210105151057.12752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Oi20lm21mQFrYXTDEK7kMRG0x4520388AA=
Content-Type: multipart/mixed; boundary="hdnrBPNJi3a1AFrJxfKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609864740;
 bh=k5nlVtrHqYYOEQUq5LMju3kiCgIxAT3Ppc8D8otKpvE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ap8E+P1Cq4HLes+zjTfHxQvtwMMZ4Qj53cSrsEqnWCtEAl+K21wAlzs5mIrGVLD0Rqu
 Z25nQuotlb0/l0q6cFQFCp4x9Z6Ujf2xoSa2CQQEbI3Q4Q0mpsApvG+IhvuYm8BmY1lTR
 ivpoG9+20ChqdZf/zExD1vGaPl8O7O2+CIs=

--hdnrBPNJi3a1AFrJxfKa
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series optimizes pinctrl driver for size and adds QSPI[01]
> pins for RZ/G2{H,M,N,E} SoC.
>=20
> All the patches have been cherry picked from v5.11-rc2
>=20
> Currently the SoC DTSI changes are being upstreamed [1] once this hits -rc
> this will be backported to the CIP. This is for users who currently plan =
to
> enable RPC-IF on CIP kernel (using patches from [1] to enable RPC-IF).
>=20
> [1]
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D408=
139


I went through this and "Add missing rpc-if clock on RZ/G2{E,M,N} SoC"
series, and they look okay to me. I can apply them if there are no
other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/0lh4ACgkQMOfwapXb+vI8NQCgrFO5h3ZTlvIvLIkcZ6Rr8Ztj
wOkAn3DQBOzZo2aT6YNYwGBJYZrDmK4U
=Q1Y/
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

--hdnrBPNJi3a1AFrJxfKa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6031): https://lists.cip-project.org/g/cip-dev/message=
/6031
Mute This Topic: https://lists.cip-project.org/mt/79451745/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hdnrBPNJi3a1AFrJxfKa--
