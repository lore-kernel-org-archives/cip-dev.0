Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC27FEA833
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 08:36:23 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17548.1774427774074518719
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 01:36:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fMmNxA9L;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fb439299so52084715e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774427772; x=1775032572; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8v3b84AXH9zy61AD32F90wTkgT4scjARP+KVItP5RZE=;
        b=fMmNxA9LRcGWxbhnD7Qv6DuTcyS9E4wJba2FQxJOcYfQLT/ZJBHSUkgWiUgfoYmckg
         wD3nR0ZrXm7rFqwZq1+gRj1iFstAdbY75arWhBs17N5U0T/VptrvhHzR3xqVwI9BGa68
         YjmE4fJ0rUH2abuIW50iNnZIhIHADu3+8bbIb09zU9ByiGMOU2mHvzfziwVSbyt7O22a
         z39ynl0ot2t/tVZANuMLJhN5Iki4lYeVXclupn45UPUctEKv2lhloWuy+T+36iKBbDWL
         e9uyY6Bc7Mnokos6GBindpgVHxyqWj2QfqCey9e+R7AjVSJn54F3JQCCMBc2rD6VPuzD
         dy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774427772; x=1775032572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8v3b84AXH9zy61AD32F90wTkgT4scjARP+KVItP5RZE=;
        b=ZLB1NDcmPT8hfvXL38+i5lLvott4WXtBX6lBbyzhVPf3HGO34rXF0qpZ1xGCNA16Cn
         KkyYWJBl7duAhh91pXaWhBqsDwlpye8jkQV5zlo/X7VmY8vWw1pU472qoeDF7SfWBoU/
         l5Xp+d9O/8GiKpCg8Pp1NQVNpZo+39C709IPzc5+Hv+rT36aGDs576Oj7+AwWs7lXJx2
         gaWF+cf3rvuX9/OUIHoeAb5nvm3cwJ+53w8vmIySHWQtoDcna1sBjWg/QYKI8sBQyF6F
         zUYWlYAPbWrZILzULGUWx0NhFKfFbBJlFGgvbKZ+bn2OTRm88O9mEq/VMKxiIPm4+lGM
         rWug==
X-Forwarded-Encrypted: i=1; AJvYcCUqgFVibgX9nrPRt51goLZPHpT7enljct+N/Lh78aJo8nLuGpfvTuKKz/PaPoLN8qjGCANvoJsg@lists.cip-project.org
X-Gm-Message-State: AOJu0YyrPqZqt1psfAmarTR8/9eTvBK1I2rpRowN4JKXpjVq4EO/wbf5
	uork3ZlRh0ke2AjKZU9HZWRLgBqIAaKgD91PbvYFFptF+lBOAPbEztgu66vUTPaS5Uw=
X-Gm-Gg: ATEYQzwkZrQrlpKHhdVrdrMWv/aw8zNSnsvyzEqtwhxJ6WrXLI6f+LnaqC3t0F5f6mA
	Y/kmTOFzFMUp5NXr8KQr2ewYisbp+g8ehtEHMMIb/ye7CACwU3Ti0LYcBaL/l4p1egR57QKWzkV
	Nqbsr0QrgCkc9DGBjnX8ix30SLWs9Xui3pBqF3Bv8/ERf2abgb2SKd7WlXdpBfaIrTDi+s/ceab
	j0lb0vkndpvR4N8KBTle/iHckkVYiUuGZOyU0v/xGtldJNejzmYCUlbvh6wJmAu7oCfZpvPDqVL
	oDG6iaLkdWlWkTPOsiQuxY9NJKE+8tWMPuoqhE3/bqyULlLD5KPtntzurgNATk2+uKIPqMcQ4x5
	gUS/KWTxZVhnpPPM/U3nDHF/GmfzURa/X4eHVWNkNGwsmih1n9W7DdUhhXg4XP0ztFo0rfHYBJI
	peQ4DAyciWS6rb8nFkwrdMjth4vtJvs1Q=
