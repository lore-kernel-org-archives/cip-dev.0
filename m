Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50075CFC270
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 12:47:26 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10679.1763729240228826490
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 04:47:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZzRVn8A1;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so17971905e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 04:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763729238; x=1764334038; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s73Vjrhksyf/jK/ggqaUZCkhMEImtSbNyCkI8p986ZQ=;
        b=ZzRVn8A1wIE/lT9XSuc5DMQ1hF4/oq7kwfydRMoycHJOCdXRsMjbHFuzJNabUpWRkp
         8ON679O8pYk9fOaTLxlsEwVHmX5qe42LBRlySHXx47FPyk4kthdDY8fYN/HqhI0/skVR
         twYGD4COfqyoG5iZKDVWtowQRrxvWikuh3b+MQ4Oi6R9hBW4UFKDd2KDD14tLimobXqs
         02az7XNfw8rHmRmpWD7lG/sRazRaqH8NCQYjnatP+SUKxESceaLVFawYVOHcwOAN/KPB
         3lOou57ntsHabjggbpmWbudLnx4WKLo4Cxj/Zo4cyNURkc+9aM9tlKXeL2EPTaBwKuEw
         360Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729238; x=1764334038;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s73Vjrhksyf/jK/ggqaUZCkhMEImtSbNyCkI8p986ZQ=;
        b=bFzzlBc4OHfruIWgQncWn1QEtbgNqSx+R+u8Z0eIbXRdiCfegk7ETpSmLRRnBtBaVU
         gtycVum179v5EbEziQz7bWEWOLIFADz1fnOC95y1vCBinSC4m5ZVOVof8asFs+UDHEIW
         YrtIbtxm4a3pD7NmFengKqf0ZXN+CpV8+XoskfP9vgVLoroSbt0z8nAf41TrL9JOXYE7
         n+EgDO8Z7E8xIrTYrqo+hLDeeAHkXj0E5Sga5x+9i4UjIPshDhBOSSnAqpxu0jfdTh4p
         SDFSs65cacL0uM2yBjetrvm6HoNVymvFeg5Pakt/+nkbisxO3yFm6gFZmrRkhAc+9LCu
         mKig==
X-Forwarded-Encrypted: i=1; AJvYcCUJTIEmny6A0Tm3UqmkYWqHK5ACnB+v/izR3k+nb3dcjL0zwtIb4zHZWz/DF0vRjORNCwmaUf41@lists.cip-project.org
X-Gm-Message-State: AOJu0YzHt42y1LAGww1Yf+g9c2Yd8FJN+HUAR6bxJcO9YxHRi3za3lDI
	SazdSc43oqwPRGi0JzWkzPLLzieilMsqBybPTi2AN2YJ8I/wkaVAol8BHHy5KTnd+og=
X-Gm-Gg: ASbGncuukz6cWbmH1EE6gABQA9feL3o9Lp+MWYbi3mFXmgYt5qZ8M+FSBzYQ+uqb8aF
	jnl6Z6O+5e9rYld4jQDqoqmI1zOtFlSPLcawX0/iOoS3v3m5KPvskMlxxHhFl1FKzSNuTxmOb/z
	Ef9mrutcT4IoGhaswAt/2XpcKB258Kh6TnHRFLdDjexJY7E0L8vkHIbhtMU9ctH2DAh5czr0LM/
	rJxdg2h7ZotL1VkD08nQoCb1BmqEfLvQf2MmF7Rk+Ly3gVSz0saodNToY1YHt9QLtCUtVqJKmjn
	XDg9gjqhUI5y/bMPNbnOmpNEweGpMR9ofHw6H2ugpodWYBpSXyBU7dzE1fzPQa2TfnKKB6ypvH5
	D3HtL6Sjhjzn9BvhZELmJrdhAdL5/UwpqkDmGmYwj6IhUpeyaK9W4oh9sREpmDV85PiR2Mm4Z0R
	gy+y1Z8RM6VzSrg0oA2e4=
X-Google-Smtp-Source: AGHT+IHEpsBN+BP3l43//vqmlYLVrk4Gjk1UK1B5xvdD2HTTtDMlaPp4ct6AWsgie4owQ1JMFGa6Nw==
X-Received: by 2002:a05:600c:4746:b0:475:dd89:abc with SMTP id 5b1f17b1804b1-477c017e10cmr22348475e9.11.1763729238324;
        Fri, 21 Nov 2025 04:47:18 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477afb54774sm68987735e9.3.2025.11.21.04.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 04:47:17 -0800 (PST)
