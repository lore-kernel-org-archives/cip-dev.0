Return-Path: <SRS0=pmxo=AB=lists.cip-project.org=bounce+64572+4805+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E6EC433DF
	for <cip-dev@archiver.kernel.org>; Sat, 20 Jun 2020 13:11:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F3A22282
	for <cip-dev@archiver.kernel.org>; Sat, 20 Jun 2020 13:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NKdf5szl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F3A22282
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4805+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nkQ5YY4521723xESPvZN5FFx; Sat, 20 Jun 2020 06:11:04 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.10464.1592658661926717568
 for <cip-dev@lists.cip-project.org>;
 Sat, 20 Jun 2020 06:11:02 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8298D1C0C15; Sat, 20 Jun 2020 15:10:57 +0200 (CEST)
Date: Sat, 20 Jun 2020 15:10:57 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] staging drivers in use by defconfigs (moxa_eds and others)
Message-ID: <20200620131057.GA31680@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Q8hijwnDUqorsCbPIjmuEAgCx4520388AA=
Content-Type: multipart/mixed; boundary="IqIRuA5rrref4SgyKKLJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592658664;
 bh=gKBNoiOV7nkQwPdeBoNMvRgT6iXNQ3GnI3YHoC8//TM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NKdf5szlvVMMFboRnIhZZcQj0AOg7NNjzylwI4mE74B62/OI56/ulUNRjfDi1z7gufa
 FKCp4W0s3oJTdaCIzekPIjAZt1SgBRcmLi4DT1XngDiMPv6ph4S0mQ+MDRZY3KID9wkg4
 dZGNG+iTnbnrs3fGqZbfVct2beRqyNMZX+U=

--IqIRuA5rrref4SgyKKLJ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I noticed that android drivers in staging are enabled by moxa_eds:

CONFIG_ION=3Dy
CONFIG_ION_SYSTEM_HEAP=3Dy
CONFIG_ION_CARVEOUT_HEAP=3Dy
CONFIG_ION_CHUNK_HEAP=3Dy
CONFIG_ION_CMA_HEAP=3Dy

I normally don't review staging changes, and they are deemed by
community not to be ready for serious usage.

Is someone using them in production? If not, could we disable them in defco=
nfigs?

=2E/4.4.y-cip/arm/toshiba_tegra_defconfig:CONFIG_STAGING=3Dy
=2E/4.4.y-cip/arm/siemens_imx6_defconfig:CONFIG_STAGING=3Dy
=2E/4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_STAGING=3Dy
=2E/4.4.y-cip/x86/siemens_iot2000.config:CONFIG_STAGING=3Dy
=2E/4.19.y-cip/arm/renesas_shmobile_defconfig:CONFIG_STAGING=3Dy
=2E/4.19.y-cip/arm/siemens_imx6.config:CONFIG_STAGING=3Dy
=2E/4.19.y-cip/arm64/moxa_eds_defconfig:CONFIG_STAGING=3Dy
=2E/4.19.y-cip/x86/siemens_ipc227e_defconfig:CONFIG_STAGING=3Dy
=2E/4.19.y-cip/x86/plathome_obsvx2.config:CONFIG_STAGING=3Dy
=2E/4.19.y-cip-rt/arm/renesas_shmobile-rt_defconfig:CONFIG_STAGING=3Dy
=2E/4.19.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_STAGING=3Dy

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXu4K4QAKCRAw5/Bqldv6
8iczAJ9z+yZA59QjSTuyDe43PF67VcdY1ACfXMM7aVSKz4dFNFNWpqzZDcjI66E=
=RKG9
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--IqIRuA5rrref4SgyKKLJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4805): https://lists.cip-project.org/g/cip-dev/message=
/4805
Mute This Topic: https://lists.cip-project.org/mt/75001103/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--IqIRuA5rrref4SgyKKLJ--
