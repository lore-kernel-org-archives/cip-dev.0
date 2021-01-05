Return-Path: <SRS0=349Z=GI=lists.cip-project.org=bounce+64572+6035+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34823C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:58:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B082A22CB9
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 16:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B082A22CB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6035+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id L8qCYY4521723xT6E7mV5AhQ; Tue, 05 Jan 2021 08:58:47 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.86.1609865926522334023
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 08:58:46 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E6BB41C0B77; Tue,  5 Jan 2021 17:58:41 +0100 (CET)
Date: Tue, 5 Jan 2021 17:58:41 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v3 4.19.y-cip 16/17] spi: add Renesas RPC-IF driver
Message-ID: <20210105165841.GE361@amd>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210105135757.11069-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210105135757.11069-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 35U3ImT9jE9Zxf6YlDJ14t47x4520388AA=
Content-Type: multipart/mixed; boundary="NZEoZ7T22giyWMEb3m3z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609865927;
 bh=gUJtLJ1LXJHtrkd3bL+8QmamBbqw9WKcsFMxSsMU6qo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vCZFQl5FjBFRyJ3CbM9yfLrrB1BRUtra4Z2qUat76ShjPh/luEwXpAa9K/V57ChwUP4
 iS22L6VcQmZiVRYAeGjAshAuB9bImPpoFeIabUSq+1CYWaLmAIxD5cBg/jn55WeNBss9o
 t3h0vF/78USis0UKroF9TjVyJQxOGLjAxlE=

--NZEoZ7T22giyWMEb3m3z
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline

--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +
> +#ifdef CONFIG_PM_SLEEP
> +static int rpcif_spi_suspend(struct device *dev)
> +{
> +	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> +
> +	return spi_controller_suspend(ctlr);
> +}
> +
> +static int rpcif_spi_resume(struct device *dev)
> +{
> +	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> +
> +	return spi_controller_resume(ctlr);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_=
resume);
> +#define DEV_PM_OPS	(&rpcif_spi_pm_ops)
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif
> +
> +static struct platform_driver rpcif_spi_driver =3D {
> +	.probe	=3D rpcif_spi_probe,
> +	.remove	=3D rpcif_spi_remove,
> +	.driver =3D {
> +		.name	=3D "rpc-if-spi",
> +		.pm	=3D DEV_PM_OPS,
> +	},
> +};

#ifdefs here could be reduced...

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/0msEACgkQMOfwapXb+vJe9ACfYm6NvJMvlVNy3af4e/JhK2aa
FTsAn0WmNAizJqDkzlr9JtXtt6xix3J4
=YVbB
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--

--NZEoZ7T22giyWMEb3m3z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6035): https://lists.cip-project.org/g/cip-dev/message=
/6035
Mute This Topic: https://lists.cip-project.org/mt/79450083/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NZEoZ7T22giyWMEb3m3z--
