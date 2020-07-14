Return-Path: <SRS0=efIL=AZ=lists.cip-project.org=bounce+64572+4923+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184CCC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:37:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC86922519
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dU9v8WhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC86922519
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4923+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DT93YY4521723xgmOJ32Q6qu; Tue, 14 Jul 2020 10:37:23 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1720.1594748242140085958
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2020 10:37:22 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8DE3F1C0BD7; Tue, 14 Jul 2020 19:37:19 +0200 (CEST)
Date: Tue, 14 Jul 2020 19:37:19 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 17/23] PM / OPP: Fix NULL pointer dereference crash when disabling OPPs
Message-ID: <20200714173719.GB18210@amd>
References: <20200708154554.26450-1-wens@csie.org>
 <20200708154554.26450-18-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200708154554.26450-18-wens@csie.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 83P2WX4TOByGNwIsAcEkuhu4x4520388AA=
Content-Type: multipart/mixed; boundary="G6kZNFPuG0UFusYHN2e1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594748243;
 bh=Ws1ca/3t3xWL8yo17byMMS9mZbluZ6lEZPsmwht1QRE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dU9v8WhZMtVlit8V1qmwyvZ/6NxltooygKmHSCcWAI6aw9cCbzAVRjNvE3YZzU75kr1
 5c5MZhwi5kei2Q5iUMQ6BGO5Dig6rm+IqsWlIrY0UaQJ6TzGTmXlUqwbDVRJWQCiFFX+f
 tWUfBx1IbXhwNwJywLQWS2VPxb43HgkDFo4=

--G6kZNFPuG0UFusYHN2e1
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline

--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed 2020-07-08 23:45:48, Chen-Yu Tsai (Moxa) wrote:
> From: Jon Hunter <jonathanh@nvidia.com>
>=20
> commit 78ecc56247f0ec2bc0cf6f2f2af69e98d99767bc upstream.
>=20
> Commit 7d34d56ef334 (PM / OPP: Disable OPPs that aren't supported by
> the regulator) causes a crash to happen on Tegra124 Jetson TK1 when
> using the DFLL clock source for the CPU.  The DFLL manages the voltage
> itself and so there is no regulator specified for the OPPs and so we
> get a crash when we try to dereference the regulator pointer.  Fix
> this by checking to see if the regulator IS_ERR_OR_NULL before
> dereferencing it.
>=20
> Fixes: 7d34d56ef334 (PM / OPP: Disable OPPs that aren't supported by

So this one should be close to the patch it fixes, or maybe squashed
together.

Best regards,
								Pavel

> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 91b4cc261d84a..067379f931662 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -975,7 +975,7 @@ static bool _opp_supported_by_regulators(struct dev_p=
m_opp *opp,
>  {
>  	struct regulator *reg =3D dev_opp->regulator;
> =20
> -	if (!IS_ERR(reg) &&
> +	if (!IS_ERR_OR_NULL(reg) &&
>  	    !regulator_is_supported_voltage(reg, opp->u_volt_min,
>  					    opp->u_volt_max)) {
>  		pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8N7U8ACgkQMOfwapXb+vKoFACfQg4fRi8sgcpGv+NyaqOlFBg8
N3wAniwoKwBYWPfjbAADXHJwjhhNm49W
=v/V7
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

--G6kZNFPuG0UFusYHN2e1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4923): https://lists.cip-project.org/g/cip-dev/message=
/4923
Mute This Topic: https://lists.cip-project.org/mt/75379094/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--G6kZNFPuG0UFusYHN2e1--
