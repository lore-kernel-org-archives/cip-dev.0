Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C58CCCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 10:06:59 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8145.1762510011022204259
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 02:06:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=krBFg0DT;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710665e7deso2341445e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762510009; x=1763114809; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p52aYkn5BI9PlddPrH4bklf0jT7PR830849KplEPeOQ=;
        b=krBFg0DTItfgF6T5s2HXN9vGSDqSM0mafAyL9eZ5+BoHhLaxwS5FlQZ9YX65w/TjN9
         5j5xRgAuAP3GvF5N1JNxmXAgTc3fDkEo29V1Pi5IemSYRvo9tThmn/eue1EpQNagPqtB
         +/AjQjrpDSmi75e8DG66JV7l8ULYdC0fXl9kkqwZBhoG+jU7DfR7MNJZSg2gj7myQ3R7
         mM4/Yo1Js4f4pZXKC78n125ZglBY6ENaRRO7mCNfLJX8n5JLdZHRTjhtWV2Lh/w3Rfa0
         JNNZyO3fqvRHwS55rqlh+1HYbg3ypewv/FdS1D+/UvxNqp+3WhqT8WEngn2zZ3qCCZxy
         AcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510009; x=1763114809;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p52aYkn5BI9PlddPrH4bklf0jT7PR830849KplEPeOQ=;
        b=U7JyzTFpuHDZMWMOk2zY68E0UP56CPhr1UvxHO6sUMv0l676YI4Vhoi3wGFHd1BZDD
         GykN0UmCKQemfnusFCjte67k5sjZ+XghoARGhY8LzADU9uVeuMlNLqxj2VC8aLNW6X14
         Pa3w3lGlI9VDcC7Sf4Tz/+shsFl9hvrZ0JmSeUnGU5Ga9NIxo5YbkSQbdGpTnYVvKzkT
         zKcGumlfnXq1BKZHQ7yMkDb/ACRJv3bywXoghDcMdqc7dyZNwwxf9prxXeTgxmrI/Prd
         JXQGaVWLcW6YxBEbnFpilXLxew90h1RpM+McJ/8dPBNa9auiE2Y7yJAbCAXt9qPKo8rn
         xqvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz+azqZQ9BkcM/uvSEkc0GravGYIyX2na3SLHdyDj+M6RmQovccmtFnQrQGHlQGkc/jPZcLSkh@lists.cip-project.org
X-Gm-Message-State: AOJu0YwmCTftXgiTuJJ4Q1BNRXls5xvyDt2+7C08S7FdzcH27PTLA8/2
	MZcmd7icvw06MT4UNv6PNlBCDE+0tvJGMUTjEBq4a6GpKxNdoyHNl5bsOTNSAJTSd7s=
X-Gm-Gg: ASbGncvwixfcfDnsvSzzybbF3ZYZygdC9yYwp02fYudHbvq4eRFJXyrSnYbWDCX1mcH
	fnMZcRo+n20jnfN9M2IN4sF8UxaYPK3MG2iKCz1oeO7WWQZRbg4OWP3QlJD2TVMLlfLYplPhO5p
	DWQMGGzufnv5Ttgr5UnYJLZqTZHUarNtluqDDu8GrQusOVO6qUMA8lsA7pSDh2O9zWtx5ukB5AW
	kCDEqWIke5l0pkqfLoWBDj6AhF4oKiBTae/i0O/R3clqrN878MulYKbh1DPUkzP3Wge5v/PnFFA
	efveggkQceqW6r4yxzclHAnzOT+EsjiEngxk1i31BxJuzUtjrgiJhE7HL4ZKjKTpP0R0pkKvSBl
	+7nftzYZNxz93XOxCHXmdVKARz/s5dc56jGa+83iBDZvG90VcT0HOAMvCN03o+qm14D5FVwPLGY
	Irk8ppdAVquznFVyhiYrGw/SIiSFOkUA==
