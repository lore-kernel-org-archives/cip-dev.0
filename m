From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 11 Jul 2017 15:34:00 +0900
Subject: [cip-dev] Project-X (minimal root filesystem) : rewrite and
	renesas iwg20m board support
In-Reply-To: <71df6523-5844-01a2-8c67-d6ebc0a2a4f1@siemens.com>
References: <006f01d2f6fe$264d6c60$72e84520$@toshiba.co.jp>
	<3a3fd45a-c550-07cc-5b34-de176818d1fd@siemens.com>
	<001f01d2f9d5$5de03250$19a096f0$@toshiba.co.jp>
	<71df6523-5844-01a2-8c67-d6ebc0a2a4f1@siemens.com>
Message-ID: <001f01d2fa0f$ae4a6410$0adf2c30$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> Sent: Tuesday, July 11, 2017 3:20 PM
> To: Daniel Sangorrin; cip-dev at lists.cip-project.org
> Cc: kas-devel
> Subject: Re: [cip-dev] Project-X (minimal root filesystem) : rewrite and renesas iwg20m board support
> 
> On 2017-07-11 01:36, Daniel Sangorrin wrote:
> >> Btw, instead of having yet another setup.sh, you may want to have a look
> >> at kas [2]. There is no release yet (next week, hopefully), but it is
> >> fairly mature. Moreover, you can build inside Docker, removing most of
> >> the host dependencies. We are using this now with both Yocto and Isar
> >> projects, often in layered ways [3] that enable reuse.
> >
> > Yesterday I managed to build the qemux86-64 meta layer using the following
> > kas project configuration. Could you check it please?
> >
> > https://gitlab.com/cip-playground/project-x/commit/de611ae06040f6e426d3c5d1b77eb20b4af31a19
> 
> Looks good. You should just set version to 0.10 and use yesterday's
> release. You can pull the corresponding docker image from
> https://hub.docker.com/r/kasproject/, and there should be a pip package
> as well soon.

That was fast. I was using the next branch and built the Dockerfile included in kas.

I had to create a daemon.json to set overlay2 as the storage driver, pass the USER_ID variable,
volume mount the project-x folder and manually set the proxy settings (for some reason using
build-args didn't work for me).
 
> Does it still make a difference to set BB_NUMBER_THREADS and
> PARALLEL_MAKE? I'm seeing full CPU usage without it as well. I'm always
> looking for reasonable defaults we can set (?=) from kas automatically.
> BB_DISKMON_DIRS should likely be included, I was adding it as well already.

You know better than me ;)
I just checked the latest ref manual and apparently OE automatically sets them up.

Thanks,
Daniel

> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA ITP SES-DE
> Corporate Competence Center Embedded Linux
