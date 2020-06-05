Return-Path: <SRS0=nyW7=7S=lists.cip-project.org=bounce+64572+4725+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE2C433E0
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 11:45:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1E7206E6
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 11:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="L0R41TKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1E7206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4725+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CjzEYY4521723xRc4pjKP3H0; Fri, 05 Jun 2020 04:45:06 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9051.1591357504976332199
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jun 2020 04:45:05 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6EA1D1C0BD2; Fri,  5 Jun 2020 13:45:01 +0200 (CEST)
Date: Fri, 5 Jun 2020 13:44:46 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [PATCH v2 v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Message-ID: <20200605114446.GB26010@duo.ucw.cz>
References: <1591087404-7118-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <OSBPR01MB298388B7BE773E7DD4284E4A928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20200604084220.GA18398@duo.ucw.cz>
 <OSAPR01MB25320997874CB4CA51FD876AC2860@OSAPR01MB2532.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB25320997874CB4CA51FD876AC2860@OSAPR01MB2532.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DkofK6tPTOCJICx87oAvKSJtx4520388AA=
Content-Type: multipart/mixed; boundary="KMYWlar3Kl8jI1Puxj9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591357506;
 bh=lOBDnumM/MoXWAE12PdqO9/GxT1IPrCUfHc1tdoaLm8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=L0R41TKqhC7e9AYM5+hCQJWK9+D9AuHZjrQpEN89wGZY1W3TbF9JnPi5AAgiNiJxME0
 92Gmwivsb3GBhAoV7WogErvckn/KVTPX6jcERNlv/aJz0MiUo3ZDvs3+iCXO7YT/+kh64
 68MfOnf2AQFaiirMVQXOx5EStgyG0t6hyu4=

--KMYWlar3Kl8jI1Puxj9N
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline

--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > SIMPLE_PANEL is not enabled in
> > 4.4.y-cip/arm/renesas_shmobile_defconfig , and it seems to be driver
> > relevant to this panel.
>=20
> This seems to be a problem. DRM_PANEL_SIMPLE depends on DRM_PANEL,
> but DRM_PANEL is not user selectable, it needs to be selected by another =
option.
> In upstream, commit:
> https://github.com/torvalds/linux/commit/bf7149f34
>=20
> modified the LVDS driver to use the panel API to delegate panel handling,=
 rather
> than parsing the DT manually, and of course in the same context Kconfig is
> modified to select DRM_PANEL.
>=20
> I think we should have another look at this, do you guys think it's possi=
ble to drop
> this patch?

It is possible to drop the patch and force push before new commits are
added on top. It is also possible to queue a revert at any later time.

OTOH if the patch is not wrong, just needs another patch to be useful,
I'd keep it.

Adding prompt to Kconfig so that it can be enabled manually should not
be too hard to do.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtowLgAKCRAw5/Bqldv6
8hsGAJsFLOskPUw4bUjxe0dBoG+sl+v2DQCffu+BA/aMHEpEHg1grBXrGpA/lXo=
=qPJ5
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

--KMYWlar3Kl8jI1Puxj9N
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4725): https://lists.cip-project.org/g/cip-dev/message=
/4725
Mute This Topic: https://lists.cip-project.org/mt/74623758/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--KMYWlar3Kl8jI1Puxj9N--
