Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0753DC6379F
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 12:12:47 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.38008.1676968316900546741
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 00:31:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=Qd26HqM1;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: sbabic@denx.de)
Received: from [IPV6:2001:a61:6068:4901:e151:1c1f:9965:ac8d] (unknown [IPv6:2001:a61:6068:4901:e151:1c1f:9965:ac8d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbabic@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1FBA885A26;
	Tue, 21 Feb 2023 09:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1676968284;
	bh=nV1uHjB0qwm+3jdG4a89zfrt0ytrbI5H/e5NQluJ0Ok=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Qd26HqM1n/VoTJ/DlkUxeMfbN9Q492E4NI2a2/Lp/byzSiGkl/nKJR7QYPSMOy6Mo
	 q7FtNp/7YPrPGSCH1pvPkuTxhVardSSAoICReJgJUu58ah1G86+Mx9maxI+EM/wfqG
	 X9p7pJ57E18JYhYEjfa5xOnDPhwMAlBfoPPT9zQIocZQuFmjfeJeuuajWTfHZOuc5C
	 ab8Q+n6kCJDvDJRL/rJ79ieywOB5T7z+OjfmF7URygFKOAAzGZ4Rf4XuOeBasvYDfU
	 ottU8NanPTeccnWlW/p4wPKHRVx2YA52i3W/DgnDb2yMTSmXbg55DtxzN5eaouevbz
	 msKp3x8Awk3Dw==
Message-ID: <b51cdb4f-fdca-154b-7a09-d24896facb8a@denx.de>
Date: Tue, 21 Feb 2023 09:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: SWUpdate+EBG: The impossible state and how it's being handled so far
To: Jan Kiszka <jan.kiszka@siemens.com>,
 efibootguard-dev <efibootguard-dev@googlegroups.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Adler, Michael (CT RDA IOT SES-DE)" <michael.adler@siemens.com>
References: <934a4d61-ed5c-cb5b-82af-86d9e3353120@siemens.com>
From: Stefano Babic <sbabic@denx.de>
In-Reply-To: <934a4d61-ed5c-cb5b-82af-86d9e3353120@siemens.com>
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 12:12:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10749

Hi Jan,

On 21.02.23 08:09, Jan Kiszka wrote:
> Hi again,
> 
> playing with updates, I maneuvered the EBG envs on a system into this
> weird state:
> 
> 
> ----------------------------
>   Config Partition #0 Values:
> in_progress:      yes
> revision:         4
> kernel:           C:BOOT1:linux.efi
> kernelargs:
> watchdog timeout: 0 seconds
> ustate:           3 (FAILED)
> 
> user variables:
> recovery_status = failed
> 
> 
> 
> ----------------------------
>   Config Partition #1 Values:
> in_progress:      no
> revision:         3
> kernel:           C:BOOT1:linux.efi
> kernelargs:
> watchdog timeout: 0 seconds
> ustate:           2 (TESTING)
> 
> user variables:
> 

I see - we should *never* reach this state.

> 
> To get there, I started an upstate with swupdate and booted into testing
> path #1.

Ok

> But then didn't confirm this update and rather started it
> again, using the same swu.

It looks to me that this is the point. SWUpdate requires to close the 
transaction, for itself or for the deployment server (Hawkbit). If a 
system boots with TESTING, the glue logic should start SWUpdate asking 
to close the transaction - with OK or FAILED by passing the -c parameter.

However, this was thought to work together with the deployment server, 
because it handles the state machine on Hawkbit. The parameter is 
ignored if another deployment interface (Webserver, USB, ..) is used. 
This is managed (again) on such situation on glue logic, and the 
transaction (that is set of ustate) is done before starting SWUpdate. Or 
in case of U-Boot, it is also managed with the help of additional (and 
custom) variables.

In your case, it seems that nothing is done at boot time, and SWUpdate 
is started. SWUpdate does not know (because it expects that someone has 
already decided, and ustate is not checked) that a new software is 
running, and the same SWU is loaded again.

> That didn't complete because the UUID clash
> was detected. swupdate terminated, and I was left with the above.
> 
> I can still boot this constellation, EBG will select path #1 (endless
> testing, so to say). OTOH:
> 
> # bg_printenv -c
> Using latest config partition
> Values:
> in_progress:      yes
> revision:         4
> kernel:           C:BOOT1:linux.efi
> kernelargs:
> watchdog timeout: 0 seconds
> ustate:           3 (FAILED)
> 
> user variables:
> recovery_status = failed
> 
> 
> That is not quite correct. To be fair, bg_printenv deals with an illegal
> state here.

Agree.

> Still...
> 
> The key question is where to avoid best entering this state in the first
> place?

My question is why the transaction was not closed before running 
SWUpdate. This is a common pattern even with other bootloader, but it is 
more important here because EBG stores an history (well, with deep=1) of 
previous run.

SWUpdate can check the state when is running, but there is no general 
cases. There are use cases where the OK is coming from the application, 
and SWUpdate waits via IPC the result (but then SWUpdate is started with 
WAIT option, and does not try to load a new SWU). So SWUpdate cannot 
decide itself that TESTING is a wrong ustate, because it depends on a 
single project.

Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================


