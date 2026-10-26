Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39890.1793011319346453747
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 03:41:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OGZMYmx+;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so5044605e9.0
        for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793011317; x=1793616117; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJuhvfIf47XdZIFiFeSsY5D7zXbE3IRmDesQn07l4Sg=;
        b=OGZMYmx+qme5NFtKVZAQw6hqOaKR9JTRCkJLWPVVZMn1sWGwFWQ1ANQljWGem76sxv
         FYwYZmaGLykZL0rWSbbQEBiKL3oF3g3FYRuU+/cxXpfPO1aJZhs9NeCUCMahlvoiP3xv
         0+JG4TwvCK3YntcKSyeaNPu5O2lsrntHwGMeESsaGTsKdIvccA7kTur2/gz3dJMo61J7
         YKzwuzg1BxULQciX3ym4CiEqxiKJPNjZV2DfDzGFAW8syig4XfWj4mb97gS79PnV6uXm
         4LEuFi6O9Gc9L5VnUsLRrj++7QZKJmu7+wR2NJzNu9gmvdpWpi3UCNez2cVxokVn06pu
         DpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011317; x=1793616117;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJuhvfIf47XdZIFiFeSsY5D7zXbE3IRmDesQn07l4Sg=;
        b=JAlI8+mp4ddKKIowIVeGKKELrgvNH/addqLZNPaiqbkOp9JeTGDkUE7AgHfYQdNcgh
         7Dw8E8mVJT/HIUgnRuYdtKJaZ9M+U9yK9aDTJKPsxGqrTFxowXxVJBLDK9D1vuwP2loa
         hC3e3arni5TFTugb7HA+0OW7sssVwhfTuXKeNdotRL85F2NI1DJDheP6KZqIQmbH6Oq8
         3CpzQMkiL1uLI9RQc4tVYF82N9ZeswNbubw9+MDHVVo+e048poF5KV/1x16Ddg3vmhZC
         04pj3JCscRVLH6JGJGnoHYSbC1EFfve7iE/pkLSE/Jv9r7eu2HafGTDoVCyg5WqBif7+
         w14g==
X-Forwarded-Encrypted: i=1; AKwUvBzQ9W1Eb2N3WYhmFgVn7CITXnT2wZ0id3rVsEKZbcwF58digyBgprITOQODEaCgBhEWP10mwTHd@lists.cip-project.org
X-Gm-Message-State: AFq9FYJnJS21WiJI5eLuNXlPt8k8+EbYIAP8jN75LrMFxA8xje8iud4N
	ek5SHFBKrfcj8zcGwLSotCL/GNyALztAl2lSaVhLav5ffhzps3JKjc3Vt6hZJt9dBpo=
X-Gm-Gg: AYBFou2EQ6VEMxDTFfIeveHr0DaZP+Ftolq6MjXN8PxzEw8jSUDhblOISJsos1aKzXE
	Av+ubtb7L1gruzDlClAixIFzue+k8TMLKehHbdy+WdeKDoXFA45qaE1F1pOmgr6gneJmIeHaiex
	h9UNXuo2rnaSQixpfUQTEZSGhlUAbhpk/efu/bQyQk8rwxCX7n7shRhx4j4vHy3J4dEBpehW7fw
	6Ww7ni+BmQfhU6ZUVlk2aGlwlDif+Lp8Cjczxxn2EKGlu43505M4CoJaZ1bKXzNGhzrGTEXyKIW
	4OH6wIFDPsrwb4Wl0+Jm7chBx/IatUugjAYgi/zNQU5rvZQuZEiKqHqDzEbxCAbzemH4kbZcVuW
	0FV75K4YsvpjgBgoVMwVv1noeE+bcPBalPtgFtsm+qiqn72AjJjhqL+0FY4SJCvRyDAw0pbLzVQ
	RgBHFygDUPSfJWX6OwAMfLLCx6tLrEbyKLN23UD25PRwLilJEW9YsVY2vagJ39wbIIkDmiLj9Ww
	QF34Ox3N/NudvH8JgQl/IDOUYnnRbbiKMAW+TJfUCdUBfNzkjA76djufd8BHpRh3JydR7C7WfbG
	JMLVOc1nqw==
X-Received: by 2002:a05:600c:348d:b0:4a1:9c71:9f17 with SMTP id 5b1f17b1804b1-4a35ae881ddmr119932735e9.9.1793011317208;
        Mon, 26 Oct 2026 03:41:57 -0700 (PDT)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm495583025e9.1.2026.10.26.03.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:41:56 -0700 (PDT)
Message-ID: <0a84c839-1a27-436e-a4a5-312f09b5b43e@tuxon.dev>
Date: Mon, 26 Oct 2026 12:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 1/2] i3c: master: renesas: Fix memory
 leak in renesas_i3c_i3c_xfers()
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
 claudiu.beznea.uj@bp.renesas.com
References: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979286-32200-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1792979286-32200-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 10:42:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24539



On 10/26/26 03:48, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> From: Felix Gu<ustc.gu@gmail.com>
> 
> commit d7665c3b4f575251e449e2656879392346ca612b upstream.
> 
> The xfer structure allocated by renesas_i3c_alloc_xfer() was never freed
> in the renesas_i3c_i3c_xfers() function. Use the __free(kfree) cleanup
> attribute to automatically free the memory when the variable goes out of
> scope.
> 
> Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
> Tested-by: Tommaso Merciai<tommaso.merciai.xr@bp.renesas.com>
> Reviewed-by: Tommaso Merciai<tommaso.merciai.xr@bp.renesas.com>
> Reviewed-by: Frank Li<Frank.Li@nxp.com>
> Signed-off-by: Felix Gu<ustc.gu@gmail.com>
> Link:https://patch.msgid.link/20260406-renesas-v3-1-4b724d7708f4@gmail.com
> Signed-off-by: Alexandre Belloni<alexandre.belloni@bootlin.com>
> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.x90@mail.toshiba>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
