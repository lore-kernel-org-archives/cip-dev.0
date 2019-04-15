From: sbabic@denx.de (Stefano Babic)
Date: Mon, 15 Apr 2019 12:02:31 +0200
Subject: [cip-dev] Was: Software updates comparison
In-Reply-To: <OSAPR01MB3763BCD2795C773983692A01D02B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
References: <987bae4c-1936-bda6-5e12-f4d1016110a3@denx.de>
	<OSAPR01MB3763BCD2795C773983692A01D02B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <8f304163-8d36-a0e1-cd87-7b59145cf312@denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 15/04/19 11:51, daniel.sangorrin at toshiba.co.jp wrote:
> Hi Stefano,
> 
> Thanks a lot for the clarifications. 
> # Christian (Siemens) had already informed us about part of the progress.
> 

ok

>> From: Stefano Babic <sbabic@denx.de>
> [...]
>> - depends on libubootenv which needs to be rebuilt for each target.
>>
>> This was a well known issue and source of several conflicts in the past.
>> Thanks to a customer of mines, I have implemented a new libubootenv
>> library that is hardware independent and fixes this issue. Not only, this could
>> allow in future to extend it and introduce security features, like signed
>> environment:
>>
>> 	https://github.com/sbabic/libubootenv
>>
>> The library must be explicitely activated in SWUpdate's configuration, it will
>> become the default in future.
> 
> Sounds great.
> I think that SZ Lin (Moxa) was already preparing a Debian package.

I am in touch with him and I have already merged some changes he asked
me to allow an eaier integration of the package in Debian.

> If the new library is mature enough then we should enable it by default.

Most projects of mine are still using the old approach, a couple of
newer have switched to libubootenv. For the future, I will set to
libubootenv as the old approach is often tricky and depends on U-Boot's
changes.

>  
>> - hard to manage updates from v1 to v5 directly
>>
>> This is also a topic I had on my desk - as it is possible to read in your
>> comparison / research, this can be solved if SWUpdate and CASync can be
>> combined. But to make things correct, SWUpdate should well integrate
>> CASync and uses it as library - this requires some changes in CASync, too. I
>> had a draft design about this, but due to the complexity / effort, the project
>> asking for delta-update decided in another direction. There is currently no
>> further work in SWUpdate in this direction.
> 
> Thanks for the update!
> Was transforming CASync into a library the complex part that you mention?

No, it is a part. It must be well integrated in SWUpdate and should not
break the current security concept. SWUpdate implements privilege
separation and processes that communicate with network run with
different permission as the installer, that is generally root. CASync
processes shoult be split and some of them replaced with something
inside SWUpdate.

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic at denx.de
=====================================================================
