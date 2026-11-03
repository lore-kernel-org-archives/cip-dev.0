Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10469.1793710460807417510
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2026 04:54:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KIeofMoX;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e10a70540so2347832f8f.1
        for <cip-dev@lists.cip-project.org>; Tue, 03 Nov 2026 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793710459; x=1794315259; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+s9RgHW86aPZH4cNGnQ6uR2ZwV1QElnDNVUTDmWNpo=;
        b=KIeofMoX7ZzfalI3il9O5Pv0swkFpSHr1RF9Ba21onuNV6l40Ca8ZvOW2PGY5lx4VD
         G0SIRmnEA08g2PiTYPVp9qZMA2kj65VhdMlI+khRyDKCK5I6KZwG7LG0doDhxMLAb7P+
         60HRYJ9B8WNGs7C5dAjqu07ax98V16/LmRTafpyktGFrbIU+JaKELI+9mlMLN+xzGiy7
         JC7kXpZexypDicAthNkS4xV6c5ytPiKP2Zo9UYi2jv58xhD9FKnBI2w5cRW7m0S6TteD
         0pQmI/c3H8y6VTclhW+N6zvbIKMh9aPeiXIjBwEUv1oem6VEqD+m76QDbKf6ouT1bcY7
         Dh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710459; x=1794315259;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C+s9RgHW86aPZH4cNGnQ6uR2ZwV1QElnDNVUTDmWNpo=;
        b=mRNyliWbR7/hiKHFf44e5wFpcFqZgCXXInIFMH7SR6FW+skBtHod67psb1OhnRZFAZ
         kOqLk/uJyTBso3Jf3gC72ftsCeP0cds2d8t87Tz4MndQThfwrX5EVl05z1ccbQvjmWDf
         tNx91NdYaMY/Rs5GYTsegr7wjbnthUoO/ojXKaumjsB04iKx9eZbxgPJMn2lHwwIyjR9
         k0NgSPvJsa3GSuX+O2rZKKnXCeHj75x1RS08lX5qStXss01YomK9RpHs+zQKzTLdB0Yp
         O1/q9et1udwXWozMfGnJZtO+RwSj+Na8WEaS6Ch0OYwirhlZi1nz85F8PdQ+BqCt4b3u
         S0HA==
X-Gm-Message-State: APuU4Z8ZQ50N21yQU02BHDDal2QykotdR9Hb7j+VVXdPXzzShfKJ7FOr
	0+K3kM1U+5C7wBKds2lC+JJe9sQIQg7BM8o6BPlh4eI2cSXSsaEPZln+GXI3Q7+G1kE=
X-Gm-Gg: AYBFou11KjAZYt8HWvNYXCQxNaH2HwouyhRjFOGWl7+CbMPnCzW5ZYJuKrFKhsWEhnH
	abHdNlmQiJFSq70rs8tKGxpGQfKJn2JJH7V3lyA7yn8lUzeY8ypW8B9/tdzO6L+x6QhTfCE/iFI
	S00/5qK3YfoNs9/VNDAomdTQI11M7VWliaByuZz/psWWDInZoTmWPPj6crnU+lSiBy/V5FfF+Fe
	VX4y3vDtNH0DcM1E/djDyZEeRCkUMhL+wfNToTUOkDRV73Hlcz8HTIEUAr1xJpnFFMEwlJb69Vk
	ZSllC2QR4ok6RG7BHQbyKZTRYEAP4tv0E65UCiq1DMeL1WfyroZYHXCosGY/wtNIqLZ3bvhBZfP
	brHToEGjxoraBalPgdJ/d87vqT/T8G7ZDTJ6vfHLOFeaCNcXdjNuyB+vcV85nRhGFKl2LrdYzPi
	cCu1CER1uJLvGk3Nwn7GzVMpYdHoWvftQAgTzo5YohfTdg2Mvu48a5CwWSVNP7Ntd+dM7hDq/4g
	RNbuIph9udm0p/AdaB5W1bYWR7fNLbnZFOfng/7PWkrGlt3NIt0+CEl48gz6365k37A2wBGkNVS
	minQgsAi8LiwNOksjCSI1Q956oPmHsFj4Pc=
X-Received: by 2002:adf:e003:0:20b0:48b:5e2:52dd with SMTP id ffacd0b85a97d-48e6e2f66e4mr21619650f8f.11.1793710458902;
        Tue, 03 Nov 2026 04:54:18 -0800 (PST)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78f95sm23371233f8f.28.2026.11.03.04.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:54:18 -0800 (PST)