X-Received: by 2002:a05:600c:3511:b0:487:467:42a2 with SMTP id 5b1f17b1804b1-487160438e2mr39662635e9.18.1774427772380;
        Wed, 25 Mar 2026 01:36:12 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871728a19dsm30077425e9.1.2026.03.25.01.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 01:36:11 -0700 (PDT)
Message-ID: <02bf97da-a22e-4849-bd33-5bcd9641372b@tuxon.dev>
Date: Wed, 25 Mar 2026 10:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 09/28] PCI: Add
 PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
 <20260311110357.1938200-10-claudiu.beznea.uj@bp.renesas.com>
 <acJabrcQAzuYQzi2@duo.ucw.cz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <acJabrcQAzuYQzi2@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 08:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22559

Hi, Pavel,

On 3/24/26 11:33, Pavel Machek wrote:
> Hi!
> 
>> commit d5ceb9496c565eb5763c127c6eb2d2b3068ab1df upstream.
>>
>> Add the PCIE_RESET_CONFIG_DEVICE_WAIT_MS macro to define the minimum
>> waiting time between exit from a conventional reset and sending the
>> first configuration request to the device.
>>
>> As described in PCIe r6.0, sec 6.6.1 <Conventional Reset>, there are two
>> different use cases of the value:
>>
>>     - "With a Downstream Port that does not support Link speeds greater
>>       than 5.0 GT/s, software must wait a minimum of 100 ms following exit
>>       from a Conventional Reset before sending a Configuration Request to
>>       the device immediately below that Port."
>>
>>     - "With a Downstream Port that supports Link speeds greater than
>>       5.0 GT/s, software must wait a minimum of 100 ms after Link training
>>       completes before sending a Configuration Request to the device
>>       immediately below that Port."
>>
>> [kwilczynski: commit log]
>> Link: https://lore.kernel.org/linux-pci/20240328091835.14797-21-minda.chen@starfivetech.com
>> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
>> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
>> [claudiu.beznea: fixed conflict by keeping only the definition for
>>   PCIE_RESET_CONFIG_DEVICE_WAIT_MS]
> 
> I don't understand the message here. Upstream patch seems to be
> identical to this one, but context differs.

Yes, the commit d5ceb9496c565eb5763c127c6eb2d2b3068ab1df ("PCI: Add 
PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value") and this patch are 
identical, but, cherry-picking commit d5ceb9496c565eb5763c127c6eb2d2b3068ab1df 
on top of v5.10.249-cip69 give the following conflict:

#define PCI_VSEC_ID_INTEL_TBT   0x1234  /* Thunderbolt */ 

  

<<<<<<< HEAD 

======= 

#define PCIE_LINK_RETRAIN_TIMEOUT_MS    1000 

  

/* Power stable to PERST# inactive from PCIe card Electromechanical Spec */ 

#define PCIE_T_PVPERL_MS                100 

  

/* 

  * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization> 

  * Recommends 1ms to 10ms timeout to check L2 ready. 

  */ 

#define PCIE_PME_TO_L2_TIMEOUT_US       10000 

  

/* 

  * PCIe r6.0, sec 6.6.1 <Conventional Reset> 

  * 

  * - "With a Downstream Port that does not support Link speeds greater 

  *    than 5.0 GT/s, software must wait a minimum of 100 ms following exit 

  *    from a Conventional Reset before sending a Configuration Request to 

  *    the device immediately below that Port." 

  * 

  * - "With a Downstream Port that supports Link speeds greater than 

  *    5.0 GT/s, software must wait a minimum of 100 ms after Link training 

  *    completes before sending a Configuration Request to the device 

  *    immediately below that Port." 

  */ 

#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS        100 

  

 >>>>>>> d5ceb9496c56 (PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time 
value)
extern const unsigned char pcie_link_speed[]; 

extern bool pci_early_dump; 


So, I had to manually adjust it and keep only the 
PCIE_RESET_CONFIG_DEVICE_WAIT_MS define along with its documentation.

Thank you,
Claudiu

