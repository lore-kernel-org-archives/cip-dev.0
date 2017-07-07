From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 7 Jul 2017 09:00:01 +0000
Subject: [cip-dev] Project-X (minimal root filesystem) : rewrite and
 renesas iwg20m board support
In-Reply-To: <006f01d2f6fe$264d6c60$72e84520$@toshiba.co.jp>
References: <006f01d2f6fe$264d6c60$72e84520$@toshiba.co.jp>
Message-ID: <TY1PR06MB07027E2A41B20F745A62CDF8B7AA0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

> From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
> Sent: 07 July 2017 09:51
> 
> Hi,
> 
> I've been working on a minimal root filesystem made with "deby".
> The code is here and it includes BSP meta layers for qemux86-64, Beaglebone
> black, Renesas iwg20m board and CycloneV.
> 
> https://gitlab.com/cip-playground/project-x/tree/master/deby
> 
> The meta-cip-common layer is where we put the packages that will be
> included for all targets. The BSP meta-layers contain settings related to the
> architecture of the processor, and Linux/u-boot configuration.
> 
> Currently, I have tested qemux86-64 and Renesas iwg20m. Both of them
> worked fine so in the next step I will try to run tests on them using B at D.
> # Beaglebone should work fine, but I haven't tested it yet.

Great to see you're making some good progress.

> 
> For Cyclone V, I need a kernel repository.
> Koguchi-san: could you create it on https://gitlab.com/cip-playground/linux-
> cip-cyclonev
> 
> Finally, for U-boot I need repositories to fetch the sources.
> Should we have separate repositories for each board? For example:
> https://gitlab.com/cip-playground/u-boot-iwg20m
> https://gitlab.com/cip-playground/u-boot-cyclonev

If the consensus is to use different u-boot versions/repos for each platform, (rather than push vendors to add support upstream), then this approach makes sense.

However, perhaps we should try and use exiting repositories provided by the vendors, rather than CIP create and maintain them. If we start hosting these repositories we will have to continue to maintain them forever.

Of course, the downside of using externally maintained repositories is that support may end at any time. Perhaps bringing this ownership/maintenance into the CIP project is something we want to do/fund.


Kind regards, Chris

> 
> Thanks,
> Daniel
> 
> 
