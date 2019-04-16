From: sbabic@denx.de (Stefano Babic)
Date: Tue, 16 Apr 2019 17:50:37 +0200
Subject: [cip-dev] Was: Software updates comparison
In-Reply-To: <CAFk6z8M54_TUXwE80yher-nNLw0EdsXzwguHwo0doaib2EruyA@mail.gmail.com>
References: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
	<OSAPR01MB3763BCD2795C773983692A01D02B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<8f304163-8d36-a0e1-cd87-7b59145cf312@denx.de>
	<CAFk6z8M54_TUXwE80yher-nNLw0EdsXzwguHwo0doaib2EruyA@mail.gmail.com>
Message-ID: <167bfb10-6e19-eec3-a0fa-1b7fcd004f6d@denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 16/04/19 17:07, SZ Lin (???) wrote:
> Hi,
> Stefano Babic <sbabic@denx.de> ? 2019?4?15? ?? ??6:03???
> 
> <snip>
> 
>>> Sounds great.
>>> I think that SZ Lin (Moxa) was already preparing a Debian package.
>>
>> I am in touch with him and I have already merged some changes he asked
>> me to allow an eaier integration of the package in Debian.
> 
> As we discussed, please reconfirm the license changes below
> 

Ok

> 1. GPL-2+ with OpenSSL exception [1]
> 
> I've marked below files with "GPL-2+ with OpenSSL exception" since
> these are OpenSSL-dependent
> 
> - corelib/channel_curl.c
> - corelib/verify_signature.c
> - corelib/swupdate_rsa_verify.c
> - corelib/swupdate_decrypt.c
> - corelib/test/test_crypt.c
> - corelib/swupdate_cms_verify.c
> - core/cpio_utils.c
> - core/swupdate.c
> - core/parser.c
> - corelib/swupdate_verify_private.h
> 

Yes - these files include openssl.h, and for them the OpenSSL exception
is required. As you told me that SPDX has finally released an identifier
for it, I could also change the ID for that files for next version of
SWUpdate, (a 2019.04 release will be pushed on next days).

> [1] https://salsa.debian.org/szlin/swupdate/blob/debian/master/debian/copyright#L27
> 
> 2. {Expat and} GPL-2 with OpenSSL exception
> 
> I've marked below file with "Expat and GPL-2 with OpenSSL exception."
> since this file includes "mongoose.h" which is GPL-2 only.
> Besides, I'll suggest removing Expat since it will turn to GPL-2 after all.
> 

Yes, agree.

> - mongoose_interface.c
> 
> [2] https://salsa.debian.org/szlin/swupdate/blob/debian/master/debian/copyright#L39
> 

Best regards,
Stefano Babic


-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic at denx.de
=====================================================================
