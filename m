Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FA8E8FDB1
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 13:21:02 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43057.1767014457200855546
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 05:20:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Vu7wI3O8;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b61f82b5fso12028173a12.0
        for <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 05:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767014455; x=1767619255; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5zwxS76itjaOAkPVyJ1WWGQKfttX25FdtESAR9L+e4=;
        b=Vu7wI3O8NsJBP+mTqgWFH3AG3a8Pf57Ag6rgRLS/At7ZMjMPMHAJ8r+T3nojtbRPI5
         tByk0h2dbmxknqIAdLqs2rH88NfQSLWgaZHTz4rQkmqx5TdlUupmdnbF0JYKSsMDkx90
         I99kxl1qAfFpLBIiaU82CWyyNkGDWRNUBehrWkpssVPNATfTAMMIExkf6q2NsHPWsq+/
         rQUlP5AflVSTAjSgoCCxiZyukqcblo/lbJHshU1OrFQIkTDlF7w5OBH4tWVBW1ROCco/
         83aSP+BKPEaCRYvlsoVOjIk7KjB3AyLTBbJ/So+js1HdbKtW9kaZQVHswF2aE4kOGlbr
         ZDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767014455; x=1767619255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5zwxS76itjaOAkPVyJ1WWGQKfttX25FdtESAR9L+e4=;
        b=rNWZKh7b1ZiQ7dBKKkevZVreiZGR+sr6mwsZOwlDN5HFa/9Pz8412eSKoL/k3oKdiH
         lWrs/2CH4QI+u9KhyKr6YE2vSpN+Avocb2CfSin2CnPB16xyx7+K3bf7VsBlG1VQttEn
         Ctf1ILNXLihZVAIlCdpp0Q0yY8i+Hl9WkN/otwBBb9HspRCBxYIk23ApI2YNHzv9qUH8
         GMX2jejkFrtiSLo0tSAGryIJC3W4vzi1v3dHv9+e0q9IdH0Ljq/LvNrL7Fk+8jZ0nVp+
         C8P2elklcBrBafOIRWFFu9COTrXgMsxFk6QZtBrQYRrXvSPkXo1cWzDJGRaJY+AoJ8Om
         6kUQ==
X-Gm-Message-State: AOJu0YzTD2D5YLIB0CxSqXmn8BVEQnMwgU8fI9iopvWzDKedHhAk/A1F
	pYOl8k3xF3tpqEVZ/JKJMttw0ufu8KvdwEvY/FGgG7ziUWbG1vXT8ZL/OY+MzGZ4WbM=
X-Gm-Gg: AY/fxX5sWox0cwmRFdBIG3NPJbbszF3XFNbwMMp5sRKv1TZO6J5PX9gioGGVk/RmVNJ
	8C1jLzQ2ySkScpmX2sx4iwyE+5U/iArrWzzqHp7yAbxJd55SBq2EA5gr4VAbw5jMAFShLSkfjrP
	db/nXrrCVRdntgDQv48B/cwyhfyIIlH2DSHmbGo1xkv4dHKB3JKzTxZOM0bpQCPEFmDhh+utF9a
	AuV0oKaapp9ERaTO7Xaq8XXEn4HNcqMAcH2vhc0K+exGcB+j9KZNmzkCSWKht82kVGeQCUoTPaM
	9AFu5AUKlQRI1ojAIa30HXRX5O9f3ckOFHkUqSxGVI9WDzGd6lfMG8bFPnyYeTgmoGbuHwBh/bM
	/ERUIpjLTb5xPmaKz/JL12PcofLa9JkuvBwu8xAlHecLnVZidA3g4yQAFOXVWbfNbjgrt0USIUy
	qPSGyzfhhb1odZfaH3YQ==
X-Google-Smtp-Source: AGHT+IFhdZDV8E5t+RMX0UAvru/tfV8p41PEIF7LF0FLfh+2XOQEAPYTHFkqOAQySwbGz1O6rRefYw==
X-Received: by 2002:a17:907:3f89:b0:b72:134a:48c8 with SMTP id a640c23a62f3a-b8036f63805mr3300742366b.14.1767014454553;
        Mon, 29 Dec 2025 05:20:54 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5c4dfsm3314410966b.14.2025.12.29.05.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 05:20:54 -0800 (PST)
Message-ID: <535bd4f4-117b-475a-b616-2262c2247152@tuxon.dev>
Date: Mon, 29 Dec 2025 15:20:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/6] RZ/G3S: Backport TSU support
To: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@denx.de
Cc: cip-dev@lists.cip-project.org
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818367AD749019DCAAF7364CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY7PR01MB14818367AD749019DCAAF7364CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 13:21:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21249

Hi, Nobuhiro,

On 12/25/25 04:13, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi all,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Wednesday, December 17, 2025 7:32 PM
>> To: pavel@denx.de; iwamatsu nobuhiro(岩松 信洋 □ＤＩＴＣ○ＣＰＴ)
>> <nobuhiro.iwamatsu.x90@mail.toshiba>
>> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
>> Subject: [PATCH 6.12.y-cip 0/6] RZ/G3S: Backport TSU support
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hi,
>>
>> Series backports the TSU (Thermal Sensor Unit) support for RZ/G3S.
>>
>> Thank you,
>> Claudiu
>>
>> Claudiu Beznea (6):
>>    clk: renesas: r9a08g045: Add clocks, resets and power domain support
>>      for the TSU IP
>>    dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
>>    thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas
>>      RZ/G3S SoC
>>    arm64: dts: renesas: r9a08g045: Add OPP table
>>    arm64: dts: renesas: r9a08g045: Add TSU node
>>    arm64: defconfig: Enable Renesas RZ/G3S thermal driver
>>
>>   .../thermal/renesas,r9a08g045-tsu.yaml        |  93 ++++++
>>   MAINTAINERS                                   |   7 +
>>   arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  77 ++++-
>>   .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 -
>>   arch/arm64/configs/defconfig                  |   1 +
>>   drivers/clk/renesas/r9a08g045-cpg.c           |   5 +
>>   drivers/thermal/renesas/Kconfig               |   8 +
>>   drivers/thermal/renesas/Makefile              |   1 +
>>   drivers/thermal/renesas/rzg3s_thermal.c       | 274
>> ++++++++++++++++++
>>   9 files changed, 465 insertions(+), 5 deletions(-)  create mode 100644
>> Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
>>   create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c
>>
> 
> I reviewed this series for each branches, looks good to me.
> I can apply this if testing is no issue and there are no other comments.
>    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232119913
>    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232120629
>    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232120713

I see there are some failures among these pipelines. I see bootloader 
issues and console logging kind of failures. Are these related to this 
series and v5.10, v6.1 ones?

Thank you,
Claudiu

