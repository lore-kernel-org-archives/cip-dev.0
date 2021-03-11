Return-Path: <SRS0=3uYm=IJ=lists.cip-project.org=bounce+64572+6276+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9640AC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 11 Mar 2021 12:42:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72FB64F90
	for <cip-dev@archiver.kernel.org>; Thu, 11 Mar 2021 12:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72FB64F90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6276+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Y5aMYY4521723xHSsMFLwLSS; Thu, 11 Mar 2021 04:42:54 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5478.1615466573268985534
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Mar 2021 04:42:53 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F23AA1C0B77; Thu, 11 Mar 2021 13:42:48 +0100 (CET)
Date: Thu, 11 Mar 2021 13:42:48 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] master branch at git.kernel.org/...cip
Message-ID: <20210311124248.GB32725@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HttDGVZVzOeXiuohinsdG5wix4520388AA=
Content-Type: multipart/mixed; boundary="jwwZ1dkgT1IlqdjaP7uf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615466574;
 bh=yKqOZeYAo90X2zeWMiAKpi8m7vmSYvDRYpNixwzAVGk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ige38/LuDKR6v8ghnGKSO7hLjFaFgsry/SunH8YtCLM6znCA4/b0uTnVvV4tDzYOf/3
 KuF27gri3TME9rPoBi0Dm7EuzsOueqvb6KfbMOk1Brqke9OOahw6+YHQPXPfM2xo5dn/G
 SJvJwO2+Qn2S99nCBs41KUsSjXFHWtRYmjQ=

--jwwZ1dkgT1IlqdjaP7uf
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline

--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Chris pointed out our master branch at git.kernel.org is rather old:

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/refs/heads

master	CIP: Bump version suffix to -cip28 after Renesas patches Ben Hutchin=
gs	  2 years


Master branch is really not too applicable for our workflow. Yes, 2
years old version of 4.4 looks out of place.

I see these options:

1) leave it alone. (+) It is quite obvious development is not
happening there (-) It looks strange.

2) delete it. (-) I'm not sure that is possible or what problems it
might cause.

3) update it to Linus' 5.12-rc1 and keep it updated. (-) Extra work to
keep it updated, (-) we don't really do anything with mainline commits
newer than 5.10

4) update it to Linus' 5.10, and only touch it when the linux-5.21-cip
is branched out.

Any other ideas?

My preference would be (1) and (4).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBKEEgACgkQMOfwapXb+vIRvgCfSE9ZWCFP8ZOml2i1Ps3S09WF
BpwAoIDhIsIipSMAo2zLKz1L4iPppRHw
=mj0+
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--

--jwwZ1dkgT1IlqdjaP7uf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6276): https://lists.cip-project.org/g/cip-dev/message=
/6276
Mute This Topic: https://lists.cip-project.org/mt/81251519/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jwwZ1dkgT1IlqdjaP7uf--
