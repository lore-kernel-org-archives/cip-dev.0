Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9347FE77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 09:05:10 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.148385.1734685503884791111
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Dec 2024 01:05:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qhFatsIn;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso11315345e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 20 Dec 2024 01:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734685502; x=1735290302; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNZoOCA0FZqxObBLXQVATJj1w0u0Y5qBmYv40kXfmrI=;
        b=qhFatsInIFzZBQOB40ViO+WxYCUmaUffs/5Hpj1sIuBIL4S5lgDdytaJNOgSIYXOaE
         aKES16lbPEzdEB7iqH/oiHGUTNnIQVgCiT0BRX/AjWy+R9XJltlTAtEEDfnfjY2SCUbY
         ojwzgLlEWwHinOM24nulaHt95qQIeOL2RAaUUAZr1OJNKUUwyppzx4aRgyfVyLE9QCp+
         80xDHS5/QJlTw/ArxfNKscAS2s/DFWSs/6fZdmWB4bbEWo5fa/N3pVx0W+GTWXPcZc/2
         fr6CmrUE2QrbN0sM4YFAiEO6ekNgZO0vwPCwTmCBS2kj4hVcXApFiU2cd6gGOT5EHMt/
         NBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734685502; x=1735290302;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNZoOCA0FZqxObBLXQVATJj1w0u0Y5qBmYv40kXfmrI=;
        b=T9OOQMxIAlS268eXjTVviN5ATjwzCsPlTkSZar7bUw0/NvXuKYKzmjqq6fCQxwXgsw
         QVNkuQpvmv3yza2C1rlyZxZfpzsQrf20Hp1W0xcno1cQpMt/ZsI8oPNQBVokdP/8Jji1
         xloXsQeS3UV6TdugYukAKdggOabxh4w3F9p5wzCE/0ChGo3z8hJXCXBpPGdlzVp8UUuq
         EEEA2958VhGwjPK+ud0vVJnKFitMajjS6SAevXyiygUjKB0NpvL5xVv+6HfECiox+Olh
         L0lOX8UvSZ6ey4/pGFTJ1lsVE9MhO1a7E0xLcjfyFqjxsKRZmpQO2AalB7evS2UwsLRR
         n2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWpy5P5wHF5mMdYQAZBfUbdkrIm7Iz0q1gnui3Vn0HXfY4//e/RGi1VSd6LmGcfZhFmHD9ntnh@lists.cip-project.org
X-Gm-Message-State: AOJu0YxeP5VKbLNHxyCwe1QPGF/tJuTDGEGelRFCRcSgCwc89IuMif4z
	Qw9ntkTfwm3KzZZalHT4aFU2WaAxpQZf2bpZUt9jPxV8ivhuwPecSUm5F7Ei+R8=
X-Gm-Gg: ASbGncs8Kxs/L8oFsSnGuIZxW0dJa2wjnUGzp0g7phYuk20Qr3i3K5T47EcCmF4cRj/
	+CuXPBn4jjBEV1QbXJrOqVOCc440XtavJW6gHnIvWrnHwPn9FR7oRl6Bv0b0qU6obzZy0JSDZNw
	PJYizimddvrOGhkeOlgyqrY7MGPiYlPsFvdZ490fFE+UhiCyCFCxjwQozIVFtf8ve3pQPXwwji2
	BBa2ZxVvSSRwTRPFo0I1ZDEa1Iyy5nWOcAZlS6sImF6hvoIRKtyYfVuNzF2WpSkeQ==
X-Google-Smtp-Source: AGHT+IEU1L3fwFxEn3XJvUcCwiHcCErPH+/KxoTkB84Q2FefjDk3gdIn+SFmPLFrk30FuI/nYrC3cQ==
X-Received: by 2002:a05:600c:5488:b0:431:5863:4240 with SMTP id 5b1f17b1804b1-43668b498a3mr13366075e9.24.1734685501997;
        Fri, 20 Dec 2024 01:05:01 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219611sm40433385e9.23.2024.12.20.01.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 01:05:01 -0800 (PST)
Message-ID: <d24257b0-c506-4c08-b6cc-3ee40a7b50fa@tuxon.dev>
Date: Fri, 20 Dec 2024 11:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip dev][PATCH 6.1.y-cip 0/8] watchdog: rzg2l_wdt: Backport
 RZ/G3S support
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
 <Z2RlIUU0vCUjnmTF@duo.ucw.cz>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <Z2RlIUU0vCUjnmTF@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Dec 2024 09:05:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17483

Hi, Pavel,

On 19.12.2024 20:25, Pavel Machek wrote:
> Hi!
> 
>> Series backports the watchdog support for the Renesas RZ/G3S SoC.
> 
> Applied, but there may be more work to do there.
> 
> rzg2l_wdt.c:
> rzg2l_wdt_start
> /* Enable watchdog timer*/
> ->                "timer */"
> 
> static int rzg2l_wdt_stop(struct watchdog_device *wdev)
> 
> We can now fail to stop the watchdog.. not sure how well core can
> handle that. If pm_runtime_put fails, we return error, but we already
> toggled the reset control. Should we undo that? 

You're right! That should be undone. I remember I noticed it in one of the
versions I've published upstream, but it seems I failed to adjust the
patches for it. Thank you for pointing it!

> Does error handling
> here make sense at all?

The stop API (where rzg2l_wdt_stop() is called) can return int. It think it
worth having it.

> 
> rzg2l_wdt_restart:
> Similar problem. If reset_control_deassert() fails, we should probably
> do pm_runtime_put().

For code simplicity, I chose to not undo anything in rzg2l_wdt_restart() as
if that happens the system will not be able to recover anyway unless
restarted.

Thank you,
Claudiu

> 
> Thanks and best regards,
> 								Pavel


