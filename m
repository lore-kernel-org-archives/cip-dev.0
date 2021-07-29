Return-Path: <SRS0=7vwq=MV=lists.cip-project.org=bounce+64572+6639+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CEFC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 07:47:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADA060F6F
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 07:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7ADA060F6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dHNvYY4521723xgJDJumAlVS; Thu, 29 Jul 2021 00:47:11 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.6679.1627544830205740417
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jul 2021 00:47:11 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B1B271C0B7C; Thu, 29 Jul 2021 09:47:04 +0200 (CEST)
Date: Thu, 29 Jul 2021 09:47:03 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20210729074703.GA14232@amd>
References: <CAODzB9o8xwbKB7i1vDfQx0SSZa84+nPh+9kZDKj7LRvpO9R0mg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9o8xwbKB7i1vDfQx0SSZa84+nPh+9kZDKj7LRvpO9R0mg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4c12OiKFnMpWO4tuhkzYSTfnx4520388AA=
Content-Type: multipart/mixed; boundary="TzemTDvlhjxv2Ha452QQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627544831;
 bh=PSouRqT9ceLEso7RkhqhaEKO1nywVVydRUh06w5ObFM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=mAXsTiEWSPAKv3x3G6MQOubG88am78VmsjrQbSn3BGJhz5yTlzTdbCmEPMN816xMVNW
 AGEf6OArp224UuHYchn413vcvixS24AzSwc3G5YE1sfN9P2KgJ6Y2leFgArvE7jb95cjG
 4p4QY+EYb5RIyl0k2KJfGkSL9XAovuYxaiA=

--TzemTDvlhjxv2Ha452QQ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> ** Traking CVEs
>=20
> CVE-2021-21781: v4.4 is not fixed as of 2021/07/29

This is basically missing memset. Does not look evil to backport.

> CVE-2021-3655: v4.4 is not fixed as of 2021/07/29

This may need more careful look. There are 4 patches fixing this in
mainline, but only two in
5.10. c7da1d1ed43a6c2bece0d287e2415adf2868697e should be easy to
backport to 4.4.

> CVE-2021-31829: Linux kernel protection of stack pointer against
> speculative pointer arithmetic can be bypassed to leak content of
> kernel memory
>=20
> Fixed status
> mainline: [f8be156be163a052a067306417cd0ff679068c97]
> stable/4.19: [117777467bc015f0dc5fc079eeba0fa80c965149]

Strange, this talks about CVE-2021-22543 in the changelog.

> CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
> Bluetooth Core Specifications 4.0 through 5.2
>=20
> Not fiexd in mainline yet

> CVE-2021-3655: missing size validations on inbound SCTP packets
>=20
> According to cip-kernel-sec's scripts v4.4 is not fixed as of 2021/07/29
>=20
> One of a patch 50619dbf8db77e98d821d615af4f634d08e22698 is included.
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/n=
et/sctp?h=3Dlinux-4.4.y&id=3D48cd035cad5b5fad0648aa8294c4223bedb166dd

I guess this should be listed in stable/4.4: ... then?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmECXPcACgkQMOfwapXb+vLnfQCeMkaetR8EG1HuOGa5Wok6K6sd
IpUAmwcaxsHIMUNNvfLVfK+ns/+nlkiw
=sf6k
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--TzemTDvlhjxv2Ha452QQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6639): https://lists.cip-project.org/g/cip-dev/message=
/6639
Mute This Topic: https://lists.cip-project.org/mt/84519830/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TzemTDvlhjxv2Ha452QQ--
