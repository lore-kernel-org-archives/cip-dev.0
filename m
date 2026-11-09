Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1667.1794243238594728843
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 08:53:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZaJNHqZE;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4922dbcee23so586574f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 08:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1794243237; x=1794848037; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Vk9W5o8drYGs+rQ01zCVQKcfoBPV/AvNYYyygd7MtY=;
        b=ZaJNHqZEm30qxlQcmXAoX64kWYQWeBt+MYJwC8ujP5FuL0/i6QAI8UwuQXwT1aQ6UU
         48KXhPRAfSiTP230uawMr6GNqeIcTZqegLLzdyyn+VfRW2Dnh2GO+7UAK3+N73ZL3lN1
         4MF2Gk4jVQ+jcFEehcrJfa+x0gnfZpJdbIeKzx4LCBmb3yFdIPFHFVEJoW50/FXll2s7
         0XhZ5DQNt64ZtV+EaruDtzTJCmBpB5n6imyfQRjSpfTaGSQGGps+dGnODq5qU+W5PZv4
         e0IRjiG5BlEtuqMobbTdOnF4LQh4P9Cd0I+Wh68Mf/MxOL2bg3nqBo8uGgfklu6eVPZB
         fX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243237; x=1794848037;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Vk9W5o8drYGs+rQ01zCVQKcfoBPV/AvNYYyygd7MtY=;
        b=J+0WWqI51/5IO9M6lJhltQAXWHiRhqaeXea0WX/0erwtd16xaQ9kAkP2lKmLh4bW/q
         l727fgOqZvlkFOibGa3cWG5uVkNGR0usqQX9OekN5KIxIG+bLz9lhZCww8r44JUq7Dwp
         GGyf3A1OnMrF3i+Z+QlAa2cjZybLkAukaSHaopGlHzX0yeZEre4T7ikt86lWN8iebqJH
         yaonj+On8v0NAcWzkk+xu61zFl6AYbLaoy2XptsLMww49vEjv62TtdSHoP0S46yiLpp5
         c74Z9DVjWgu8XMAgg1hiWMkqY5hvgIhg3nOOfHURHJl0FOZwmufMCpeoV5IKdfi6b5CV
         scHQ==
X-Gm-Message-State: APuU4Z9PaN5rTH2oP6nu1XfX9EtsfcdkOE8rzU7kEWmTgmtnau/uDXig
	KVB+PUyg1N3eXD2DE/pyFQHi+kSUIy4JcosrO4ITf4yl812jxZySaNikgBwHyQAZcfs=
X-Gm-Gg: AYBFou31ULJawIS6bpu2lpTPhe0BPON2g/LVvRrEVyhSe/x3EkTxfnYCbmlNSrhanOl
	470bRuDK617BsUEcMwFY9dz6xBGrgtgN031PhNdP6Ykt2tgVghXM3tJHIcOylWH38ge0uPWqnsS
	7yBMQuCi01r79fyUEcmaOtrOQe/FiK1ul+H2UMKOLlmPScXF4vSRJ+liY3DZtnsGTp6lVSL+HHD
	oHDVx9EmI1vm9i7eNzAY+Fs9a86nY+hx6x6/WUJ5+3BzBY3K3Id9yUXqeOyiByASrBcxGHou9Ra
	hUoaVcrx5JJvAtmcXXCdyiYeiuGqElxPU29ZarN5Z5ATJVSzIrHH5HoH7zi+3W4DX9TJg88knTL
	YVvrMdYduSt4pAYUpm44QBSu+E4pkKDF8t7l+Q/zRp6Ho/O077rO1iJRXJNmbv/gtgzBLXIuIq8
	sobv9YVMzfFi0TCzyfF0yRq7xWSTCKOHNMi4+e1mCJ3GNQkZKZCPYO1xNBb45yluoMT/Kr1Fkuj
	zZuK/nBb6AC1YmBjFUZSnuphcs6N0K4oJlJCrBaUYVEkuQIxvBXP982srx3ChUOZc7K7IX/6AOO
	n/Gyv1k+aPKrpg5ZMONye5I/xdZBXDldzg/b
X-Received: by 2002:adf:e195:0:b0:48e:75a1:1e38 with SMTP id ffacd0b85a97d-49831cd14b8mr21883f8f.56.1794243236609;
        Mon, 09 Nov 2026 08:53:56 -0800 (PST)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495b90701c7sm13883797f8f.10.2026.11.09.08.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 08:53:55 -0800 (PST)
Message-ID: <8780b8c1-1fb8-4d95-b526-4e49bf7f869e@tuxon.dev>
Date: Mon, 9 Nov 2026 18:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Fix CVEs related to patches
 backported to the CIP kernel
To: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu, biju.das.jz@bp.renesas.com,
 tommaso.merciai.xr@bp.renesas.com
References: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <avGOCF83NRdd3Nk4@duo.ucw.cz>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <avGOCF83NRdd3Nk4@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 16:54:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24731

Hi, all,

On 11/9/26 11:10, Pavel Machek via cip-dev wrote:
> Hi!
> 
>> This is patch series that fixes CVEs related to patches backported to
>> CIP kernel.
>> The following CVEs and commits are addressed:
> 
> Thanks, I will take a look.
> 
> I don't see these in 6.12 (c8fba74056). Should we get them into 6.12
> before merging them to 6.1?
> 
>> Claudiu Beznea (2):
>>    i3c: renesas: Check that the transfer is valid before accessing it
>>    i3c: renesas: Fix out-of-bounds access for newdevs mask

Just to let you know, I plan to backport these (along with other renesas-i3c 
fixes and improvements) on CIP v6.12, v6.1, v5.10. These should be done by the 
end of the week. If you can wait till then, I can handle it.

Thank you,
Claudiu

