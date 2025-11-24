Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8DCCFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 00:16:44 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5328.1763943396628380048
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Nov 2025 16:16:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CbQkHDw9;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so32854791cf.1
        for <cip-dev@lists.cip-project.org>; Sun, 23 Nov 2025 16:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763943396; x=1764548196; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=410RM8n4v+//RRHrnVYmGVzAjdnXlQdv9D2pn397usY=;
        b=CbQkHDw9dDKVAyhjXvwPHz90WyKkxfUvcTavPZzzO8afRLv4TbhdTsACk/O5ScjNcX
         8vYJ50egto2u6J78k4z+yM6fLlovtSPzhYsiFVpr3t6TIGvyGMU+LS87CUPZSJ5whrhF
         clznuGNPlWykBqFBGoSwLj07G50IUnYRpsFi7aBgtVLRh0Vxt+3URk8Pi4reMNkVbQ+N
         Up6yPrJBpGvOHibcXP6NnYEyVrdWc1V3rnW2fyUnG4QtDJWoT9FTgroHTZq5LVo2aSiA
         GEHwgG3GiSK+6GT2TZHb2u/ytZq05bUMNfOx/+71QIxHwCDOerYd5331JW03hw12W8f3
         QydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763943396; x=1764548196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=410RM8n4v+//RRHrnVYmGVzAjdnXlQdv9D2pn397usY=;
        b=nfQ04vAAtaP4rjSfmrH7POa7LHZsewj374oP3582aj4Q2c5RQpsLWV3kBlp3Q7ah9w
         0qfXOxoO64YhFbojS0q7SuDzC6vb84SDwbUAQlZasnQi9/BVik27tO1wLgB3X+3Ydx+d
         THT2FOUovJja4F7Go0D5h6o5UMWNQDT5TlV6Vgd6mji/zx1iFAKF/DPOKVXzaFJm3Ree
         kK/dm2CJ90oaExjQdN7m2qeaICyIe+h8FnwZ3aCV7LswOaWttTFmRw8NlcS4iIK3tb2s
         usCFGREsiGkkEaP4/XexS94/nHWzsFeBMgw50AjwImRsahgfAwGF/X6eC05MSd1dhAtV
         LYhw==
X-Forwarded-Encrypted: i=1; AJvYcCUrwbwN+j6RNgbNLEejJQ1N6sl/gqeiq9hRJyQr3ua6/hqSl8tsZu41WjvmcqXLmnDd4GdEs/My@lists.cip-project.org
X-Gm-Message-State: AOJu0YxgLfaYCRqtxmHnOuMJ/lk3p/17HshJQrrSlvdgFZi3SfMBgxwm
	ApMA7hKMUhhjgzlw1OuTgLqm6bK57JnPURFfp0PP9yLd0Ndzvs6MIqe0qAmYdlUGmAfP8oWXwwC
	c+KUmZfTm+J43EDL2tT3g4/zGrTZsIQw=
X-Gm-Gg: ASbGncvQbiMnfN8BuMn7lMCGRF/suR4L5dUWtxdv6rU3tQFIT/YTnxPgzR+H+9yucqf
	rM+Zde8YeYhskLhWv3HWHIqaENhWjGDbpX9wa0THWz7l0TD6+NClBqznESB/S/gO+Xi3LDYchfS
	LxGyc4fUss8i/nA6Mqxgf+1VaGkpmAzXG9D4rcmL03mhXLQ9N9PbcYn367VSdMOulTgGlHHTuud
	hsdCa8u7epNcKHNq8d0gD3PitHiqvHoNxemeoa+NpY5/tiSJkzymsJPjdCi5kJH3tZ4
X-Google-Smtp-Source: AGHT+IEtn1oyqPdKxUJmyazyXt1GzQhcr4a4RdNyHL+Le8+hWSVZoR4nGAWU/INjKtu0kJSei4RiezSJZQlW00PXmiU=
X-Received: by 2002:ac8:5955:0:b0:4ee:2a83:22eb with SMTP id
 d75a77b69052e-4ee58818bb2mr158328781cf.16.1763943395570; Sun, 23 Nov 2025
 16:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com> <20251122105116.2782841-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251122105116.2782841-2-claudiu.beznea.uj@bp.renesas.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Mon, 24 Nov 2025 09:16:24 +0900
X-Gm-Features: AWmQ_bkn1L-E9xz6yV2-alAjQqAKx8GamM5bj9ldyCE4huGysV_OsFrijZIIFPE
Message-ID: <CACe6DC5bsN166QrMFSzVT_JhtLKVHtqXrnP0aBdrk0ua0mEWJw@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/2] ASoC: da7213: Use component
 driver suspend/resume
To: claudiu.beznea@tuxon.dev
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de, 
	cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 00:16:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20699

Hi,

