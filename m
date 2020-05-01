Return-Path: <SRS0=aFtI=6S=lists.cip-project.org=bounce+64572+4612+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DB5C47247
	for <cip-dev@archiver.kernel.org>; Mon,  4 May 2020 22:41:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78029206EB
	for <cip-dev@archiver.kernel.org>; Mon,  4 May 2020 22:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ruvPuWVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78029206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4612+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BwZ9YY4521723xfrY8PFMP4f; Mon, 04 May 2020 15:41:55 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.6645.1588325506739869008
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 May 2020 02:31:47 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 87ACB1C020C; Fri,  1 May 2020 11:31:44 +0200 (CEST)
Date: Fri, 1 May 2020 11:31:43 +0200
From: Pavel Machek <pavel@denx.de>
To: Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= <JohnsonCH.Chen@moxa.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 3/3] cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
Message-ID: <20200501093143.GB11782@amd>
References: <HK2PR01MB3281A0A027BAB0F4F036AC7AFAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
In-Reply-To: <HK2PR01MB3281A0A027BAB0F4F036AC7AFAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mrUTGAKkpFa5A63q1CLdgKrAx4520388AA=
Content-Type: multipart/mixed; boundary="YCp3xFrCbVtD5im5mUPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1588632115;
 bh=o6mXI8c49bZoP41EnRjJtuSrY+6zIIV2zMOu8X+rgeE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ruvPuWVZL7Dhj9S5QYB0efLim2n64kqgko4kXBxQUMu0e5Y5qTq3xTpPYgK6SOzCC0C
 UdpO8Ct6x1PjD2Xn9rbRkzKnsDTLd8H8XwuZV2cxbuqFa56Dq8L0nceZav6lz8gz15GOb
 EI3aGYC8BZ5ZD28AEy94XxDtYhTgfX1Cz8I=

--YCp3xFrCbVtD5im5mUPh
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline

--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Dave Gerlach <d-gerlach@ti.com>
> =20
> commit e13cf046cd70894393a1085ca39da7ef751353fb upstream
>=20
> Some TI SoCs, like those in the AM335x, AM437x, DRA7x, and AM57x families,
> have different OPPs available for the MPU depending on which specific
> variant of the SoC is in use. This can be determined through use of the
> revision and an eFuse register present in the silicon. Introduce a
> ti-cpufreq driver that can read the aformentioned values and provide
> them as version matching data to the opp framework. Through this the
> opp-supported-hw dt binding that is part of the operating-points-v2
> table can be used to indicate availability of OPPs for each device.
>=20
> This driver also creates the "cpufreq-dt" platform_device after passing
> the version matching data to the OPP framework so that the cpufreq-dt
> handles the actual cpufreq implementation. Even without the necessary
> data to pass the version matching data the driver will still create this
> device to maintain backwards compatibility with operating-points v1
> tables.
>=20
> index 000000000000..3dbf57164ded
> --- /dev/null
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -0,0 +1,272 @@
> +/*
> + * TI CPUFreq/OPP hw-supported driver
> + *
> + * Copyright (C) 2016-2017 Texas Instruments, Inc.
> + *	 Dave Gerlach <d-gerlach@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.

I guess SPDX would be better than this.

> +static int ti_cpufreq_init(void)
> +{
=2E..
> +	/*
> +	 * OPPs determine whether or not they are supported based on
> +	 * two metrics:
> +	 *	0 - SoC Revision
> +	 *	1 - eFuse value
> +	 */
> +	ret =3D ti_cpufreq_get_rev(opp_data, &version[0]);
> +	if (ret)
> +		goto fail_put_node;
> +
> +	ret =3D ti_cpufreq_get_efuse(opp_data, &version[1]);
> +	if (ret)
> +		goto fail_put_node;
> +
> +	of_node_put(opp_data->opp_node);
> +
> +	ret =3D dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
> +						version, VERSION_COUNT);
> +	if (ret) {
> +		dev_err(opp_data->cpu_dev,
> +			"Failed to set supported hardware\n");
> +		goto fail_put_node;
> +	}

This should be "return err", we have already put the node few lines
above.

> +register_cpufreq_dt:
> +	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +
> +	return 0;
> +
> +fail_put_node:
> +	of_node_put(opp_data->opp_node);
> +
> +	return ret;
> +}

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6r7H8ACgkQMOfwapXb+vLzWQCeI9j3T5oRmKo40hcf/vNs69w1
TTMAnA9Cn6dOFCXeLsgvcylK+BFtPaBa
=WqT4
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

--YCp3xFrCbVtD5im5mUPh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4612): https://lists.cip-project.org/g/cip-dev/message=
/4612
Mute This Topic: https://lists.cip-project.org/mt/73369237/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--YCp3xFrCbVtD5im5mUPh--
