From: pavel@denx.de (Pavel Machek)
Date: Mon, 13 May 2019 21:44:42 +0200
Subject: [cip-dev] [PATCH 4.4.y 18/52] gpiolib: Extract mask allocation
 into subroutine
In-Reply-To: <1557761837-24993-19-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-19-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190513194442.GE27497@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon 2019-05-13 16:36:43, Fabrizio Castro wrote:
> From: Stephen Boyd <swboyd@chromium.org>
> 
> commit e4371f6e079294369ecb4cfa03aaeb60831e8b91 upstream.
> 
> We're going to use similar code to allocate and set all the bits in a
> mask for valid gpios to use. Extract the code from the irqchip version
> so it can be reused.
...
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -279,6 +279,20 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
>  	return 0;
>  }
>  
> +static unsigned long *gpiochip_allocate_mask(struct gpio_chip *chip)
> +{
> +	unsigned long *p;
> +
> +	p = kcalloc(BITS_TO_LONGS(chip->ngpio), sizeof(long), GFP_KERNEL);
> +	if (!p)
> +		return NULL;
> +
> +	/* Assume by default all GPIOs are valid */
> +	bitmap_fill(p, chip->ngpio);
> +
> +	return p;
> +}

I'd do

    if (p)
         bitmap_fill();

    return p;

But it is not that important.
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190513/a4e893b5/attachment.sig>
