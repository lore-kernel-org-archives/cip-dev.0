Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F9CFC27F
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 13:56:06 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11870.1763733356955024274
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 05:55:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RSnq+0UV;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so13744075e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 05:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763733355; x=1764338155; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVASwPeimD0fXpHZvP2qkiKfn3A20Ugo6g6qPOUL9ik=;
        b=RSnq+0UVc0SJSR8zuC3aspWdO5WR5H8smCohTrD0HVITfnTnU5Ha+EY6CtpAmMRlrw
         jY76IT7HjnXVF49z3FYvEbWEKW+ger4JD5nvzNzldwuanVd7wvi5bQ/jTufxO1geKL7X
         xrlvz8weDfpKgdLoEUwR/uzUed4lUTYHMu91x+VS4Lp+HjzpQDObsTUZ60N+1pZzTBPD
         hl04vGi2KeTaL6ImxsrIKLv0i5Lv6vBIBIuP8g8xsS8Tr+EpwY6YlZEuFlvCi7Q3ik+w
         N3HCfcAlE0shYj3jbnIQ6UU6nHDANuX7UfixkfJe5LbKv1rLaU9X1gJh2Q+kFpB74lkO
         fHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763733355; x=1764338155;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVASwPeimD0fXpHZvP2qkiKfn3A20Ugo6g6qPOUL9ik=;
        b=ENTtxUaqZIcxDhXBP0gf+QLmZyTaFEDL2KhwGa5uVhG3SZRn0GXNBAh8c8w54GVjm7
         B+xKfSpRiDtb03cazXiwdMV8JVh9Vi+AeRwwDD7gpoitA8pO9y548oUEYU+TxeNDd1Ep
         ffa+1FfWP3ikcf5lDWVaCpnpaREFxJQXj5Pkb3VI451sLqJnlIuOcutsmSMiz7H4BmU1
         PQqN3xSUy7Qez52znWmSX/cw3IbSXYxlPpqwslDvrVcCJoaDDfBKB3h0E078LkjyRej7
         bPlP3waDXMTHb2SVf0d0/tO/NPi43d4m6h7nVWYY0h7R/vYKLEYq8BH0N4ByRK5YkP4k
         wB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7yijriwq9+AFHXGK7ozlog6B0oAdlYuKbfxtN65dXZsB1GY6VWOtMi6jgWvtofmFhahtTSTNX@lists.cip-project.org
X-Gm-Message-State: AOJu0YxwiVNILPnwu5riGA+ZmQk4rYyHnV5vAjPuekZmrgt4ljMf+Bjt
	G+35TKm3+lKaq8Z5wFsOl3f/OVhlsESVU4OdKEXM+Ov/Ls8JjBnScFVEhj6hEKoCD5U=
X-Gm-Gg: ASbGncvlRV5A8BhYruVTdnkw+ff9YRYMTjpVW1oBFYN8H9R4HBXYKKdAVqG1WQEMPxi
	moqFgSHd+iZXA0TL3Ac80zG9GKw1Mk4+WhBLCIyoB1JNWp39EkpQhVygPAtWurhfA+EIRJ0HGcI
	z/IqnCgUGkkvFGoRGGcQFTZq54WodYK4MV0pLZeCIGePfijF1XHIuj2uJ98gXjFdSDgh/b9etwF
	ikMHTd/dUnzfmWpUz3QXSVVI2O9gx2vXuFP8Z9Qjfm5kb3k9+09YBTzxUp+cMsObdBi/LNq+yAy
	B/Vq5XAjV+nJVNspz2+SH57TSWlmTGb9yAlFmAB9GP40JrIt3ADAYXGBNRbBbQdzk8eDdSTaw4R
	JblpRSvQfApur2v7eimrazZm//QCLFr2DoLB0XnkAg/jI4yRy09bgNhkL9YUtrIOvW+Mo5BM912
	l+Hgtv6HIrP95L/X8dAMM=
X-Google-Smtp-Source: AGHT+IG6Wd709+IrkZZuEmQXYej66GOivCdtCPgL4UdXGnq4Th+IEqn5QGXA3oXNW60MpOwCi9nxEw==
X-Received: by 2002:a05:600c:4515:b0:477:63b4:ef7a with SMTP id 5b1f17b1804b1-477c01b20e8mr19761405e9.20.1763733355233;
        Fri, 21 Nov 2025 05:55:55 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e19875sm83930275e9.16.2025.11.21.05.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 05:55:54 -0800 (PST)
Message-ID: <111077d3-10ee-4c95-926c-e81f4c622c37@tuxon.dev>
Date: Fri, 21 Nov 2025 15:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aQz1pgHaEQNgfdKa@duo.ucw.cz> <1875B18477989308.416970@lists.cip-project.org>
 <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
 <aSBslxvWFIij/zGh@duo.ucw.cz>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aSBslxvWFIij/zGh@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 13:56:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20683

Hi, Pavel,

On 11/21/25 15:43, Pavel Machek wrote:
> Hi!
> 
>>> E.g. w/o MSTOP support, if a device is part of a clock PM domain, it uses
>>> devm_pm_runtime_enable() in its driver, if stressing unbind/bind I can
>>> reach the point where the rpm_idle() tries to runtime resume the device (in
>>> the unbind cleanup phase) while its clocks are not anymore part of its PM
>>> domain. If the driver has it's own runtime PM APIs as well that tries to
>>> access the IP registers, rpm_idle() will call driver RPM APIs and those
>>> will fail because the clocks are no longer enabled though PM domain. The
>>> issue is explained in the description of
>>> https://lore.kernel.org/all/20251106081218.2574950-6-claudiu.beznea.uj@bp.renesas.com
>>>
>>>> Could it be done
>>>> without changing semantics of existing functions?
>>>
>>> Other approaches I've tried on mainline are:
>>>
>>> 1/ open/close a devres group in bus drivers probe:
>>> -
>>> https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com
> 
>> One other solution would be to open a devres group in probe and close it on
>> probe failure path and on remove. This will have to be done for each
>> individual driver used by the RZ/{G2L, G2LC, G2UL, G3S, Five, V2L} SoCs.
>> With this, patches 01-11 from this series will be dropped.
> 
> That looks like feasible solution to me.
> 
>> The scope of the devres group would be to track each devm_* calls for the
>> device in question, starting from the point the devres group is opened,
>> ending to the point where the devres is closed, something like below:
>>
>> ---| any devm_ calls are attached to the group X |------> time
>>    ^                                             ^
>>    |                                             |
>>  open devres                                   close devres
>>   group X                                       group X
>>
>> When the devres group will be closed, all the devm actions or reset
>> callbacks (tracked from the moment the devres was opened) will be called.
>>
>> The devres group will be the last thing in the remove function and last
>> thing on the failure path of the probe, thus the approach will change the
>> drivers functionality in the way that all the drivers following this
>> pattern will behave like their probe will use no devm_ helpers.
>>
>> I'm going to send a PoC patch for the media drivers used by the RZ/{G2L,
>> G2LC, G2UL, V2L} SoCs in reply to this thread. Please let me know how do
>> you consider this approach.
> 
> I'll take a look, but if mainline is happy, likely I'll be happy, too.

In mainline the problem is already fixed by patches 01-11 from this series.
The PoC patch that I sent is intended for CIP kernels only, and, along with
it, all the other drivers used by the RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}
SoCs will have to be patched with something similar.

Thank you,
Claudiu

