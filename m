Return-Path: <SRS0=IdK/=FI=lists.cip-project.org=bounce+64572+5942+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CBDC4361A
	for <cip-dev@archiver.kernel.org>; Fri,  4 Dec 2020 16:36:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C09229C4
	for <cip-dev@archiver.kernel.org>; Fri,  4 Dec 2020 16:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C09229C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5942+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nPf1YY4521723xVINRVe1NHG; Fri, 04 Dec 2020 08:36:13 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.16941.1607099772201918551
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Dec 2020 08:36:12 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A22D41C0B8D; Fri,  4 Dec 2020 17:36:06 +0100 (CET)
Date: Fri, 4 Dec 2020 17:36:06 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
Subject: Re: [cip-dev] cip/linux-4.4.y-cip baseline: 117 runs, 15 regressions (v4.4.243-cip51-21-g1d9a9094c010)
Message-ID: <20201204163606.GA1781@duo.ucw.cz>
References: <5fc8716c.1c69fb81.84407.0412@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <5fc8716c.1c69fb81.84407.0412@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: q76aCB32i8hqBBdAj8aW55d9x4520388AA=
Content-Type: multipart/mixed; boundary="6h0cfI15C0B82xofWJvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607099773;
 bh=guYb1tXg9ZACn+hG+AcnSWVGbpYMAVxsrBFFnTV9zb8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MYjar6nmcJVK/0oKN8CbLZJ/zbMzV8qDFghReHBmfORWwEvOeDiyNcMdF14X0JA5n7a
 Br6Mh59I5uhUKfKlZJPR9dMAHfJwch338B5M7LCE24xPsu2XhUdj4As9J2oHqYMzq/OQA
 U7zzONrs6H0QBn0xJB09HZhRzVyFGYTLRXw=

--6h0cfI15C0B82xofWJvu
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Hello, bot. Which human is your master?

> platform            | arch | lab           | compiler | defconfig        =
            | regressions
> --------------------+------+---------------+----------+------------------=
------------+------------
> qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfi=
g           | 1         =20
>=20
>   Details:     https://kernelci.org/test/plan/id/5fc8690820b4b4e275c94d76
>=20
>   Results:     0 PASS, 1 FAIL, 0 SKIP
>   Full config: multi_v7_defconfig


>   HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243=
-cip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-=
qemu_arm-virt-gicv2.html

Something indeed goes wrong there, but it does not look like kernel
failure:

04:25:41.680063  / # mount /dev/disk/by-uuid/1d696e5c-20bb-44a2-9bc5-bed2a2=
143e32 -t ext2 /lava-443880
04:25:41.680696  mount /dev/disk/by-uuid/1d696e5c-20bb-44a2-9bc5-bed2a2143e=
32 -t ext2 /lava-4
04:25:41.681778  43880
04:25:41.764174  mount: mounting /dev/disk/by-uuid/1d696e5c-20bb-44a2-9bc5-=
bed2a2143e32 on /lava-443880 failed: No such file or directory
04:25:41.874957  / # ls -la /lava-443880/bin/lava-test-runner

This is marked as a regression, but I don't see ... was there
successful run? If so, which version?=20

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX8pldgAKCRAw5/Bqldv6
8vJaAJ9TlmZYCe3BZOcxE0sXLecXJd9CqgCfQGDmlbIH/fklxYDc8Qm6Wa41lqk=
=urhT
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--6h0cfI15C0B82xofWJvu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5942): https://lists.cip-project.org/g/cip-dev/message=
/5942
Mute This Topic: https://lists.cip-project.org/mt/78682104/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6h0cfI15C0B82xofWJvu--
