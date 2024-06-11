Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F491C25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 13:16:37 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.9310.1718111794889741141
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jun 2024 06:16:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Y0Gmh7L3;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f123bf735so752443f8f.1
        for <cip-dev@lists.cip-project.org>; Tue, 11 Jun 2024 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718111793; x=1718716593; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMbx8j23qCFqjaOu+Ri0gWhxkcKEfApuKubHzM4IdK0=;
        b=Y0Gmh7L3vFmG7BJTz8CkfONH0eNAFNpVq6+9NlUDu/qiCfX4NQ+2ESDhyqzUIbHh+r
         Puu7afYQbRbHJomWQW0iLmLHeL0fnXKd7TKRSmMe3YpxjOwGJf1tD9GCb9Vzifwjx0w5
         yAUxOqybVdxUDMOe2s5u1UiwQVUC/u1MQwciUcPywKaN2oyva+sV0oQpwp4nC1p/3pGH
         1gA38SPBNbo6wQzTd/Z4z8N235HUzxcEXUXfavykzgxfTg4ZW7GEurHfGbNfZo1CD5ET
         2utshQ/Lj9s2DWE/LE8a/bUt7+s7hVf1ZLGJ3gtxMDiTDQfleUs/gXqP2lkIFy3xM+kv
         OGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111793; x=1718716593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMbx8j23qCFqjaOu+Ri0gWhxkcKEfApuKubHzM4IdK0=;
        b=wEii+D/7lMxqWcBIV5sYg3xwXsmVh+EccmdWRpsSJ6F6btusQ0IX4PSVhJiKw7V6Kb
         o03j5v81/NebqsXevg3slSFucDZVr7BHbLq7w100rxG3zsb2XVTetAXoN/gNuA9If8q3
         pXFsCYCV7SNqFWotSH47Bqxve33Sijjwys8BWGXbhKqR75gN9zblpUU6sZAyak0065vI
         wSAHbyDaGRMKTtsLMQ/PIf2Qk90sg2BsmaY8L59TuDfIIxN8ZUlp/8syKyswj+40nb44
         p6ecMClSVCl+nsJMVZ8KWn46Flp5/1NuoZqELi1p7wdwtcw0A88FQoKUcMW9n7SMoq08
         Ca6g==
X-Forwarded-Encrypted: i=1; AJvYcCWUOV9rIjgW30rmtwSSrAbnpTu6DyOWGnkFkX4RY9gjmlyGKdE7qq2LagMmOy1LXrYwSuFn4U0kzEj8+VQbu7ARUIGywa4L3W2pQoMVdQ==
X-Gm-Message-State: AOJu0YwRB9k2Cn6dl7ueMcrIIJxJnqBJPYr5Gf+TPB51QvkTZ8LQL+tM
	akCzkHdhpdhW9LV2TufBXOORJmb8F7UatdnlA9OE/MHgwRVy60B+YfZK0fcFTAw=
X-Google-Smtp-Source: AGHT+IGgEJnr2suX+Ud/jI6hb5ywxvWDosTazlLnXUHc8Lwjb3rrywve8FQJ0eXRiAH3exAh0Tl1RQ==
X-Received: by 2002:a5d:5249:0:b0:35f:2b1d:430 with SMTP id ffacd0b85a97d-35f2b1d0483mr2201659f8f.53.1718111793282;
        Tue, 11 Jun 2024 06:16:33 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f19db5decsm8608407f8f.55.2024.06.11.06.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 06:16:32 -0700 (PDT)
Message-ID: <c60e08d2-4673-4b08-9ad4-302c24e6fc8a@tuxon.dev>
Date: Tue, 11 Jun 2024 16:16:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y-cip 09/17] pinctrl: renesas: rzg2l: Add
 suspend/resume support
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
 <20240607140856.2497508-10-claudiu.beznea.uj@bp.renesas.com>
 <ZmdtvDPD3l+6bhj4@duo.ucw.cz>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZmdtvDPD3l+6bhj4@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jun 2024 13:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16192

Hi, Pavel,

On 11.06.2024 00:18, Pavel Machek wrote:
> Hi!
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
> 
>> Because interrupt signals are routed to IA55 interrupt controller and
>> IA55 interrupt controller resumes before pin controller, patch restores
>> also the configured interrupts just after pin settings are restored to
>> avoid invalid interrupts while resuming.
> 
>> +static int rzg2l_gpio_irq_set_wake(struct irq_data *data, unsigned int on)
>> +{
> ...
>> +	if (on)
>> +		atomic_inc(&pctrl->wakeup_path);
>> +	else
>> +		atomic_dec(&pctrl->wakeup_path);
>> +
> 
> Would it make sense to use refcount_t here for greater robustness?

I think it may be changed, with a bit of logic change as well around the
new refcount (on suspend path and on inc/dec path), as I see there are
warnings around refcount_inc()/refcount_dec() when refcount reaches 0/1

I'll investigate it.


> 
>> @@ -240,6 +267,32 @@ struct rzg2l_pinctrl_pin_settings {
>>  	u16 drive_strength_ua;
>>  };
>>  
>> +/**
>> + * struct rzg2l_pinctrl_reg_cache - register cache structure (to be used in suspend/resume)
>> + * @p: P registers cache
>> + * @pm: PM registers cache
>> + * @pmc: PMC registers cache
>> + * @pfc: PFC registers cache
>> + * @iolh: IOLH registers cache
>> + * @ien: IEN registers cache
>> + * @sd_ch: SD_CH registers cache
>> + * @eth_poc: ET_POC registers cache
>> + * @eth_mode: ETH_MODE register cache
>> + * @qspi: QSPI registers cache
>> + */
>> +struct rzg2l_pinctrl_reg_cache {
>> +	u8	*p;
>> +	u16	*pm;
>> +	u8	*pmc;
> 
> Ok, so this is ... quite interesting. I guess you can't use generic
> reg_cache for this?

Driver is not using regmap. AFAIK, regcache works with a regmap. Also,
there are different steps (imposed by HW manual) that need to be followed
when applying values to various registers.

> I also guess nports is usually high enough that
> this is not wasting too much space? 

nports corresponds with the number of ports that each platform has. As the
driver is used by various SoCs each with its own number of ports. This is
the place where the nport is computed:
https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/renesas/pinctrl-rzg2l.c#L2135

> I'd expect to have struct with
> just the values, and then have nports-sized array of those structures.

It has been dynamically allocated as each pinctrl IP that this driver is
working with have different number of pins.

Thank you,
Claudiu Beznea

> 
> Thanks and best regards,
> 								Pavel

