From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Mon, 15 Apr 2019 09:51:47 +0000
Subject: [cip-dev] Was: Software updates comparison
In-Reply-To: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
References: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
Message-ID: <OSAPR01MB3763BCD2795C773983692A01D02B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Stefano,

Thanks a lot for the clarifications. 
# Christian (Siemens) had already informed us about part of the progress.

> From: Stefano Babic <sbabic@denx.de>
[...]
> - depends on libubootenv which needs to be rebuilt for each target.
> 
> This was a well known issue and source of several conflicts in the past.
> Thanks to a customer of mines, I have implemented a new libubootenv
> library that is hardware independent and fixes this issue. Not only, this could
> allow in future to extend it and introduce security features, like signed
> environment:
> 
> 	https://github.com/sbabic/libubootenv
> 
> The library must be explicitely activated in SWUpdate's configuration, it will
> become the default in future.

Sounds great.
I think that SZ Lin (Moxa) was already preparing a Debian package.
If the new library is mature enough then we should enable it by default.
 
> - hard to manage updates from v1 to v5 directly
> 
> This is also a topic I had on my desk - as it is possible to read in your
> comparison / research, this can be solved if SWUpdate and CASync can be
> combined. But to make things correct, SWUpdate should well integrate
> CASync and uses it as library - this requires some changes in CASync, too. I
> had a draft design about this, but due to the complexity / effort, the project
> asking for delta-update decided in another direction. There is currently no
> further work in SWUpdate in this direction.

Thanks for the update!
Was transforming CASync into a library the complex part that you mention?

Best regards,
Daniel

> 
> Best regards,
> Stefano
> 
> --
> ================================================================
> =====
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic at denx.de
> ================================================================
> =====
