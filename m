Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE748C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 12:31:00 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.9383.1737635454264880072
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 04:30:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qURI1+7S;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso156129666b.2
        for <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 04:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737635452; x=1738240252; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3d+/dP5RmuwIc54zGizhtLoPhCjHX3zOBiCt64Zw+C8=;
        b=qURI1+7S/vbuYTNoOdydUYlDjDNdB+M+Z2oPTIZ042DrC4RGdQ6UdeMt0CFyTSIMzk
         wWWeLivdMhmg1Fql1jHQkJCCnflid8MiXZLin2Qc8ruhHl3gdx6kNuFQJelbs7aOQw1E
         B6yrxCLWofGwoz8tq5HRs4tS5ezvenZog1D5lOIFKGu2JP0z0u4+0HwjnE7MYYXxeczO
         /zeFaSA4eX8pWNZn3tNfp/agn0MCS/4owAvGY0VJfJAMICMP+OqOCO/y6sVfrQJRzt9j
         IgzFhdMXbmcLa78adxHbEMJcaZW2Qs+5dpCModYc7H6V2WuyG9t9zI4VUnAcIfMBtJQz
         gQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737635452; x=1738240252;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3d+/dP5RmuwIc54zGizhtLoPhCjHX3zOBiCt64Zw+C8=;
        b=KXwF1Ri0qJESxhhbJGTi2HQePakq08MmfoNO+iEkZ/4Cc/14xM6WB8uadTpknz/h9n
         c4bMK+BMmAGjhmlZY46J2xQIhZv+5n67dDAi+Ygy1bcR5nrRtoGc376rgyRRT7V4SN+F
         j2Jem18FFcpQPgJPTvYqomMdf/IYTjjD+R7sRy58P0oA8it/NhahIjVMm0bmzAk7QNd8
         mCbUM9iSamwt+tKtlSuv43STsuVyNgzHPxb0xS97YhTQHGgbUVElrVlRrj2pon18oxfs
         Bq37qo27MHB4ZtxKTFHc1i/kTCMHJVvkoLjxHK3wT9QpJHaoduCb/1NmnINX9vNi+xf9
         yipw==
X-Gm-Message-State: AOJu0YzC6CwAsO0v2LLCz+AxxF3iUlSv4f+vPFAayxwVLguOzIhepzZR
	q9jqFgXAM44P/ipXC5EAJbsirYC1ZvL+IJHMCJQtpQP0UX8KkkeAz8WiEDGzOEiwqFPv5yGGCs4
	n
X-Gm-Gg: ASbGncuwTzXhWWfCOrd00ryiqgchTB1nN26b0O5wmVh0Kntqr7OZ6f02q9W+1k/LvGZ
	EFd+fwYILDDcAqDnCZQ6kHX5lzIfy9iq21PX0JdQpU9bApiMFe5y4oIHiv5QfAxD7T0A2ER1YnJ
	pPPfwpGNtBCaS8bIavK0AXo5sKxopXoACSVBhMcQicgOPJLAAo+1Ln0FL/qisAY4yC6xC88jNXI
	YuFl9n0Q0nXrv/8gS47jtSbsqwIgMaXyydU1IV6rrjVir1fFKsLGUTwq8JlAHpFPPMeYR+R2pV7
	Abcv7iwvYRgS
X-Google-Smtp-Source: AGHT+IE5mvRUp7lqQaKUE6ei4QTqpTtGn4YJVvv4C3TE8ZPOSYDBXi5nW420PAQ+ZUS6mBkGDsZlvA==
X-Received: by 2002:a17:907:3e1f:b0:aaf:117c:e929 with SMTP id a640c23a62f3a-ab38b51c914mr2539087466b.57.1737635452339;
        Thu, 23 Jan 2025 04:30:52 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce109asm1071104866b.51.2025.01.23.04.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 04:30:51 -0800 (PST)
Message-ID: <9a4bf2e6-2b5c-4e33-b8b7-98756f544895@tuxon.dev>
Date: Thu, 23 Jan 2025 14:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH v6.1.y-cip 00/14] renesas: rzg3s: backport the
 RTC support
To: cip-dev@lists.cip-project.org, pavel@denx.de
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB6388E136F89EFE42C5D4D43C92E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <OS0PR01MB6388E136F89EFE42C5D4D43C92E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 12:31:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17608

Hi, Nobuhiro,

On 23.01.2025 07:44, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi Claudiu,
> 
> Thanks for your patch.
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Wednesday, January 22, 2025 8:51 PM
>> To: iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○ＯＳＴ)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
>> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
>> Subject: [PATCH v6.1.y-cip 00/14] renesas: rzg3s: backport the RTC support
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hi,
>>
>> Series backports the RTC support for the Renesas RZ/G3S SoC.
>> Along with a clock driver for the clock provided the VBATTB is included as this
>> is critical for the RTC to work, as it feeds the RTC counter.
>>
>> For the VBATTB clock driver the following patches were also
>> backported:
>> - clk: Add Sunplus SP7021 clock driver
>> - clk: fixed-factor: add fwname-based constructor functions
>>
>> and adjusted accordingly, if needed.
>>
>> Thank you,
>> Claudiu Beznea
>>
>> Claudiu Beznea (12):
>>   clk: Add devm_clk_hw_register_gate_parent_hw()
>>   clk: renesas: r9a08g045: Add clock, reset and power domain support for
>>     the VBATTB IP
>>   dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
>>   clk: renesas: vbattb: Add VBATTB clock driver
>>   dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
>>   rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S
>>     SoC
>>   rtc: renesas-rtca3: Fix compilation error on RISC-V
>>   arm64: dts: renesas: r9a08g045: Add VBATTB node
>>   arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
>>   arm64: dts: renesas: r9a08g045: Add RTC node
>>   arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
>>   arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3
>>
>> Qin Jian (1):
>>   clk: Add Sunplus SP7021 clock driver
>>
>> Théo Lebrun (1):
>>   clk: fixed-factor: add fwname-based constructor functions
>>
> 
> I reviewed this and for 5.10.y-cip series, LGTM.
> But regarding "clk: Add Sunplus SP7021 clock driver", as I commented, I think we should consider it.

For v5.10.y-cip only: this driver is selected by ARM/SUNPLUS SP7021 SOC.
There is no SUNPLUS SP7021 SoC support in v5.10. With this, do you want me
to backport the full patch (along with the fixes you mentioned) as well?

Thank you,
Claudiu

> 
> Test:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commits/ci/iwamatsu/linux-6.1.y-cip-rc
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commits/ci/iwamatsu/linux-5.10.y-cip-rc
> 
> Best regards,
>   Nobuhiro
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17602): https://lists.cip-project.org/g/cip-dev/message/17602
> Mute This Topic: https://lists.cip-project.org/mt/110751142/8377987
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/13165139/8377987/1773116124/xyzzy [claudiu.beznea@tuxon.dev]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


