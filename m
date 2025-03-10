Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA7C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 12:52:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.36434.1741611153439076823
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 05:52:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=MDfjU+NE;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 429A9103D43B8;
	Mon, 10 Mar 2025 13:52:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741611151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=yFMj7xxuaCEg+58y4bhCPFLcFwstFhWBkfZtrU0BHHc=;
	b=MDfjU+NEYNCrHzFPyZEUXZhctWXI/0vh+Kd57gRWXjl3HC0WtIlQ/bVRLeAEVrJKyrSAvD
	OwFcArQPF+VzGo2niF8P97f/0mfwQiFDymwXi7PszSi/IYGn5zd4ftcy9ivxaukl85CVzC
	Hy2ImScy909a2MRNBO+v8ATkvOFWYve3m9JXJTMkRVYsl0DiBC1tDN9zFz3wO3QpZ18axp
	7Lcr4k6HHzsVcOivItBGHhX7HufkbIcjblmOMGMi1t3ggAkEkv7nJ9Vaf4+UlTjA8ODZeX
	TC+xXvhNoAUPTOH/HDFZlnxru9270AqwAzNUDiQRNZzUhLKwE2pnnysCIf0iBw==
Message-ID: <f7c75d07-efd4-407e-8c11-ee95484f4865@denx.de>
Date: Mon, 10 Mar 2025 13:52:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH v4 2/5] initramfs-crypt-hook: use static
 temporary encryption key
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Heinisch, Alexander" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
References: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
 <20250305-initramfs-crypt-hook-patches-2-v4-2-4170912e5261@denx.de>
 <AM7PR10MB3320E9FCB6FBE8D3FA69DA0686CA2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <602ce0bb-ada2-4eb4-87e8-e917a2388c65@denx.de>
 <cf030a84-ccb9-4cba-b5c6-d117ebc66620@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <cf030a84-ccb9-4cba-b5c6-d117ebc66620@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Mar 2025 12:52:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18076

Hi Jan,

On 2025-03-06 12:20 pm, Jan Kiszka wrote:
>>>> Security wise the partially encrypted volume, with a static temporary
>>>> encryption key can be considered the same as the un-encrypted
>>>> partition that was there before the system has booted. So using a
>>>> known temporary encryption key should not affect the system security
>>>> in that way.
>>> For new devices, during device bootstrapping / setup that's probably
>>> true,
>>> but such assumption is not generalizable!
>>> But even if it was, once the device is in the field, probably
>>> sensitive data is
>>> added during onboarding or gathered during operation.
>>>
>>> Thus, once the volume key is retrieved (as described above) attackers
>>> could
>>> potentially unencrypt content after years, getting access to sensitive
>>> data which
>>> wasn't there initially.
>> That is true, I wasn't considering that.
>>
>> I guess the only real option would be to try to use the TPM2 to generate
>> a static key... I will have to research how that works.
>>
> Exactly. The question is why we cannot generate the final key already
> before the encryption starts, ie. eliminate any temporary keys.

That would probably require patching cryptsetup and/or systemd-cryptenroll.

I however managed to encrypt and store a password PCR protected in the 
TPM2 using tpm2-tools, so maybe that would be another way.

So far I tested this setup only in qemu+swtpm, and will test in on real 
hardware next.

regards,
Claudius

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


