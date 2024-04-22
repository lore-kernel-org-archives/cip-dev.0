Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E493C4345F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 05:09:49 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.11301.1713762587817464753
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 22:09:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mmdukvkr;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55bdf477e5so18826966b.3
        for <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 22:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713762586; x=1714367386; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGSBkFZqgVNeSsYybOV2rw+Z3sP+Kihjt/BWq17dOlc=;
        b=mmdukvkr/upaROK6kz8r7g6VzQYrNN+ssJ2swmLLKNKexS2K/zIZJ/R67mRSvLUtDv
         mp+SUbhOMjHBHEJlD7y25yd0LMifVEwBaZ2IIXXxCDu2r5gk62sZMC49x7y1p5Gt/2qD
         vFW1zVPJyyzJzphJ6PHPgD2PJfhDhgeyiokabep9OgwB0gENZNHirzcMl5EdyPtA0arh
         Xm6adX3TowC2L1ENvIaQkBfoJt5t11fi3abHaKheN7gnvaQA5pfUGvgDCFMeYuyJDmeo
         /jkOe39bbxuiaRq+lEH5OnD2PaR0y9gibIsNSdVT80eOm2Sh5h25GnbSq2qs/EAQCS53
         dYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713762586; x=1714367386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGSBkFZqgVNeSsYybOV2rw+Z3sP+Kihjt/BWq17dOlc=;
        b=Ye1BYq21lIbIB6TRfywko11oSAh8JjhhU8bBnT4LFxxvRHxleJWWYeJGEN7HELsYmX
         RgLjH4uaSR16ZO/8eQerS3gJYkd273Eo7qJA8wYc0CQ0YekN/+KVytfZGu2aDfTalBZQ
         Z9h7L1oJzS+qKFZsLuFaInXwmHQv3FpPSnpk5gs7wwTDcRp5BsTohqjliZ8YhthRMrrG
         zJRODB7dIj8e2VPk1XmwNf4wNKVloqpVbuuh6bY2F5AL1zjR29Xu6NFQYULChnEQSM3d
         JFsR3JuAHA9Du4HRf64wK6Y5byC5aSUYMxR4gLMAkF4CbzzvcKdbj483dhK85TpCFfGl
         f9yA==
X-Forwarded-Encrypted: i=1; AJvYcCWC6Dnf4uS2vZdLZKL72VjTAHda7EnNQaVBV/j73TEJE00hVzgzRbPPqXVHDxwFIMJ7Pu+7UduwAAQoLIHAt0rpGOA8IXg0lJTvlCp+/g==
X-Gm-Message-State: AOJu0Ywrr2ueSdG0sEl3YHdSTvTL1kGr4aPOoi+koQpo3EOs3nOwoYDj
	dhej//bGWTzad7MdTXiBRJSwmw4gjn4g2WmZNDVq4JSHGMp/qdN/d6Ofy228EcE=
X-Google-Smtp-Source: AGHT+IFOcft2kt+cyX068kTN4aogD9uTrPxMDR9Wqb3Xf0EQlKcyr5QCxfxzkXOYgK5Sq2sDrHahGA==
X-Received: by 2002:a17:906:830f:b0:a52:3b6a:ab43 with SMTP id j15-20020a170906830f00b00a523b6aab43mr7097635ejx.67.1713762586174;
        Sun, 21 Apr 2024 22:09:46 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id lj26-20020a170906f9da00b00a5254ec731esm5337049ejb.176.2024.04.21.22.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 22:09:45 -0700 (PDT)
Message-ID: <4f276d6d-5f67-485a-9778-c174369923f8@tuxon.dev>
Date: Mon, 22 Apr 2024 08:09:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 37/53] pinctrl: renesas: rzg2l: Add support for
 different DS values on different groups
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
 <20240419081742.3496709-38-claudiu.beznea.uj@bp.renesas.com>
 <ZiUhkX5xyChq0wlL@duo.ucw.cz>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZiUhkX5xyChq0wlL@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Apr 2024 05:09:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15720

Hi, Pavel,

