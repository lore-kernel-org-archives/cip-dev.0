Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB1ECFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 13:23:48 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16588.1763990624760960847
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 05:23:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WhDb6y8I;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso26389265e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 05:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763990623; x=1764595423; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OA9JZlZpXNZUyF/p5qB1f7l6MopER2dNkSYorR2N+3w=;
        b=WhDb6y8Im0j8QbgSXjptWfntKuNzEPajm6+5naxO97oqDJz8GEWgTLGX0/9YBt/VIY
         RQpIprbMbNg0eUXInkBMlH+g158oaGGrZ3D0nXtjNVjhQzXBowNqyJnKlymYizqHki2G
         zDzpkQzfzVIQjzBYVlO3ttLhXp+2eOnLtEKUhmE9wQWfDeyFBDVIU8eqkHj021mxI9VM
         hj3ikwo6mSd5+qq912BVGdHRIzPseHylAKKta3KRwc0dPhQIctvt2aOGiGPbHisw6iG0
         i4svu6x7x7ajwupEvRmDGQ8sY2qtjPeFXNC3pygCz5d8bIo3TVBzPqfSIPMrkEz14SFd
         mjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763990623; x=1764595423;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OA9JZlZpXNZUyF/p5qB1f7l6MopER2dNkSYorR2N+3w=;
        b=lyxbI9Um0X6PV2v1vuOU9+DucmdzeL5L0Nl9LsEprWkjHFHtBuIs5mglhCeTqtfI+d
         b0XJSnNkX06+txUqMkG8O77eKLVOfxf747YEG3IB6syjyEMS3AbCU+lT8wnQWGQpLUyt
         mPGTse27G/xbr9Ed6GZ0Ac3NdCTiXOKCh4pUsHZndQS8Mj4KrbuLvCZVnrlbVev4udii
         fvhO7QAS+74c/uTxR0StbwYbQ4+yE6GJveZDJatbH9d6myTawGL+FFCrmdHMiBXRbHAB
         IkmMM2/MINUj5e0Z0lxgc1ayV/StDzEl8YPboe69t+kE283DJCHfhXVY4i4q/1XiaYmk
         bnfw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7tKRFLy0cvtaSDANJzMU6PnqiV8yppYd1CZojp9irNx9DBYRelkqZaMtQeOSQdQ4FpOCHmBJ@lists.cip-project.org
X-Gm-Message-State: AOJu0YwD04uebe7do+TPG/XINbMy/lSfocPNyowmF8yFEtJvWgzzu9Tl
	AFy4xaSp4R6MBicRPwnY8CcbQJZfViHUbkGUXddASAmce21uwvdzKBrj6a0i9oSnScE=
X-Gm-Gg: ASbGncvMskxs/zGtREUGHISIKVY3w2JMBTKZNTuN6mw/t2PQNZk15NHvxEsy/jheqcT
	Kfe8sMxhYiQO8p88uof8/ZS/VIrQrMylhtNp7/5Qu5GSmu3UpmEgGEYtKNJqwsCVZ/H8O5eAlXv
	SVMA1TFTSSwf85jxa8UpvJRDAlMoz7KcjtPrRQmhc6tnZ8yvnXNeUZJ5HqEbuPYSNgZP4K4snsl
	UkjWFRJ++jmrgHqGGuKSVuzT4jXN8qL3Fy/aAY/xiKRc2AJDKPZHCDxot3Av/NJbff0gfCl0WG0
	MNaQgCaFkyzu+X4XKX4yaTd0m4OPumnZXiQqd4NO23kMmtlbV+6hmJzuPsB4wpexnVfKTMejHEV
	ISlOdMlg6xXG7giOCLIxGs5uIqqelIIccc1Hef02lVk/wXjjcIiHidkbfQ0dxwnWMIj2cjTwGa1
	mkR4347EHA0MY4OqqmMg4=
X-Google-Smtp-Source: AGHT+IFBZxgcQxTtBC+vuMlndRDicIM78SSlwn+WmnLdTGsCMspEdVV5Fi+tvRq2qiDtxyTv0TsUOA==
X-Received: by 2002:a05:600c:354d:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-477c10d7003mr112217235e9.11.1763990622915;
        Mon, 24 Nov 2025 05:23:42 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dcd891sm152555915e9.7.2025.11.24.05.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 05:23:42 -0800 (PST)
Message-ID: <27a51129-2e2e-4358-b1e7-c6475644c9b1@tuxon.dev>
Date: Mon, 24 Nov 2025 15:23:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 2/2] ASoC: renesas: rz-ssi: Use proper
 dma_buffer_pos after resume
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
 <20251122105116.2782841-3-claudiu.beznea.uj@bp.renesas.com>
 <aSQxv6iREysaFLVQ@duo.ucw.cz>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aSQxv6iREysaFLVQ@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 13:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20715

Hi, Pavel,

On 11/24/25 12:21, Pavel Machek wrote:
> Hi!
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> commit 22897e568646de5907d4981eae6cc895be2978d1 upstream.
>>
>> When the driver supports DMA, it enqueues four DMA descriptors per
>> substream before the substream is started. New descriptors are enqueued in
>> the DMA completion callback, and each time a new descriptor is queued, the
>> dma_buffer_pos is incremented.
>>
>> During suspend, the DMA transactions are terminated. There might be cases
>> where the four extra enqueued DMA descriptors are not completed and are
>> instead canceled on suspend. However, the cancel operation does not take
>> into account that the dma_buffer_pos was already incremented.
> 
> Ok. So if you suspend the board in the middle of music playback, few
> notes may be dropped or something?

Yes, few samples from the audio buffer will be dropped.

> Don't do that, then. Suspending in
> the middle of audio playback will sound horrible, anyway.

OK.

I think audio subsystem is trying its best to avoid glitches and other
unwanted sounds.

Thank you,
Claudiu

> 
> I guess this may result in some alert beep being lost (instead of
> delayed), and I'm not against applying this, but...
> 
> Best regards,
> 								Pavel