Message-ID: <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
Date: Fri, 21 Nov 2025 14:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aQz1pgHaEQNgfdKa@duo.ucw.cz> <1875B18477989308.416970@lists.cip-project.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <1875B18477989308.416970@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 12:47:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20679

Hi, Pavel,

On 11/7/25 12:06, claudiu beznea via lists.cip-project.org wrote:
> Hi, Pavel,
> 
> On 11/6/25 21:23, Pavel Machek wrote:
>> Hi!
>>
>>> Series backports the MSTOP (Module Stop) support for the Renesas
>>> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>>>
>>> The purpose of MSTOP is to reduce power consumption by stopping
>>> unnecessary module's functions.
>>>
>>> If any master accesses a module that has the clock stopped and the
>>> MSTOP bit set, a bus error will occur.
>>>
>>> Due to this, to avoid CPU generating synchronous aborts, changes
>>> to PM domain specific code were needed. The changes backported in
>>> this series were adjusted to be executed only for the above
>>> mentioned Renesas SoCs.
>>>
>>> Please share your thoughts on this approach.
>>
>> This is a bit more intrusive than I'd like. dev_pm_domain_detach()
>> changes API and now we have to modify unrelated drivers to fix it up.
> 
> All the bus drivers were updated to avoid issues described in
> https://lore.kernel.org/all/20251106081218.2574950-6-claudiu.beznea.uj@bp.renesas.com/
> 
>>
>> How much power does it save?
> 
> I don't have numbers here. It is what HW manual sates.
> 
>> Do we really need this? 
> 
> There are issues with the way the device is attached/detached to its PM
> domain w/ or w/o the MSTOP support as long as the drivers are using
> devm helpers while the power domain attach/detach calls in bus drivers are
> not. This is because devm cleanup helpers are called after the device is no
> longer part of a PM domain (due to the dev_pm_domain_detach() calls in bus
> drivers remove functions or bus drivers probe functions (on the failure
> path)). And the cleanup helpers may access IP registers while power is not
> applied.
> 
> It just started to be more visible on Renesas devices with the addition of
> MSTOP because any master access to an IP having MSTOP set generates bus errors.
> 
> E.g. w/o MSTOP support, if a device is part of a clock PM domain, it uses
> devm_pm_runtime_enable() in its driver, if stressing unbind/bind I can
> reach the point where the rpm_idle() tries to runtime resume the device (in
> the unbind cleanup phase) while its clocks are not anymore part of its PM
> domain. If the driver has it's own runtime PM APIs as well that tries to
> access the IP registers, rpm_idle() will call driver RPM APIs and those
> will fail because the clocks are no longer enabled though PM domain. The
> issue is explained in the description of
> https://lore.kernel.org/all/20251106081218.2574950-6-claudiu.beznea.uj@bp.renesas.com
> 
>> Could it be done
>> without changing semantics of existing functions?
> 
> Other approaches I've tried on mainline are:
> 
> 1/ open/close a devres group in bus drivers probe:
> -
> https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com
> 
> 2/ add devm_pm_domain_attach() to have the dev_pm_domain_detach() call in
> devres cleanup phase:
> -
> https://lore.kernel.org/all/20250526122054.65532-3-claudiu.beznea.uj@bp.renesas.com
> -
> https://lore.kernel.org/all/20250606111749.3142348-3-claudiu.beznea.uj@bp.renesas.com
> 
> Please let me know if you have other suggestions.
> 
One other solution would be to open a devres group in probe and close it on
probe failure path and on remove. This will have to be done for each
individual driver used by the RZ/{G2L, G2LC, G2UL, G3S, Five, V2L} SoCs.
With this, patches 01-11 from this series will be dropped.

The scope of the devres group would be to track each devm_* calls for the
device in question, starting from the point the devres group is opened,
ending to the point where the devres is closed, something like below:

---| any devm_ calls are attached to the group X |------> time
   ^                                             ^
   |                                             |
 open devres                                   close devres
  group X                                       group X

When the devres group will be closed, all the devm actions or reset
callbacks (tracked from the moment the devres was opened) will be called.

The devres group will be the last thing in the remove function and last
thing on the failure path of the probe, thus the approach will change the
drivers functionality in the way that all the drivers following this
pattern will behave like their probe will use no devm_ helpers.

I'm going to send a PoC patch for the media drivers used by the RZ/{G2L,
G2LC, G2UL, V2L} SoCs in reply to this thread. Please let me know how do
you consider this approach.

Thank you,
Claudiu

