Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC746D2D8FD
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 11:05:58 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8078.1769511954430630780
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 03:05:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=JYDujOW1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6425C10E9DA;
	Tue, 27 Jan 2026 12:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769511952;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wvFUf9VU+gU/fUExZ8AdUp4O+W5GBx+7/pu0bs5RvBY=;
	b=JYDujOW1MWtvcFfFVWewPNxNd4F38ZQvAanpetrI3XpD5TaVgP6lzSBQTtuDF0uhfpMh0B
	/PFuI19QaNYPRQwyFq3fK7Lp1JxsQOgDp46gSgHSq4CEqJ7p6S1cACcZ0RbcWw/yR1TQx2
	QZ1+nY/DpHjxnsgKcN0VXpgNjlMVkfGpzaI6Ae6z0FxxATI3JWpKxZpWh625jYKDr9hFQH
	g4O+A0Q185J97M1SOVQd6/Ax2Et169R514ZYr+Z/o9S8Ynzt1JcZx51hz4k78GiMZfS+QU
	Kw//0dEo6L9BURq78jQMa0NSOVnTBE5A2XcER6L01CHT8Zmpk1+kzQCzkIriOA==
Date: Tue, 27 Jan 2026 12:05:46 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com, chris.paterson2@renesas.com, vigneshr@ti.com
Subject: Re: [PATCH 6.12.y-cip] dmaengine: ti: k3-udma: Enable second
 resource range for BCDMA and PKTDMA
Message-ID: <aXicChQlaiaAq7w3@duo.ucw.cz>
References: <20260127075639.1259440-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rsSXh/vV4+E1Nkx5"
Content-Disposition: inline
In-Reply-To: <20260127075639.1259440-1-s-adivi@ti.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 11:05:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21722


--rsSXh/vV4+E1Nkx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Patch looks good, even if I'd like less code duplication.

But patch can't be applied as is: it is missing "upstream commit xxx"
marking at [1] and your sign-off at [2].

Plus, -stable might be better place for this patch. We currently don't
have am62p specific patches in the tree, so this affects 6.12-stable,
too, and should be fixed there AFAICT.

Best regards,
								Pavel

> From: Siddharth Vadapalli <s-vadapalli@ti.com>

[1]

> The SoC DMA resources for UDMA, BCDMA and PKTDMA can be described via a
> combination of up to two resource ranges. The first resource range handles
> the default partitioning wherein all resources belonging to that range are
> allocated to a single entity and form a continuous range. For use-cases
> where the resources are shared across multiple entities and require to be
> described via discontinuous ranges, a second resource range is required.
>=20
> Currently, udma_setup_resources() supports handling resources that belong
> to the second range. Extend bcdma_setup_resources() and
> pktdma_setup_resources() to support the same.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Link: https://lore.kernel.org/r/20250205121805.316792-1-s-vadapalli@ti.com
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

[2]

> ---
>=20
> Hi,
>=20
> This patch is upstreamed at [1]. This is required for ethernet to be
> functional on TI AM62P SoC.
>=20
> Thanks,
> Kartheek
>=20
> [1] v6.14-rc1-24-g566beb347ede
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/dma/ti/k3-udma.c?id=3D566beb347eded7a860511164a7a163bc882dc4d0
>=20
>  drivers/dma/ti/k3-udma.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 38b54719587c..e877cd50898b 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4876,6 +4876,12 @@ static int bcdma_setup_resources(struct udma_dev *=
ud)
>  				irq_res.desc[i].start =3D rm_res->desc[i].start +
>  							oes->bcdma_bchan_ring;
>  				irq_res.desc[i].num =3D rm_res->desc[i].num;
> +
> +				if (rm_res->desc[i].num_sec) {
> +					irq_res.desc[i].start_sec =3D rm_res->desc[i].start_sec +
> +									oes->bcdma_bchan_ring;
> +					irq_res.desc[i].num_sec =3D rm_res->desc[i].num_sec;
> +				}
>  			}
>  		}
>  	} else {
> @@ -4899,6 +4905,15 @@ static int bcdma_setup_resources(struct udma_dev *=
ud)
>  				irq_res.desc[i + 1].start =3D rm_res->desc[j].start +
>  							oes->bcdma_tchan_ring;
>  				irq_res.desc[i + 1].num =3D rm_res->desc[j].num;
> +
> +				if (rm_res->desc[j].num_sec) {
> +					irq_res.desc[i].start_sec =3D rm_res->desc[j].start_sec +
> +									oes->bcdma_tchan_data;
> +					irq_res.desc[i].num_sec =3D rm_res->desc[j].num_sec;
> +					irq_res.desc[i + 1].start_sec =3D rm_res->desc[j].start_sec +
> +									oes->bcdma_tchan_ring;
> +					irq_res.desc[i + 1].num_sec =3D rm_res->desc[j].num_sec;
> +				}
>  			}
>  		}
>  	}
> @@ -4919,6 +4934,15 @@ static int bcdma_setup_resources(struct udma_dev *=
ud)
>  				irq_res.desc[i + 1].start =3D rm_res->desc[j].start +
>  							oes->bcdma_rchan_ring;
>  				irq_res.desc[i + 1].num =3D rm_res->desc[j].num;
> +
> +				if (rm_res->desc[j].num_sec) {
> +					irq_res.desc[i].start_sec =3D rm_res->desc[j].start_sec +
> +									oes->bcdma_rchan_data;
> +					irq_res.desc[i].num_sec =3D rm_res->desc[j].num_sec;
> +					irq_res.desc[i + 1].start_sec =3D rm_res->desc[j].start_sec +
> +									oes->bcdma_rchan_ring;
> +					irq_res.desc[i + 1].num_sec =3D rm_res->desc[j].num_sec;
> +				}
>  			}
>  		}
>  	}
> @@ -5053,6 +5077,12 @@ static int pktdma_setup_resources(struct udma_dev =
*ud)
>  			irq_res.desc[i].start =3D rm_res->desc[i].start +
>  						oes->pktdma_tchan_flow;
>  			irq_res.desc[i].num =3D rm_res->desc[i].num;
> +
> +			if (rm_res->desc[i].num_sec) {
> +				irq_res.desc[i].start_sec =3D rm_res->desc[i].start_sec +
> +								oes->pktdma_tchan_flow;
> +				irq_res.desc[i].num_sec =3D rm_res->desc[i].num_sec;
> +			}
>  		}
>  	}
>  	rm_res =3D tisci_rm->rm_ranges[RM_RANGE_RFLOW];
> @@ -5064,6 +5094,12 @@ static int pktdma_setup_resources(struct udma_dev =
*ud)
>  			irq_res.desc[i].start =3D rm_res->desc[j].start +
>  						oes->pktdma_rchan_flow;
>  			irq_res.desc[i].num =3D rm_res->desc[j].num;
> +
> +			if (rm_res->desc[j].num_sec) {
> +				irq_res.desc[i].start_sec =3D rm_res->desc[j].start_sec +
> +								oes->pktdma_rchan_flow;
> +				irq_res.desc[i].num_sec =3D rm_res->desc[j].num_sec;
> +			}
>  		}
>  	}
>  	ret =3D ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);

--=20
In cooperation with Nabla.

--rsSXh/vV4+E1Nkx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXicCgAKCRAw5/Bqldv6
8pNkAKCXOpFv12+0DRENerxhBSwW6N5GTQCgqsk6Nc73ctANBngDl6KsbNV7VUs=
=zOgo
-----END PGP SIGNATURE-----

--rsSXh/vV4+E1Nkx5--

