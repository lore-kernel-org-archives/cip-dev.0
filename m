Return-Path: <SRS0=X04f=CB=lists.cip-project.org=bounce+64572+5229+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62408C433DF
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 19:04:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D838206C0
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 19:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vtvhWIxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D838206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5229+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pZMUYY4521723xceF9Dmzy3u; Sun, 23 Aug 2020 12:04:28 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.180035.1598209466878692107
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Aug 2020 12:04:27 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 568C41C0BB7; Sun, 23 Aug 2020 21:04:25 +0200 (CEST)
Date: Sun, 23 Aug 2020 21:04:25 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/7] Add IPMMU/SYS-DMAC/GPIO/EAVB Support on R8A774E1
Message-ID: <20200823190425.GC25365@duo.ucw.cz>
References: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IxhD5hGvZeZMdKKBvIZI8c5dx4520388AA=
Content-Type: multipart/mixed; boundary="K5Kcr83K0fqkGDl2uWCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598209468;
 bh=GCtffLbsyZRn8ZuM4WOdQcmVitTQylP3Q4ar9WDVSNM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vtvhWIxBaAykdCoEsLPeYo3G1kHvwayvYbrKWX3P9vJujA2vOo2x5ZC2GmUkxL3Nnaw
 6rcTBk3TXYG5b6irTReZF4mxu/Rx1k7p2U8ojBWZXPD9yU+IhAbWRFmc+01LxatycZlyd
 nSHc6k3Bm1rdsGk6qzke63t4Xjwv2n4Qges=

--K5Kcr83K0fqkGDl2uWCF
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline

--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series add support for IPMMU/SYS-DMAC/GPIO/EAVB on
> HiHope RZ/G2H board based on R8A774E1 SoC.
>=20
> This patches in this series are cherry-picked from mainline.
>=20
> This patch series depend upon [1]
> [1]:
> https://patchwork.kernel.org/project/cip-dev/list/?series=3D336489

This series looks ok to me, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0K9uQAKCRAw5/Bqldv6
8p22AKC2HsiPl4KX39vug/FLV953IcDZhQCfc3zzdPqDJ0+FvswAa0nh6fBdtHE=
=oa9V
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--

--K5Kcr83K0fqkGDl2uWCF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5229): https://lists.cip-project.org/g/cip-dev/message=
/5229
Mute This Topic: https://lists.cip-project.org/mt/76329804/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--K5Kcr83K0fqkGDl2uWCF--
