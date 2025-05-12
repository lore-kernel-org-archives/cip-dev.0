Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E0C3ABBC
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 10:45:54 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web11.47383.1747046747722648889
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 May 2025 03:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=d3S0+tYq;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fbfa0a7d2cso7239584a12.1
        for <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747046746; x=1747651546; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qql9l8UhQMeNVpe8HSrwy+IgpPfUt4Al+eyu4m0urWI=;
        b=d3S0+tYqUEuWiTi85+KJroh9Qt+m6cZR3XrBgamJ6MjpEqmiiPS79g9l0dVC26sHxu
         dTn96cMmyFmWG3LGdtJKzrzshAf/jZZZSvcDhLvXoy/7CjoaIBgxFJW25J/ZU+/0ynvc
         8CFCsyfhcNbi4VJ5Kg/FHSu6bZhxsqd+HRAqJ5vz0tVz4AJv8NnF/E0jRrtVeiDsa2RG
         dEpKxeQPNF6p4C9djPjCfgVMLnYMH/KZer5KodMI4g20OpI/Hw45XN3lndF8ZFn4tcDO
         Q7/ELN+M+Ee8PunPK2DqHAtyft5FtdgE63HIJHQYMXywXi0d70qbM6FLzQxkVBcr7/Xq
         NO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747046746; x=1747651546;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qql9l8UhQMeNVpe8HSrwy+IgpPfUt4Al+eyu4m0urWI=;
        b=MWJo0O64lX9R44FZ0y2btJvGkdpvkkhnKD/GZb8gQ7h2GYPoa9d4K2TmqE/Y4uFgDZ
         6O6JbBH+s1s+WENMMbXNXDTZn3Br1xfN6rDmsr9Ybk3bGJBeBmcs0USOOrMVSwViTa8L
         +xcsc9e9B+zXaV4J/sIHVgLnuGDAmu/Cab3TuHRqV4zoQXLZJadJHU+1A0NKarS9h/N7
         3kk/rMFKf5FsgJ4nCCsDwmMDzIkxb3ilHeE5A/SEQr8y3VNqdiTn3rV8Ig9lh4zBCFxE
         4hcVYBjYtw6p2lN5S45vaP1D8PWuGxpLzcbTiNNc0xuzOiF+znB9uyFK1FAUEpBeKUbI
         J7mA==
X-Forwarded-Encrypted: i=1; AJvYcCVqMPfEguSB0n5l6FYp44UoGQU9+19jenu47/r8v4FOSRJCUKLoy35IgZJK0v1B/wqxmMxHB4gI@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz7YxawuX7BTeTZah0jUMa1zLLkGpGUEcfhIqPlGmnaeRgGU5pa
	KPivAMJu2Vq0xumbEb79yIfOyeHSRAPkmQxYrhxtGLNyiKvrNwt11j1OjFcXbqI=
X-Gm-Gg: ASbGncuENOY/f2i6Uwi3UReMQDB0bB+mMnoav2mdAEVISOqbhRsSQ2a7dGAGNWHsrHT
	tXrwFuc3aFW33Uw2kUYfY3oAJWBDanb1B6nb8AKdu1C4rIXrd6gekAW7OWZpydpPDSOneCrJvYb
	HPXh5Sn9+d7m3gboSb4/OvYVxcsXPPxodyAA1Tg2AJhY8u6mDjReUbPekqUOT4zpqjV+/IVvFpR
	x5Sc73M31vKjWLkErLIc0n14+MZVGks+e/tGfClHLEiR83glDoB8twEXkUrm89dK/6WG/Bf8IAZ
	apOEvOAAYqQHPsoQmPtciVhNma5vSocJL3DRgYjFbeRAfp4zNxjK8jYwfqQ=
X-Google-Smtp-Source: AGHT+IExyjWFGE7C3hkhgZRPJyn41XWBXQv5Podx0mE6AdruSU20HjgD/UNlhc3eY7Iwb+okMoobpg==
X-Received: by 2002:a17:907:1b03:b0:ace:c2d4:bf85 with SMTP id a640c23a62f3a-ad21927cc55mr1269054566b.43.1747046745584;
        Mon, 12 May 2025 03:45:45 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2198532d7sm601668966b.170.2025.05.12.03.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 03:45:45 -0700 (PDT)
Message-ID: <3b2097ac-20e1-4e5d-a9d6-2b2bfbf0cc1b@tuxon.dev>
Date: Mon, 12 May 2025 13:45:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 03/37] ASoC: da7213: Add new kcontrol for
 tonegen
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
 <20250509093442.4015145-4-claudiu.beznea.uj@bp.renesas.com>
 <aCGq0e9FcQ1ShAAq@duo.ucw.cz>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aCGq0e9FcQ1ShAAq@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 10:45:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18894

Hi, Pavel,

On 12.05.2025 11:01, Pavel Machek wrote:
> Hi!
> 
>> From: David Rau <David.Rau.opensource@dm.renesas.com>
>>
>> commit 64c3259b5f86963c5214e63cfadedaa2278ba0ed upstream.
>>
>> Add new kcontrol for tone generator
> 
> DTMF in hardware? What are you using DTMF for these days? And is it
> really useful to have special silicon and special code in driver to
> accelerate it?

We are currently don't use this with the RZ/G3S SoC. I've backported this
patch as it was needed to have the DA7213_TONE_GEN_OFF_PER macro used in
patch 05/37 "ASoC: da7213: Populate max_register to regmap_config".

Would you like me to try another approach 05/37? E.g. Use directly the
latest available offset for v5.10?

Thank you,
Claudiu

> 
> Like I mean... I'll take the patch, but it looks strange.
> 
> Best regards,
> 							Pavel
> 


