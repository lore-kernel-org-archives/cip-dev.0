Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A372CC6B1D
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 15:20:44 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16488.1791991238253952251
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2026 08:20:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mDSHEWjF;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b042c0728so1020739f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 08:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1791991236; x=1792596036; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQPVlLxqAp7cH5+GPawZw+Uqe+HDwSKmfFoKG5haHbE=;
        b=mDSHEWjFO2ydX9D2St1gAKTx8AtepxlPTLqPitiXwExyMfxju1U/qi98cJv3W0itTw
         CGDhYf5cpMw+2p646AyfmgT31wZmmCur50GQqCZJS34aAfO6AxDDRsU1Dj1J+RnUvydL
         8DpKV8vPotISXRJje/v5UmoreOY0Ii7apY0S2I4s+crX0xyZA9df66hnAzivl2KWsMIn
         7ohIiV36ws0MkJwXM+wGW/HmJ/W5xvu4wnfup+AIb4g5eq1noNZliJaUN1j/u7jIxEjG
         tMIf5ET5asQeT5MwHXvr+iGLsHrjzz/TNbB4Y/mKURJa623RRYJuNCPCEOdjrRdi+4pd
         WBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991236; x=1792596036;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQPVlLxqAp7cH5+GPawZw+Uqe+HDwSKmfFoKG5haHbE=;
        b=KfazxGc402AFDcLoRmPvD+H9e6y4ossVlY29csPNDKm38/N0cDvHFF27Hc5utfarH2
         wcbX1+GDWxfHGGavk7XL1tn68Er1Puywv5J8UCe4hpjuoK/o0XyCKCNrdODgX3hajCCO
         J1eZk3VgRFtg12J/UhdPj69FOEcesMcBxR7RSNirs0tpOPFCFKBpQIxB1hwTod2EYnZT
         OEFgct158aLzi94FWYrUJht+htALLzoDLp+CUfDzhILtd1SwxLaYuP+bXQnvldB9PLlu
         YzJcgEpUUg1S1iW5BHfhadxuUGlRcgDG4poVfxV2KWlg7S8Gs4X3ikeN6oM0ka7UzNyf
         efvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxT42Ls6CtWhSQkELWb0o+4PoUj3sLP6kpHQ8ZtGUf33zMGf7MGVteMq1NXyhjLVZecQxmUGoE/@lists.cip-project.org
X-Gm-Message-State: AFq9FYLijdBcs/RoMFfgrF5bCfHVZgwjk/AvnTb4t5pyLWC260KNYJ76
	nVL8JpCcBF1dykDP1iGxtwxq8mu8yVvIXtdjys/s1jUgoqmJQLmOW+sXzPiHores1SU=
X-Gm-Gg: AYBFou3PWBnG9Q++n9NsfDiGoJW+4DR2Mg3WdUVzBF+PkaOMQ18sus88RYgsB34Sr3l
	L2olc8eGm5yMwANs6AURsCwo8EkHlkgYGdSLBVYeX1khihNwafm/DaxYINB4iv4S9ZAP7iKPFNg
	ejNmm6aUPb7wSB+Ra6+AQuYtO49yR4kW8GPKQgMyvbnELaTKCWG4T0FgsCoQfg6V69VJ3wq6jAa
	K+ts8mg4XiZlMFzmNBgKvCpB3vCnHO7gxZaw4QHt9HPrOD+6cLTt9QnoJKUU6qZCfSMz2+OLCca
	PoXh/zNcZ3/bMUOXvJK/oDqDPtUgH1jzwM4Q2Imuf21RKLeJix4O+7GjvC0YwscyMiED7z/HVlO
	11O7V6ZBVWIWDg1U3hv7M/pVuato7pRwAEB/Owj1oyQUvGPnJ51jhnM6LBUH9d9GHagSHmimJlh
	t7zWvDpdZ5O3rbIxo23wiVMzoknvk9ldHr2gFCufw51SHMHQou4jCqb80NNdT52A5g48VV0lgzF
	cgeAsk=
X-Received: by 2002:a05:600c:8b65:b0:49e:6683:d23c with SMTP id 5b1f17b1804b1-4a18e3ef1bdmr298195925e9.0.1791991235610;
        Wed, 14 Oct 2026 08:20:35 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcf2537fsm8740745e9.8.2026.10.14.08.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:20:33 -0700 (PDT)
Message-ID: <6f97fc22-6107-4bc5-8d0d-508bb3ec78e6@tuxon.dev>
Date: Wed, 14 Oct 2026 18:20:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 2/3] PCI: rzg3s-host: Remove duplicate
 field_get()
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, john.madieu.xa@bp.renesas.com,
 biju.das.jz@bp.renesas.com
References: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1791930919-10628-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1791930919-10628-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 15:20:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24461



On 10/14/26 01:35, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> The LTS commit 94cad2c26306 ("bitfield: Add non-constant field_{prep,get}()
> helpers") causes a duplicate definition of field_get().
> This removes field_get() from pcie-rzg3s-host.c, where the modification
> was made.
> 
> ```
> drivers/pci/controller/pcie-rzg3s-host.c:181:9: error: ‘field_prep’ redefined [-Werror]
>    181 | #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>        |         ^~~~~~~~~~
> In file included from drivers/pci/controller/pcie-rzg3s-host.c:12:
> ./include/linux/bitfield.h:277:9: note: this is the location of the previous definition
>    277 | #define field_prep(mask, val)                                           \
>        |         ^~~~~~~~~~
> ```
> 
> Fixes: d71d7aba7486 ("PCI: rzg3s-host: Revert generic field helpers, use a local field_prep()")
> Cc: John Madieu<john.madieu.xa@bp.renesas.com>
> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.x90@mail.toshiba>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>