X-Google-Smtp-Source: AGHT+IHOIttO8d1n0SsuZzgLhEyjaPoYeaKG5IazUF7inPJNRHEIjCqFb/t6ygnMoNuffVBdJZT4yw==
X-Received: by 2002:a05:600c:458d:b0:477:e09:f0f with SMTP id 5b1f17b1804b1-4776bca7cbdmr16248125e9.8.1762510009130;
        Fri, 07 Nov 2025 02:06:49 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce32653sm155931235e9.13.2025.11.07.02.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:06:48 -0800 (PST)
Message-ID: <2854d981-a0f0-4cc3-8a20-677d1fa0e02c@tuxon.dev>
Date: Fri, 7 Nov 2025 12:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}:
 Backport MSTOP support
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aQz1pgHaEQNgfdKa@duo.ucw.cz>
Content-Language: en-US
In-Reply-To: <aQz1pgHaEQNgfdKa@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 10:06:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20469

Hi, Pavel,

On 11/6/25 21:23, Pavel Machek wrote:
> Hi!
> 
>> Series backports the MSTOP (Module Stop) support for the Renesas
>> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>>
>> The purpose of MSTOP is to reduce power consumption by stopping
>> unnecessary module's functions.
>>
>> If any master accesses a module that has the clock stopped and the
>> MSTOP bit set, a bus error will occur.
>>
>> Due to this, to avoid CPU generating synchronous aborts, changes
>> to PM domain specific code were needed. The changes backported in
>> this series were adjusted to be executed only for the above
>> mentioned Renesas SoCs.
>>
>> Please share your thoughts on this approach.
> 
> This is a bit more intrusive than I'd like. dev_pm_domain_detach()
> changes API and now we have to modify unrelated drivers to fix it up.

All the bus drivers were updated to avoid issues described in
https://lore.kernel.org/all/20251106081218.2574950-6-claudiu.beznea.uj@bp.renesas.com/

> 
> How much power does it save?

I don't have numbers here. It is what HW manual sates.

> Do we really need this? 

There are issues with the way the device is attached/detached to its PM
domain w/ or w/o the MSTOP support as long as the drivers are using
devm helpers while the power domain attach/detach calls in bus drivers are
not. This is because devm cleanup helpers are called after the device is no
longer part of a PM domain (due to the dev_pm_domain_detach() calls in bus
drivers remove functions or bus drivers probe functions (on the failure
path)). And the cleanup helpers may access IP registers while power is not
applied.

It just started to be more visible on Renesas devices with the addition of
MSTOP because any master access to an IP having MSTOP set generates bus errors.

E.g. w/o MSTOP support, if a device is part of a clock PM domain, it uses
devm_pm_runtime_enable() in its driver, if stressing unbind/bind I can
reach the point where the rpm_idle() tries to runtime resume the device (in
the unbind cleanup phase) while its clocks are not anymore part of its PM
domain. If the driver has it's own runtime PM APIs as well that tries to
access the IP registers, rpm_idle() will call driver RPM APIs and those
will fail because the clocks are no longer enabled though PM domain. The
issue is explained in the description of
https://lore.kernel.org/all/20251106081218.2574950-6-claudiu.beznea.uj@bp.renesas.com

> Could it be done
> without changing semantics of existing functions?

Other approaches I've tried on mainline are:

1/ open/close a devres group in bus drivers probe:
-
https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com

2/ add devm_pm_domain_attach() to have the dev_pm_domain_detach() call in
devres cleanup phase:
-
https://lore.kernel.org/all/20250526122054.65532-3-claudiu.beznea.uj@bp.renesas.com
-
https://lore.kernel.org/all/20250606111749.3142348-3-claudiu.beznea.uj@bp.renesas.com

Please let me know if you have other suggestions.

Thank you for your review,
Claudiu

> 
>>   driver core: platform: Drop dev_pm_domain_detach() call
>>   mmc: sdio: Drop dev_pm_domain_detach() call
>>   spi: Drop dev_pm_domain_detach() call
>>   rpmsg: core: Drop dev_pm_domain_detach() call
>>   soundwire: bus: Drop dev_pm_domain_detach() call
>>   serdev: Drop dev_pm_domain_detach() call
>>   i2c: core: Drop dev_pm_domain_detach() call
> 
> Thanks and best regards,
> 
> 								Pavel