Message-ID: <a348a282-7a6f-41c0-b564-b0aa65fdae9d@tuxon.dev>
Date: Tue, 3 Nov 2026 14:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/1] iio: adc: rzg2l_adc: Set driver
 data before enabling runtime PM
To: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu,
 claudiu.beznea.uj@bp.renesas.com
References: <1792979104-32023-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979104-32023-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <at-DUZn8PsBDbxxQ@duo.ucw.cz>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <at-DUZn8PsBDbxxQ@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 03 Nov 2026 12:54:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24632

Hi, Pavel,

On 10/26/26 18:44, Pavel Machek via lists.cip-project.org wrote:
> Hi!
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> commit c69e13965f26b8058f538ea8bdbd2d7718cf1fbe upstream.
>>
>> When stress-testing the system by repeatedly unbinding and binding the ADC
>> device in a loop, and the ADC is a supplier for another device (e.g., a
>> thermal hardware block that reads temperature through the ADC), it may
>> happen that the ADC device is runtime-resumed immediately after runtime PM
>> is enabled, triggered by its consumer. At this point, since drvdata is not
>> yet set and the driver's runtime PM callbacks rely on it, a crash can
>> occur. To avoid this, set drvdata just after it was allocated.
> 
> I'm not sure this was diagnosed properly. Ok, I guess that fixes
> immediate problem.
> 
> We now publish indo_dev pointer before ->hw_params is initialized,
> before mutex is initialized, and before ioremap is done (and
> others).

I may be missing some bits here but, at the moment we set the indio_dev as 
platform data it is just allocated though IIO specific calls. An IIO device is 
registered for the allocated indio_dev at the end of the probe. Until the 
devm_iio_device_register() is called there should be no IIO subsystem call 
reaching the driver code.

> If that races with PM callbacks, bad things are going to
> happen.

The PM callbacks should be called only after devm_pm_runtime_enable() is called.

device_initialize() ->
   pm_runtime_init() ->
     // ...
     dev->power.disable_depth = 1;

and rpm_resume() returns if disable_depth > 0.

pm_runtime_enable() decrements disable_depth.

Please let me know if I'm missing something.

> 
> Actually I'm not 100% convinced that this patch solves all the
> problems, are suspend/resume callbacks fine running while
> adc_hw_init() is running / before irq is initialized?

adc_hw_init() calls pm_runtime_resume_and_get() on its own. That should 
increment the RPM counter and avoid powering off the HW while any adc_hw_init() 
operations are in progress.

If there is conversion started before the hw_init (e.g. by previous 
applications), runtime resuming the device at that time should not trigger 
anything to Linux since the IRQ is not requested.

> 
> What happens if PM callbacks are running, then devm_request_irq()
> fails and device is unregistered racing with callbacks?

I expect this is properly handled by the subsystem: it should detect when a 
parent device got unregistered or fail to complete registration.

> 
>> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
>> index d48aec92add9ac..418211c06f1fe2 100644
>> --- a/drivers/iio/adc/rzg2l_adc.c
>> +++ b/drivers/iio/adc/rzg2l_adc.c
>> @@ -436,6 +436,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>>   	if (!indio_dev)
>>   		return -ENOMEM;
>>   
>> +	platform_set_drvdata(pdev, indio_dev);
>> +
>>   	adc = iio_priv(indio_dev);
>>   
>>   	adc->hw_params = device_get_match_data(dev);
>> @@ -490,8 +492,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	platform_set_drvdata(pdev, indio_dev);
>> -
>>   	ret = rzg2l_adc_hw_init(dev, adc);
>>   	if (ret)
>>   		return dev_err_probe(&pdev->dev, ret,
> 
> Consider moving platform_set_drvdata() immediately before
> pm_runtime_set_autosuspend_delay().

That can be done but, unless I'm missing something, that should not influence 
the behavior currently present with this patch.

Please let me know otherwise.

Thank you,
Claudiu

> 
> I'm okay with taking this patch, but someone should take second look
> at the mainline.
> 
> Best regards,
> 								Pavel
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24546): https://lists.cip-project.org/g/cip-dev/message/24546
> Mute This Topic: https://lists.cip-project.org/mt/121936051/8377987
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [claudiu.beznea@tuxon.dev]
> -=-=-=-=-=-=-=-=-=-=-=-

