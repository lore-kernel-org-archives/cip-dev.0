Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D868ACAC59A
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 13:03:22 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web10.22318.1758114194457330230
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 06:03:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ddjWD7l0;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0787fdb137so1002122466b.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 06:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758114193; x=1758718993; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbqXUGYACAG9ONDRlWUtnK7aj0lDQicvIBWeuXiyHCI=;
        b=ddjWD7l0V/9R2cOlq1r64rIwjshWAXE8LQHsxA0n+tDzE4ZkG4Oz/bxx0FrCjQRqF2
         pcYHX167D3IhQsuD2GpLQvQh0INUO0R5Ha10euMhjf42CWXyvuBcUoxfG2fJ/uYrI4X7
         lXa/5M7Dn9fqAJn9pEEeUcz+MxMuCPGIW9eFUvLH709eBKr4hxqXI002exbQi20D6TbG
         X+3qkLGTeJP0AnIEDD6kpAsjTmN5hEHfmz4151sqpqiGzZ9i8WfppG+1fQdBwRqo10NG
         R/OOvAM4C8mwkRCX7PQLel7EL9VJpFFs7Nub7LAF3WGIp2AIWC0LSCacnsBv6FpAYqKq
         Pb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114193; x=1758718993;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbqXUGYACAG9ONDRlWUtnK7aj0lDQicvIBWeuXiyHCI=;
        b=BtoYaN2PrK+NNGMuGpTw/tH5cPqIlDzBYXdVKDIrAqryF7XHpAypBDKr8fJwqOUfLC
         KzkLLZKLJ4Y66j623NB0kz5p8wSH7mDdlF7Z2BCAwqEmNW9e1cQweTRunZNgstEkk0UQ
         LZwADWM5bgq4x7ouHKt28ulQB5oPSGvutiLqyFfHYg37ZlNZcfl2zksm6QTnTCUWCtxW
         tLYMAbmcVKfsWEOg8Q6A/Efoo0UMv/NcnD75keuquFwez+dNX9MoMRrHUD3j65abShBf
         bACgk7SVJ6cEegD1FxV+eN23XWTNIZ5TWb60sTyki8j8nDzp/aeiR0FJ7mfce4Nf8sPW
         iRlg==
X-Gm-Message-State: AOJu0YxjprDwjEx1sL9wyPP9texzDAiM7FDUIoYohutD/hftaq6s6yXv
	4YYT6OmJegL5rbynFzoYj8Y/a3AoWOe9RptvdI5Ze9yb0UH8lQGBl3LbsuFiVou/XTE=
X-Gm-Gg: ASbGncuVMS9XB5BaCetdI5zZUBihNfhj4C4msULR4Kv/S2WnLDx+au10eRkK9aSjWSv
	CMz4Nr7s403aetoWHKUCJNPFc7BJRAwha56TZMfhqBwuYsKd2lNn4/Q0LV4B0u47uBMdn//qA0K
	S3/Cfycu1d7YxC2S7s3hm3UWD/jGdim9VVmhYJcGkwXQSn6c/EHztwurM/Hr9f9GTW9w+dEuGqm
	rK4HbcI23+1oqJmephk1WEjtEOMV+ZHvZllENv7UX1b/tlQir/12hGHbap+Ee7k9UDhVz6GitDg
	AxZCLeEMHPpD205bRlptBTzwe4wY2wnfZaoPGsfWNmzrGCpv0vklkk4V25cUENYLdYZLh1hmF5M
	b4beXcGCVkqvYYiBqMma5f+l+GAzCZOFtTmptzzqRRQ==
X-Google-Smtp-Source: AGHT+IGG9IohAUHkmH6JG3ejMI3gvWlYiDK1tBBnDvA57crgfVPZuLwCcEoJWc9UN5vVIlLpi/D9pw==
X-Received: by 2002:a17:907:3d89:b0:b04:858e:c200 with SMTP id a640c23a62f3a-b1bc02f6679mr239759266b.32.1758114192619;
        Wed, 17 Sep 2025 06:03:12 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da268sm1359667366b.10.2025.09.17.06.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:03:11 -0700 (PDT)
Message-ID: <e2cbeca0-243c-4858-9693-3752c57a4bbb@tuxon.dev>
Date: Wed, 17 Sep 2025 16:03:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [RESEND PATCH 6.1.y-cip] mmc: renesas_sdhi: Set the
 SDBUF after reset
To: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@denx.de
Cc: cip-dev@lists.cip-project.org
References: <20250917110854.326336-1-claudiu.beznea.uj@bp.renesas.com>
 <20250917110854.326336-2-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB1481859F96555ECC68F8091F7CD17A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <TY7PR01MB1481859F96555ECC68F8091F7CD17A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 13:03:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20080

Hi, Nobuhiro,

On 9/17/25 15:40, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Wednesday, September 17, 2025 8:09 PM
>> To: iwamatsu nobuhiro(岩松 信洋 □ＤＩＴＣ○ＣＰＴ)
>> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@denx.de
>> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
>> Subject: [RESEND PATCH 6.1.y-cip] mmc: renesas_sdhi: Set the SDBUF after
>> reset
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> commit 68dbe38ed7ba9141b9329eb203fe9762a93b60e8 upstream.
>>
>> For development purpose, renesas_sdhi_probe() could be called w/ dma_ops
>> = NULL to force the usage of PIO mode. In this case the
>> renesas_sdhi_enable_dma() will not be called before transferring data.
>>
>> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable() call
>> from renesas_sdhi_probe() will configure SDBUF by calling the
>> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
>> tmio_mmc_host_probe() when calling tmio_mmc_reset() though
>> host->reset().
>> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
>>
>> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
>> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
>> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
>>
>> Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
>> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Link:
>> https://lore.kernel.org/r/20240430093724.2692232-1-claudiu.beznea.uj@bp.r
>> enesas.com
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Sorry, I missed this and 5.10.y-cip patch.

No problem!

> 
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you!

> 
> Best regards,
>   Nobuhiro


