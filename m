Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A68D2D8E4
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:04:28 +0000 (UTC)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7389.1769508267051922002
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 02:04:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eqA4kWCR;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.67, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-435903c4040so3316436f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 02:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769508265; x=1770113065; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSp4RzBNSudyPCLbQSXrmu11y4BvQ10vFqvqLdQycEU=;
        b=eqA4kWCREEYvncQvYKZOTKjpPcgdaXdSrrPMDCDEwzwfXl6IwqxeAixthzhyp5pMy5
         NJvRYW9zlJJPp0kYL+0SFflMTVPvMY7l8Q7Epa/aIJFvCZU4oL9tHg1t+sIGwOU3wFGZ
         8XFn/LZm3/eXWzKt8j0HjlXvoNHpCB7XYmORmNC6S7XiiX2agAkrdW2mW0ErbzpIMOxf
         U7X5IKzA6MvniyDdILMKZp7xKQm8Z7xD5IhanK5ifWK2ByYPnpT2oIuBKfphtYCXxf/h
         V6SyGjaqCDjzvDP/MAuBk8PQsuP6Wlh3z6SYQTHWt/PT/7mQjVsWef35MGqWxGMzJYMi
         n0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508265; x=1770113065;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSp4RzBNSudyPCLbQSXrmu11y4BvQ10vFqvqLdQycEU=;
        b=Anx3J/KdS3TVKknmDGuqZG2DbLGJS9wKWIWAn23mCKsKQ+Fes2ap9SHQ+S97VbQTFm
         HCdL5EBDKlE12s7IGm6KuDmGCb0MKuer6Eb4Npa3MRGlScLBbEu41iSbyOuyZ/7cA5n7
         nDssaq/iIdTeFZ0n9qAa4LyosmFf5DpX9hfltmg3cOXzu5ecysbyNjCPKu8Dt/kjbKyp
         uNry+IA/y0q3SbUJlbkBmNraJaX7sS0HKKHw09/fE0lCZ6W4cLzmWdmYtKEdw8cy/AZF
         P/zdHtpCBJKrSelqUjkjXwV59+mDXvNgyOJlHRkC/5WIOKkBq4qSx+sIiSQAYGSSIs27
         1dQQ==
X-Gm-Message-State: AOJu0YzNRo48wjDRAX1cUdtYKzpfrQiBKe36qOmyZE5yVhJEga8b3Qty
	/t7WDlIenDWdM4bz0Jp2Cg3UaUHgK6ZomPZ0g1jdv1bwryd2SQjMxDq7zIjK6dxDD94=
X-Gm-Gg: AZuq6aLA2oVxDsO38rGcUzv5ZEkAPJ1BOyO9sljt7yipSRgfY8wgw4TPcIYkPsvC/u/
	d0+QSNFiUKyjHtAk7yG3IZ413xkepe8X0KOpefe8QNWXd/81gr53/QCN2PMBz0KslnMbkwLHI/v
	tkn3Sl/dySOzBAP5XtCkAldBYQnRJ/hhjVIruocmxUFV8ddoWOC7+vGX2aGdj2Pc1pkHih8iqaY
	Kw7L2y1qcsVu6f2aMAYBajfK1ToqwgyVWndqsyrIHfUsa+QsEg+Pp2Lij/+tIbHvrz+QLmx5kys
	0+LT4JWAjFOa0RihDa3W/6/1As5oE/u9koPmbdbp1lSJpD2PGv8sr5kieekgin94dPP4BaKHP5y
	Zjm3PZksZM+Hp4YhokNGCc/Tb3sAAIYpHQllBAevR87SowrE1dHvt4Z+k1KPrFJRPj8VJzUcMBm
	yFGc7lvSLhGOveRqYJQg==
X-Received: by 2002:a05:6000:40ce:b0:432:c06c:1043 with SMTP id ffacd0b85a97d-435dd1c14dfmr1628096f8f.44.1769508265075;
        Tue, 27 Jan 2026 02:04:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c01783sm37693096f8f.3.2026.01.27.02.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 02:04:24 -0800 (PST)
Message-ID: <71577b5a-b879-4d5d-be4c-ff38883aa3f6@tuxon.dev>
Date: Tue, 27 Jan 2026 12:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 2/2] mmc: renesas_sdhi: Add
 suspend/resume hooks
To: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
References: <20260126094304.2528903-1-claudiu.beznea.uj@bp.renesas.com>
 <188E3EA6FA665A88.3837557@lists.cip-project.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <188E3EA6FA665A88.3837557@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 10:04:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21721

Hi,

On 1/26/26 11:43, claudiu beznea via lists.cip-project.org wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> commit dcbce328d3a2d87770133834210cf328c083d480 upstream.
> 
> Add suspend/resume hooks which assert/deassert the reset signals, along
> with forcing runtime suspend/resume. This allows using the driver in
> scenarios where the resume is done with the help of bootloader and the
> bootloader disables the SDHI clocks, resets, IRQs before passing execution
> to Linux.
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [claudiu.beznea: adjusted as follows:
> - in renesas_sdhi.h: kept the include section as it was in CIP v5.10, kept
>   the renesas_sdhi_probe() and renesas_sdhi_remove() prototype as it was on
>   v5.10 CIP
> - in renesas_sdhi_core.c: kept the renesas_sdhi_suspend() and
>   renesas_sdhi_remove() definitions
> - in renesas_sdhi_internal_dmac.c: kept the code from CIP v5.10
> - guard new PM function with CONFIG_PM]

This should have been CONFIG_PM_SLEEP as SET_SYSTEM_SLEEP_PM_OPS() is
defined as follows on v5.10:

#ifdef CONFIG_PM_SLEEP

#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \

        .suspend = suspend_fn, \

        .resume = resume_fn, \

        .freeze = suspend_fn, \

        .thaw = resume_fn, \

        .poweroff = suspend_fn, \

        .restore = resume_fn,

#else

#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)

#endif

I'll post v2 for this backport.

Thank you,
Claudiu

