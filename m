From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 14 May 2019 09:25:59 +0000
Subject: [cip-dev] [PATCH 4.4.y 18/52] gpiolib: Extract mask allocation
 into subroutine
In-Reply-To: <20190513194442.GE27497@amd>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-19-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190513194442.GE27497@amd>
Message-ID: <TY1PR01MB1770FC21C203435B3973A915C0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thank you for your feedback!

> From: Pavel Machek <pavel@denx.de>
> Sent: 13 May 2019 20:45
> Subject: Re: [cip-dev] [PATCH 4.4.y 18/52] gpiolib: Extract mask allocation into subroutine
> 
> On Mon 2019-05-13 16:36:43, Fabrizio Castro wrote:
> > From: Stephen Boyd <swboyd@chromium.org>
> >
> > commit e4371f6e079294369ecb4cfa03aaeb60831e8b91 upstream.
> >
> > We're going to use similar code to allocate and set all the bits in a
> > mask for valid gpios to use. Extract the code from the irqchip version
> > so it can be reused.
> ...
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -279,6 +279,20 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
> >  	return 0;
> >  }
> >
> > +static unsigned long *gpiochip_allocate_mask(struct gpio_chip *chip)
> > +{
> > +	unsigned long *p;
> > +
> > +	p = kcalloc(BITS_TO_LONGS(chip->ngpio), sizeof(long), GFP_KERNEL);
> > +	if (!p)
> > +		return NULL;
> > +
> > +	/* Assume by default all GPIOs are valid */
> > +	bitmap_fill(p, chip->ngpio);
> > +
> > +	return p;
> > +}
> 
> I'd do
> 
>     if (p)
>          bitmap_fill();
> 
>     return p;
> 
> But it is not that important.

I could send an additional patch for this if you'd like?
Just let me know.

Thanks,
Fab

> 									Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
