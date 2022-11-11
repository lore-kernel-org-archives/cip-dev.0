Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E092C4332F
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 07:38:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3029.1668152312459689797
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 23:38:33 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3A2021C09F3; Fri, 11 Nov 2022 08:38:28 +0100 (CET)
Date: Fri, 11 Nov 2022 08:38:27 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <chris.paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 4.4.y-st] gitlab-ci: Add configuration for CIP's GitLab
 CI pipelines
Message-ID: <Y23783UalLmLHzbr@duo.ucw.cz>
References: <20221011144940.24071-1-chris.paterson2@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YNcBCLLSj+CFLNYc"
Content-Disposition: inline
In-Reply-To: <20221011144940.24071-1-chris.paterson2@renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Nov 2022 07:38:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10023


--YNcBCLLSj+CFLNYc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Actual pipelines are defined externally [0] to save on churn in the kernel
> tree.
>=20
> [0] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines

Thank you, applied to -st-rc tree.

Best regards,
									Pavel

> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .gitlab-ci.yml | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 .gitlab-ci.yml
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> new file mode 100644
> index 000000000000..ad0593601dbb
> --- /dev/null
> +++ b/.gitlab-ci.yml
> @@ -0,0 +1,3 @@
> +include:
> +  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/m=
aster/linux-cip-pipeline.yml
> +  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/m=
aster/trees/linux-4.4.y-st.yml

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YNcBCLLSj+CFLNYc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY2378wAKCRAw5/Bqldv6
8in2AJ9bHCFOoqjo02ygHBdnJHns0AxPQgCfTgZR1hnLv8e4DSIiY/AiiosXaOI=
=GLO9
-----END PGP SIGNATURE-----

--YNcBCLLSj+CFLNYc--

