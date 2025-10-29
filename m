Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A20CCF9F0
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 14:30:18 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web01.7299.1761748216075080429
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 07:30:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P0Qy1Il6;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47118259fd8so57271915e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761748214; x=1762353014; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsUF/Gqv0mJ2Cv8yyGx+O8IwfssgJPBvuxjHLOrN6sk=;
        b=P0Qy1Il63jxkI+96tqoOd3odBiWnRzoCV3M+NUEd2JM+ijuaOhYtBcl3XmiwmRNRKF
         oGPXdN1FaECTkl5NvtfdaK/vs/ECzYIigLEYaI2rhDBANpDwCVUG3xD5YL9917INQblb
         ufCQkq3tUk3QzLaF7Ll0IU6p8qw9T0RTRH4tdTz65mGBRlxd2OPjyYw06hM6o55AlfFC
         bri+2i86eeyQy0hZj07GZqtRgvY5Y+25e1gav/KZU46lIsInWCk/DPA8jZPxbHFOQ42H
         HUWFcAPQRDfuC2sHRcIex70EYEYDn7oECvCymQGCHZnJPKDuSetKBd+7uKuSOQgde4Jm
         rEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748214; x=1762353014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsUF/Gqv0mJ2Cv8yyGx+O8IwfssgJPBvuxjHLOrN6sk=;
        b=s/ao6o722ZWgQEK17xFnsWDceZpw0O7XO7Zfv8kCTlgEeaIrbOCTLs3/kjThrIfT2W
         bLFVMTTz8Ccj/qTAPpn/bY/YwHWeO4mhaEJGeQtcm3FwYyS2cGm9bpvI420kmEaNYzUN
         m/iX73ZT9/csDoPhjJhpbYvI/GcOpqq1NsGyeiiHWOt1xg9h2Tls1ikLnQLPS1OT0csx
         XT4NRHZ34gnp7nP5GS+Zmsx8sHfnLxgULrg2u4QMP5B6VIvGciM/E+G+L3lSpEKQrCxM
         FvatDJEgt6+Xst374Je/YjTFMeSt4/506tM6fH7LvIBEoxnj6JBOd4JxwzZj6a3MiSgL
         UjjA==
X-Forwarded-Encrypted: i=1; AJvYcCW4DbETS3O8yTyNWD1/pm1Z5zTccV2Aiefw8ZIioIq1K1uIYffNwsvO8BOVYX0WZMrjBvDvjFvW@lists.cip-project.org
X-Gm-Message-State: AOJu0YzSrdaq+7g1aBwnO1cNFQGY2k4DIa5+l6bXnDm39x9jathbbfz7
	I8UaElxs7r2jYoNzqdID6K3YaHcUyfnanzkG28JOxzN7PCvowyaeN1lN0wOjnacIa1I=
X-Gm-Gg: ASbGncsSXTQ03H8p+ldVSa9usuvvTrjSrb6czWfYpPmKukBrAILqhJmkDL2gf2VRTqJ
	8vYjQl6zF8GVuSCRJvoOuOixaX2h1G8HjuNrnsRlb7UKkwfRPq3STktkmjzhtk0sk2+3N7csC3R
	+MRqNNERrCW5169M/+8snskJP5O++Sdny/+oVEiIK3IQ5KZKtTs7rs2nU2826O0llji4pMbLNgs
	vt9CaWktWbrqPPx0XaUhr2lwSzhy7DP1KloC7CA3FxBcJbteDPRE6aC5qZXfidTwfk6eXF0Aluj
	98f/vFPCd8kc0vsxNtVVxLUs2RI9UPb6ZHfdqF29cx/WX3MU91YfR3ZU/rhAcHSzFehiBpYYVo7
	gVsEvFewtUPbZ/XGwQz2Z7ZnBqJiyIJJYGYjqLrNjMnxuSpPFImUL8bovTqsyxEniP0DN0GdXlQ
	KbHfeSYeV3NnLkI0mYFGZQfybLe+7zXxt1nTz+76aT98rR9MbOWBaLOzw=
X-Google-Smtp-Source: AGHT+IEjFEJzjwzCoCZkIG8NNNB3/h598yXT0KSBjoYdwhJ55WaqyLycvg0ZQSK1DPaNjOve9gykaw==
X-Received: by 2002:a05:600d:435c:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-4771fd61d0emr18802445e9.29.1761748212502;
        Wed, 29 Oct 2025 07:30:12 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6302:7900:aafe:5712:6974:4a42? ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7d1sm27034146f8f.16.2025.10.29.07.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:30:11 -0700 (PDT)
Message-ID: <bd43e5bf-4fe9-451d-971e-f4bea874db23@tuxon.dev>
Date: Wed, 29 Oct 2025 16:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y-cip] mm: page_alloc: Add kernel parameter to select
 maximum PCP batch scale number
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20251027092658.84955-1-claudiu.beznea.uj@bp.renesas.com>
 <aQHdNhBR2DiWAtEx@duo.ucw.cz>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aQHdNhBR2DiWAtEx@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 14:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20276

Hi, Pavel,

On 10/29/25 11:24, Pavel Machek wrote:
> Hi!
> 
>> Commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid
>> too long latency") introduced default PCP (Per-CPU Pageset) batch size as
>> a configuration flag. The configuration flag is CONFIG_PCP_BATCH_SCALE_MAX.
>>
>> The ARM64 defconfig has CONFIG_PCP_BATCH_SCALE_MAX=5. This defconfig
>> is used by a high range of SoCs.
>>
>> The Renesas RZ/G3S SoC is a single CPU SoC, with L1$ (I-cache 32Kbytes,
>> D-cache 32 Kbytes), L3$ (256 Kbytes), but no L2$. It is currently used in
>> a configuration with 1 GiB RAM size. In this configuration, starting with
>> commit 52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid too
>> long latency") the "bonnie++ -d /mnt -u root" benchmark takes ~14 minutes
>> while previously it took ~10 minutes. The /mnt directory is mounted on SD
>> card. Same behavior is reproduced on similar Renesas single core devices
>> (e.g., Renesas RZ/G2UL). bonnie++ version used was 1.04.
>>
>> Add a new kernel parameter to allow systems like Renesas RZ/G3S to
>> continue have the same performance numbers with the default mainline
> ...
> 
>> This patch was posted as RFC at [1] but got no feedback. Starting with
>> kernel v6.17 the behaviour was restored by commits:
>>
>> 18ebe55a9236 ("mm/readahead: terminate async readahead on natural boundary")
>> 38b0ece6d763 ("mm/filemap: allow arch to request folio size for exec
>> memory")
> 
> Ok, so this is not mainline, because mainline has different solution.
> 
> It is also not queued for stable.
> 
> It introduces kernel parameter that will be special for -cip, not seen
> in mainline nor -stable.
> 
> Presumably you'll be telling your customers to set the command line
> parameter.

Yes, the idea was to have the generic built image tuned tough the command line 
parameter.

> Would it make sense to ask them to tune the config instead?

We wanted to avoid updating the generic kernel config to not, presumably, affect 
the more powerful devices sharing the same defconfig. We can update the config 
in cip-kernel-config but that may have negative impact on the more powerful 
devices. Please let me know this approach fits better for you.

The commit description specifies:

Although it is reasonable to use 5 as max batch scale factor for the
systems tested, there are also slower systems.  Where smaller value should
be used to constrain the page allocation/freeing latency.

Thank you,
Claudiu

