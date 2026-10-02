Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4A7CA5FD4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 13:48:27 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12494.1790948904125315977
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 06:48:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YKDv6meq;
 spf=pass (domain: tuxon.dev, ip: 74.125.225.141, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so42617175e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1790948902; x=1791553702; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSCpPs/tN2tK6vB44yWD91/CpLjdaJTkiXl+1qyjaMk=;
        b=YKDv6meqmNp0j/MO928vOkJi0t8u8GfM+EK5QYi836TtDwzASuZ5CkNqv0jKLQpPoJ
         YAKZ49t2dIPi29J9i8YMZD95UiwLruhghvTRKbzBlo0m+m0n+H7qGnPmTl2NCmMAwJlg
         JbSyIbZGt4R/y95K5oJSO2vz6vCVpwncaMnUqQdodCYdYnnitEQ8c6BOfH3wBgIpueqa
         4UwzCvzBOCshj1lJ7nPs5gXUQta2rXEBC7Y66jCl0eXkQpQvr4UIW2RaqGxEkVyxRe2j
         m/oKEEtyZNTHYgLhlZ1b6K7D25YaG4VbasbQJ64r+/wEJxlH+VZQxpUoRKjIrmMrCM2l
         8IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790948902; x=1791553702;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSCpPs/tN2tK6vB44yWD91/CpLjdaJTkiXl+1qyjaMk=;
        b=MSZwdKLorDgHUyUihdUrMxpmkdRlwd6DJwS7p/l3LxatOKHxTclSYDKlkLpmo9TFR0
         WqmnjWvvQLHO3ISOebqWjnhKBqCEs8srO1UG1oBck0Xz99wTXrtGUn2nLVRuJc3UA5ff
         URoHi2dMzQzM4AI8ElHVJg4CHf9kcHF4wlOG7woMTf0ZuRn3bF4pwEbTWJFRiaVC6o93
         W0bZpFQ3U32GLMU8LTgPR4Fm/Y45NNFu2CSWNCIkyPj5o9G5Qd3D4XzYm/L9Q85vOqSA
         ZuI+lZwLW2Zybaa1/16qPHgFxLIbgl+F6UocVqDFD8axDtOVYdF0xmnpzTfu7ieorSCS
         Ndow==
X-Gm-Message-State: AFuF++nJqwJQf5x2Ka9lzAB+P2uYqUvx727SPwWz8ZgSgh2MdAWwreqz
	tWsYCajp8yVKpB7ly8yMe8Z68QD53ekjqfDpdvHB0H16TzZw1e1hqlEZN3W2PpiX9yQ=
X-Gm-Gg: AYBFou3IuKNf9Ws16JM9r4chS6eI4LFsLf+gdpGPbznIqegJk0UxUYfzfFD8NXJPTXe
	P1twkuOvHSZzIAydtH5vBRUDRgX6T4q/sR0PeeQ3wMAyeuKBMz0AVdbpdec/lw8aN+dZerSMrBX
	qiZ14ms0PXeZlEiMsPuDoJUAXLTlSTvHdwrDtmY3s6Cox34IFVDhP0NqhCDmzW4sKrI3VvaLRFg
	W4jGCzUg2tRHm/R+d34DSA5BTtH18HZ5dCa9+PwWXhh4H94VeBgv6Cfpu+QFS6Wb7IR7ZmO03TK
	ATWRTfW3yXrDt8e7W84id22h+hGfx9oDCk18TUEJL2eCFiz8M+BP3/O9W3h5M5hH2iuucI05nts
	sieeg8k++v8qNT1KxOC3nRtgzCeqvOEiWpg+NLr4x5ojkX0Bvj36wlhsGY7oZLIwyjsiUw87REk
	ErNNHdQlXXdF/vIe7WnE2zMVGnym3GkcmsIUkrXDyo+IPyRWLqidLFWzX9EF20Eori9VieeBVNc
	xgGrg==
X-Received: by 2002:a05:600c:c089:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-4a0276a2003mr37863195e9.10.1790948901950;
        Fri, 02 Oct 2026 06:48:21 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c8bb0sm90353075e9.11.2026.10.02.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 06:48:20 -0700 (PDT)
Message-ID: <d71210d9-0661-4146-8265-8bcec61f182c@tuxon.dev>
Date: Fri, 2 Oct 2026 16:48:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip v2] PCI: rzg3s-host: Fix compilation
 warning
To: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
References: <18DABA70C609480B.1715499@lists.cip-project.org>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <18DABA70C609480B.1715499@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 13:48:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24418

Hi,

I realized just before sending this patch: the v2 should not be in the patch 
title. Please let me know how would you prefer to handle it.

Thank you,
Claudiu

On 10/2/26 16:46, claudiu beznea via lists.cip-project.org wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Fix the following compilation warning:
> 
> pcie_rzg3s_host.c: In function ‘rzg3s_pcie_probe’:
> ../drivers/pci/controller/pcie-rzg3s-host.c:1558:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>   1558 |  struct rzg3s_pcie_host *host;
>        |  ^~~~~~
> 
> With it dropped extra ';' at the end of the moved line.
> 
> Fixes: c5249a6594d6 ("PCI: Add Renesas RZ/G3S host controller driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v2:
> - dropped extra ';' and updated patch description
> 
>   drivers/pci/controller/pcie-rzg3s-host.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 987015e8ec9b..010b6747a0aa 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1553,10 +1553,10 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   	struct pci_host_bridge *bridge;
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> -	struct device_node *sysc_np __free(device_node) =
> -		of_parse_phandle(np, "renesas,sysc", 0);;
>   	struct rzg3s_pcie_host *host;
>   	int ret;
> +	struct device_node *sysc_np __free(device_node) =
> +		of_parse_phandle(np, "renesas,sysc", 0);
>   
>   	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
>   	if (!bridge)
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24417): https://lists.cip-project.org/g/cip-dev/message/24417
> Mute This Topic: https://lists.cip-project.org/mt/121546794/8377987
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [claudiu.beznea@tuxon.dev]
> -=-=-=-=-=-=-=-=-=-=-=-


