Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D41C61DA3
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 12:12:56 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.38168.1676972039690767553
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 01:34:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=yhxDcHxg;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: sbabic@denx.de)
Received: from [IPV6:2001:a61:6068:4901:e151:1c1f:9965:ac8d] (unknown [IPv6:2001:a61:6068:4901:e151:1c1f:9965:ac8d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbabic@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 514A0859B6;
	Tue, 21 Feb 2023 10:33:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1676972036;
	bh=w0GFUhMGWwYD+kVIRREnqxS0pHksC9HOZE3Y4rwxQlU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=yhxDcHxgwFSMl3JyjLVvRO0HhjQakfPCZhvPzKBrhMcMYVBwF8lD8ZFWlJ+YfMRqk
	 SOrLNCmCSVR7wA5PV73n9CMsqG+HeNg5TQVuzg01e7epvzyjXmrQz9jUxBCggq6IUB
	 NpTaTCeBSipEnUx8urByvXw2Ad6uNcIs/2zKgJZO/0Ade+5opl47UQwz3mRpKm5tmv
	 UULZ3YAAoyQDK1SbQYNXu1kC4WwgyPNnQSewsNEcexpqE/qoY6BsZ11x3XwA+zrdB/
	 goQiiZkIW/zZTzizvFpfnzMAipsOL3lOU2z6tV8kqIO+KiKI/MhxVk9wFrH+Lkb4ed
	 Cl4nVso3o0Pwg==
Message-ID: <42568352-ea72-0f41-0944-fea437f01edc@denx.de>
Date: Tue, 21 Feb 2023 10:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: SWUpdate+EBG: The impossible state and how it's being handled so far
To: Jan Kiszka <jan.kiszka@siemens.com>, Stefano Babic <sbabic@denx.de>,
 efibootguard-dev <efibootguard-dev@googlegroups.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Adler, Michael (CT RDA IOT SES-DE)" <michael.adler@siemens.com>
References: <934a4d61-ed5c-cb5b-82af-86d9e3353120@siemens.com>
 <b51cdb4f-fdca-154b-7a09-d24896facb8a@denx.de>
 <5b7c25ce-d70f-fac7-7a85-660ebcf45847@siemens.com>
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <5b7c25ce-d70f-fac7-7a85-660ebcf45847@siemens.com>
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 12:12:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10750

Hi Jan,

On 21.02.23 10:21, Jan Kiszka wrote:
> On 21.02.23 09:31, Stefano Babic wrote:
>> Hi Jan,
>>
>> On 21.02.23 08:09, Jan Kiszka wrote:
>>> Hi again,
>>>
>>> playing with updates, I maneuvered the EBG envs on a system into this
>>> weird state:
>>>
>>>
>>> ----------------------------
>>>  =C2=A0 Config Partition #0 Values:
>>> in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
>>> revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>>> kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C=
:BOOT1:linux.efi
>>> kernelargs:
>>> watchdog timeout: 0 seconds
>>> ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3=
 (FAILED)
>>>
>>> user variables:
>>> recovery_status =3D failed
>>>
>>>
>>>
>>> ----------------------------
>>>  =C2=A0 Config Partition #1 Values:
>>> in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>> revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>>> kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C=
:BOOT1:linux.efi
>>> kernelargs:
>>> watchdog timeout: 0 seconds
>>> ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
 (TESTING)
>>>
>>> user variables:
>>>
>>
>> I see - we should *never* reach this state.
>>
>>>
>>> To get there, I started an upstate with swupdate and booted into test=
ing
>>> path #1.
>>
>> Ok
>>
>>> But then didn't confirm this update and rather started it
>>> again, using the same swu.
>>
>> It looks to me that this is the point. SWUpdate requires to close the
>> transaction, for itself or for the deployment server (Hawkbit). If a
>> system boots with TESTING, the glue logic should start SWUpdate asking
>> to close the transaction - with OK or FAILED by passing the -c paramet=
er.
>>
>> However, this was thought to work together with the deployment server,
>> because it handles the state machine on Hawkbit. The parameter is
>> ignored if another deployment interface (Webserver, USB, ..) is used.
>> This is managed (again) on such situation on glue logic, and the
>> transaction (that is set of ustate) is done before starting SWUpdate. =
Or
>> in case of U-Boot, it is also managed with the help of additional (and
>> custom) variables.
>>
>> In your case, it seems that nothing is done at boot time, and SWUpdate
>> is started. SWUpdate does not know (because it expects that someone ha=
s
>> already decided, and ustate is not checked) that a new software is
>> running, and the same SWU is loaded again.
>>
>>> That didn't complete because the UUID clash
>>> was detected. swupdate terminated, and I was left with the above.
>>>
>>> I can still boot this constellation, EBG will select path #1 (endless
>>> testing, so to say). OTOH:
>>>
>>> # bg_printenv -c
>>> Using latest config partition
>>> Values:
>>> in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
>>> revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>>> kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C=
:BOOT1:linux.efi
>>> kernelargs:
>>> watchdog timeout: 0 seconds
>>> ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3=
 (FAILED)
>>>
>>> user variables:
>>> recovery_status =3D failed
>>>
>>>
>>> That is not quite correct. To be fair, bg_printenv deals with an ille=
gal
>>> state here.
>>
>> Agree.
>>
>>> Still...
>>>
>>> The key question is where to avoid best entering this state in the fi=
rst
>>> place?
>>
>> My question is why the transaction was not closed before running
>> SWUpdate. This is a common pattern even with other bootloader, but it =
is
>> more important here because EBG stores an history (well, with deep=3D1=
) of
>> previous run.
>>
>> SWUpdate can check the state when is running, but there is no general
>> cases. There are use cases where the OK is coming from the application=
,
>> and SWUpdate waits via IPC the result (but then SWUpdate is started wi=
th
>> WAIT option, and does not try to load a new SWU). So SWUpdate cannot
>> decide itself that TESTING is a wrong ustate, because it depends on a
>> single project.
>=20
> I was running swupdate manually from the command line. No backend
> involved, just the desire to intentionally break things. ;)

The best way to reach the goal...:-D

And yes, this can happen because the part deciding if previous update=20
was ok, is missing. In most projects, if system is up and running, it is=20
considered ok. That means the decision is done in SWUpdate's systemd run=20
unit (or SystemV init script), see also glue logic under=20
/usr/lib/swupdate. In some other cases, update is ok only if application=20
is running, a migration of a custom database was ok, ad, and....that=20
means is outside SWUpdate. SWUpdate supports all these use cases.

To avoid the issue you are seeing, the decsion should be done inside=20
SWUpdate: something like a transiction TESTING =3D=3D> OK, because SWUpda=
te=20
is running. But as I said, this can be done if it will be configurable,=20
or it will break the use cases I mentioned.

Regards,
Stefano

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


