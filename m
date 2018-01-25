From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 25 Jan 2018 09:38:02 +0000
Subject: [cip-dev] [PATCH] ARM: shmobile: r8a7743: Fix Watchdog timer
	clock
In-Reply-To: <1516831338.3417.49.camel@codethink.co.uk>
References: <1515498517-23722-1-git-send-email-chris.paterson2@renesas.com>
	<1516831338.3417.49.camel@codethink.co.uk>
Message-ID: <TY1PR06MB0702A9A542BF73825BF01420B7E10@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 24 January 2018 22:02
> 
> On Tue, 2018-01-09 at 11:48 +0000, Chris Paterson wrote:
> > R8A7743_CLK_RWDT should be 2 as specified in the hardware manual.
> 
> This macro doesn't seem to be used in any in-tree device trees.
You're right; it isn't at the moment.

At some point in the future we'll be adding support for RWDT to the iwg20m, so I thought I'd get this fix submitted now before I forgot.

> Should it be?
If we weren't planning to use it - good question!

I guess usually a fix like this would come down the v4.4 LTS route? But as this file has been added directly to CIP this won't happen.

Presumably similar bug fix patches will have to be directly applied to CIP Kernels in the future anyway (once LTS support has ended), even if there is no known use case. There may be users of the CIP Kernel that we aren't aware of?

> 
> I've applied this anyway.
Thank you!

Kind regards, Chris

> 
> Ben.
> 
> > Fixes: 9683f2eba952bc0d ("ARM: shmobile: r8a7743: Add clock index
> > macros for DT sources")
> > Reported-by: Thong Ho <thong.ho.px@rvc.renesas.com>
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > ---
> > ?include/dt-bindings/clock/r8a7743-clock.h | 2 +-
> > ?1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/dt-bindings/clock/r8a7743-clock.h
> > b/include/dt-bindings/clock/r8a7743-clock.h
> > index a5c7e387e66dfd55..53f54dfce59245d8 100644
> > --- a/include/dt-bindings/clock/r8a7743-clock.h
> > +++ b/include/dt-bindings/clock/r8a7743-clock.h
> > @@ -71,7 +71,7 @@
> > > ?#define R8A7743_CLK_USBDMAC1		31
> >
> > ?/* MSTP4 */
> > -#define R8A7743_CLK_RWDT		4
> > +#define R8A7743_CLK_RWDT		2
> > ?#define R8A7743_CLK_USB_DDM		6
> > ?#define R8A7743_CLK_IRQC		7
> > ?#define R8A7743_CLK_INTC_SYS		8
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
