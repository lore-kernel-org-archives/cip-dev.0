Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3FEC61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 12:50:56 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.4146.1677054999403026229
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 00:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=T1/r2QsQ;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: sbabic@denx.de)
Received: from [IPV6:2001:a61:6068:4901:9e6d:c2dc:95e6:35f5] (unknown [IPv6:2001:a61:6068:4901:9e6d:c2dc:95e6:35f5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbabic@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B8ABB8551B;
	Wed, 22 Feb 2023 09:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1677054997;
	bh=w82qS8m5BOT9dQXagyKkYeLbhekeY1BlpWiK9iH/wdo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=T1/r2QsQq1pA88i9qLHtTCUYdsJdmJXWfssN/i3aF8uE3z2Vf3/2CA0ewPTxJELXf
	 6RgstiOFcOI5ttfDVDWcNnpwdowad7NaVtqiQqV0lxOT+pkipPXm/kzNLa+EUlF+VU
	 RBsOIfYMO/hMEdv1wQl1bBUtN7Wok6fVCNvxX1KNtfHHRhnTZ0TtFhHN8YXvZITwCB
	 A/UQuTIvwni+El2orBF+fiuThV2T+9rZ0PDj1bXB/3pra6OoHmkgEb05zGRRxDiUcM
	 Kl6Zk8hpfVPhdQ0MLC/NjuYAuCiaGwfhXyNfvRbPuAmEInrY3aRHZdbdBWc4zJHiZZ
	 LQE4E7+L879LQ==
Message-ID: <30573098-aa19-d6cb-051d-356178307493@denx.de>
Date: Wed, 22 Feb 2023 09:36:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: SWUpdate+EBG: The impossible state and how it's being handled so far
To: efibootguard-dev <efibootguard-dev@googlegroups.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <20230221212125.zdic7daabaa25ovk@cosmos>
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <20230221212125.zdic7daabaa25ovk@cosmos>
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 12:50:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10782

Hi Christian, Jan,

On 21.02.23 22:21, Christian Storm wrote:
> Hi,
>=20
>>>>> playing with updates, I maneuvered the EBG envs on a system into th=
is
>>>>> weird state:
>>>>>
>>>>>
>>>>> ----------------------------
>>>>>   =C2=A0 Config Partition #0 Values:
>>>>> in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
>>>>> revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>>>>> kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 C:BOOT1:linux.efi
>>>>> kernelargs:
>>>>> watchdog timeout: 0 seconds
>>>>> ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 3 (FAILED)
>>>>>
>>>>> user variables:
>>>>> recovery_status =3D failed
>=20
> Hm, did you start with a clean environment and SWUpdate >=3D 2022.12?

I think we can reach the status with any SWUpdate version.

>=20
>=20
>>>>> ----------------------------
>>>>>   =C2=A0 Config Partition #1 Values:
>>>>> in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>>>> revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>>>>> kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 C:BOOT1:linux.efi
>>>>> kernelargs:
>>>>> watchdog timeout: 0 seconds
>>>>> ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 2 (TESTING)
>>>>>
>>>>> user variables:
>>>>>
>>>>
>>>> I see - we should *never* reach this state.
>>>>
>>>>>
>>>>> To get there, I started an upstate with swupdate and booted into te=
sting
>>>>> path #1.
>>>>
>>>> Ok
>>>>
>>>>> But then didn't confirm this update and rather started it
>>>>> again, using the same swu.
>>>>
>>>> It looks to me that this is the point. SWUpdate requires to close th=
e
>>>> transaction, for itself or for the deployment server (Hawkbit). If a
>>>> system boots with TESTING, the glue logic should start SWUpdate aski=
ng
>>>> to close the transaction - with OK or FAILED by passing the -c param=
eter.
>>>>
>>>> However, this was thought to work together with the deployment serve=
r,
>>>> because it handles the state machine on Hawkbit. The parameter is
>>>> ignored if another deployment interface (Webserver, USB, ..) is used=
.
>=20
> The suricatta modules handle this for you =E2=80=95 as a "convenience" =
feature
> and to keep the (hawkBit, ...)  server's view of things consistent with
> the device's, which is more important than the convenience aspect :)

Right, this was an initial decision. For not suricatta aka Hawkbit use=20
case, this is handled outside SWUpdate, often before running SWUpdate.=20
It is duty of the integrator understand this and add the required glue=20
logic.

I just ask the question if this should be handled completely by=20
SWUpdate, if configured. The "state" itself is part of SWUpdate=C5=9B sta=
te=20
machine, too, and it could be moved into core, informing suricatta to=20
send the correct feedback to the deployment server.

>=20
> If you're running it with other modules/modes, you're on your own.

Right.

> Then, you have to play along the (convention) rules to close the
> transaction as there's nothing preventing you to get into this
> situation with EFI Boot Guard.


Exactly - issue raises because the transaction was not closed, and glue=20
logic is missing in the Jan'use case.


>=20
> Hence, the valid question whether this should be allowed / denied by EF=
I
> Boot Guard or the tools (SWUpdate in this case) making use of it?

IMHO EFI boot guard should be transparent, and someone else takes the=20
decision. My question here is if we add a way to avoid external glue=20
logic and put it into SWUpdate's core.

>=20
>=20
>>>> This is managed (again) on such situation on glue logic, and the
>>>> transaction (that is set of ustate) is done before starting SWUpdate=
. Or
>>>> in case of U-Boot, it is also managed with the help of additional (a=
nd
>>>> custom) variables.
>>>>
>>>> In your case, it seems that nothing is done at boot time, and SWUpda=
te
>>>> is started. SWUpdate does not know (because it expects that someone =
has
>>>> already decided, and ustate is not checked) that a new software is
>>>> running, and the same SWU is loaded again.
>=20
> Exactly, here you're on your own.

Yes, you are on your own !!

>  You have to instrument EFI Boot Guard
> so that it's happy... which is convention and not enforced, currently.
> Granted, this requires a lot of context knowledge how to integrate
> things properly and seamlessly...
>=20
>=20
>>>>> That didn't complete because the UUID clash
>>>>> was detected. swupdate terminated, and I was left with the above.
>>>>>
>>>>> I can still boot this constellation, EBG will select path #1 (endle=
ss
>>>>> testing, so to say). OTOH:
>>>>>
>>>>> # bg_printenv -c
>>>>> Using latest config partition
>>>>> Values:
>>>>> in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
>>>>> revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>>>>> kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 C:BOOT1:linux.efi
>>>>> kernelargs:
>>>>> watchdog timeout: 0 seconds
>>>>> ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 3 (FAILED)
>>>>>
>>>>> user variables:
>>>>> recovery_status =3D failed
>>>>>
>>>>>
>>>>> That is not quite correct. To be fair, bg_printenv deals with an il=
legal
>>>>> state here.
>>>>
>>>> Agree.
>>>>
>>>>> Still...
>>>>>
>>>>> The key question is where to avoid best entering this state in the =
first
>>>>> place?
>>>>
>>>> My question is why the transaction was not closed before running
>>>> SWUpdate. This is a common pattern even with other bootloader, but i=
t is
>>>> more important here because EBG stores an history (well, with deep=3D=
1) of
>>>> previous run.
>>>>
>>>> SWUpdate can check the state when is running, but there is no genera=
l
>>>> cases. There are use cases where the OK is coming from the applicati=
on,
>>>> and SWUpdate waits via IPC the result (but then SWUpdate is started =
with
>>>> WAIT option, and does not try to load a new SWU). So SWUpdate cannot
>>>> decide itself that TESTING is a wrong ustate, because it depends on =
a
>>>> single project.
>=20
> One common pattern is to have a "health" target and once that's reached
> you start SWUpdate with according parameters (or set them yourself via
> some glueing method). But again, that is convention, not enforced, and
> it's currently the responsibility of the system integrator to get right=
.

Exactly.

>=20
>=20
>>> I was running swupdate manually from the command line. No backend
>>> involved, just the desire to intentionally break things. ;)
>>
>> The best way to reach the goal...:-D
>=20
> If you would have used suricatta, you would have missed this :)
>=20
>=20
>> And yes, this can happen because the part deciding if previous update =
was ok,
>> is missing. In most projects, if system is up and running, it is consi=
dered
>> ok. That means the decision is done in SWUpdate's systemd run unit (or=
 SystemV
