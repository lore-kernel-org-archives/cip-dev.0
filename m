Return-Path: <SRS0=FlQo=D6=lists.cip-project.org=bounce+64572+5666+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33869C388F9
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 19:40:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F7D2192A
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 19:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ffB7/LJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F7D2192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5666+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8aoAYY4521723xBydSgzgGCP; Fri, 23 Oct 2020 12:40:43 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1845.1603482042519380489
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 12:40:43 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F03C61C0B8F; Fri, 23 Oct 2020 21:40:39 +0200 (CEST)
Date: Fri, 23 Oct 2020 21:40:39 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] PCI: rcar: Move shareable code to a common file
Message-ID: <20201023194039.GB6002@duo.ucw.cz>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023165805.1910-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201023165805.1910-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: agpowZx2JzgjF4bZu2T7RJTSx4520388AA=
Content-Type: multipart/mixed; boundary="fxBBJ99LCSG5zfAAyRHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603482043;
 bh=TTurVufFwpXCa4FAtUOSKp/7aL5Ruy9Ffx9I8QRwSl0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ffB7/LJkAHanOpklwjkc4VyeQJskaUvr30KWdGYEW6FENkOxlBF/2lq5bazldurFD6R
 tbsYQXFJD7vlr8D7pUk/m+5MJWOeDbsbQ2JwISxlEYME7Sg41nB7v3JxaMhEPy63Vdjmc
 I7OL8fdNLOuQSm45YnXRNU+NK7qX4BF2SBY=

--fxBBJ99LCSG5zfAAyRHU
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline

--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Move shareable code to common file pcie-rcar.c and the #defines to
> pcie-rcar.h so that the common code can be reused with endpoint driver.
> There are no functional changes with this patch for the host controller
> driver.

I have merged the patches, but this should be cleaned up IMO...

> +int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
> +{
> +	unsigned int timeout =3D 10;
> +
> +	while (timeout--) {
> +		if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
> +			return 0;
> +
> +		msleep(5);
> +	}
> +
> +	return -ETIMEDOUT;

Kind of fun. We test the PHYRDY, not ready, so we wait (now phy
becomes ready).. and we time out.

What about

while (1) {
	if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
		return 0;
	timeout--;
 	if (!timeout)
		return -ETIMEDOUT;
	msleep(5);
}

?

> +int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
> +{
> +	unsigned int timeout =3D 10000;
> +
> +	while (timeout--) {
> +		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
> +			return 0;
> +
> +		udelay(5);
> +		cpu_relax();
> +	}
> +
> +	return -ETIMEDOUT;
> +}

This has same problem. Plus, I don't believe cpu_relax() is good idea
there. Relaxing CPU every 5usec will not change anything.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5MxtwAKCRAw5/Bqldv6
8oSqAKDB7aM59OqzXxtqT+kpdKx4aEeZiACfc6vWNuCQ8Z66iqUoNLMMi/9ix6A=
=kapQ
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

--fxBBJ99LCSG5zfAAyRHU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5666): https://lists.cip-project.org/g/cip-dev/message=
/5666
Mute This Topic: https://lists.cip-project.org/mt/77756293/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fxBBJ99LCSG5zfAAyRHU--
