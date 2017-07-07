From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 7 Jul 2017 12:40:01 +0200
Subject: [cip-dev] Project-X (minimal root filesystem) : rewrite and
 renesas iwg20m board support
In-Reply-To: <006f01d2f6fe$264d6c60$72e84520$@toshiba.co.jp>
References: <006f01d2f6fe$264d6c60$72e84520$@toshiba.co.jp>
Message-ID: <3a3fd45a-c550-07cc-5b34-de176818d1fd@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2017-07-07 10:50, Daniel Sangorrin wrote:
> Hi, 
> 
> I've been working on a minimal root filesystem made with "deby". 
> The code is here and it includes BSP meta layers for qemux86-64, Beaglebone black,
> Renesas iwg20m board and CycloneV.
> 
> https://gitlab.com/cip-playground/project-x/tree/master/deby
> 
> The meta-cip-common layer is where we put the packages that will be included
> for all targets. The BSP meta-layers contain settings related to the architecture of
> the processor, and Linux/u-boot configuration.
> 
> Currently, I have tested qemux86-64 and Renesas iwg20m. Both of them worked fine
> so in the next step I will try to run tests on them using B at D.
> # Beaglebone should work fine, but I haven't tested it yet.
> 
> For Cyclone V, I need a kernel repository.
> Koguchi-san: could you create it on https://gitlab.com/cip-playground/linux-cip-cyclonev
> 
> Finally, for U-boot I need repositories to fetch the sources.
> Should we have separate repositories for each board? For example:
> https://gitlab.com/cip-playground/u-boot-iwg20m
> https://gitlab.com/cip-playground/u-boot-cyclonev

Nice work! Maybe I find the time to model a binary Debian variant as
well, using Isar [1] - ideally prior to DebConf.

Btw, instead of having yet another setup.sh, you may want to have a look
at kas [2]. There is no release yet (next week, hopefully), but it is
fairly mature. Moreover, you can build inside Docker, removing most of
the host dependencies. We are using this now with both Yocto and Isar
projects, often in layered ways [3] that enable reuse.

Jan

[1] https://github.com/ilbers/isar
[2] https://github.com/siemens/kas
[3]
https://github.com/siemens/meta-iot2000/commit/eb4c3df4a62d0e5c32c74082e4c5c467627b9a84
