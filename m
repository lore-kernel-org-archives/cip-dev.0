Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F758D116E2
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 14:55:00 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17643.1764341690544952425
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 06:54:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nKwhyMEe;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477632d9326so11578735e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764341689; x=1764946489; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=En8rJzB0GPa6cWbMQR8VLh7Mb07ybNAe6C38spzqDXw=;
        b=nKwhyMEeGAk9GFVLn/1pbVZ1NnS/LzmOOJr7g6EkQFd/q8LHdo6QNAscVa0jws1RaZ
         1v/Hmh3ACJwaLKFBcL8rA6f7/kWJSPWqP2CxG3qbgvh5MNIoloQIOyxI0EU8PD6HTDE+
         yAytJqKJxooXUqx0j5QBKIaPB4pPOjgGeJskCmOCzn6IpWubx4HwyuIHyiPwtAAumbIF
         z/aRu0/WHx+9/WxX7Hd6hfiY/pdL6VoeD/DqBmfShVd71CmVm6lQBNRzNM68ZDkSOSSm
         1sx2fH2HKfFse2hXxwsYrdTxdxepaDECIzFH4n1Krj9UXCdgDVKNDquovWGDlqYNHTHR
         /wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764341689; x=1764946489;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=En8rJzB0GPa6cWbMQR8VLh7Mb07ybNAe6C38spzqDXw=;
        b=mbwJyTkdxQWLqLZmVE1qN/bfC5yTfgC+zdTiWO1aG5EvuYRRx3zhhw/ttvhyNJsN0Y
         8581xCyOKh4JZ5ifhxDeSx5p3G/FAtOMK0yYYIF3TdXeSNP95lbTRIkvP+G1hWibst47
         ffqfiMlIzK+94zZkRxCdyK0EyI2iTdCpVRp9NgjCF5H/VGjZCTeiM/I2AFEhXw6OPIEq
         UwTm8U/4g1NdAHTd/PwoxDr/pEIMrojhWuhRp+P9M79Y54b3KZwqRpxmUUenn1vRKRb8
         Rvt2/6e3fyndrQCtjW8v/U86ZN7bhHzeJc4Vnu9PlPV0ayJj6JFaUH6YwgVeu7HVCAGI
         p7yw==
X-Forwarded-Encrypted: i=1; AJvYcCUDhbOyBNQmMrW/mIYW8vQ3L+eOr7CvfrG45xbm/O2P66PEqZeRhDgEC/iW2l0DcENv+Ir9y0PW@lists.cip-project.org
X-Gm-Message-State: AOJu0YwSc4dULfLBzluk1fxXY8zOClV0ZYK7QWEvWCBF04YDfif0Iu2R
	Hgdf40KY5Pm54zeEakERljgMastOnY7dKKam/77M7oOl6CqyBvVCQ186+2QdsoUn6xY=
X-Gm-Gg: ASbGncv5IZdJv3lVn818RQigya2HLtCHgixHRiM4p8SXKjF5QQTjijm+8sYBM/epR63
	iEORvy4GQ+Ru+6Znj0KEjACxgTy9PgMc1i0q5lm3rtj/Sg1+mzOsFzit6vUTdz8NpOCE0ZO7cc5
	kBNgZ6FJJGf/uBTJGorqrY5tc6mMs54NOnFtvvAQbxZ162it3n10+5Rja2fFgTe/gnRYPJwOUlu
	o5syYLWdRaMXzoYE7aguT9vgFxtcW6zwY1WCAqAfpx1OKG3R079ZWtKBsNGjKhJWBINLrgV7YVV
	xlvY6pZFP47scQL7GrxecCzMReDGcQRhnx0Np3Hz0atIEph/kF9BTpkhHXxvpL8OazXwmrmGHSC
	9GMKHDos1qAgEI91q92i2W1cat/KmGpRO/Kuer401YGEfWbgaWqfbiJs2egbqOa45xsUyiY9DRQ
	7wvtGNLiwKTz3k6PQMOso8+k1W/O46WQ==
X-Google-Smtp-Source: AGHT+IHCRidK6dWq/8uMfBlDlKi1b63Ed1ZnY/9pqVl/KKWEXBB7NbjJuGnFb8yG/1197SFkYMRHaA==
X-Received: by 2002:a05:600c:1906:b0:46e:3550:9390 with SMTP id 5b1f17b1804b1-477c01d47c7mr251855675e9.20.1764341688740;
        Fri, 28 Nov 2025 06:54:48 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add608bsm155600215e9.5.2025.11.28.06.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 06:54:48 -0800 (PST)
Message-ID: <92ff8ea3-f4ca-4788-ab62-803678ac2a7d@tuxon.dev>
Date: Fri, 28 Nov 2025 16:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}:
 Backport MSTOP support
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aSmPR2lrojvlkjpW@duo.ucw.cz>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aSmPR2lrojvlkjpW@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 14:55:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20767

Hi, Pavel,

On 11/28/25 14:02, Pavel Machek wrote:
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
> Ok, so after IRC meeting, I went through the patches again, but I
> guess I'll need some more help.
> 
> 03/22] PM: domains: Add helper to check for PM domain detach on unbind
> 
> This one is not mainline, and is only non-mainline patch around,
> correct?

That is correct. This patch is here to make the mainline code affect only
to the selected Renesas SoCs: RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}.

> 
>  05/22] driver core: platform: Drop dev_pm_domain_detach() call
>  06/22] mmc: sdio: Drop dev_pm_domain_detach() call
>  07/22] spi: Drop dev_pm_domain_detach() call
>  08/22] rpmsg: core: Drop dev_pm_domain_detach() call
>  09/22] soundwire: bus: Drop dev_pm_domain_detach() call
>  10/22] serdev: Drop dev_pm_domain_detach() call
>  11/22] i2c: core: Drop dev_pm_domain_detach() call
> 
> These are good cleanups, but are they neccessary for your goals? (Are
> you using rpmsg?) Could we get rid of some or all of these?

Currently, we don't use everything here. The following could be dropped as
we don't have drivers for these subsystems:

08/22] rpmsg: core: Drop dev_pm_domain_detach() call
09/22] soundwire: bus: Drop dev_pm_domain_detach() call
10/22] serdev: Drop dev_pm_domain_detach() call

All the rest are needed as we have drivers on the affected subsystems, and
we want to avoid bus drivers detaching the device from the PM domain too early.

> 
> 22/22] clk: renesas: r9a07g04[34]: Use tabs instead of spaces
> 
> This one is certainly not neccessary.
That's true. There is no need for this one.

Thank you,
Claudiu

