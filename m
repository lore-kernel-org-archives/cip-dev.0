From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 3 May 2019 10:25:54 +0000
Subject: [cip-dev] [PATCH 4.19.y 29/29] arm64: defconfig: Enable R-Car
 thermal driver
In-Reply-To: <20190502213416.GE19728@amd>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1556706143-11898-30-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190502213416.GE19728@amd>
Message-ID: <TY1PR01MB1770188328B2F66831C3B151C0350@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thank you for your feedback!

> From: Pavel Machek <pavel@denx.de>
> Sent: 02 May 2019 22:34
> Subject: Re: [cip-dev] [PATCH 4.19.y 29/29] arm64: defconfig: Enable R-Car thermal driver
> 
> Hi!
> 
> > commit 4aac2bf0760d359af44e423dc01e10880d9d18b0 upstream.
> >
> > Enable the R-Car thermal driver as a built-in.
> > This seems safer than enabling as a module from the point of view of
> > protecting equipment from overheating.
> 
> No objections here, but...
> 
> ...make sure your hardware can protect itself when kernel fails for
> whatever reason. Yes, crashes from time to time, and then thermal
> support will fail, too.
> 

My understanding is that the unit is programmed to always output from
pins VTHSENSE and VTHREF (as in like the THIDLE bits are always 00),
therefore it's down to the PCB design to pick this up properly. A kernel
crash will prevent a graceful shutdown.

Biju, you had a deeper look into this a while back, is my understanding correct?

Thanks,
Fab

> Thanks,
> 									Pavel
> 
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
