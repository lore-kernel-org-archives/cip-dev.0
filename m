Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A68C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 07:21:56 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web11.42463.1745824877319931627
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 00:21:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=f+DSLiXU;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so8045379a12.0
        for <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 00:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745824875; x=1746429675; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVEWW1pgmh7n7uDnqO6PrRua65Ho+mOC/uXksdpd5Q8=;
        b=f+DSLiXUchcVFkL9SVki/KK1Ea4NqENABm/78RLKdvGhUfzwJG1vBrmtT+C96z1UHC
         ZmwRhgIVvi38IWJIsCpMFtLRl/y9RIuFNGYLaOT1EJu+pF2YQsWFboKZ5LKqe+STCczz
         xl5Os4A1wwZb/lthQuoSvi2G8SNkCyciIQNT/IbJd/AOavcDNXblrDnfb+JPBlRdKSBF
         abG3fblB3OPw/TdpxXQh9MJvxoDbImCq3pF8gLlRo/3VDmrZZRuzKfwB2M0x098N9SmH
         bs8LMWTYhUjTsHDxpnERE19GiOIaypoRICkcN9cfBPDRF3q6yw35o/6ke+OduAHxlOKe
         fwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745824875; x=1746429675;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVEWW1pgmh7n7uDnqO6PrRua65Ho+mOC/uXksdpd5Q8=;
        b=bmrYBojs07qHOf8tw1MVD6ZQMap/DtTADnV+jOGCeeKWLagc7Prk419Z2yTFSlZb6O
         jQpR0IJf8OdHvhInBJIbSjwRksAPeWAP+reZOr0meTpp+/6oUKPByDBUq0gsEm4FTGvA
         lKlh4AQc4oxI4VNU8vu+EX2G5e05GgBZVVb6tFipA2eB2g8kvTTEHBiXZZ9xncOEAyn4
         ippXrVISX2AzP1NGBtI35yDT+JwvOdmBWVlZrSQHJeJk9FXxywAUCdlxAhRuQalKlUyc
         3s4/fHKQPTf94ReJbGylbK5wi3L8bp/hFUqiiI9vWU6ne3C4gc4uBB9uYcRacyMrT2Ok
         2c9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAHDZzEdgGHOQjMm/8u4amU0m1D98EmapyHZ3Refa7g5R4sWcgHugy69rUHenHI7bD3DEr5aMO@lists.cip-project.org
X-Gm-Message-State: AOJu0YyCWEdt0/UEefvrDgZkAA4aGN/U5I4ormDs/Yw/ys6EdBC8wUuY
	Xmm16/lo7FAS9u4SLo53k1gT0E+GYrPn72iB5ztFUjtuO+APHeoTn9NjFQf4iiQ=
X-Gm-Gg: ASbGncvqACqoOf8/TvyeDTvTjNchpIue7KJUslp0Y6r0w1FHSuYehNKwNpbyZOomJc1
	UaSJ7EhZ7ci+3PwA1cHLVCYzuSw3OSJgiDdX3FrEoSZ0p1imu4jJu1KYw/8XpwEXrD84xhXproP
	JfVy02hJYGcUPOzleCkYYw2NyzYLq86nOoC4FCs8FMMf+P9/cLI/RDJLiVi/dkqppwOKVlbIRWW
	HgFt+mVucygmRaEELYC0WQV6n8vth2wfGItDMFe/H5xM2kpKvL5VCWrHjpsvVVIiCm9v0S5vqi7
	LuQzRWNrjJSGUpOiHjyjGCiOnFo1DaBsLKQUxdn5AwYfdqd2Wg==
X-Google-Smtp-Source: AGHT+IGjpuz8Pn/rirpkALUZl9BAgyWoiD9WFcXXQ1rKJ51kkEV9V1WEuYNB4Iviw4ZkGIE6evINxA==
X-Received: by 2002:a05:6402:2787:b0:5f5:6299:ad68 with SMTP id 4fb4d7f45d1cf-5f7395ef2cemr6948796a12.11.1745824875293;
        Mon, 28 Apr 2025 00:21:15 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f658csm5483100a12.41.2025.04.28.00.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 00:21:14 -0700 (PDT)
Message-ID: <d8ff6b74-0508-453e-946a-83491659316c@tuxon.dev>
Date: Mon, 28 Apr 2025 10:21:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5.10.y-cip 0/3] RZ/G3S: Backport DMA
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
 <aA8nwI87irhzJxS3@duo.ucw.cz>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aA8nwI87irhzJxS3@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 07:21:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18686

Hi, Pavel,

On 28.04.2025 10:01, Pavel Machek wrote:
> Hi!
> 
>> Series backports the Renesas RZ/G3S DMA support to v5.10.y CIP.
> 
> Thank you. Series looks okay to me, and I can apply it if there are no
> other comments and it passes testing.
> 
> If you wanted to help me, adding note "All the patches are already in
> v6.12-cip" would be nice. (I checked few, and assume they are).

Yes, they are all present in v6.12-cip. Sorry for not mentioning it. I'll
keep it in mind for the next submissions.

Thank you,
Claudiu

> 
> Best regards,
>                                                                 Pavel


