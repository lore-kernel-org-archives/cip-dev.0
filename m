Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA023C25B76
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 08:00:15 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.9819.1717574412380537055
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jun 2024 01:00:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=PPqYk4Gd;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: ch@denx.de)
Received: from [10.0.20.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ch@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5E46D882F9;
	Wed,  5 Jun 2024 10:00:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717574410;
	bh=nYioCfkW/aVzgbNBq4cVQIu0db0/Q6um5nIU4QRrM+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PPqYk4Gdokrl4/+5Zz3TZzphwXCxMgRUigGTZyX20wDjy8AAkGagA0VDHjYmi88+u
	 PUZNqcjR/gVX8MIHUxpfVwUyROzWMkfr7qqca6ZlpXmQI4oX0Lgn7AqyMcX126gHdM
	 sxmA4cBhAk1EWyZbMt8dazE8FGskJZQV9MZ06X/t0V9j55Ka7NHHecRdlAdUtSGs85
	 adXEoj8XN7/fz9MPja8GFA+A+QK1GOeSqdH1fIjeOen/y0ZB6sD3rkjAgQrmIo6DpM
	 t0Oo2PwiSGczZIIQODWso/3R5gNhoyjtFUBejDCE9+MRLbK1WXGeMSvVlB2B6w6YcI
	 XFDc9SIirof+Q==
Message-ID: <4c30427d-d63d-42e4-a603-966c09aa9079@denx.de>
Date: Wed, 5 Jun 2024 10:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Siemens targets timing out?
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <ZlhfLfL7fmsHShTx@duo.ucw.cz>
 <99f545b1-ee28-4a23-be6b-68999d8218c3@siemens.com>
 <1ca5451b-4929-406a-a985-570eb5562f34@siemens.com>
 <7dd2c3fc-7c37-4b1a-a996-3f600278cee5@denx.de> <Zl2X8iYxb0r/2rTk@duo.ucw.cz>
From: Claudius Heine <ch@denx.de>
In-Reply-To: <Zl2X8iYxb0r/2rTk@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jun 2024 08:00:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16109

Hi Pavel,

On 03/06/2024 12.16, Pavel Machek wrote:
> Hi!
>
>>> https://lava.ciplatform.org/scheduler/worker/lab-cip-denx
>> I had the bright idea to restart the server and update it beforehand last
>> week, I now had to fix the boot issues, but it seems like
>> docker-compose/docker now complains:
>>
>> ```
>> docker-compose client version 1.22 is too old. Minimum supported API version
>> is 1.24, please upgrade your client to a newer version
>> ```
>>
>> It seems now that there is `docker-compose-plugin` package from the docker
>> repos, which does not supply a `docker-compose` binary to the PATH. Instead
>> now it is used via `docker compose`...
>>
>> So either patching all `docker-compose` calls to `docker compose`, adding
>> `/usr/libexec/docker/cli-plugins/` to the search path, or creating a symlink
>> for it.
>>
>> I will probably try to patch the `docker-compose` calls to `docker
>> compose`.
> Thank you. Can you ping me when I should re-try the tests?

The lab-cip-denx is online now, and hopefully stays that for a while.

regards,
Claudius

