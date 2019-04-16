From: sz.lin@moxa.com (=?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Tue, 16 Apr 2019 23:07:43 +0800
Subject: [cip-dev] Was: Software updates comparison
In-Reply-To: <8f304163-8d36-a0e1-cd87-7b59145cf312@denx.de>
References: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
	<OSAPR01MB3763BCD2795C773983692A01D02B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<8f304163-8d36-a0e1-cd87-7b59145cf312@denx.de>
Message-ID: <CAFk6z8M54_TUXwE80yher-nNLw0EdsXzwguHwo0doaib2EruyA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,
Stefano Babic <sbabic@denx.de> ? 2019?4?15? ?? ??6:03???

<snip>

> > Sounds great.
> > I think that SZ Lin (Moxa) was already preparing a Debian package.
>
> I am in touch with him and I have already merged some changes he asked
> me to allow an eaier integration of the package in Debian.

As we discussed, please reconfirm the license changes below

1. GPL-2+ with OpenSSL exception [1]

I've marked below files with "GPL-2+ with OpenSSL exception" since
these are OpenSSL-dependent

- corelib/channel_curl.c
- corelib/verify_signature.c
- corelib/swupdate_rsa_verify.c
- corelib/swupdate_decrypt.c
- corelib/test/test_crypt.c
- corelib/swupdate_cms_verify.c
- core/cpio_utils.c
- core/swupdate.c
- core/parser.c
- corelib/swupdate_verify_private.h

[1] https://salsa.debian.org/szlin/swupdate/blob/debian/master/debian/copyright#L27

2. {Expat and} GPL-2 with OpenSSL exception

I've marked below file with "Expat and GPL-2 with OpenSSL exception."
since this file includes "mongoose.h" which is GPL-2 only.
Besides, I'll suggest removing Expat since it will turn to GPL-2 after all.

- mongoose_interface.c

[2] https://salsa.debian.org/szlin/swupdate/blob/debian/master/debian/copyright#L39

SZ

>
> > If the new library is mature enough then we should enable it by default.
>
> Most projects of mine are still using the old approach, a couple of
> newer have switched to libubootenv. For the future, I will set to
> libubootenv as the old approach is often tricky and depends on U-Boot's
> changes.
>
> >
> >> - hard to manage updates from v1 to v5 directly
> >>
> >> This is also a topic I had on my desk - as it is possible to read in your
> >> comparison / research, this can be solved if SWUpdate and CASync can be
> >> combined. But to make things correct, SWUpdate should well integrate
> >> CASync and uses it as library - this requires some changes in CASync, too. I
> >> had a draft design about this, but due to the complexity / effort, the project
> >> asking for delta-update decided in another direction. There is currently no
> >> further work in SWUpdate in this direction.
> >
> > Thanks for the update!
> > Was transforming CASync into a library the complex part that you mention?
>
> No, it is a part. It must be well integrated in SWUpdate and should not
> break the current security concept. SWUpdate implements privilege
> separation and processes that communicate with network run with
> different permission as the installer, that is generally root. CASync
> processes shoult be split and some of them replaced with something
> inside SWUpdate.
>
> Best regards,
> Stefano
>
> --
> =====================================================================
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic at denx.de
> =====================================================================
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
