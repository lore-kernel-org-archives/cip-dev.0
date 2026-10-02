Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F7CA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 13:49:17 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12513.1790948955267240564
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 06:49:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=C5PJyNwR;
 spf=pass (domain: tuxon.dev, ip: 74.125.225.141, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso374195e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1790948953; x=1791553753; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97G/lr+3fToLIoat73Bk5iTr2dd2yzJT2/7HkVIWCrY=;
        b=C5PJyNwRItD0W9T3opCGTeUAVpTp1Czd6uglWAv1fEcwOJfO7oQ3QTMQCGBKIneogD
         +n2iDfvS0D7zvx/lSsb8bip6LGZzvzF6a6pgR2vn+rQYOybLGfNwd6Var4+ix5mNs9Ce
         ntCFI/ELhUr5pVPGZPP6m8moHg4LybX2b/1cdksIl2O4Z4mwW/Pbb9ziv56+Bb2mSpxK
         RIlsdx3C3ekXkakOGbi3XxqBC8gqsCfMZEu36lgJ0bgDUvfAgP4dgUCxbOz/v9X71OSV
         7DzXGxjIQTa231LT5JeM98nkanQglmHN56On2k7OWAvT81cRAagjObXUvxUEyKerTKA4
         XmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790948953; x=1791553753;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=97G/lr+3fToLIoat73Bk5iTr2dd2yzJT2/7HkVIWCrY=;
        b=iXUn2MO1HUJYYU7bETx36PtxoWBEfeuhuH/4Jf+jWJLnkZ8Dbra/r0YDx+ZOsxVFPf
         I/Kqf70oFBZOIZUhsrdDWyQA8B0+8VopaSkkSzRsN+tqdeEYE39iOs4fuKkDLJVkBd2/
         cYRiS8uxFkuX6Yc/+HOIglx5lLacSxzPbu76LzxOXHFOQucKZe/0CBKM519jZV/0ozmv
         tidV7UMgFTh0js/r6BlvmcRptkAyYfhfTZzbxGNAIA3rdaep5OlKIcBwqQe3eGN5kzzS
         o3aHazW8vDT2mkrjrCdmR3VcZKG0Mv6MXg2u0bHBDmARiBcvFMjE4nLS+lEKKWKlMcx2
         SYYA==
X-Gm-Message-State: AFuF++lY6uv0h1hj0uJYynFpxP7Ty5rwzdxecZ/B+tL+wquRtOwsnAqu
	NL4EiSWqyLJzTkxfLQEmMgRy2Q3Zw2ukB56nWVM3YxSyqYHjI2zW6P2maIaW9/Uc0lIetX/sLZG
	WDSQhPb4=
X-Gm-Gg: AYBFou3mQoE5YPodC/O8e3mYmX1+5McZAadz3msX8ZCE+QnGW9UnQTfWdDRHmOeH6Yx
	SiiXjwPPqB7gZUTAMFetbjIKhfXfeqLY4onHY6pCcxPgMJqHOAMthjpdiHSPW9POXxLblSsLTO3
	EinuTzTFV6yCMnda9kM7D8gHoUzNAsnXL4xS0sHhI3f4LI8xFdktgKcPv02IlCJqDMiPPfS4Rsp
	g+k6QISyK/ocFv0rGsCC0N5fSZZ28rIeF4TiAvHa5diTc2FqDBEobM6epBxYNkC/nvJY27o2cu+
	0uYzU/RfWapwGQCEje2Lq2p4G22AL+YzWpIKc0H2TvZAubRDSz96sC7SskBtMxii83wOnmrtoAn
	WUQRaIbPIHOJAAfqUfdCcV4eELorC7M04dUfVhit35aPIpsiG0UUc+3MxYQmYjWfLYYTlutMGLA
	y3wgx3UKFTU2ydCWCj1mvb2L8z0Lq8j4zhphGHvPWKExSTaHtYunjsb/3TpCj1A4eEvQckbQ2FY
	JaP0w==
X-Received: by 2002:a05:600c:4e55:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-4a02755a141mr52305185e9.14.1790948953310;
        Fri, 02 Oct 2026 06:49:13 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm69647925e9.13.2026.10.02.06.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 06:49:12 -0700 (PDT)
Message-ID: <a33b1f98-8d7f-4826-b6aa-2058cc81b2db@tuxon.dev>
Date: Fri, 2 Oct 2026 16:49:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip v2] PCI: rzg3s-host: Fix compilation
 warning
To: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
References: <18DABA70C609480B.1715499@lists.cip-project.org>
 <18DABA8A478FA49E.2870736@lists.cip-project.org>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <18DABA8A478FA49E.2870736@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 13:49:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24419



On 10/2/26 16:48, claudiu beznea via lists.cip-project.org wrote:
> Hi,
> 
> I realized just before sending this patch: the v2 should not be in the patch 

s/before/after

> title. Please let me know how would you prefer to handle it.
> 
> Thank you,
> Claudiu
> 
> On 10/2/26 16:46, claudiu beznea via lists.cip-project.org wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Fix the following compilation warning:
>>
>> pcie_rzg3s_host.c: In function ‘rzg3s_pcie_probe’:
>> ../drivers/pci/controller/pcie-rzg3s-host.c:1558:2: warning: ISO C90 forbids 
>> mixed declarations and code [-Wdeclaration-after-statement]
>>   1558 |  struct rzg3s_pcie_host *host;
>>        |  ^~~~~~
>>
>> With it dropped extra ';' at the end of the moved line.
>>
>> Fixes: c5249a6594d6 ("PCI: Add Renesas RZ/G3S host controller driver")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - dropped extra ';' and updated patch description
>>
>>   drivers/pci/controller/pcie-rzg3s-host.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/ 
>> controller/pcie-rzg3s-host.c
>> index 987015e8ec9b..010b6747a0aa 100644
>> --- a/drivers/pci/controller/pcie-rzg3s-host.c
>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>> @@ -1553,10 +1553,10 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>>       struct pci_host_bridge *bridge;
>>       struct device *dev = &pdev->dev;
>>       struct device_node *np = dev->of_node;
>> -    struct device_node *sysc_np __free(device_node) =
>> -        of_parse_phandle(np, "renesas,sysc", 0);;
>>       struct rzg3s_pcie_host *host;
>>       int ret;
>> +    struct device_node *sysc_np __free(device_node) =
>> +        of_parse_phandle(np, "renesas,sysc", 0);
>>       bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
>>       if (!bridge)
>>
>>
>>
>>
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24418): https://lists.cip-project.org/g/cip-dev/message/24418
> Mute This Topic: https://lists.cip-project.org/mt/121546794/8377987
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [claudiu.beznea@tuxon.dev]
> -=-=-=-=-=-=-=-=-=-=-=-


