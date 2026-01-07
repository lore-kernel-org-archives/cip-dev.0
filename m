Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE33CF6BEC
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 12:22:05 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4497.1767788515541154909
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 04:21:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Mcj9IoKN;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so16960285e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 04:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767788513; x=1768393313; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9KcKzWWk+FYpYcESsWrkK3ZN6OAJgrAgHCLT2SD3SQ=;
        b=Mcj9IoKNNt8tEz3isCokEfvU9Z5Sf4THXKelDZKmxdGiZB40SLHBDEa08k2Cc/vdW0
         kdaRVBlxEw7Ok/JV29t17KzXXZ0vAdXUcsACZ0qac+2ULqC5pBqg7kIOohcZw88JL1BR
         7YL8Ly7kMY2xzI+dIwJNPBAhWbgrTMeYB7Nqqj8q5I+kWJv81TW4JI6VryATYsOi7yBW
         VVYqQWaFU+VPb28JlX0R4Tj3q/T3WehNKSpRQWUuhO0USdo3do3KO/gg9Cz48lhli1nG
         OB4kZgTLxxgyn32gPjZYztTfVUT2/SFw/nfzfWjC8QPDA4ItnoS9lE05lUYKN0IsIrnz
         +UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788513; x=1768393313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9KcKzWWk+FYpYcESsWrkK3ZN6OAJgrAgHCLT2SD3SQ=;
        b=tin7DQ0fQq0/fXbL9Ijq6OuCZp4FKagd7iR+XC6IwZCrJ5O4mqriISK8cU0uMyp6SB
         mU8JtDAcQKbe/NFPHh1ogrb6QLVcy2vpstUy+A2oKRxJjQbGyPEBZJIrzNqVFzmoCQ60
         QYK1aPNC6L5K6I0r+KM1F7ONxJYgJVsu5sFr245EXnVcoHf4u2ymJ5YDpXbQEFcLB15q
         /Y+LWK2QxbZt9of7xmP3gXiEyOP6BvzaQfSvmQ50CJWcXd1FONx0dArB45qZ9svgoSIu
         8vyXkth+AF1W8FsSk1QbnN57kY0ntKAlKsD+SqifgtegY5Bk2tB22cKWLpMpyQZqzjAN
         /Chw==
X-Forwarded-Encrypted: i=1; AJvYcCWhPIotxRUPYBi23Ct5DjFJR8Lxasi6emHF4tViHKT2tpyl0okm89uD0nlZmatGMbdnI/mAXZbr@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx+LZCcsvbYRb/GyDc2m6dv9lLipH71BgWt+C/iavP0qAmg6hzi
	tX8P7/Uijm1+dYYEDvrYmKDHmjuW8K1bpkX5M9+Jpp0Ah9Yxk0EXK1ARBxoEveHTwy0=
X-Gm-Gg: AY/fxX526WbUpYzcn7MFsHsEGW9Aa/h7jFvmi6cr/1BnH3vsXpAque9efAuBUBXc3XR
	mcGf5u2BfsCm0Xa/t34gAh7cx2wSS9j/SwCQaOrVO1hgYpUZ46KfZllw6MKaKvLmS5+f6+Buray
	xPQfK/8az8ybCGlOSji8/X3hooo9Yks0FSV6qseRUmUXefy5UTmV/ACy+9pEfH0tp87GDsD82aQ
	+rPwcvQ5Z4G43C9Q9d6+5huSyAMLEIu02a6Wj8uvWQMJ+wJrXQgsIPaVP4c9bzd28Hm5VpLIDKU
	BhiJ3uwri4P2X9q9yXxOFro7P2lwLV0rPQhxpstkQoqdMYOlOFjOKzji+PduC5HWTYCni1aVD+7
	3CYIXl04JBxahTQFGw62R8XzOWk6iQWxfW8zEq0SzhO1hokntpTYA1pwgCzFNGpBhi6HAEr/O6X
	F+nyUXg1P5HmqqcGktwA==
X-Google-Smtp-Source: AGHT+IFXWsNwNqyPYC0qW/XnO/o1EO3q2zNhZO4LptLEJvPk3fT+iZvF7lgXwpP07bvFqzM/faH3Ow==
X-Received: by 2002:a05:600c:8484:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-47d84b1a095mr24141425e9.14.1767788513384;
        Wed, 07 Jan 2026 04:21:53 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f668e03sm98081965e9.14.2026.01.07.04.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 04:21:52 -0800 (PST)
Message-ID: <dec35e63-55cf-46d6-a69c-894f460ea7a1@tuxon.dev>
Date: Wed, 7 Jan 2026 14:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y-cip 3/6] thermal/drivers/renesas/rzg3s: Add thermal
 driver for the Renesas RZ/G3S SoC
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
 <20251217103222.4183089-4-claudiu.beznea.uj@bp.renesas.com>
 <aVLi32qigJKR3NcP@duo.ucw.cz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aVLi32qigJKR3NcP@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 12:22:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21402

Hi, Pavel,

Sorry for the late reply, I was off for a while.

On 12/29/25 22:21, Pavel Machek wrote:
> Hi!
> 
> I have some comments below.
> 
>> index 000000000000..d184dccc882f
>> --- /dev/null
>> +++ b/drivers/thermal/renesas/rzg3s_thermal.c
>> +static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>> +{
>> +	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
>> +	int ts_code_ave = 0;
>> +
>> +	if (priv->mode != THERMAL_DEVICE_ENABLED)
>> +		return -EAGAIN;
> 
> I'm pretty sure -EAGAIN is wrong error code here. -EBUSY or something?

-EAGAIN is something that the thermal core expects here in case the 
temperature reading is failing:

https://elixir.bootlin.com/linux/v6.18.3/source/drivers/thermal/thermal_core.c#L319

https://elixir.bootlin.com/linux/v6.18.3/source/drivers/thermal/thermal_sysfs.c#L46


> 
>> +	/*
>> +	 * According to the HW manual (Rev.1.10, section 40.4.4 Procedure for Measuring the
>> +	 * Temperature) the computation formula is as follows:
>> +	 *
>> +	 * Tj = (ts_code_ave - priv->calib1) * 165 / (priv->calib0 - priv->calib1) - 40
>> +	 *
>> +	 * Convert everything to milli Celsius before applying the formula to avoid
>> +	 * losing precision.
>> +	 */
>> +
>> +	*temp = div_s64((s64)(ts_code_ave - MCELSIUS(priv->calib1)) * MCELSIUS(165),
>> +			MCELSIUS(priv->calib0 - priv->calib1)) - MCELSIUS(40);
>> +
>> +	/* Report it in milli degrees Celsius and round it up to 0.5 degrees Celsius. */
>> +	*temp = roundup(*temp, 500);
> 
> If we did the computation in high precision, and interface wants
> millicelsius, is rounding good idea?

If I remember correctly, not adjusting the above code for precision lead 
to temperature variation at degree level not be detected. I chose to 
round it to 0.5 milli degrees to follow similar Renesas thermal drivers.

> 
>> +static void rzg3s_thermal_set_mode(struct rzg3s_thermal_priv *priv,
>> +				   enum thermal_device_mode mode)
>> +{
>> +	struct device *dev = priv->dev;
>> +	int ret;
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret)
>> +		return;
> 
> Now caller does not know if we failed or not. Should this return errno?

Yes, this one could be improved to return the error code.

Thank you,
Claudiu

