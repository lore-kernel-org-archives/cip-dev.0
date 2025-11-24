Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC7CFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 08:10:56 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11970.1763971846987117792
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 00:10:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=horWpGl8;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a219db05so23559515e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 00:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763971845; x=1764576645; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fTKsJMnrBje9xP+mzxh0dy7kk7LBsFaX84jkMPejeA=;
        b=horWpGl8YSM4RfakDHf+xOYfey7i/lZ71huT8IlDbm7FLc0YIiBZgvqH+lA753ouk8
         3Y2DGLWSJeJZ8qrRoLV0lq1ZjB2cMx2krNIOmcxkbTU0ZFJVuUDA/gyhqNXzKAmTXipI
         Xezs1XCI+6NBLaaS7EqmgQXKa+47G0Uh3tEJyy+pC6Xqtfgdp12BY83q6/v9t6uPTaBH
         cglqjxyC+5UECqc0Qnipozy77V3Okw/ZDndjOLlRZMj8NQrk1ccrPal9fWYuXnzJ7P56
         74pcrzHcL8Iyi3ZPXZltVUERhLl4MyxX6YV9JW0C5rL7PKMCDTA/MEzJBs4JPO8NZbHr
         YF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971845; x=1764576645;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fTKsJMnrBje9xP+mzxh0dy7kk7LBsFaX84jkMPejeA=;
        b=sCGes4psshgWZLAvT4bX5+c/yn+/AGEkpx8nGSVBn1/p3aDZI5Se7Kkn4Ipk/zPFgQ
         Tf14mqc68I+vHvYqmzxpysKIknDy6jNRhc6wrDW2XKkN8ZiJb5/0UFXyQVcfXeD6+JpA
         RqZaw7wVp7+nUiM/Nx3K3LqGHHE+Pz4o2+qoLG/y751ZeqUbXr8AtyM/+dXaS5h3a+xg
         HxIor5kvgssccy4YLMbmZ04Imwse3C0+BYxPtsjLhzmFkSLCYeOXImDimuDYfBGdTQ5V
         yrQ5QEsd2pxhP6AewYl3pvaqmt9lb0ZjkxYsij28RndcHfYJFUWSTuZCP6bmswwlFh2S
         1sdg==
X-Forwarded-Encrypted: i=1; AJvYcCVfiFLuir/lZXFjkFihoXMjYwTtWi8UAu+3elh+4gOjKUVukYwCeqEmfSeV35WHXk4P7hQGv3Lm@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz4419abrc/c4M2w0Pd0Yh9qP6abmE5rUF5XjbtzpbPj9v8lPGs
	Gc4fzzyVb8ZMGiXy2CNW6tLy/7rBZ8JmtVWAhMj8veyvagpTGMW9k/crjn3eTS+Dp4A=
X-Gm-Gg: ASbGncs3XyFekHeaE9tsy1TM6pi6kTH/nekqmeGXEADcT2cpQleyGdYkUBvyJ2FQ4hY
	Pr7xpy0JQRyzNirFZB3AkXAiSffoGlv5sGkqBNc4qKM/4JNQ+29URcVUPthPbQpud4y1NonGn7S
	brfncAVjNE2zk2tcp+pbK8urIl/zVFq1dQWEaBdskIFlNRcsFNlxLpwHwthwegifWlxF9ExvYu+
	hljZwnzAik3Y6kt/613770lcQPyv+5XrzQSGnEB6CAm5QVGx5Ezd2Hh9bqAn3NTXthfO7w5M+5k
	Gcz4V+G7b7YZETsj1/dg5hD2oqNEWZ6gJWDN92CzQiiLKr06lO0se/oV4UpovoSmhkPz4PobisD
	ifNfz9xxbCW0bPNrSq3pfhNa1npUs9pQGUyMU3GtFrZLHZvxMbP73JTH3UAPZ9weWk3DMkqk5E1
	qRWfbaop76ZgFgFLFXrdQ=
X-Google-Smtp-Source: AGHT+IFmohbNm/ra+KkqMRUpUS9IqGoQowN3bmF1QyudNqmmrvDHBjd/OWR0JZ4nG15gt5lSkXSEhg==
X-Received: by 2002:a05:600c:3588:b0:477:bcb:24cd with SMTP id 5b1f17b1804b1-477c11179ffmr115530875e9.22.1763971845072;
        Mon, 24 Nov 2025 00:10:45 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e86b3sm211728595e9.6.2025.11.24.00.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 00:10:44 -0800 (PST)
Message-ID: <401dab8e-a50f-4c76-8997-a311e818e81e@tuxon.dev>
Date: Mon, 24 Nov 2025 10:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/2] ASoC: da7213: Use component
 driver suspend/resume
To: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
 cip-dev@lists.cip-project.org
References: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
 <20251122105116.2782841-2-claudiu.beznea.uj@bp.renesas.com>
 <CACe6DC5bsN166QrMFSzVT_JhtLKVHtqXrnP0aBdrk0ua0mEWJw@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CACe6DC5bsN166QrMFSzVT_JhtLKVHtqXrnP0aBdrk0ua0mEWJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 08:10:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20702

Hi, Nobuhiro,

