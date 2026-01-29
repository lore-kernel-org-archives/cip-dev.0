Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874B8D358DF
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 08:21:15 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10807.1769674874602956153
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jan 2026 00:21:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UDQR3rrd;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so739619f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 00:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769674873; x=1770279673; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2d36Hk1LawSPx8X9wIS0p79ky67pLs7gUaS13mnM0M=;
        b=UDQR3rrd6RChoWoVdcFCDVQSvZOlrxaMz3QOEQ5uHoWf1STFkJUnRTxof8bb9j7Jy6
         w/ZDmfIIr93eLUFTbyPL+Xe8aHuBKnt+TtIpj8NF/nczHER5Qc5nJci9Ak4oC7rAwLGI
         9zVIlfsEEPaA9W/qteYZTb6cg3jVRSfV91mJskemE1FLsnmdaRp3J5B2/FDNf1E/ujpB
         VVSeupq/JLqpba6mVr5nHn9UkMcNH37kG5AFgRQk0A7E0jpRZrzBVa+PzOYQBK6cdeUB
         ZNS59dM8+zYNznKeRctJz5pTVioke7bXCpV0AZ36a9vC/PAY/p549aoov7TqT7LPM8kY
         t7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674873; x=1770279673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2d36Hk1LawSPx8X9wIS0p79ky67pLs7gUaS13mnM0M=;
        b=VQ/oocx+RaRI9Z/wGsRzm4Acd8PCfKEpSArFOvXzeoemmytJ43vDkmpv8cvlhbE4u5
         lUEUSF5PZlFRFHYuFZCqsW1ap4JREYGnXos/P4nZ052LiJf1nVZYpdvD/sTpSvN3mvb3
         TY9SRnxnxwxsyRCV11ShEAbabO5Et1SERh+MV1AKSfvpgKR1OJ9HFldsBEV4DhjMLmmA
         0jVp5F2wz78rRBAG52DGP+BBMKPnfGHYb0xmtojKdVH9uxcuUoS8tvF5R18wOaLMxNQ8
         /wohvjawaky2Vak7FIDYMTQnNBKrQ0bIydMTzTitRgDjuXrrUBg8W4FJOKylTx3z+g+s
         t34w==
X-Forwarded-Encrypted: i=1; AJvYcCUGIbbRMaj4KeCbe0336xuV0ag5C9yNr78U5Y3/pyXqqOBgMrCTu+gMrNDI/vYFgoLxiCGzy7wE@lists.cip-project.org
X-Gm-Message-State: AOJu0YxsuwUUXVTqncxeyil0yn2Vp5WB/pZV6H+Pe/7z6tV3LiGRa1UC
	wBqkQSR7ttFKF5xBoP7bkFHraI7lqRwVuVwula9/iMPharKcNnbjWzDB9YhUfrosHrEqztDZ9CH
	W9Jin
X-Gm-Gg: AZuq6aJYXDb+/dfoVfstVpSDgQHj0bD8UFASHfrgwhPCMZW+XceG7T5Jr10hEv5PSlO
	Tc1ges2Cai+tqBOX/oVLYxNBWrqA9s/1clasDTYbxCJ3p+xUlz66s8IenHjw7UNL2wac9XNZ7G4
	lAmFD50ZXnZ/ekNqCvkvGt6J5JqXaJIGOvtuA1bKcOsNu4W/LmxG8B3ob8jO/5KEunhKDX1ugx9
	nXjq8tNE5fIERPkwoNTXOJ+Hql0vII2uqZWjZxdGd0GSNn9niMF+xkcdag71Nr7X6hP+otE9iN6
	JLfOfRh03+1Re6dvs2QCUnKNdKixDV0knZgu+Je5kxCNu9kpFWTBYw0hhX+p2NB1C25w6tE8m4N
	HMNuz2haku8kgMjattJmbmi0qNguHQF7hZEV58TVNUefp44BpBlIaHsRIcBRay4GmqHfadLvQye
	3ZvaK5BGJJnXjbyvGkagYSK99TElV8
X-Received: by 2002:a05:6000:1886:b0:435:a0ca:bdca with SMTP id ffacd0b85a97d-435dd1cedabmr12245657f8f.57.1769674872191;
        Thu, 29 Jan 2026 00:21:12 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm12001776f8f.17.2026.01.29.00.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 00:21:11 -0800 (PST)
Message-ID: <7451bd37-a7f9-4cff-9bea-ffed11c81b7e@tuxon.dev>
Date: Thu, 29 Jan 2026 10:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
To: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
 pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba
References: <20260128125830.6791-1-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260128125830.6791-1-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 08:21:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21788

Hi, Ovidiu,

On 1/28/26 14:58, Ovidiu Panait via lists.cip-project.org wrote:
> The devm reset callback that should undo the reset_control_deassert() done
> during probe is incorrectly calling reset_control_deassert() again,
> instead of reset_control_assert().
> 
> Fix this by calling reset_control_assert() and rename the callback
> function accordingly.
> 
> Fixes: c3e23a40a178 ("thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas RZ/G3S SoC")
> Signed-off-by: Ovidiu Panait<ovidiu.panait.rb@renesas.com>

Thank you for fixing this!

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

