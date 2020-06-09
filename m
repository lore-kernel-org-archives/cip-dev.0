Return-Path: <SRS0=x39O=7W=lists.cip-project.org=bounce+64572+4790+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76859C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 11:01:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA00A207C3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 11:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="galztItR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA00A207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4790+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hd6sYY4521723xIJvLQ3PF8L; Tue, 09 Jun 2020 04:01:44 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4662.1591700502931145117
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jun 2020 04:01:43 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CF6051C0C0C; Tue,  9 Jun 2020 13:01:40 +0200 (CEST)
Date: Tue, 9 Jun 2020 13:01:40 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip v3 00/14] PM / OPP v2 & cpufreq backports part 1
Message-ID: <20200609110140.GC27637@amd>
References: <20200609040926.8910-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200609040926.8910-1-wens@csie.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4wPq28J5MFGJOeSmoZsHIdb5x4520388AA=
Content-Type: multipart/mixed; boundary="kROYRcmIrnJWC2YLajhW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591700504;
 bh=9u6o6IiiuiSNLFmX75UEVPz/Xc4N0QCnKqRkfdFRDzo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=galztItRGjCwHT8Wa5xfF+VxqQ5GZogzOL4zWP4hWnIxAAN83qhIo8W6oCY7u++u7qc
 3XTd3YBsMybMS+PPuriReqVicxypfBlVkwZHxPhd7zpR2xWoeeCh2D1LcUXyb/P0B4cCw
 pGqKYh8BcqEgZmm7CA+lzNq+ESR1XRXIN3Y=

--kROYRcmIrnJWC2YLajhW
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline

--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is v3 of the part 1 of MOXA's PM / OPP / cpufreq backport series.
> Changes since v2:
>=20
>   - Squashed "PM / OPP: Fix parsing of opp-microvolt and opp-microamp
>     properties" into "PM / OPP: Parse 'opp-<prop>-<name>' bindings"
>=20
> Changes since v1:
>=20
>   - Added missing SoB and upstream commit hash for "PM / OPP: Set
>     cpu_dev->id in cpumask first"

Thanks! I have applied the series, will run some basic tests and push
the results if they work okay.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7fbBQACgkQMOfwapXb+vJOpACfU1aqroEa9kjoMW/rnjuMKiNJ
FdkAn1PAUlRk2HMMZTDOEYhHbKNks0x5
=gQvH
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--

--kROYRcmIrnJWC2YLajhW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4790): https://lists.cip-project.org/g/cip-dev/message=
/4790
Mute This Topic: https://lists.cip-project.org/mt/74768055/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kROYRcmIrnJWC2YLajhW--
