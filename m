From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 14:18:55 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 08/12] phy: renesas:
 rcar-gen3-usb2: follow the hardware manual procedure
In-Reply-To: <1563199312-18842-9-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
	<1563199312-18842-9-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190716121854.GH24157@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> commit 72c0339c115b31b3c0b22b1809854136cadd49be upstream.
> 
> This patch modifies rcar_gen3_init_otg() procedure to follow Figure
> 73.4 of "R-Car Series, 3rd Generation User's Manual: Hardware Rev.1.00".
> 

> @@ -310,16 +310,21 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
>  	void __iomem *usb2_base = ch->base;
>  	u32 val;
>  
> +	/* Should not use functions of read-modify-write a register */
> +	val = readl(usb2_base + USB2_LINECTRL1);
> +	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
> +	      USB2_LINECTRL1_DMRPD_EN | USB2_LINECTRL1_DM_RPD;
> +	writel(val, usb2_base + USB2_LINECTRL1);
> +

I don't understand the comment here. Actually having function to
set/clear bits in arbitrary register might be a nice cleanup.

While reviewing that I noticed:

static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
...
        val = readl(usb2_base + USB2_LINECTRL1);
	rcar_gen3_set_linectrl(ch, 0, 0);
 	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
 		usb2_base + USB2_LINECTRL1);


AFAICT it modifies the register only to undo those chanes
immediately. Is it intentional? Is it worth a comment? Can the block
be replaced with

static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
...
	rcar_gen3_set_linectrl(ch, 0, 0);
	rcar_gen3_set_linectrl(ch, 1, 1);

?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/39db3e09/attachment.sig>
