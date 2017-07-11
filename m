From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 11 Jul 2017 10:03:38 +0900
Subject: [cip-dev] About the U-Boot policy
Message-ID: <002c01d2f9e1$87b26920$97173b60$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

# Chris, I wanted to discuss about the U-Boot policy last night during the online meeting but somehow I missed the URL change.

We have had some discussions about U-boot for a while but I would like to achieve some consensus about what
we should do about it. 

U-boot is a rather big project that resembles the Linux kernel in some aspects. For example, unlike generic software 
(e.g. openssh) a big bunch of its code is hardware dependent. U-boot releases have a cadence of 2 months (for 
example v2017.07 was released on Mon, 10 July 2017) but there is no LTS project as far as I know. The closest to an LTS
project that I know of is the U-Boot packages maintained by distros (e.g. Debian) , which seem (see changelog [1]) to 
focus on bug fixing and backporting new hardware support.

I'm going to throw some mud at the wall and see what sticks after our discussion.

1. Should we focus on supporting our reference boards only?
Sangorrin: yes.

2. Should all reference boards use the same source code base line?
Sangorrin: yes, unless the porting effort for a board is too complicated in which case we are better off providing a separate repo.

3. In case the answer to question 2 is 'yes': what's the base line that we should use?
Sangorrin: the source code from a Debian u-boot package that better supports our current reference boards and CIP kernel.

4. Should we focus on backporting security/bug  fixes, or new HW support?
Sangorrin: No. I think that we should only make sure that our reference boards are able to boot the CIP kernel during its lifetime. 

5. Should we upstream our fixes?
Sangorrin: Yes. For future maintainability and as a quality assurance step. But while the patches are getting accepted we should also have our own repos on gitlab's playground.

6. What functionality in U-Boot is important for us?
Sangorrin: network support for tftpboot would be great to have. Specially for debugging and for the CI tests.

Please add your answers!

Thanks,
Daniel

[1] http://metadata.ftp-master.debian.org/changelogs/main/u/u-boot/u-boot_2014.10+dfsg1-5_changelog




> -----Original Message-----
> From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
> Sent: Friday, July 07, 2017 6:00 PM
> > From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
> > Sent: 07 July 2017 09:51
> > Finally, for U-boot I need repositories to fetch the sources.
> > Should we have separate repositories for each board? For example:
> > https://gitlab.com/cip-playground/u-boot-iwg20m
> > https://gitlab.com/cip-playground/u-boot-cyclonev
> 
> If the consensus is to use different u-boot versions/repos for each platform, (rather than push vendors to add support upstream),
> then this approach makes sense.


> However, perhaps we should try and use exiting repositories provided by the vendors, rather than CIP create and maintain them. If
> we start hosting these repositories we will have to continue to maintain them forever.


> Of course, the downside of using externally maintained repositories is that support may end at any time. Perhaps bringing this
> ownership/maintenance into the CIP project is something we want to do/fund.


I'm not sure what maintenance is required for u-boot



> 
> 
> Kind regards, Chris
> 
> >
> > Thanks,
> > Daniel
> >
> >
