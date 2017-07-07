From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 7 Jul 2017 17:50:57 +0900
Subject: [cip-dev] Project-X (minimal root filesystem) : rewrite and renesas
	iwg20m board support
Message-ID: <006f01d2f6fe$264d6c60$72e84520$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, 

I've been working on a minimal root filesystem made with "deby". 
The code is here and it includes BSP meta layers for qemux86-64, Beaglebone black,
Renesas iwg20m board and CycloneV.

https://gitlab.com/cip-playground/project-x/tree/master/deby

The meta-cip-common layer is where we put the packages that will be included
for all targets. The BSP meta-layers contain settings related to the architecture of
the processor, and Linux/u-boot configuration.

Currently, I have tested qemux86-64 and Renesas iwg20m. Both of them worked fine
so in the next step I will try to run tests on them using B at D.
# Beaglebone should work fine, but I haven't tested it yet.

For Cyclone V, I need a kernel repository.
Koguchi-san: could you create it on https://gitlab.com/cip-playground/linux-cip-cyclonev

Finally, for U-boot I need repositories to fetch the sources.
Should we have separate repositories for each board? For example:
https://gitlab.com/cip-playground/u-boot-iwg20m
https://gitlab.com/cip-playground/u-boot-cyclonev

Thanks,
Daniel
