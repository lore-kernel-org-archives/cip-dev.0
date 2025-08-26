Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C713DCA0FE9
	for <webhook@archiver.kernel.org>; Tue, 26 Aug 2025 11:37:15 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.62517.1756208227679537837
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Aug 2025 04:37:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=K3C4LvFp;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so42161355e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756208226; x=1756813026; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDOb7OYX7HCZhylVNLpa04OEWlLV6YY2Zh1vcKqO8Us=;
        b=K3C4LvFpFkeiguRTOVy35G+SyslLUf0SihJJtlNWYby9m4pjwPUHbKsNdKq7pNpVZ5
         xtv217EAAnardd1SqXNWhQATYPvyzc/jotnEgMOdK1+jcyCoJg35Z8FUKjzJpNnAH/HD
         PIrytKAYEOZFPO5u2WyKM8Iv0cKDnJlNoMnG5Ugg6r/JHA8p24xxyWgpK+02SVAfdtFp
         fNLmN9PY1mvrKAL87uRcY2vSt4c0yvXEd5H4dZUJPsWelfp8/YLvAuyP9MYbWowW8m6c
         3sdX/+xemTKwg7ZVeCbtDrAb9PesnoZ+9iswbbFbTzh8wqT2uv9/iIAsOmixciF9cnGC
         5qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756208226; x=1756813026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDOb7OYX7HCZhylVNLpa04OEWlLV6YY2Zh1vcKqO8Us=;
        b=NgQbtQ+9agzBT493FyfcACfmlHn3zCe3HSuNgVmQT7CiA3dLbvNf0h8Jgkvl4+af3U
         Ztev5hXOCL59Z22bnnfpN/q5VxM9eEaxNQM3g9lQ/uKoEPz7Gooq+MKAWlz1L5m0onS/
         KR6d9l4Q474wtx8GFa4PsqiGeC3l3IGx7Xzd0M4MMyLlx3V5PwGhOP0+NZA6neWPlI4A
         yDChyzKtPq6Cikn2SR7BoCBtQpy4ah1PTWwtqN1cpyEZXvyejDo0JsXPGf5E2iyUOphF
         xAPwh20HU1hIvwBgIjk8Xb226UskJH6zyV747yoExZg4e83liDCsbVbVnIgVZ0+E8Vo+
         LVuQ==
X-Gm-Message-State: AOJu0Yw4Xm9nhKcuML8UuLN8GdMtLD0xeXQgWOXIdb6dFifmSWPA19XM
	y1PbDsmeR5yV0c1ov8vE2BoLBPEHmQ5kl7lCO3rXwvc4kzm2q5gvtQaEEie386eMwV8=
X-Gm-Gg: ASbGnctLR6q5DhpmqNnxL3m4koDoqREhoTLOUnTf9dCn1AXj+rNLufSU3frTcSfKtKO
	uyvK2H+6zSp14KmX8QuBSKUEPOMpEO8pXO2gs69BMKdAFOfrtczo+uPy738ZAzbAFiPpcyrBSJ5
	/dPPQ8Bjn8/qseI/eg0zNDwb+MwYqYuB8r9BSh2+LooV3PqoOYHahr1+MbPuMNzcjLCW7vtVBIT
	HO3luDFBRXfq4QjfvsjWdTWzS7QLhArF+zXWDHNrsRoA20IePcnr7aUBcDT/SrTJXi4ivgZgPEd
	dStaOoShjrvvZwQvv98tOojehAjTSHLnxDyVxyQs7ZFwWZLSHiotGFhNvTsL8kM/AI9oUmwOTU2
	H6ookz1mGRLWQLYc5lJSOBitSfTBTow==
X-Google-Smtp-Source: AGHT+IGChYMyfRXfIGqxGgk5a7r3rez5lC70cvJjDJL2eHmWDxP8cS6oIyVWB315KwbNTO6JS3MJYQ==
X-Received: by 2002:a05:6000:2281:b0:3c8:4a4e:4adb with SMTP id ffacd0b85a97d-3c84a4e4f7amr6900536f8f.56.1756208225884;
        Tue, 26 Aug 2025 04:37:05 -0700 (PDT)
Received: from [10.172.229.246] ([82.79.79.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70eb7eed5sm15438922f8f.18.2025.08.26.04.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:37:05 -0700 (PDT)
Message-ID: <fef368e6-8a60-471a-bc1e-16e58e5c3cdd@tuxon.dev>
Date: Tue, 26 Aug 2025 14:36:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
 Ethernet aliases
To: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de
Cc: cip-dev@lists.cip-project.org
References: <20250826111016.143286-1-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250826111016.143286-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 11:37:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19966

Hi,

On 8/26/25 14:10, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 

I missed to added "commit upstream" reference here.

> Fix typos in the Ethernet aliases.  U-Boot uses the ethernetX (X={0, 1,
> ..., N}) aliases to update the DTB with the MAC addresses.  The
> ethernetX or ethX aliases are not used by the Linux RAVB driver.
> 
> Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces")
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/20240328065738.3049316-1-claudiu.beznea.uj@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

And my SoB here. I'll re-send. Please ignore this version and the v5.10 one.

Thank you,
Claudiu

> ---
> 
> Hi,
> 
> This patch is already integrated in v6.12 CIP.
> 
> Thank you,
> Claudiu
> 
>   arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> index 3f050a28f2a7..3d707c9c6e46 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -20,8 +20,8 @@ aliases {
>   #if SW_CONFIG3 == SW_OFF
>   		mmc2 = &sdhi2;
>   #else
> -		eth0 = &eth0;
> -		eth1 = &eth1;
> +		ethernet0 = &eth0;
> +		ethernet1 = &eth1;
>   #endif
>   	};
>   