>> init script), see also glue logic under /usr/lib/swupdate. In some oth=
er
>> cases, update is ok only if application is running, a migration of a c=
ustom
>> database was ok, ad, and....that means is outside SWUpdate. SWUpdate s=
upports
>> all these use cases.
>=20
> Yes, that's the codified context knowledge. Still, if you miss out on
> one thing, the whole integration will crash and burn. And it's quite
> easy to miss a thing...

There is a balaance between flexibility to cover all use cases and=20
convenience.

>=20
> The question is whether there is a generic pattern like the "health"
> target I sketched above so that SWUpdate can handle and abstract
> the bootloader interactions?

Yes - and yes, the generic pattern is:

- transaction is closed by SWUpdate and not by another process
- SWUpdate evaluated ustate and close the transaction, independently if=20
the update was done via suricatta, Webserver, USB, command line
- related processes like suricatta are informed and they do what they=20
need to do : suricatta sends feedback to Hawkbit.

Nevertheless, the "open" approach must still remain in case a custom=20
acknowledge is required. This is also very common, for example if an=20
operator must acknowledge the update via a GUI.

>=20
> Then, any SWUpdate mode/module will behave the same and there's all
> in one place reducing the need for having all the context knowledge...

Correct.

>=20
>> To avoid the issue you are seeing, the decsion should be done inside S=
WUpdate:
>> something like a transiction TESTING =3D=3D> OK, because SWUpdate is r=
unning. But
>> as I said, this can be done if it will be configurable, or it will bre=
ak the
>> use cases I mentioned.
>=20
> This is essentially promoting the current suricatta behavior to all
> SWUpdate modes/modules w/o the remote reporting part if not run from
> a suricatta module. Would be a starter...

Exactly, this is what should be done.

Regards,
Stefano

>=20
>=20
> Kind regards,
>     Christian
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

