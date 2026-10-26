Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39998.1793011765388706838
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 03:49:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=aJIOYwhj;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso25018605e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793011763; x=1793616563; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNt2ONNJWFv/uDCrzZhJQGHFGAkVP47XNUV4o5ug3rU=;
        b=aJIOYwhjP1A/KeSG1PMX1Uf37GoIichM/cHmgpHZeI7d4XXCmlLiu/2JFiMtURw0rs
         t+qYjLCdCbiRvaf6cpBC7p/vxoTmey0yQHQOXcxgQaoN/NVRPjonceGJ3QAY6qojoUr9
         K2TIOvMJfG1YQx0Z3QAq5+PDiXMsp9glZPJHeCg0kME8Moe9srltvt9nztSqxSqmHS3t
         0a18xhK6zmiWs910ZrvhISQwZ+BUsEDi3z2NNymQpmYjn5ZhtMQzEWbDLVSFeQHV0r3Z
         wBdd7jTkcca/ySUpKczDkJLyHb3rs9op7O9xWk1G24W6BReikI8Hwxil5kR2nduJnYhB
         ggDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011763; x=1793616563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FNt2ONNJWFv/uDCrzZhJQGHFGAkVP47XNUV4o5ug3rU=;
        b=OgUdMRkpU4LkzWmQhpFQYzpZGJE4AAvdic1+FbS/VYBYaM5FvB1qHE0hZ7NkvKj2IW
         oyOftVONIt9KNgNGjqQ2c2EdF1dt1+l8JcYfJ9gFqhw2Y9zdHLyuLxzkZO1S0OGtIjI6
         bi9KRBW9mfcWL9cKY/LbMCLH77cwGTp5EcHMVzXYin8mdr3OuUXYgwn750wB22wUHI1H
         eA1H1z7fGgcnY64lb/JqIOT2Kod8vCKIjePwZbDkLVYg6EJZ5cDlsn/QzzXxu2+9U+RI
         4Mw21SXfHukA3Rgdk7St3lADSE48r3RSCWPYAAl3heOHhOLoAyyCQaMGCXCoQUMkcqg+
         8raA==
X-Forwarded-Encrypted: i=1; AKwUvBwXYdAkVSLfkbk41BG1yMyVK9erHVpyxopN5iFyiCf0WYT6aypCPVqdu2977d8zCxWpoEWGVEV5@lists.cip-project.org
X-Gm-Message-State: AFq9FYJdDf+lH/3BAA1U++XU6Bhfg6axIUTA/afTLkA+j9xJEFC4lSr/
	hdd4dXxoUi8aOsirTRJ+91P2dPIlGIP1Wp6Fgp/KFRGVsL/5ByCC4yXzKsiYWXNiPvc=
X-Gm-Gg: AYBFou1SzNFdFIAdc1Cqk7fNVdxRbaY8ks6GFKGfo7ckxwa5hfPhUl2eow+N4KHs/uk
	oqsX/vc6532eMIy4lHKzWPhGF39GEoZXUQzGrkl8n1nd+rwDJ1OrXEt2tfnUGU2h1OJ/N4HZCkI
	r2Lz72W/2jrX6REDtSBw6+uAS9XYjamxPS4qJH5WdM1XKOAgmz6j4f6GXazw+WykHnVUnR91R7S
	bTZoVV0qXC+V9UfV8k1krphtKQRcOdX0/qlNphOL7HF07cu/NmtQ9UysY6UaWGlOqaF+FA54cNM
	W1UKOyjvuHfDFTH8RkXRJ6nvh/CVgO4NptuSNldPHEgFEroiQO8SMKQk1Dm+oxPj+GOr2bkZ5L2
	7y+zo9nGYHdKpPDCZ2GQMrIzsoal07Z8DNfSfTlr3ez+N30Y0mqzBdvFMZwtr5fYKneHTORTkMg
	ULuvpUDJhyrNikGjQZZcyfWFYCHi4/3Kc44jqzd02B9+iod/gXVG6Y1RG2Pf9EWWhMiISOOBp4O
	KmtlzDik8zLmfLS4bNqpnaDbBI/bwpXK0YYxXUrOfz0vXQRiQdrG4/S0pFTtHqy
X-Received: by 2002:a05:600c:3e86:b0:4a2:cbe:bebc with SMTP id 5b1f17b1804b1-4a35aca5f94mr114146105e9.23.1793011763626;
        Mon, 26 Oct 2026 03:49:23 -0700 (PDT)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a74d7f18a3sm9426905e9.1.2026.10.26.03.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:49:22 -0700 (PDT)
Message-ID: <e9d08796-00b8-4c59-8a33-5b6fa5514889@tuxon.dev>
Date: Mon, 26 Oct 2026 12:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 3/5] iio: adc: rzg2l_adc: Set driver
 data before enabling runtime PM
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
 fabrizio.castro.jz@renesas.com, claudiu.beznea.uj@bp.renesas.com,
 cosmin-gabriel.tanislav.xa@renesas.com
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979242-32127-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1792979242-32127-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 10:49:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24543



On 10/26/26 03:47, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> From: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> 
> commit c69e13965f26b8058f538ea8bdbd2d7718cf1fbe upstream.
> 
> When stress-testing the system by repeatedly unbinding and binding the ADC
> device in a loop, and the ADC is a supplier for another device (e.g., a
> thermal hardware block that reads temperature through the ADC), it may
> happen that the ADC device is runtime-resumed immediately after runtime PM
> is enabled, triggered by its consumer. At this point, since drvdata is not
> yet set and the driver's runtime PM callbacks rely on it, a crash can
> occur. To avoid this, set drvdata just after it was allocated.
> 
> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> Signed-off-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> Link:https://patch.msgid.link/20250810123328.800104-3-claudiu.beznea.uj@bp.renesas.com
> Cc:<Stable@vger.kernel.org>
> Signed-off-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> Signed-off-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.x90@mail.toshiba>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