2025=E5=B9=B411=E6=9C=8822=E6=97=A5(=E5=9C=9F) 19:51 claudiu beznea via lis=
ts.cip-project.org
<claudiu.beznea=3Dtuxon.dev@lists.cip-project.org>:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> commit 249d96b492efb7a773296ab2c62179918301c146 upstream.
>
> Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
> and snd_soc_pm_ops is associated with the soc_driver (defined in
> sound/soc/soc-core.c), and there is no parent-child relationship between
> the soc_driver and the DA7213 codec driver, the power management subsyste=
m
> does not enforce a specific suspend/resume order between the DA7213 drive=
r
> and the soc_driver.
>
> Because of this, the different codec component functionalities, called fr=
om
> snd_soc_resume() to reconfigure various functions, can race with the
> DA7213 struct dev_pm_ops::resume function, leading to misapplied
> configuration. This occasionally results in clipped sound.
>
> Fix this by dropping the struct dev_pm_ops::{suspend, resume} and use
> instead struct snd_soc_component_driver::{suspend, resume}. This ensures
> the proper configuration sequence is handled by the ASoC subsystem.
>
> Cc: stable@vger.kernel.org
> Fixes: 431e040065c8 ("ASoC: da7213: Add suspend to RAM support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Link: https://patch.msgid.link/20251104114914.2060603-1-claudiu.beznea.uj=
@bp.renesas.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> [claudiu.beznea: fixed conflict by keeping the code from this patch and
>  using SET_RUNTIME_PM_OPS() instead of RUNTIME_PM_OPS()]
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  sound/soc/codecs/da7213.c | 65 ++++++++++++++++++++++++---------------
>  sound/soc/codecs/da7213.h |  1 +
>  2 files changed, 42 insertions(+), 24 deletions(-)
>
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index 6d32026ae69f..b4f4f4ebafaf 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -2106,11 +2106,50 @@ static int da7213_probe(struct snd_soc_component =
*component)
>         return 0;
>  }
>
> +static int da7213_runtime_suspend(struct device *dev)
> +{
> +       struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> +
> +       regcache_cache_only(da7213->regmap, true);
> +       regcache_mark_dirty(da7213->regmap);
> +       regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);

There is no error checking.
We need to add error checking or return an error code.

> +
> +       return 0;
> +}
> +
> +static int da7213_runtime_resume(struct device *dev)
> +{
> +       struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret =3D regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->suppli=
es);
> +       if (ret < 0)
> +               return ret;
> +       regcache_cache_only(da7213->regmap, false);
> +       return regcache_sync(da7213->regmap);
> +}
> +
> +static int da7213_suspend(struct snd_soc_component *component)
> +{
> +       struct da7213_priv *da7213 =3D snd_soc_component_get_drvdata(comp=
onent);
> +
> +       return da7213_runtime_suspend(da7213->dev);
> +}
> +
> +static int da7213_resume(struct snd_soc_component *component)
> +{
> +       struct da7213_priv *da7213 =3D snd_soc_component_get_drvdata(comp=
onent);
> +
> +       return da7213_runtime_resume(da7213->dev);
> +}
> +
>  static const struct snd_soc_component_driver soc_component_dev_da7213 =
=3D {
>         .probe                  =3D da7213_probe,
>         .set_bias_level         =3D da7213_set_bias_level,
>         .controls               =3D da7213_snd_controls,
>         .num_controls           =3D ARRAY_SIZE(da7213_snd_controls),
> +       .suspend                =3D da7213_suspend,
> +       .resume                 =3D da7213_resume,
>         .dapm_widgets           =3D da7213_dapm_widgets,
>         .num_dapm_widgets       =3D ARRAY_SIZE(da7213_dapm_widgets),
>         .dapm_routes            =3D da7213_audio_map,
> @@ -2159,6 +2198,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
>         if (!da7213->fin_min_rate)
>                 return -EINVAL;
>
> +       da7213->dev =3D &i2c->dev;
> +
>         i2c_set_clientdata(i2c, da7213);
>
>         /* Get required supplies */
> @@ -2210,32 +2251,8 @@ static int da7213_i2c_remove(struct i2c_client *i2=
c)
>         return 0;
>  }
>
> -static int __maybe_unused da7213_runtime_suspend(struct device *dev)
> -{
> -       struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> -
> -       regcache_cache_only(da7213->regmap, true);
> -       regcache_mark_dirty(da7213->regmap);
> -       regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
> -
> -       return 0;
> -}
> -
> -static int __maybe_unused da7213_runtime_resume(struct device *dev)
> -{
> -       struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> -       int ret;
> -
> -       ret =3D regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->suppli=
es);
> -       if (ret < 0)
> -               return ret;
> -       regcache_cache_only(da7213->regmap, false);
> -       return regcache_sync(da7213->regmap);
> -}
> -
>  static const struct dev_pm_ops da7213_pm =3D {
>         SET_RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume,=
 NULL)
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_forc=
e_resume)
>  };
>
>  static const struct i2c_device_id da7213_i2c_id[] =3D {
> diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
> index b9ab791d6b88..29cbf0eb6124 100644
> --- a/sound/soc/codecs/da7213.h
> +++ b/sound/soc/codecs/da7213.h
> @@ -595,6 +595,7 @@ enum da7213_supplies {
>  /* Codec private data */
>  struct da7213_priv {
>         struct regmap *regmap;
> +       struct device *dev;
>         struct mutex ctrl_lock;
>         struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
>         struct clk *mclk;
> --
> 2.43.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20688): https://lists.cip-project.org/g/cip-dev/messa=
ge/20688
> Mute This Topic: https://lists.cip-project.org/mt/116421641/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

Best regards,
  Nobuhiro
--=20
Nobuhiro Iwamatsu

