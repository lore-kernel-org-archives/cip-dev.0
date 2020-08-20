Return-Path: <SRS0=4hF2=B6=lists.cip-project.org=bounce+64572+5163+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B4FC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 09:41:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906AF20724
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 09:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QBIglnsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906AF20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5163+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id S8M0YY4521723xEzqmubVBUB; Thu, 20 Aug 2020 02:41:56 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.107180.1597916514630939629
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Aug 2020 02:41:55 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2E0F01C0BD6; Thu, 20 Aug 2020 11:41:47 +0200 (CEST)
Date: Thu, 20 Aug 2020 11:41:46 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, biju.das.jz@bp.renesas.com,
	cip-dev@lists.cip-project.org, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/2] drm: atomic helper: fix W=1 warnings
Message-ID: <20200820094146.GA4985@amd>
References: <20200813083925.7830-1-biju.das.jz@bp.renesas.com>
 <20200813083925.7830-2-biju.das.jz@bp.renesas.com>
 <20200813204902.GB24086@duo.ucw.cz>
 <OSBPR01MB2983EFF3C8CD4DDA63FCEF18925D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983EFF3C8CD4DDA63FCEF18925D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PTmhaDJAooYIia47A6nEPNKRx4520388AA=
Content-Type: multipart/mixed; boundary="90CfZbGIeDGoZKaaPK1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597916516;
 bh=2ACzsAcVXThGUzqWXdyhL9xQstw5PvXzACguze7LVes=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QBIglnsc5MxdYF7M537MrotJHn2Q7dMgcTas3K01HR+6Oa8OMpuHJ3lpTBgYA7BN1eY
 9OyNyKBBIBR4CN4yrD3MjcAhrfNZiRJfGWKaUv7DnrkVNZ6bMjnWnWnBtkGoTHXYUp7JO
 c1FB0bY1E5p36UQDqhvNLB07I0utagfw4/c=

--90CfZbGIeDGoZKaaPK1z
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > commit bf5d837a0a4ced7cc223befc9e76d4ad30697d27 upstream.
> > >
> > > Few for_each macro set variables that are never used later which led
> > > to generate unused-but-set-variable warnings.
> > > Add (void)(foo) inside the macros to remove these warnings
> > >
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Link: https://patchwork.freedesktop.org/patch/msgid/20191008124254.21=
44-1-benjamin.gaignard@st.com
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >=20
> > Thanks for the fixes. Applied and pushed out.
>=20
> This patch doesn't seem to have been pushed yet.
> Could you push me?

Sorry for that, should be fixed now.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8+RVoACgkQMOfwapXb+vIrpACfUUQt94hwWr0m7d0AwfuhHrlq
IK8AoLdBJYw+5yZIWI/y6BhANJkrFXAh
=Jk8J
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--90CfZbGIeDGoZKaaPK1z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5163): https://lists.cip-project.org/g/cip-dev/message=
/5163
Mute This Topic: https://lists.cip-project.org/mt/76165489/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--90CfZbGIeDGoZKaaPK1z--
