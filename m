Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39950.1793011551022902458
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 03:45:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Y2QLiBF4;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e0d885929so1809225f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793011549; x=1793616349; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBKyeoi7ybRPNg3eU4WMLgbTTAZkwx1EjbCd9IeqnOY=;
        b=Y2QLiBF4MNTO58Vhh1RKkNmXqjH4EgohnTwJYbnKr1VK7pgUbX2UMsxQzInj+SCKU3
         c8ndtHgMLeLona8XChHZ5fw34IwEVyQtS4QxxW5NpxJAd4IcbU5X8yVNRXJfZ0q7O3UC
         GTJcHQHvjU88M5A4oswx2gqi2/hoE0ZCLhugqptdFB8YWp3CLVFX9rsLXhtcsoecpyIh
         lbckGM5Uew+ii59G7Pcs+0pK4BVP85pwKnzPyiUaL8DZ3EE5JbBTUQmn4UXi8GF/1LLA
         qAcIyjtH00qjFRCRtrXGaeRwx9gdwco5hsAf4u+ejspo7wD6H6F1Ww4NPozqeJrH9T1j
         L1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011549; x=1793616349;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qBKyeoi7ybRPNg3eU4WMLgbTTAZkwx1EjbCd9IeqnOY=;
        b=K9Wd/cSMirT9/zVuhrzAU7fKSpKxHh3pZ0PquPh+Vwps/y+WL6gyCgLbZbhe7hQPdC
         fAv+K93NsCgDK+IX4n5/7qdMWQXBl9WtDW0LeboGclIZI7NabELkYASTBSrnvXXQ5iWL
         JKyZhNe7kqvk/rkKmFz2S3RrJ15eOYjbi02fizVZSivhGlDD9W/IAcUPGs+nBtcbGUjD
         HrQ3I+6XcsFEtE9E962j43BwYnT7CT57vIf+QUhn2p+WdVDUBepsSVC30hK4c7Rh1tZr
         hXKnue4JCG//KFYKQxfxOFpi8XhrkvpDPtShJPzUsIftbIu9BRUO+gPD3i0JeXsdaMBm
         hN+A==
X-Forwarded-Encrypted: i=1; AKwUvBxYKC3Rzj+swtgAekhMwejU3WLNGTeWAgnZgEpWoqDncqmbD8FbsTC5L3xeh9NTHhudSOGXQs10@lists.cip-project.org
X-Gm-Message-State: AFq9FYKAfs6vCqEtroHk40SBl6wJBeE1g16wRniWRqXU6VJPMUOli93w
	0HwmhjmUMoa1Rbpqese9BwuY29KnhnRCq/AabLocoLgs0DmXm+CJlYnTJTxf7oCS4vU=
X-Gm-Gg: AYBFou0JEe81B7Ndgy8JrAvLTWyU9w699JdRumk/9nQ2GS6lHYA1sD2yRMK7XIvwTdb
	LxMWlGm90Fw36IrROMhEQcbnEEfe6A/a/JZqUVYnLFWHSYt4R0ORW2B2v+mEcPQ63qNJs7vVgOp
	zyw0omjnSISqor02Q3ev97k5bhnqUDDyf/NFcwTLkHtWqES4irj02P6muF0HJXSCWqI4FDjky6T
	gKYc59ljzPnz3CNEwDZHPzvPWe3tJsgUnqTm52cGZBle/gZig9gRXeZWdyhnn3CE2bHVLrVmjTy
	InCJD2oh+Exhy1jzLjK5OqYJ8OpKnshcuU/9H71nSPD1BF2kMtnR9LFzV/fzI+O5lKeEHMWfgTx
	8Bpp+v+dKE+udv1/+mPHFp2OarliXob92USmHBlNh99Siu9tWeyj46u69onjeCkkzzM2SwBUOtP
	AGvaPhhnud6PpfOA3VIA4vLiSfU5ElekZEHNNTDRbbCvoRVG0tN2orzo2pcSUKGHTJvfVSe77jk
	xZwRSb8BP43/p6a3AELvfGESo4FAsBPYOyNVM/Z2FMFRNDwgj6NS0ArtSE2fGBR
X-Received: by 2002:a05:6000:4202:b0:48d:ff71:dd87 with SMTP id ffacd0b85a97d-48e3eb9a3bamr11853411f8f.17.1793011549021;
        Mon, 26 Oct 2026 03:45:49 -0700 (PDT)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f36asm15883979f8f.1.2026.10.26.03.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:45:48 -0700 (PDT)
Message-ID: <3fa7b29e-3c5f-4325-9692-3ba5a6a944f8@tuxon.dev>
Date: Mon, 26 Oct 2026 12:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 1/5] i3c: master: renesas: Fix memory
 leak in renesas_i3c_i3c_xfers()
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
 fabrizio.castro.jz@renesas.com, claudiu.beznea.uj@bp.renesas.com,
 cosmin-gabriel.tanislav.xa@renesas.com
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979242-32127-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1792979242-32127-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 10:45:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24541



On 10/26/26 03:47, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
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