On 21.04.2024 17:24, Pavel Machek wrote:
> Hi!
> 
>> RZ/G3S supports different drive strength values for different power
>> sources and pin groups (A, B, C).  On each group there could be up to 4
>> drive strength values per power source.  Available power sources are
>> 1v8, 2v5, 3v3.  Drive strength values are more fine tuned than what was
>> previously available on the driver thus the necessity of having
>> micro-amp support.  As drive strength and power source values are linked
>> together the hardware setup for these was moved at the end of
>> rzg2l_pinctrl_pinconf_set() to ensure proper validation of the new
>> values.
>>
>> The drive strength values are expected to be initialized though the
>> SoC-specific hardware configuration data structure.
> 
>> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> 
>> +static enum rzg2l_iolh_index rzg2l_ps_to_iolh_idx(u16 ps)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(available_ps); i++) {
>> +		if (available_ps[i] == ps)
>> +			break;
>> +	}
>> +
>> +	/*
>> +	 * We multiply with RZG2L_IOLH_MAX_DS_ENTRIES as we have
>> +	 * RZG2L_IOLH_MAX_DS_ENTRIES DS values per power source
>> +	 */
>> +	return i * RZG2L_IOLH_MAX_DS_ENTRIES;
>> +}
> 
> Is it valid that ps is not in the array and so that i == ARRAY_SIZE(available_ps)?

Not with the current code.

In the current code this function is called at [1] or at [2].

When called at [1] the power source is previously validated with
rzg2l_get_power_source() (defined at [3]) which returns a value from
available_ps[] or -EINVAL. If -EINVAL is returned the
rzg2l_ps_to_iolh_idx() is not called anymore.

When called at [2] it is called with settings.power_source as argument.
This argument is either validated at [4] or used a previous validated and
valid value set at [5].

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/renesas/pinctrl-rzg2l.c#L927
[2]
https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/renesas/pinctrl-rzg2l.c#L1069
[3]
https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/renesas/pinctrl-rzg2l.c#L626
[4]
https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/renesas/pinctrl-rzg2l.c#L1054
[5]
https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/renesas/pinctrl-rzg2l.c#L961

> 
>> +static u16 rzg2l_iolh_val_to_ua(const struct rzg2l_hwcfg *hwcfg, u32 caps, u8 val)
>> +{
>> +	if (caps & PIN_CFG_IOLH_A)
>> +		return hwcfg->iolh_groupa_ua[val];
>> +
>> +	if (caps & PIN_CFG_IOLH_B)
>> +		return hwcfg->iolh_groupb_ua[val];
>> +
>> +	if (caps & PIN_CFG_IOLH_C)
>> +		return hwcfg->iolh_groupc_ua[val];
>> +
>> +	/* Should not happen. */
>> +	return 0;
> 
> I'd expect WARN or pr* or return -EINVAL here.

I kept it as is to have a valid unsigned returned value. And it really
cannot happen with the current code flow as the caps is previously
validated against PIN_CFG_IOLH_A, PIN_CFG_IOLH_B, PIN_CFG_IOLH_C here:

https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/renesas/pinctrl-rzg2l.c#L920

> 
>> +static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl *pctrl, u32 caps,
>> +				  enum rzg2l_iolh_index iolh_idx,
>> +				  u16 ds)
>> +{
>> +	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
>> +	const u16 *array = NULL;
>> +	unsigned int i;
>> +
>> +	if (caps & PIN_CFG_IOLH_A)
>> +		array = hwcfg->iolh_groupa_ua;
>> +
>> +	if (caps & PIN_CFG_IOLH_B)
>> +		array = hwcfg->iolh_groupb_ua;
>> +
>> +	if (caps & PIN_CFG_IOLH_C)
>> +		array = hwcfg->iolh_groupc_ua;
>> +
>> +	/* Should not happen. */
>> +	if (!array)
>> +		return false;
> 
> I'd expect WARN or pr* or return -EINVAL here.

I kept it as is to align with the return type of rzg2l_ds_is_supported().
In case this function returns false the calling function will return
-EINVAL:
https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/renesas/pinctrl-rzg2l.c#L1073


> 
> 
>>  		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
>> +		/*
>> +		 * Drive strenght mA is supported only by group A and only
>> +		 * for 3V3 port source.
>> +		 */
> 
> Typo "strenght".

Noted!

Thank you for your review,
Claudiu Beznea

> 
> Best regards,
> 								Pavel

