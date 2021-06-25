Return-Path: <SRS0=7Z0j=LT=lists.cip-project.org=bounce+64572+6579+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D5BC48BC2
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 10:24:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042F061439
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 10:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042F061439
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6579+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jCboYY4521723xVE0C51AqS1; Fri, 25 Jun 2021 03:24:39 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.5609.1624616678253196410
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Jun 2021 03:24:39 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6C6E31C0B76; Fri, 25 Jun 2021 12:24:35 +0200 (CEST)
Date: Fri, 25 Jun 2021 12:24:35 +0200
From: "Pavel Machek" <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.195-cip52-rt20
Message-ID: <20210625102435.GA19226@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6kEIFSHAJ68KPN9PClZymuDGx4520388AA=
Content-Type: multipart/mixed; boundary="gfHtFtHolYgXbnjNjUe2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624616679;
 bh=lyNg2+984mosFZDwWu1Du4it7qY/fDyV1/J60dFxfAA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YYaAaP2weNBH1jJYc7vBDARAI0BZyJ9OT2D1ZYFtw7R43hu+lnYxWA8Ce+gz+xhu2Mn
 LcOEB3MI+ZfUsc1maiGPywhhYwHS/j/7dKm1yxQIzaNaJmfwKLvBYvaWaFn4vhzQ4fpqP
 wP35Sv6/xrJXajLbrggPIjySi2DFnVW1NPo=

--gfHtFtHolYgXbnjNjUe2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYNWu4wAKCRAw5/Bqldv6
8q6iAKCu5Nf6fwDgMkDuWjKSrLzCkxlluACeKVZZfw/22XC/G4Rxtml4YZ9JBxU=
=CZa9
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

--gfHtFtHolYgXbnjNjUe2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6579): https://lists.cip-project.org/g/cip-dev/message=
/6579
Mute This Topic: https://lists.cip-project.org/mt/83781138/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gfHtFtHolYgXbnjNjUe2--
