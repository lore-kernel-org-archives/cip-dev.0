Return-Path: <SRS0=2jJO=E5=lists.cip-project.org=bounce+64572+5827+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F0C63697
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:37:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81ED206E3
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wDZMEOtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81ED206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5827+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LM2wYY4521723xPiuzHDJYNd; Mon, 23 Nov 2020 11:37:44 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.41107.1606160263684096564
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 11:37:44 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 52D001C0BA6; Mon, 23 Nov 2020 20:37:40 +0100 (CET)
Date: Mon, 23 Nov 2020 20:37:39 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/7] memory: add Renesas RPC-IF driver
Message-ID: <20201123193739.GA5619@amd>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201123120354.26413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: X5uLhwIBh8MLoLuUu6W4Ra9ox4520388AA=
Content-Type: multipart/mixed; boundary="b7uodgf2lhaBBJJ2CqzC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606160264;
 bh=rjcJmUNYNgsNSQ3VUgb0UE20sg9bF0wkPBnXpn7JxFg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wDZMEOtZQq64649ZpCfb6cMI2a3VqtMCuPIkX7zUEJEeQ45dhAgq9XTMUrjTOss9Pk6
 FSWVISJVm1X4+Q6NJzv95sanbgp2AFTmUtPoZT8UqTuZmB7brWl/XaXW2jdGCmVYbEInn
 MGlPkrLgQVmQgdpK66oWXVJsWEUaKAg1FkM=

--b7uodgf2lhaBBJJ2CqzC
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +EXPORT_SYMBOL(rpcif_sw_init);

EXPORT_SYMBOL_GPL?

> +void rpcif_enable_rpm(struct rpcif *rpc)
> +{
> +	pm_runtime_enable(rpc->dev);
> +}
> +EXPORT_SYMBOL(rpcif_enable_rpm);
> +
> +void rpcif_disable_rpm(struct rpcif *rpc)
> +{
> +	pm_runtime_put_sync(rpc->dev);
> +}
> +EXPORT_SYMBOL(rpcif_disable_rpm);

Should these go to header as static inlines?

> +static int wait_msg_xfer_end(struct rpcif *rpc)
> +{
> +	u32 sts;
> +
> +	return regmap_read_poll_timeout(rpc->regmap, RPCIF_CMNSR, sts,
> +					sts & RPCIF_CMNSR_TEND, 0,
> +					USEC_PER_SEC);
> +}

This can't be right. sts is used uninitialized here.

> +int rpcif_manual_xfer(struct rpcif *rpc)
> +{
> +	default:
> +		regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
> +		regmap_write(rpc->regmap, RPCIF_SMCR,
> +			     rpc->smcr | RPCIF_SMCR_SPIE);
> +		ret =3D wait_msg_xfer_end(rpc);
> +		if (ret)
> +			goto err_out;
> +	}
> +
> +exit:
> +	pm_runtime_put(rpc->dev);
> +	return ret;
> +
> +err_out:
> +	ret =3D reset_control_reset(rpc->rstc);
> +	rpcif_hw_init(rpc, rpc->bus_size =3D=3D 2);
> +	goto exit;
> +}

So we get failure in wait_msg_xfer_end(rpc); but then
reset_control_reset(rpc->rstc); returns success and whole function
returns success. Is that ok?

> +static int rpcif_probe(struct platform_device *pdev)
> +{
> +	struct platform_device *vdev;
> +	struct device_node *flash;
> +	const char *name;
> +
> +	flash =3D of_get_next_child(pdev->dev.of_node, NULL);
> +	if (!flash) {
> +		dev_warn(&pdev->dev, "no flash node found\n");
> +		return -ENODEV;
> +	}

Does this need corresponding of_node_put()?

> +struct	rpcif_op {

Weird formatting; we normally use spaces (not tabs) for this.

> +	struct {
> +		u8 buswidth;
=2E..
> +	struct {
> +		u8 ncycles;
> +		u8 buswidth;
> +	} dummy;

Are you sure this will be consistent accross architectures? Should the
structure be marked attribute packed or something?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+8D4MACgkQMOfwapXb+vKhrQCgjYvW5JkjKwcdbh1xQhKJ734I
qaAAn2sYOQYUZJgxA1d7abUQXSZm4FTA
=j+Lu
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--b7uodgf2lhaBBJJ2CqzC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5827): https://lists.cip-project.org/g/cip-dev/message=
/5827
Mute This Topic: https://lists.cip-project.org/mt/78451541/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--b7uodgf2lhaBBJJ2CqzC--
