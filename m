Return-Path: <SRS0=xJse=BW=lists.cip-project.org=bounce+64572+5111+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1C3C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 12 Aug 2020 19:37:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F428208B3
	for <cip-dev@archiver.kernel.org>; Wed, 12 Aug 2020 19:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jI1rAGmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F428208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5111+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cWnjYY4521723xQ9G2tsG97W; Wed, 12 Aug 2020 12:37:51 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.401.1597261070561615696
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2020 12:37:51 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6F9191C0BD2; Wed, 12 Aug 2020 21:37:47 +0200 (CEST)
Date: Wed, 12 Aug 2020 21:37:46 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [linux-cip:linux-4.19.y-cip 7/17] drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for 'drm_atomic_get_old_private_obj_state'
Message-ID: <20200812193746.GB19363@amd>
References: <202008092247.i5TR1Oel%lkp@intel.com>
 <TYBPR01MB53096578ABB1E74E2E2153DA86450@TYBPR01MB5309.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYBPR01MB53096578ABB1E74E2E2153DA86450@TYBPR01MB5309.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 16JQVDtv5b925HKxHvPkmRnHx4520388AA=
Content-Type: multipart/mixed; boundary="gjii14of3jPi1JoHn5MV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597261071;
 bh=nIkktr7/u00jWqNcVd8z2UA97IhssK+zx5p7tIAaru4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jI1rAGmCILHtbbWyii5ZJUvKKaporrDtwEZSejcGvsixkojICzI4PndixomHT9C61Rs
 h2MBeFW2qNpVYw+L1WmqWkVYYIJrdhdjOMUFkCLuv0jr0GH6uQGRyXUDI9ht/bbmdoxLd
 MUAHD3nZUdc6Kc2GShuz7qVbPOsovrF1j+M=

--gjii14of3jPi1JoHn5MV
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I have received a warning message mail from Kernel test robot. I have inv=
estigated this issue and found there were lots of warnings with architectur=
e by following the steps mentioned in this mail.
>=20
> Then I investigated this particular issue and found that issue is caused =
by bad commit done by me while backporting. The below backport commit has
> extra functions from patch1(0001-drm-Add-drm_atomic_get_old-new_private_o=
bj_state.patch), but the corresponding header is missing.
>=20
> cip commit: cacc2a81b9872aa8830353110b1252021f124ae8
> upstream commit: 1b27fbdde1df172dba604855c45078d741f8c858
>=20
> I have attached 3 patches, that looks like fixes the issue mentioned by k=
ernel robot.
>=20
> How do we proceed here?
> drop cip commit: cacc2a81b9872aa8830353110b1252021f124ae8 and apply the 3=
 patches to fix this issue?
>

First I want to make sure: we are talking about commit
60b4667275b60d92c760d48df95f5b80bbcfde6e? Because I don't see
cacc2a81b9872aa8830353110b1252021f124ae8 around.

Best regards,
							Pavel

commit 60b4667275b60d92c760d48df95f5b80bbcfde6e
Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Wed Jul 22 17:34:39 2020 +0100

    drm: Add drm_atomic_get_(old|new)_connector_for_encoder() helpers

    commit 1b27fbdde1df172dba604855c45078d741f8c858 upstream.

    Add functions to the atomic core to retrieve the old and new
    connectors associated with an encoder in a drm_atomic_state. This
    is useful for encoders and bridges that need to access the
    connector, for instance for the drm_display_info.
=09

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl80RQoACgkQMOfwapXb+vJzoQCfeAapp4Zn4AJlBn8iWOTSYk7b
aE4AniausK076QKMku6s9zasy+HBVbQX
=Zs0/
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

--gjii14of3jPi1JoHn5MV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5111): https://lists.cip-project.org/g/cip-dev/message=
/5111
Mute This Topic: https://lists.cip-project.org/mt/76126617/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gjii14of3jPi1JoHn5MV--
