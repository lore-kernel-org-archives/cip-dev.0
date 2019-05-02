From: pavel@denx.de (Pavel Machek)
Date: Thu, 2 May 2019 23:29:44 +0200
Subject: [cip-dev] [PATCH 4.19.y 13/29] media: rcar-csi2: Add support
 for RZ/G2E
In-Reply-To: <1556706143-11898-14-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1556706143-11898-14-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190502212944.GC19728@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed 2019-05-01 11:22:07, Fabrizio Castro wrote:
> commit 8809b8ceb0bd283c0528a0c7233656b12bcda2dc upstream.
> 
> According to the RZ/G2 User's manual, RZ/G2E and R-Car E3 CSI-2
> blocks are identical, therefore use R-Car E3 definitions to add
> RZ/G2E support.

> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index d409ba3..007e238 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -975,6 +975,10 @@ static const struct rcar_csi2_info rcar_csi2_info_r8a77990 = {
>  
>  static const struct of_device_id rcar_csi2_of_table[] = {
>  	{
> +		.compatible = "renesas,r8a774c0-csi2",
> +		.data = &rcar_csi2_info_r8a77990,
> +	},
> +	{
>  		.compatible = "renesas,r8a7795-csi2",
>  		.data = &rcar_csi2_info_r8a7795,
>  	},

Would common compatible "renesas,something...-generation2-csi2" make sense?
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190502/beba057d/attachment-0001.sig>
