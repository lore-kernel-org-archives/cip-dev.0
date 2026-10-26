Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40028.1793011868987915041
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 03:51:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OHuBcmFz;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2448144f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793011867; x=1793616667; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BB4LjBzYyZ7L5JU7UbSajV1+97POGHvhXfL2wUngtV8=;
        b=OHuBcmFz+98pO5uJHemBRIZx1T4MevB2B+jljePQQMnWGl7QZShXhRTChcY+8QL39p
         /5FirjUKt5M6Wpg/xb1B+nLh8PmrSex9b8m1uXxQ9n47/i5FupJ9v9ppGLuBJQ8lC30B
         PghDO+Yje5Iu/esqdRZIkH07sOxwHiki2jhJFQUH9hXWFHypoVdupUvFD6UcUb8RX4Fm
         NIbpjAfkUwOVkSR7qd5h7xE0OvXF4ZeRLLu3ILXeGjA3DdLCUc3i7Ecx0E8JqImgbdor
         +O6ze4YdYNMMW/QK2rdOCDXfRJC/gzkz+FuN62rPpft3vFeQ1XmleopNXqzD3ZxRaBWQ
         3G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011867; x=1793616667;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BB4LjBzYyZ7L5JU7UbSajV1+97POGHvhXfL2wUngtV8=;
        b=rN3fsP3JtZT3VGZGkVwYXwxXMWq9Fs1JAvlZ67Ru5k6/lLmcZOgC82W3p1+9DMO2UB
         8Ze5ej1CjNkDr9xIrFREqZbsBzTamfeeek/CpN8GICczPDl4NewqhEWU9xTZTwUnvbON
         qD5yiLic1ia9ELF3wYkGde9OQu0O/khN/cvwUe7gQ5cIwSgd8w/KGCXdczRnJbObCPxa
         g51ZMsFWtC3NJHWLmBxP5HImRqIS02DJLraJH2m/qFSSfgCJWlC+tfgZdoWfXgIcKixC
         bFPYjrJic0RDmGyKDcr0+qQp1xCouI6l52yzx6TIwCTUzTQDooiFrle54rM7m6GYA4iS
         MhYg==
X-Forwarded-Encrypted: i=1; AKwUvBwsoa/UEsE/AVlrB7BRv5Fun/zF5jpSn61CyfRo5Lg4N3trmn4TckimwJBNA587URLrwJ94vh6a@lists.cip-project.org
X-Gm-Message-State: AFq9FYLD7+L1UBkp7ivh9Jm7tq/VRTobO9NPoBltM9Dwaf+92jWqAFww
	JWsUrQoJPkio9JxnFvwMzd1OnBY52oxqawTUcrBBF9Irdjq60Mth02MUAUriy/uUq3/Bm/FNZXI
	cEXNc
X-Gm-Gg: AYBFou0btmB9h4pOi2lCO81psMdHn2D4o/PMeLxp6qN+Xe0o5N8VBn+ygN3jxlWyJYg
	k0ifF3AyTqfIUSBTbUFzBWm7P/xxgaDqIpxdhnix8u8+TG91/p1TtqJ/R3sS/4l4Tz9deyYzFec
	ibnGsMOfHxnAjaR3Y2nYFDdfSQYNeR85eRm6deuL9KpG016P+blcyt2KmnbsnGMel1t0sg6kExZ
	Vj8BcnX+fjoNSxZSQeW+2Izp9vdtYD89tiqedO1lQFA5CZQxH5gz1kcQT9JiDI0hHi2BS8X27BK
	RLRNZGl1z12N2HAUvkwB6ZF3wJjdCrEUYOS0RwTuTPKevdi1SD97/6Dlo6MVy58GVmkFCiQTuC8
	Tdk1qD3jpu7SGJ1QbHdjzs2po1DOIJ5OGK+0owUGkU85H0QqR+1R4PbGkpUi8VYtcB46q5R5Y4L
	Q3nQY0dB8Npo6tVbVm8IzI2ej246XoZLusygEx7+OQUvA7z2zfraPzmLaRULUAF1e8sPB/naTyJ
	gI6PK6s5Z2M1rNpc7Z8T6/2o2C1Br3YhhgT4nrQ59FStAEM0gvlaa0d4xGKgdSy
X-Received: by 2002:adf:e012:0:20b0:48e:e98:8b6a with SMTP id ffacd0b85a97d-48e3eb26b2bmr7988897f8f.4.1793011867310;
        Mon, 26 Oct 2026 03:51:07 -0700 (PDT)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd49afsm15961916f8f.35.2026.10.26.03.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:51:06 -0700 (PDT)
Message-ID: <2aef2cc8-8d1a-4b4a-afaa-de8cac59a8bd@tuxon.dev>
Date: Mon, 26 Oct 2026 12:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/1] iio: adc: rzg2l_adc: Set driver
 data before enabling runtime PM
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, claudiu.beznea.uj@bp.renesas.com
References: <1792979104-32023-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979104-32023-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1792979104-32023-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 10:51:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24544



On 10/26/26 03:45, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> From: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> 
> commit c69e13965f26b8058f538ea8bdbd2d7718cf1fbe upstream.
> 
> When stress-testing the system by repeatedly unbinding and binding the ADC
> device in a loop, and the ADC is a supplier for another device (e.g., a
> thermal hardware block that reads temperature through the ADC), it may
> happen that the ADC device is runtime-resumed immediately after runtime PM
> is enabled, triggered by its consumer. At this point, since drvdata is not
> yet set and the driver's runtime PM callbacks rely on it, a crash can
> occur. To avoid this, set drvdata just after it was allocated.
> 
> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> Signed-off-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> Link:https://patch.msgid.link/20250810123328.800104-3-claudiu.beznea.uj@bp.renesas.com
> Cc:<Stable@vger.kernel.org>
> Signed-off-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.x90@mail.toshiba>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
