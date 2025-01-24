Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10FBC0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 07:42:20 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.6718.1737704539245422534
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 23:42:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TMi9kWjq;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so3326344a12.1
        for <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 23:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737704537; x=1738309337; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmg/m4lfKrk+PzLvi7kEJ1k14iy48CyIxpk20f9BJok=;
        b=TMi9kWjqlun+vGIy+kT2B7iJQb6ijI3xVyT9nQjOajGn0F4XXZyOgyjPPmxdGPOUnH
         juwuFhy+cXdKcuhFSqP43qq0+RRhsokBPucP9JjNhUMUvp/2u10aDvmLfzvcxUE/cjm5
         Xp++9XHk38pDX9VdfF/e4uIkWApwbZyZV8zw8OF63ZcGRcCqYN9c8hiFnEONZnJx+Vt1
         r0K0/i4Q2WZlJnuncVQtGzNrO1knns5tM6/9SmvX2sUulNiVy01kqujBIIsYLn12/U1Z
         68yWhaNN041qSxV+DiGXUTNEtRxn0mvuVWAfGgqoNIKCsiZkkUWT665HDaxIV06JPcxu
         gIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737704537; x=1738309337;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmg/m4lfKrk+PzLvi7kEJ1k14iy48CyIxpk20f9BJok=;
        b=Bw8foMSMs+wdUlaseXbhMfAidfDYa4fLs1SbcKM6a4ywNKIjYdNY4DW1NdfLkG9vN2
         EtZ/v6yXT6Ofm9r/MPrJpjMUhXQLhPOshMxjS91z4rJz6GOJxt/aXbmChemaRP087aIv
         436qk/FTkBOGoUfmJuZKZklxPqVnoSZpqeGZcGMigrGky6nv2x+A/5MvXdG1ZMCOFHXS
         snOt5bgY3mmNPXvuCS2pqDlvCCj/dh6hCi9p6zw541CuNgB2Mkgozufpxld7ntJlp+jV
         N9SzWakVEvWDDN9F1JO0cYggpe1J72mdcbFpDwxnogZVVxi/UJEPNxFo1oAs3AEaV/un
         Hr5w==
X-Gm-Message-State: AOJu0Ywq5M92tNXXqrPgivE+J7D+/wXnpQrcHijz64VQrjkGb+lMIp1Q
	2Qh3L0oc8FSDdut4NGWbMx73Xs8XFL5TPbww4V0KzZv9sijC1zm/PViNq2+zTSid4CF1sf6ShIJ
	X
X-Gm-Gg: ASbGncudJcAT11+Myn3l1tU5T6LbM1Mnv+oLXoV0SRbgMg1+c4Jbme9kYQpZJ1uphs0
	YPid4vsDmc6e5gAur4OivjUxMZ/reyfZnZPmnl8Up1dJj5aa0ASdDLpbHGiBBYQEyPhmqqQWPQc
	ASeNRWrTl7GRUuBcH8ljQROVH4KQcnIH2M9ib6h2N/K5NB0BCxnkqMATpSp2ONC+Z9DNuVavTfx
	Llg1llY39bQ8lsOg2V4OQju4C/02y8Eety/hr7hYvBVOtsuoD3eS3IAV1JFdnwVEoLNln8TC3D3
	ETsk1Iwrcp2l
X-Google-Smtp-Source: AGHT+IFmz0ysK1EA9kvWPTo+Ly3Xw5wyn7fKA2jiXTd7LwH5REnZ8AMKxqnVn3bivPUrI/26OsPPPA==
X-Received: by 2002:a05:6402:254a:b0:5d2:8f70:75f6 with SMTP id 4fb4d7f45d1cf-5db7db12d0fmr28038180a12.30.1737704536819;
        Thu, 23 Jan 2025 23:42:16 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18638ed2sm788952a12.36.2025.01.23.23.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 23:42:15 -0800 (PST)
Message-ID: <70a94e7c-6ce3-4c09-a3fc-2e59fd64113a@tuxon.dev>
Date: Fri, 24 Jan 2025 09:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH v6.1.y-cip 00/14] renesas: rzg3s: backport the
 RTC support
To: cip-dev@lists.cip-project.org, pavel@denx.de
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB6388E136F89EFE42C5D4D43C92E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <9a4bf2e6-2b5c-4e33-b8b7-98756f544895@tuxon.dev>
 <OS0PR01MB6388D3CC612EC167DE317C6E92E32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <OS0PR01MB6388D3CC612EC167DE317C6E92E32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 07:42:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17614

Hi, Nobuhiro,

On 24.01.2025 07:56, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi Claudiu,
> 
>>> I reviewed this and for 5.10.y-cip series, LGTM.
>>> But regarding "clk: Add Sunplus SP7021 clock driver", as I commented, I
>> think we should consider it.
>>
>> For v5.10.y-cip only: this driver is selected by ARM/SUNPLUS SP7021 SOC.
>> There is no SUNPLUS SP7021 SoC support in v5.10. With this, do you want me
>> to backport the full patch (along with the fixes you mentioned) as well?
> 
> I didn't check 5.10.y. Thank you for checking.
> If you want to manage the same patch for 6.1.y-cip and 5.10.y-cip, Pavel's suggestion seems good.
> Would you consider this?

Yes, I prefer going with Pavel's suggestion as it involves backporting less
code.

Thank you,
Claudiu

> 
> Pavel’s comment:
>   That would be one option. Another would be to apply just the
>   include/linux/clk-provider.h with different title/changelog,
>   explaining this adds only generic function and where it is originally
>   from.
> 
> Best regards,
>   Nobuhiro
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17612): https://lists.cip-project.org/g/cip-dev/message/17612
> Mute This Topic: https://lists.cip-project.org/mt/110751142/8377987
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/13165139/8377987/1773116124/xyzzy [claudiu.beznea@tuxon.dev]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


