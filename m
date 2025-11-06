Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C215CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 14:49:18 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17286.1762440548147657109
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 06:49:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=H+/SYJ0T;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471b80b994bso10130775e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 06:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762440546; x=1763045346; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Qq+Yo8NZILQXx9yU2LSyCIui+OqbcxQqutXJY91wus=;
        b=H+/SYJ0TCaSvTYv7DQ/lnvW0FaBWhdxjj+FSeEkLYJr8x5lBo8a0Th+/UIWiaO8L1e
         MLhZUah9rJe0RNl9qEyDe/8/wc0tTWl1EJeVb++2sGiGrr+bdFg5701/+V+q7tWldqRS
         pEO2kxmgb+TEUhBPFoHzzGjwYbxTpO4gBYbP1R62sDBnrGQyYJMGkkjXM0IW+3kDfoGn
         jRSymXUeYXD49tT6ClwdJYPF1reVR5VwAdS2Ur3WNLVm8q29SFNpdY5y+ajlciV4sF8D
         vBGNNVupIFQh4t3QLeV7iAlrwTzxIoG7kLd0jgZc4uLBi+NigNtH2MQLBujl2LjElkpA
         MqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440546; x=1763045346;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qq+Yo8NZILQXx9yU2LSyCIui+OqbcxQqutXJY91wus=;
        b=fZ0C08U+lBdhUVqZwjg74ejb5IJfBopmXSlLFwusq2FfoAcRhC9MMj9QYqHxXwmpwM
         82qb7CR5zl+0YKPoJXynK7i/afhi6hrhRJHonhU4CzMgCWu5EFolctIhTPaBJacizzCp
         3EH5w2Y4eh7n7RewthEWP+Ac5Py7ks44C5dYhsr+0Fh+fFhSjZF2nTV9/K91Yts7F9Tw
         RAx51Y8c0rjkXSxa6nSSzpmLoZKnv0h77Ju4gF+y5xcztN2Yeq/eJeApDq5n+YqWFrKU
         rdigzHlsPbqnTPyEmkL159cxdOZrRkfemoj0AMNu5g7z0lnFesvELH7dasdlGY59gtSJ
         vhaw==
X-Gm-Message-State: AOJu0YxvgHzIeFi2lNs3SkJVXEh/yr0mlCkFnDttSez5Dsx79v87u2GG
	bNaUUy8bpNnYztwCwMrdgokIdO93u3giiwMxic/f6oePMH3s2QSDO5YqudLe9QRs2qo=
X-Gm-Gg: ASbGncusfMizbUqH+aHxP+4+Ae9dgi+ZoZ0RfZr+vJO0HE5chZo1GQJhRXhcRAwg6wF
	CbKzaS0/9jykBQMEVaJcWDS4rZ+RUB+XBwCCQa72TWqVf7QgKlXrzN8LiZYQ8rU6xgHBJYLch6o
	yBzPFnE0vdtj1692gk3iNPbYC7rWl1Wc5zpmsbKBK5xVAMj4HlqgHAmnRAI7k/T4vS5LB5gDCuN
	km8DdQZGa1DUn3BSXlyj5UAX9XcRbcFx//wrWdS3EgH1BJyB9/YfGsoYz+XxkeIDmdMO3huVu0T
	nil6kcFIsORTf9FNXqrGKTnzSBEIBH4Nz5LSTFRL0+ekfX1nsvgjYdf4817HNPjTV0X7uvfEF72
	qAeZaM326hWZV2nyRqYQHIi5o/H3f1n2GfnRg2XLzfdGp2nulOdPHXmsNo9HLjpfxbjzVeFmXwI
	TZMX/DYQfcgBXMu0V2ztA=
X-Google-Smtp-Source: AGHT+IHva26eBNeSI4kkw+FjsxcNGMUnOmyH+BlACdxlJjeFrqZdMDTbBfzcCNswZPQDDXSL0f+7KA==
X-Received: by 2002:a05:600c:3e1a:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-4775cdad5cfmr65890745e9.7.1762440546306;
        Thu, 06 Nov 2025 06:49:06 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776419d869sm18759065e9.3.2025.11.06.06.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:49:05 -0800 (PST)
Message-ID: <c23c084e-8a2b-4a9e-9e43-502ee4a4b50a@tuxon.dev>
Date: Thu, 6 Nov 2025 16:49:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y-cip] mmc: renesas_sdhi: Set the SDBUF after reset
To: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de
Cc: cip-dev@lists.cip-project.org
References: <20250827104521.931674-1-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250827104521.931674-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 14:49:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20462

Hi, All,

On 8/27/25 13:45, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> commit 68dbe38ed7ba9141b9329eb203fe9762a93b60e8 upstream.
> 
> For development purpose, renesas_sdhi_probe() could be called w/
> dma_ops = NULL to force the usage of PIO mode. In this case the
> renesas_sdhi_enable_dma() will not be called before transferring data.
> 
> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
> call from renesas_sdhi_probe() will configure SDBUF by calling the
> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
> tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
> 
> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
> 
> Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Link: https://lore.kernel.org/r/20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Is there anything I should do for this patch and it's v5.10 variant here:
https://lore.kernel.org/cip-dev/20250827104321.931369-1-claudiu.beznea.uj@bp.renesas.com/T/#u
?

Thank you,
Claudiu


