Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F2BCC6B1A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 15:21:04 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16399.1791991257151277531
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2026 08:20:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=a9zG3EVi;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2a4e013a44so194306466b.2
        for <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1791991255; x=1792596055; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cyChUgec5pSd+H+qP2treRQw/nJe3QwWsz8yD0bDZkA=;
        b=a9zG3EVii0P+VWH3I8WXINnEv0N7jYvn3MWUqzVQjjgSblxbuQuJ/rY1OefKXCLj/n
         ALjDj9iXV9fMmIToR6uPagF46hMo0jdblfSf1dJs2yIlrXUyhDoHYaFQpwG1hw8Xmnf2
         XpaDOvb/97pW4fXMvpOgEvW5HezmJdEpoSH9cfvrF5IpEgBgPs6WtiE4YycD4rkQVs8z
         I4UyVJNTY0N3ZF95FqEHwjxgHWdvbG3ePfexZm3S4KNcFn+jV9ktOgxlclUrIwydozCI
         u4gJIYxOv/xOhl+AuAG2HpdD/H3JC9sPd5flnJiEhzDRghCZsrlg7Lghmz+VB77V2931
         nzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991255; x=1792596055;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyChUgec5pSd+H+qP2treRQw/nJe3QwWsz8yD0bDZkA=;
        b=vqeJLlPQoQF+95sfj3hdIb04/FnoLdDn64vp/DjUIhq5K9OLtkHal+YFtxMoREUSqS
         Ab/KK67/wCkgs/7GWh6pRUrOKq8LXeApHDiA4gwIP6vru9acf4QZF8y5LSoLHWY1P/ne
         IZ/Up9ty+Ap4hjLq/n70PE0+Y7GAgHyNGAQ7B/VlXEQpguiIns/xidKq6YqLgyFcqUN7
         pbPXzj0n7vuWhtFvoX3hz0VVKa2aCIfTvDsHxDweN3uQ1B43Q6bRL2i24gZVm5L4cDB9
         Zllr+ypvEKvNUPtpN+DBW3UgTNpaH7ZIB+ch7PHAhODpMmCR6AlJokdbRqOGu8NnHiU/
         2YdA==
X-Forwarded-Encrypted: i=1; AKwUvBxoinfGtUR2049t116k6gh7pBdkDEKKh/fpleVdOy79ir4XrugLxJ2GA9MNCsDyjidp9y3UIlqD@lists.cip-project.org
X-Gm-Message-State: AFq9FYKuGTybh0M8u5lioV4cMYwCJvED5Rh9SoQlCinCOo6Qu3bU0gI0
	oHMqV5C07QrHAk7MNoUE6FmepCAapDuo8vxTulnfRSa1KWRUajU0dB1LuSY30nPIH++oyjguw/W
	7+a7MhiQ=
X-Gm-Gg: AYBFou03LaiqDmqLBK/oGSLPgQQ+X0aOlakD2mhpwjZEEn5xvHBQdJNE0/RafMEfgJs
	sxSsHFQLZFjTgPZHovsv/Y35JywtLhiSKjpZOaIoMmdGp30+vAXx/J4vGuv8SFsStXkaax6YvbC
	ab59rZ66V11teXQ/q3F4KHlGrzlemsr5gLyN5/KcuHTgZfJtx6ROuMNsP9NWz09mOm94hI4/Y4C
	AKBsG4WhyTNuWHfA1rOKg+3w4gLqB0zSx1el64OwMa491AMuz0vPFevQgU11J/JoJgaDmfIY1/3
	sNlFkLABNAc+aHPNzCrvmYOpW2Ru14/1qDQGlme0OorUEpOi4tEutiTatRgl2DPr7xaSza3hEZg
	iLm4ygcdeY0DbaVbqr8eyCchJtEgGeL4bfhoRpIWmoPIur3aJO862qvqly7O8vxokGA9cqmoFCj
	2hcvHpGGFG7+MY5MoKFJpmstrKfR8tcpdHSKYsW/Aa2+NGDLdmczDsjxbgO6Sf9RntPQ==
X-Received: by 2002:a17:907:c28f:b0:c31:9b37:ed3 with SMTP id a640c23a62f3a-c31a9b0b9c7mr1447118366b.14.1791991255006;
        Wed, 14 Oct 2026 08:20:55 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac37acsm12508799f8f.34.2026.10.14.08.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:20:54 -0700 (PDT)
Message-ID: <c5e19664-14f4-4950-ba3d-78248c9a06ee@tuxon.dev>
Date: Wed, 14 Oct 2026 18:20:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 1/3] irqchip/renesas-rzv2h: Remove
 duplicate field_get()
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, john.madieu.xa@bp.renesas.com,
 biju.das.jz@bp.renesas.com
References: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1791930919-10628-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1791930919-10628-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 15:21:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24462



On 10/14/26 01:35, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> The LTS commit 94cad2c26306 ("bitfield: Add non-constant field_{prep,get}()
> helpers") causes a duplicate definition of field_get().
> This removes field_get() from irq-renesas-rzv2h.c, where the modification
> was made.
> 
> ```
>    HDRTEST usr/include/asm/resource.h
> drivers/irqchip/irq-renesas-rzv2h.c:115:9: error: ‘field_get’ redefined [-Werror]
>    115 | #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
>        |         ^~~~~~~~~
> In file included from drivers/irqchip/irq-renesas-rzv2h.c:12:
> ./include/linux/bitfield.h:297:9: note: this is the location of the previous definition
>    297 | #define field_get(mask, reg)                                            \
>        |         ^~~~~~~~~
> ```
> 
> Fixes: e4b95469c6a1 ("irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume")
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>


