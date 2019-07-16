From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 14:05:19 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 05/12] phy: renesas:
 rcar-gen3-usb2: add conditions for uses_otg_pins == false
In-Reply-To: <1563199312-18842-6-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
	<1563199312-18842-6-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190716120519.GG24157@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> @@ -212,6 +212,9 @@ static void rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
>  
>  static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
>  {
> +	if (!ch->uses_otg_pins)
> +		return (ch->dr_mode == USB_DR_MODE_HOST) ? false : true;

I'd write this as

    "return ch->dr_mode != USB_DR_MODE_HOST;"

I'll take the patch, anyway, but there's room for future cleanup.

Best regards,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/1f9fc841/attachment.sig>
