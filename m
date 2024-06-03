Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26408C25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 08:53:36 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.78611.1717404813352569523
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 01:53:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=fsyWthmx;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: ch@denx.de)
Received: from [10.0.20.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ch@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3EC9087FC1;
	Mon,  3 Jun 2024 10:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717404811;
	bh=lZxfdvI9luuZJ4TwBZ4DwmpFFSH7FOnRed/BGtkzHBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fsyWthmxQH1bj22oT1q9PHBRUEDtskQhQuPePLyZrHA71wqdVXbdAgnR7zOliTGAR
	 +Us5JYkA6bwFTzDKzysWCwMhpKLSKCgKMNLiutTb+mqVYVDj6+iKxDMquuyrLe4Jpq
	 OLPGETyJK2FbKBRN6GKM1j0o9lSHVJwWvGb1wrs5EETLGzamHbFw+9PKd1t4usyEmK
	 H0Fz2w+wQNr67TZnBxm0MB85Cyk7WpqJ7tevApWh/+0lgAkanRC8YWGHsW5kjFLqTh
	 7tCqaYNFNyHbOX/Ay+f/uqBZaLAtTHvbF8JhckAPUueQ8vxi73bBgVXOtG7oHumgId
	 C6MQdpmX05J7A==
Message-ID: <7dd2c3fc-7c37-4b1a-a996-3f600278cee5@denx.de>
Date: Mon, 3 Jun 2024 10:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Siemens targets timing out?
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>,
 cip-dev@lists.cip-project.org
Cc: Chris.Paterson2@renesas.com
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <ZlhfLfL7fmsHShTx@duo.ucw.cz>
 <99f545b1-ee28-4a23-be6b-68999d8218c3@siemens.com>
 <1ca5451b-4929-406a-a985-570eb5562f34@siemens.com>
From: Claudius Heine <ch@denx.de>
In-Reply-To: <1ca5451b-4929-406a-a985-570eb5562f34@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 08:53:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16086

Hi Quirin,

On 03/06/2024 10.28, Gylstorff Quirin wrote:
> Our Lab is still not launched, the lab of denx is offline.
>
> https://lava.ciplatform.org/scheduler/worker/lab-cip-denx

I had the bright idea to restart the server and update it beforehand 
last week, I now had to fix the boot issues, but it seems like 
docker-compose/docker now complains:

```
docker-compose client version 1.22 is too old. Minimum supported API 
version is 1.24, please upgrade your client to a newer version
```

It seems now that there is `docker-compose-plugin` package from the 
docker repos, which does not supply a `docker-compose` binary to the 
PATH. Instead now it is used via `docker compose`...

So either patching all `docker-compose` calls to `docker compose`, 
adding `/usr/libexec/docker/cli-plugins/` to the search path, or 
creating a symlink for it.

I will probably try to patch the `docker-compose` calls to `docker compose`.

regards,
Claudius

>
>
> Best regards
> Quirin
>
> On 6/3/24 6:46 AM, Jan Kiszka wrote:
>> On 30.05.24 13:12, Pavel Machek wrote:
>>> Hi!
>>>
>>> I'm trying to test Renesas Ethernet changes, but Siemens targets cause
>>> timeouts. Can anyone take a look?
>>>
>>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1310801626 
>>>
>>>
>>
>> I thought our lab was still offline (internal IT...) and only about to
>> be relaunched. Quirin?
>>
>> Jan
>>


