Return-Path: <SRS0=UgRP=EZ=lists.cip-project.org=bounce+64572+5811+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007FC2D0E4
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 08:35:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51AB24248
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 08:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UgHEEehx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51AB24248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5811+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Dd34YY4521723xBvIEAgGHzT; Thu, 19 Nov 2020 00:35:55 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.6393.1605774954185305220
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2020 00:35:55 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D98CF1C0B87; Thu, 19 Nov 2020 09:35:48 +0100 (CET)
Date: Thu, 19 Nov 2020 09:35:48 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Joining CIP from Codethink
Message-ID: <20201119083547.GB29401@amd>
References: <9bd054d9-3b0e-d339-2d3f-7471ebc5421d@codethink.co.uk>
MIME-Version: 1.0
In-Reply-To: <9bd054d9-3b0e-d339-2d3f-7471ebc5421d@codethink.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hB40iWXOF9kwUJ4PJgBmHGfox4520388AA=
Content-Type: multipart/mixed; boundary="QWCtxfles3nJITpbxmm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605774955;
 bh=foAOwwiz4IWtGEHkdB5myq6RjRemwnRsaT7qpCihmrI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=UgHEEehx8pg0mNrw8XGIWaS3Yi3YlO6ktJClhXFsGSzwtHQZaWVOc0gOBcfe5imduPr
 UOKgsKcsz7XLgsQB9dWPBy3ltAGuiq5NklCMwUnvhNPbVOJ6Gf1mxL6rVaAzHwRS8Fj+M
 nKe1RENFn1tG7gVxlQV99Bni/h1I6P8U7u0=

--QWCtxfles3nJITpbxmm0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I am starting with CIP and will be trying to do what Ben used to do.
> Though many of my colleagues and ex-colleagues have worked with CIP,
> this will be my first time directly working with CIP and excited with
> the chance to contribute to the super-long-term Linux Kernel.

Welcome, and have fun :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+2LmMACgkQMOfwapXb+vK4ZACfbPe06PPGPYKvQBCUG42Kal6T
KkcAn0DjuUP7Lze6WeQSaze06hklO3YQ
=fk/h
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

--QWCtxfles3nJITpbxmm0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5811): https://lists.cip-project.org/g/cip-dev/message=
/5811
Mute This Topic: https://lists.cip-project.org/mt/78291887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QWCtxfles3nJITpbxmm0--
