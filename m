Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0EA109B487
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 04:14:41 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5357.1775016872426143797
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Mar 2026 21:14:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XdX8xP3x;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so78646495e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 31 Mar 2026 21:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775016870; x=1775621670; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFWG5lUnarvJk09CnmE8xctlZdbyzxvEA71Iio+ZxR4=;
        b=XdX8xP3xVFyHbccmJtb0Tvnd8kzpBsPHoSFGz4v6yHPXEuXBJ8NfE8IbFAubctIVEn
         dg9+NZqezgS7/b9RPb74YvxTK/njY4THkkIWR9ZPdgsi4LEJMKMDOsrO9EXCpxO6/LNS
         4+iBeN5AI/2SD3cjJIfEBf93kmkAQj4+U6H+/ACK+xLLxfOhfgRcuj7Bm/KnWnLXye7E
         NyIkB0wIb7nASMoZPdJijkDrw/IMr5bL6ZeQvcLe3GAWWLiecyc4nixV2Me1m+7JYcvN
         J49wuMPfsNSo+gQCmAyCcu4flCA0R9vyWyKoJ7FeCjnDt4+l7xK+3b+4PwFfyheJuAG4
         VUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775016870; x=1775621670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFWG5lUnarvJk09CnmE8xctlZdbyzxvEA71Iio+ZxR4=;
        b=kVDqghmgvk3ZU7tWevRukznD4gmD+FhkG6F7uvSE84uDNA96CWaTWuEm1BVSFeC927
         STv0+VW6kGXRW4gyDZOoL9vQ7Jd+yIL7EfO06kISuSxhzTxOQ6OmsmeEzBUyp6Jye+6p
         +pNWMS1mrla21+3gsxolyt3RWG/ruF16ovJ7tP4r2wb5qSFG87bS7ddIJJ6bvHSaLhGx
         1HTi9dFOksyUEt5Euz48D5gf6fr9QtUfh9w2VTb4oqNFscy2TbinjRLM99N4kkSdG33N
         IJ49k8/kX9+fB3qX5WQodE5Vts+hxagFH4BMovSw2DlBIqZYFkIvarMJAKx948GkAdML
         oK2w==
X-Gm-Message-State: AOJu0YwPcT1knEhpbGafCwVRiMZwlo0h52uDJHQw960+kx7F5v+81tqr
	kRyGHasNtu90rkc+qBp1BlcCytahKQZqXWMELgFpgR1JUVBJjgky4JYev7yAsTm18x0=
X-Gm-Gg: ATEYQzyT9gBFMgSr3Yk8h5kh5YLCR7pCS9+fm0y6yEZkdjpBgHyEcZptddGMeoXRkus
	eAYJu1CR0gesrX8ipPzUdHDgehtvrudtefkLz431wAq5UjzkB+kxSXbj7wovOIJ+749Scf8r+/J
	elWjQ7hYF4nU3xRRaKaxXDNNEYsQLOcYGj/kpHBOvf6C3+z5zsdOhbdgHyFL9aRrlHI4UC0w8u+
	rimIpbQ59erayO4To0qfbC2Pc+ksavHflxqL3qP6q/XPhe+7U79BDMySMDFmonnels0/4tuofHk
	UVHizm7LoagPcDcxxy3Wd/MALUfoUoJyH2Bo0vuF3gu3/sJYTU/3qY0pN3NsW3/IfyUK7POa+y2
	4HIOWKQBGCb8gt7PGEEgYirG8Uh6C6I/gOdJLRTFssnr8Yer4GrcizHgBM6iK8dMhAgS8nQq6wR
	p8CcgMxZfqELri6CtUDIsIOl/XWA3C3uhgV5OH1r/jHQ==
X-Received: by 2002:a05:600c:8b4b:b0:485:3fa9:358c with SMTP id 5b1f17b1804b1-4888358c814mr26689145e9.17.1775016870365;
        Tue, 31 Mar 2026 21:14:30 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm141500425e9.2.2026.03.31.21.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 21:14:29 -0700 (PDT)
Message-ID: <fc9fce75-6f6c-4753-8bc7-c14bd03d2731@tuxon.dev>
Date: Wed, 1 Apr 2026 07:14:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
To: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
References: <189BC4ACC53FCB81.1328210@lists.cip-project.org>
 <69b5da97-4fa2-4ce6-a1f7-74b9bce6712f@tuxon.dev>
 <TY7PR01MB14818E4EF12163C4F09CDE5AECD48A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY7PR01MB14818E4EF12163C4F09CDE5AECD48A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Apr 2026 04:14:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22611

Hi, CIP maintainers,


On 3/24/26 11:10, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Sent: Monday, March 23, 2026 8:06 PM
>> To: iwamatsu nobuhiro(岩松 信洋 □ＤＩＴＣ○ＣＰＴ) <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com
>> Cc: cip-dev@lists.cip-project.org
>> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
>>
>> Hi, CIP maintainers,
>>
>> Gentle ping on this series and the v6.1, v6.12 backports.
> 
> Sorry for the delay in my review.
> I checked each version, and everything seems to be fine.
> If tests are OK and there is no comment, I can apply.
> 
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> 
Would you please let me know if there's anything I should be doing for this 
series (and the v5.10, v6.12 variants) to get merged?

Thank you,
Claudiu

