Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DACD44C44
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 13:05:13 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35203.1768482307661308586
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 05:05:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mS8V0PeQ;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8768225837so132447766b.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 05:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768482306; x=1769087106; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsHA3SjDEcOGjF7GTzWpw7gNLv9rxZAIo93DxkRyjmA=;
        b=mS8V0PeQ205YuOCr9oadrg4Vxo1owJoBv7dToHiu0fw3vmEt6NXpFcHJdxoQmUM2iM
         54DKd1ff5QRvOM19ULvwT+zNizx5QmUYLDWkZ9BI7Y3Kred4fAuQoKTxaCZ7LMusJSqW
         Ht7FGaR/04cqRZ6pI8v7/nRqUSHJu2azzVK1uz5GTPUG9UfVAMm7L/KCvXFcPAWLy2y/
         d9r3xj7HMUa4Z90ANLU6zV5H7m07VdTiRTUK9J7VHB3Iy/cPCkVFeKZ3Rmdz2KS7ov4D
         M9VrPwW3eBy3V0RoIrmAjbeIU/ShPrV+5RzSNHTIKWtcsVrtrqIfJzRPma6Bl6eKxcVQ
         zlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768482306; x=1769087106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsHA3SjDEcOGjF7GTzWpw7gNLv9rxZAIo93DxkRyjmA=;
        b=S0b6h7/GA1Q77iNlBFPdqwPZDdegJRLjV5cqsXp+p3e6fZEF9yth7PBtW0hs9J85Tz
         AvPZlKhl+qyhUe6GPzcDp0D5LOz7ad2SS3yVAOPYjaBABKNFFBMBWGUXlBvpPsEES1sM
         HV2IRNqE69u+QUxXf3Xxe6H4sioFUjDRpRhqWqmqi9ePfIHpbi0u/zUzCArr3YQe5PhI
         5ByDv4Owm8YEjVwS0VGLDqTknIoi1NBtDomHBMnwZL6hlrY1uodRUc3xTKC55gDegncj
         AZ+tgRfm+9un6L7u67XM8w2t1KN0Bx2Vv8AeA030hC3Tx7aAKYu3xdSzqgOAEG1o45Nc
         vtBg==
X-Forwarded-Encrypted: i=1; AJvYcCWx1WBvZQekxfEAT3tLdnHetDvuHjmhF2OmmbvKBWDm61jXsbi8MGPzxT5ye+dTs1B/gsJAUAna@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxl6xxhH+BhRR/pMAPYuEB032M8kA+qBrasx3Gw/bPuilkzUeeJ
	7CQpVEBPO1JvZahsgznu5sUNnu7CqATbFxZYgOzAqxXSDwPdyDSmBZ/sWR4QBS5L5jE=
X-Gm-Gg: AY/fxX6KGXmRB86Kp52r+8J2sVzDNN3SNyuOzCAjPykqXjNncjwMVoJ1S/FmVrFgm7V
	bSG5iuJIVTd+QQ/SevnZRsbJY5t7JNhAnNhGXVyBuga08wH2gjnez3OeW8xXMIIPOe3kYPoUsht
	bh7mVV+kr49Been3I88k5o7WEteNTH/MAVg5CZIJZdXUhrSE+UcJC4FFABkgQ8WQEVB6/K9nHlg
	OukiInfqdJiDQvSYNkz0DfCAA7mwshpuzZqe4lGXN2Y6zH2D+2T+S6l5VqnIrDfHpW5oh0OL0ys
	y2fIU/mb1lN2ez8Lkd4cRxvBXG+KRJvJgpgGGZflkCalbI9O8IPUi6UDpa/F7BDqWM94b2xpfcM
	TX4wqSVLLI5bNTy8LsXN7nBjSnzDs+7gKras3/DNlZnh4uN517U45Qwx4nkzwJX3kkIrShzs223
	93hdFLnAkS/qLxVnze/34=
X-Received: by 2002:a17:907:d17:b0:b73:4d06:bc8 with SMTP id a640c23a62f3a-b87678c8359mr488600966b.53.1768482305629;
        Thu, 15 Jan 2026 05:05:05 -0800 (PST)
Received: from [10.78.104.246] ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b876dd0e9ffsm383601466b.37.2026.01.15.05.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 05:05:04 -0800 (PST)
Message-ID: <5a568462-b699-4b12-bd83-872bf1c1af55@tuxon.dev>
Date: Thu, 15 Jan 2026 15:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}:
 Backport MSTOP support
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
 <aWjSI5U7wVForVba@duo.ucw.cz>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aWjSI5U7wVForVba@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 13:05:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21624

Hi, Pavel,

On 1/15/26 13:40, Pavel Machek wrote:
> Hi!
> 
>> Series backports the MSTOP (Module Stop) support for the Renesas
>> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>>
>> The purpose of MSTOP is to reduce power consumption by stopping
>> unnecessary module's functions.
> 
> It would be good to somehow quantify the power consumption improvements.

I'm sorry, I don't have these figures available.

> 
>> Changes in v2:
>> - dropped patches:
>> -- rpmsg: core: Drop dev_pm_domain_detach() call
> 
> Does the diffstat match the patches?

Yes, the 2 extra lines added in rpmsg_core.c are from patch 01/19
"PM: domains: Add flags to specify power on attach/detach" which changes the API 
and thus, all the affected users were adjusted.

> 
> If there's v4 of this, could you merge reviewed-by: comments to make
> things easier?

Sure!

Thank you,
Claudiu

