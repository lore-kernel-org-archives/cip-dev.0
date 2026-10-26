Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40307.1793011733283563732
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 03:48:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=L/s9NvFu;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b060ec084so1720609f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793011731; x=1793616531; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Av/yPBuHzIld+Z1vuNoqNjCY7JEU+JDoN6zeb6F7g/I=;
        b=L/s9NvFueRakivgweWlfLrvI/HuyCU/BoR57v6ep/ellNeSk2X8ejLL9E3acIUJheq
         mT+/wd8uGZoo/5bPmJctmU7dWYUZOUQngNjE3djrdhgCHzZdKroIIHkPDBBB8GnRfzUE
         SZp3SRaeqoyQqVDev4QXCGtKY9cyikNYPAOkLg97t2+D577wCmclTOQ0TaaF8GxhD+1y
         /8OIs/OA0anofDP8ikGG5DAwUDKIiTr507NsvUdaMWM1ybDRT1Krjvjgt4Eh5NMxL+Ef
         eoN12dYhId55AMcX14oz/iRX+dg+gl6GPyBBLCeqGPASukvPjt6/Gn1x5noPx+lIGA9G
         ZS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011731; x=1793616531;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Av/yPBuHzIld+Z1vuNoqNjCY7JEU+JDoN6zeb6F7g/I=;
        b=JjxJy/gyzohwrrbIKCsNhMnAuWv0fTGeLZKBA60pDmS7X/Zu0IoNewJKT5XJWflOur
         zS6tqtC55XDTDO1StavtgGtEwCdU5dWuHzdcRigZ9fr3v3g1buQ4Nav90MLEYJOaHqET
         QZ4ztjR1ZVhyyWob5+3P4LYxswkEOVc+Lm1J1p3vaz8MeVBzuHJcoIXjgaFAINk6UnPt
         y+mEpLHHD4AFhx3SM/e0vyOdrg2ywrVmt+oiK38bh+olxoPM45ByqP3xag9jqjgf42rR
         iF1/qpMsXwXoMPASnWuJJZhBz9AZhm5nNpq3FygvZ3xMuS4ASrt94JOzUm1bkHZpjAVC
         hKtg==
X-Forwarded-Encrypted: i=1; AKwUvBwhY2eNZfPPiBEkxJ13x4FThYK8GzKQp9eM/HASlywwjJG607gJIcrsezHBxvjysVNx5Xdnf3JF@lists.cip-project.org
X-Gm-Message-State: AFq9FYLY+/XpCm+miDI1v7xdcHTjqDibZ1I/CM3BS/Oj44zr8fjulNPQ
	wUhGTOwqTEmLzuFxJxueDBvTnMJWsmTNMaEV2UDdpjDgLNQ0LCsX1IARRBWc8Kj3VJE=
X-Gm-Gg: AYBFou3uhInOkdia8tB/yWO/7gZ4Q+FCEv7DnOsiKH2S4TDHkOzx42x1LuO/79K97nE
	8/7WGvCXYFEdaxQsCXpUt61xrAlFRdAhXtW2NRNvRrI4DkBD6wbzUXMKM4GqQ6LqrlRIssYOnVk
	6MENQmWx3z0HWD9QQNuiUFbPlioXcP0Zzeed2cAMjpfKrg3eu2AI5ygT3oY051nti8lQlOW/+3Q
	eMDdSvAlXAZZxy+2HK1oRCmQBN9ekUnU6zpwhpREJBtC7h7DmipkPqK2uPrt8wSW4YcQ7ziiNU8
	gUIdLdHKcVBvy5ytAfSJ70frB8jYR5oosqhZEwv2Egxhb4Qr6ctbheQ20MKa0Ht8WnJWW/JSzfA
	N7PpQqPVGnOTt410Xo7hO9TwluSB+yVBV/FMlF+l/t1ziNHoto2Zcqkm98akSoRpQO7lBSxVFMg
	Rzw82sGkD5Ai4eabVF3xLbfPW6IubMfrfzOahFESwG9wdurd08ZPsgZ8Lvj3ThipCAYoLw9QMk7
	89wfQAmh+niC6NEPLMqXooyxhdB3Bwrey5KYp/kMnOyjtyiV+y516aOEo+ZjZtC
X-Received: by 2002:a05:6000:612:b0:48d:b650:69aa with SMTP id ffacd0b85a97d-48e3eba5700mr11757444f8f.50.1793011731538;
        Mon, 26 Oct 2026 03:48:51 -0700 (PDT)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb90dsm14320764f8f.22.2026.10.26.03.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:48:49 -0700 (PDT)
Message-ID: <55b30226-8e06-42d9-beb6-49f3cce418e7@tuxon.dev>
Date: Mon, 26 Oct 2026 12:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 2/5] dmaengine: sh: rz-dmac: fix
 device leak on probe failure
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
 fabrizio.castro.jz@renesas.com, claudiu.beznea.uj@bp.renesas.com,
 cosmin-gabriel.tanislav.xa@renesas.com
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979242-32127-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1792979242-32127-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 10:48:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24542



On 10/26/26 03:47, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> From: Johan Hovold<johan@kernel.org>
> 
> commit 9fb490323997dcb6f749cd2660a17a39854600cd upstream.
> 
> Make sure to drop the reference taken when looking up the ICU device
> during probe also on probe failures (e.g. probe deferral).
> 
> Fixes: 7de873201c44 ("dmaengine: sh: rz-dmac: Add RZ/V2H(P) support")
> Cc:stable@vger.kernel.org	# 6.16
> Cc: Fabrizio Castro<fabrizio.castro.jz@renesas.com>
> Signed-off-by: Johan Hovold<johan@kernel.org>
> Reviewed-by: Fabrizio Castro<fabrizio.castro.jz@renesas.com>
> Link:https://patch.msgid.link/20251117161258.10679-10-johan@kernel.org
> Signed-off-by: Vinod Koul<vkoul@kernel.org>
> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.x90@mail.toshiba>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