On 11/24/25 02:16, Nobuhiro Iwamatsu (Toshiba) wrote:
> Hi,
> 
> 2025年11月22日(土) 19:51 claudiu beznea via lists.cip-project.org
> <claudiu.beznea=tuxon.dev@lists.cip-project.org>:
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> commit 249d96b492efb7a773296ab2c62179918301c146 upstream.
>>
>> Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
>> and snd_soc_pm_ops is associated with the soc_driver (defined in
>> sound/soc/soc-core.c), and there is no parent-child relationship between
>> the soc_driver and the DA7213 codec driver, the power management subsystem
>> does not enforce a specific suspend/resume order between the DA7213 driver
>> and the soc_driver.
>>
>> Because of this, the different codec component functionalities, called from
>> snd_soc_resume() to reconfigure various functions, can race with the
>> DA7213 struct dev_pm_ops::resume function, leading to misapplied
>> configuration. This occasionally results in clipped sound.
>>
>> Fix this by dropping the struct dev_pm_ops::{suspend, resume} and use
>> instead struct snd_soc_component_driver::{suspend, resume}. This ensures
>> the proper configuration sequence is handled by the ASoC subsystem.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 431e040065c8 ("ASoC: da7213: Add suspend to RAM support")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> Link: https://patch.msgid.link/20251104114914.2060603-1-claudiu.beznea.uj@bp.renesas.com
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> [claudiu.beznea: fixed conflict by keeping the code from this patch and
>>  using SET_RUNTIME_PM_OPS() instead of RUNTIME_PM_OPS()]
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  sound/soc/codecs/da7213.c | 65 ++++++++++++++++++++++++---------------
>>  sound/soc/codecs/da7213.h |  1 +
>>  2 files changed, 42 insertions(+), 24 deletions(-)
>>
>> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
>> index 6d32026ae69f..b4f4f4ebafaf 100644
>> --- a/sound/soc/codecs/da7213.c
>> +++ b/sound/soc/codecs/da7213.c
>> @@ -2106,11 +2106,50 @@ static int da7213_probe(struct snd_soc_component *component)
>>         return 0;
>>  }
>>
>> +static int da7213_runtime_suspend(struct device *dev)
>> +{
>> +       struct da7213_priv *da7213 = dev_get_drvdata(dev);
>> +
>> +       regcache_cache_only(da7213->regmap, true);
>> +       regcache_mark_dirty(da7213->regmap);
>> +       regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
> 
> There is no error checking.
> We need to add error checking or return an error code.

This is just a move of da7213_runtime_suspend() to be able to use it in
da7213_suspend() w/o forward declaration.

Do you want me to adjust it for CIP?

Thank you,
Claudiu

> 
>> +
>> +       return 0;
>> +}
>> +
>> +static int da7213_runtime_resume(struct device *dev)
>> +{
>> +       struct da7213_priv *da7213 = dev_get_drvdata(dev);
>> +       int ret;
>> +
>> +       ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
>> +       if (ret < 0)
>> +               return ret;
>> +       regcache_cache_only(da7213->regmap, false);
>> +       return regcache_sync(da7213->regmap);
>> +}
>> +
>> +static int da7213_suspend(struct snd_soc_component *component)
>> +{
>> +       struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
>> +
>> +       return da7213_runtime_suspend(da7213->dev);
>> +}
>> +
>> +static int da7213_resume(struct snd_soc_component *component)
>> +{
>> +       struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
>> +
>> +       return da7213_runtime_resume(da7213->dev);
>> +}
>> +
>>  static const struct snd_soc_component_driver soc_component_dev_da7213 = {
>>         .probe                  = da7213_probe,
>>         .set_bias_level         = da7213_set_bias_level,
>>         .controls               = da7213_snd_controls,
>>         .num_controls           = ARRAY_SIZE(da7213_snd_controls),
>> +       .suspend                = da7213_suspend,
>> +       .resume                 = da7213_resume,
>>         .dapm_widgets           = da7213_dapm_widgets,
>>         .num_dapm_widgets       = ARRAY_SIZE(da7213_dapm_widgets),
>>         .dapm_routes            = da7213_audio_map,
>> @@ -2159,6 +2198,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
>>         if (!da7213->fin_min_rate)
>>                 return -EINVAL;
>>
>> +       da7213->dev = &i2c->dev;
>> +
>>         i2c_set_clientdata(i2c, da7213);
>>
>>         /* Get required supplies */
>> @@ -2210,32 +2251,8 @@ static int da7213_i2c_remove(struct i2c_client *i2c)
>>         return 0;
>>  }
>>
>> -static int __maybe_unused da7213_runtime_suspend(struct device *dev)
>> -{
>> -       struct da7213_priv *da7213 = dev_get_drvdata(dev);
>> -
>> -       regcache_cache_only(da7213->regmap, true);
>> -       regcache_mark_dirty(da7213->regmap);
>> -       regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
>> -
>> -       return 0;
>> -}
>> -
>> -static int __maybe_unused da7213_runtime_resume(struct device *dev)
>> -{
>> -       struct da7213_priv *da7213 = dev_get_drvdata(dev);
>> -       int ret;
>> -
>> -       ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
>> -       if (ret < 0)
>> -               return ret;
>> -       regcache_cache_only(da7213->regmap, false);
>> -       return regcache_sync(da7213->regmap);
>> -}
>> -
>>  static const struct dev_pm_ops da7213_pm = {
>>         SET_RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
>> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>>  };
>>
>>  static const struct i2c_device_id da7213_i2c_id[] = {
>> diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
>> index b9ab791d6b88..29cbf0eb6124 100644
>> --- a/sound/soc/codecs/da7213.h
>> +++ b/sound/soc/codecs/da7213.h
>> @@ -595,6 +595,7 @@ enum da7213_supplies {
>>  /* Codec private data */
>>  struct da7213_priv {
>>         struct regmap *regmap;
>> +       struct device *dev;
>>         struct mutex ctrl_lock;
>>         struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
>>         struct clk *mclk;
>> --
>> 2.43.0
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#20688): https://lists.cip-project.org/g/cip-dev/message/20688
>> Mute This Topic: https://lists.cip-project.org/mt/116421641/4520494
>> Group Owner: cip-dev+owner@lists.cip-project.org
>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmail.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
> 
> Best regards,
>   Nobuhiro


