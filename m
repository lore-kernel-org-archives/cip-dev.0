Return-Path: <SRS0=Za5v=FI=lists.cip-project.org=bounce+64572+5943+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F618C4361A
	for <cip-dev@archiver.kernel.org>; Fri,  4 Dec 2020 16:40:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893A622AAF
	for <cip-dev@archiver.kernel.org>; Fri,  4 Dec 2020 16:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893A622AAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5943+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QBgyYY4521723xnv0JCvqQtz; Fri, 04 Dec 2020 08:40:12 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16879.1607100011232436303
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Dec 2020 08:40:11 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A7B131C0B8D; Fri,  4 Dec 2020 17:40:08 +0100 (CET)
Date: Fri, 4 Dec 2020 17:40:08 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
Subject: Re: [cip-dev] cip/linux-4.4.y-cip usb: 4 runs, 2 regressions (v4.4.243-cip51-21-g1d9a9094c010)
Message-ID: <20201204164008.GB1781@duo.ucw.cz>
References: <5fc87876.1c69fb81.a7e0a.0844@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <5fc87876.1c69fb81.a7e0a.0844@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ghV9eyDiPEnMhnPGcQnt93Cqx4520388AA=
Content-Type: multipart/mixed; boundary="R9jHwTqeLR37MXLJZLS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607100012;
 bh=KW8gYpUbcEK8EUd42szLGZcsz9CXs/tQx6fWicGl4bQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JDHrzQcQXJnSwXnMfAJKwXSnCZu08QZ91GE1w9P2aXH5nuWFfbRS5UV4RLx7kbt69m8
 q89s4aVjjZn9mLHcpvuWhvcqwN0mXOhfuzs6wj/ihgRA6Dkl1LK+/nOXMLjeS0x7EoMpg
 2uo6w0d0KGa3HLpAST0gg8qgTbNDeiVcQyg=

--R9jHwTqeLR37MXLJZLS4
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline

--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, bot. Can you speak english?


> cip/linux-4.4.y-cip usb: 4 runs, 2 regressions (v4.4.243-cip51-21-g1d9a90=
94c010)
>=20
>=20
>   * usb.compare-freeze: https://kernelci.org/test/case/id/5fc871ebf573faf=
8a4c94cca
>         new failure (last pass: v4.4.243-cip51-10-gd7466739b72e9)
>=20
>     2020-12-03 05:04:20.932000+00:00  + /usr/sbin/rtcwake -d rtc0 -m free=
ze -s 1
>     2020-12-03 05:04:20.932000+00:00  rtcwake: assuming RTC uses UTC ...
>     2020-12-03 05:04:20.937000+00:00  rtcwake: wakeup from \"freeze\" usi=
ng rtc0 at Thu Dec  3 05:04:23 2020
>     2020-12-03 05:04:20.954000+00:00  [   18.787404] PM: Syncing filesyst=
ems ... done.
>     2020-12-03 05:04:20.967000+00:00  [   18.792542] Freezing user space =
processes ... (elapsed 0.001 seconds) done.
>     2020-12-03 05:04:20.968000+00:00  [   18.800704] Freezing remaining f=
reezable tasks ... (elapsed 0.001 seconds) done.
>     2020-12-03 05:04:20.972000+00:00  [   18.809224] Suspending console(s=
) (use no_console_suspend to debug)
>     2020-12-03 05:04:23.674000+00:00  [   18.865290] hub 3-1:1.0: activat=
e --> -113
>     2020-12-03 05:04:23.675000+00:00  [   18.867538] PM: suspend of devic=
es complete after 51.550 msecs
>     2020-12-03 05:04:23.685000+00:00  [   18.868293] PM: late suspend of =
devices complete after 0.750 msecs=20
>     ... (66 line(s) more)


I'm not sure where you see failure here, plus I find it hard to
believe that we have broken anything between
v4.4.243-cip51-10-gd7466739b72e9 and v4.4.243-cip51-21-g1d9a9094c010.

Can you elaborate what is wrong, and maybe re-run tests with
v4.4.243-cip51-10-gd7466739b72e9 to see if this is maybe some kind of
random failure?

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX8pmaAAKCRAw5/Bqldv6
8lYRAJ96XehRFask6U0XT8LBkiXEz5ymiQCgjf/9fK3XiGXI77jYdGQsDjtY1So=
=OzZk
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--R9jHwTqeLR37MXLJZLS4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5943): https://lists.cip-project.org/g/cip-dev/message=
/5943
Mute This Topic: https://lists.cip-project.org/mt/78682105/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--R9jHwTqeLR37MXLJZLS4--
