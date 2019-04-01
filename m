From: christian.storm@siemens.com (Christian Storm)
Date: Mon, 1 Apr 2019 08:48:58 +0200
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <TYAPR01MB24950C688973FA3F22D72E67D9550@TYAPR01MB2495.jpnprd01.prod.outlook.com>
Message-ID: <20190401064858.ioieooa6yksfc75p@MD1ZFJVC.ad001.siemens.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Suzuki,

> > Ah, OK. This is the "official" in the sense of exemplary implemented way
> > how to do round-robin A/B firmware update. That said, this is in my very
> > personal opinion a bit too involved and spread out over too many places.
> > That was also one reason I brought forward the Lua handler feature that
> > allows you to implement a handler in Lua. Lua handlers are feature-wise
> > on par with C handlers by now, i.e., they are equally powerful. So, you
> > can write a Lua handler that does the target partition round-robin
> > calculation, flashing, and updating of the bootloader environment in one
> > place. The sw-description becomes simpler as well since you don't need
> > to specify the A/B layout there but instead the Lua handler will take
> > care of this.
> That makes sense.
> I thought that the A/B update way adopted by meta-swupdate-boards was
> a little difficult to understand and not very flexible.
> I would like to use Lua handler to implement the flexible A/B update
> which can be used in various situations.

OK, then I'd propose having a meeting about this so that I can explain how this
variant works and how we make use of it. When do you think you'll come to this
point so that a meeting makes sense?


Kind regards,
   Christian

-- 
Dr. Christian Storm
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M?nchen, Germany
