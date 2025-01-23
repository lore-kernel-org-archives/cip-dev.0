Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4067BC02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 07:47:29 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web11.6441.1737618447762640596
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 23:47:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=htRP7Bpi;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dbfab8a2b0so1175514a12.3
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 23:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737618445; x=1738223245; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FwGOxjO4TorDtDSj3tDd69FRNj9GePriZ646AEdHRjY=;
        b=htRP7BpiD2BKsmMr+Y7JG4RX5vCr83/BY71SW1dAabtEqusoWycMnEMlQxSyFMk39S
         j3yQOJU73pnKXKY/feQRKeRcfO4VaQ3V8yu/7OCWqHf0QT/6nkraTj2GY7jFyh4sqCY/
         AuesPJX2CidSfM4i5WID0sxMmY0+J+9+fpV9OYRfdZ4K5lyKWaAGJMH4I7YR7UhjMM3N
         VrZRQK/fHpc/VRxR1ozMCrS2rAUDIh6oMOMhayT4g8Ooy5q8R/3E3nS4dTOyBxHtHgvm
         Qbv3tnZ1bPAjpiBjl+k71ksK8yEvoIW+Fy1C7Cw9cXkAG0VntzqDrKovRFkNsMNII0/+
         1taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737618445; x=1738223245;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwGOxjO4TorDtDSj3tDd69FRNj9GePriZ646AEdHRjY=;
        b=Gp/0+XGIAaFrhl0FBJBcinWH4KVkBqiUtkZzQ2jlGoL89oFOgXDnOrGcVHoeliq3B1
         1nAayxHyMErfHTUdaUoQQFlM7WOs+m6dAFkRSw0CVPiXHF8DPzxJe90lZeIpB44+2XZ4
         f6pRLhGMxsLL1DLWZNs7XKF/B5eHD2Q5r8xeJCbKlYWMoYYiAeTX2TAzmi7tWw2VsMd3
         7soeh+lU4aKZlQqiaw4MzMcKecfao/HBU9tqE4+qtFSqZNckTVhHqP91bqzJOkfrydqx
         BqH+ONQjzzkgJpl1lrJ806oHE9C4jKcdMxRr3YNzNB3GaAftMAOR2LGqTQoBG41/qQiq
         FIGg==
X-Gm-Message-State: AOJu0YyfCe25FSeFix8EqScOjvZ0sFdsa1wojLrGmLhjewquAua5xwg7
	Dh2K+2qA0pnPHWGTbfWsTKU+hWvUqzXy2flhXNaHZrt7+TX7HwrgbVx12FBDWQKAcEs7MkALpql
	n
X-Gm-Gg: ASbGnctd8YYxEUHQ3xr5LRem/anTxlDNK4W58CigsVBY3NdAwdbu2o51OUDtHZfX52W
	nY9Vohoyj9YymepBAqt7wZyZMgjamKu5JjcYSVQgdaA7ejZDmw1JnUAE+BoCWUn6W1EUSDdRUD2
	6+E5+psK2a17wD4d4jJ2jOU/lOPwfGlCfO94HDTMRzT26/04iyWAHL3rC01f6nX5DXwNaGUxLoN
	rW5LI3wAmgcoZplgsPjvkjen0+LsYq6X2/80AeqvvPJ1MrYOOq0+YULkj3+MnmAv61WsVo8vSUX
	GLEA4pGH/FQn
X-Google-Smtp-Source: AGHT+IH/YR+Y1kNlvHv+/MPuaclwJir8IYMeQVFD4oMhjQUcBupbcrTOqE/slcz8Y7rTn6Tsne2oRQ==
X-Received: by 2002:a17:907:7256:b0:aae:85b4:a07 with SMTP id a640c23a62f3a-ab38b19146dmr2124893266b.8.1737618445266;
        Wed, 22 Jan 2025 23:47:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f2903esm1028006266b.109.2025.01.22.23.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 23:47:24 -0800 (PST)
Message-ID: <00ac7a78-c715-4027-864f-15433cafa129@tuxon.dev>
Date: Thu, 23 Jan 2025 09:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH v6.1.y-cip 01/14] clk: Add Sunplus SP7021 clock
 driver
To: cip-dev@lists.cip-project.org, pavel@denx.de
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
 <20250122115120.2885015-2-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB6388CDA2AEED05007496E31892E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <OS0PR01MB6388CDA2AEED05007496E31892E02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 07:47:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17605

Hi, Nobuhiro,

On 23.01.2025 07:38, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
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
>> Subject: [PATCH v6.1.y-cip 01/14] clk: Add Sunplus SP7021 clock driver
>>
>> From: Qin Jian <qinjian@cqplus1.com>
>>
>> commit d54c1fd4a51e8fbc7f9da86b0cd338a4f7cd2bb2 upstream.
>>
>> Add clock driver for Sunplus SP7021 SoC.
>>
>> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
>> Link:
>> https://lore.kernel.org/r/20221219015130.42621-1-qinjian@cqplus1.com
>> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>> [claudiu.beznea: kept only the code from include/linux/clk-provider.h]
> 
> I understand that the SP7021 driver itself is unrelated to Renesas SoCs or this patch series.
> However, would you consider applying the patch as is without deleting the driver?

Sure!

> 
> From what I've checked, there seems to be no problem with building the driver.
> However, there are several fixes available upstream, so you should consider applying these.

Ok, I'll keep the full content of this patch (in the next version) and
along with it backport the fixes. Is it OK if I'll do it in the same series
with the RTC support for the Renesas RZ/G3S SoC?

Thank you,
Claudiu

> 
> As I've recorded here, the patch subject content and the commit content barely match. I think
> it's better to keep the modifications required to backport the patch to a minimum.
> 
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  include/linux/clk-provider.h | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h index
>> d2c799595d5e..53dd7c9dcc94 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -606,6 +606,25 @@ struct clk *clk_register_gate(struct device *dev, const
>> char *name,
>>  	__devm_clk_hw_register_gate((dev), NULL, (name), (parent_name),
>> NULL, \
>>  			       NULL, (flags), (reg), (bit_idx),
>> \
>>  			       (clk_gate_flags), (lock))
>> +/**
>> + * devm_clk_hw_register_gate_parent_data - register a gate clock with
>> +the
>> + * clock framework
>> + * @dev: device that is registering this clock
>> + * @name: name of this clock
>> + * @parent_data: parent clk data
>> + * @flags: framework-specific flags for this clock
>> + * @reg: register address to control gating of this clock
>> + * @bit_idx: which bit in the register controls gating of this clock
>> + * @clk_gate_flags: gate-specific flags for this clock
>> + * @lock: shared register lock for this clock  */ #define
>> +devm_clk_hw_register_gate_parent_data(dev, name, parent_data, flags,  \
>> +					      reg, bit_idx, clk_gate_flags,
>> \
>> +					      lock)
>> \
>> +	__devm_clk_hw_register_gate((dev), NULL, (name), NULL, NULL,
>> 	      \
>> +				    (parent_data), (flags), (reg), (bit_idx), \
>> +				    (clk_gate_flags), (lock))
>> +
>>  void clk_unregister_gate(struct clk *clk);  void
>> clk_hw_unregister_gate(struct clk_hw *hw);  int clk_gate_is_enabled(struct
>> clk_hw *hw);
>> --
>> 2.43.0
> 
> Best regards,
>   Nobuhiro
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17601): https://lists.cip-project.org/g/cip-dev/message/17601
> Mute This Topic: https://lists.cip-project.org/mt/110751143/8377987
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/13165139/8377987/1773116124/xyzzy [claudiu.beznea@tuxon.dev]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


