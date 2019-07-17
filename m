From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 17 Jul 2019 07:47:28 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/10] rtc: pcf85363: set time
 accurately
In-Reply-To: <20190716210350.GB14181@amd>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
	<1563264921-42973-4-git-send-email-biju.das@bp.renesas.com>
	<20190716210350.GB14181@amd>
Message-ID: <OSBPR01MB2103D4ED93C66F6DB47539B8B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, July 16, 2019 10:04 PM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.4.y-cip 03/10] rtc: pcf85363: set time
> accurately
> 
> On Tue 2019-07-16 09:15:14, Biju Das wrote:
> > commit 188306ac9536ec47674ffa9dd330f69927679aeb upstream.
> >
> > As per 8.2.6 Setting and reading the time in RTC mode, first stop the
> > clok, then reset it before setting the date and time registers.
> > Finally, start the clock.
> >
> > This uses register address wrap around from 0x2f to 0x00 for
> > efficiency.
>
> How does wrap around work? AFAICT it is supposed to have ram at 0x40.
> 
Please see the document [1]  and [2] section 8, that have the details related to wrap around.
[1] https://www.nxp.com/docs/en/data-sheet/PCF85363A.pdf
[2] https://www.nxp.com/docs/en/data-sheet/PCF85263A.pdf

Regards,
Biju

> Does it really provide increased efficiency (given regmap layer in
> between) and will such trick cause problems in future? If regmap is not
> aware of register mirrors it might get confused and provide stale values, for
> example...
> 
> Best regards,
> 								Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
