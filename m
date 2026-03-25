Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF53FEA832
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 08:35:53 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17939.1774427751408925194
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 01:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hBpHCOha;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486ff201041so42306355e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774427750; x=1775032550; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ka26ZtX9HUDT7yjN/gIaPVmCnCc1Rf26/GTI+lYrZfE=;
        b=hBpHCOhaqqsUMHXicvqNWccC4uPNTn01ljdbcEzLZQzwsddX53zRXNGDK2bgDwIZcp
         Tdumo5ZZPpqk7zkmfAfy95+BRi6ynl5GsF1RpAfdvWvat3TKxqBevzsLDR9jVLvSpzRD
         F9q94Mf3sp3uDPkLf2r6I9razOysVlCFBZx4kCQpz4V5UKpLD4SpVQSgmutMtmmrfV4L
         gBbtJRqPm/h9IZLD3Yhb6SjFbaopcYGgB8w/dCAWF2ntsoRBwVxcHMviugQOM48+7L21
         lVmOG5KHP7khCZM2UqqRCgeGqNljo4+TvWC3ycwUL/cERlU1TaNthgcDqB4oZnSUgPRw
         Wrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774427750; x=1775032550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka26ZtX9HUDT7yjN/gIaPVmCnCc1Rf26/GTI+lYrZfE=;
        b=aipjuJGf5R7cE6KJ+6+QtYc2ChEzVelDDLrWjPIu/SbyzyRmI+VpKE82Imj0FjYFOR
         dxYYdXOhsM/787NEPAsu8GZA3tyosGjqKq57I+tq3j8s2eouTJm7TKtdYEXo2bP2+qf2
         SYfC9UVJX1WOMiPSFPv+LMvaoh+BzSCzfHnhcjzmLuqrAsbecKWG05a8ZVI4XOZwO61Q
         dhpyKGyqKJP4VaPtK8ghgZ4etPpEkypPiYgvdZjs+emQM0TqOOBTf3wQddum5AU+/2kV
         enmrNwAIu5yEEXH2DcZS0JOEjm+fTh6+UGm/Oz+xWYc5eOD8IS7WBSgGTtljHI/1U9xD
         L/eg==
X-Forwarded-Encrypted: i=1; AJvYcCX6KrYdWBBKZ57J/0aJ9Gq/4Q7xHmaecpErEHi+mtd+XQ14YzBZLvMOxug/PufVG21R5AeCK+j3@lists.cip-project.org
X-Gm-Message-State: AOJu0YyiITELBXMoUOEyhdirvj8tOxdLcv/Ho7yD9dK1X1LBUk+Rvhey
	3X60v1D4Z4phxEKIXycEuaWi20lTOQ4srXFPbpysvQXV/2vJBuEq7aswnMab0UvsMRW3gnPjVIC
	x0nHA
X-Gm-Gg: ATEYQzwakSTuKZ7AazoHqDWpfrqvOWX+EJP1BFRt5dCvZ1vnmMnrncfGB2MIwDaUdHb
	YKzlrRbusCDKJvMnksTCpIvs9UR4rfvbBo/aOjxro+WJ9pXzj3aCbBmhswzmjV9clUl4B0cpgjg
	qg6suBfxQiHCbv6kDs09bG9lJThH12OQtblD9j1DEf7lSQP5HDofR07ewlUiPWMAPjasxUj0Y2M
	q1uB59DUx7V+1hryWu9ePXgL5W97BSiQkpDRBb/fp3Y19xn/xdRmL0ZrO+iLo3sw144fKnjEl6U
	prfZyiGspLZC4ub7UKidhyyNO4lzuittHogtFxyffNWGrlOxX40s+cWebE/XiLo4vBbCfF9R+Cr
	DmLXOgGfAWMAe2/D1bJmU0FNjQigCqizR0l04j0f9VA+k2U52glHKu8Y7DkeLaekOUlOcjs1640
	HYibjlub0ztnLtdMVAEy+0HJQBvreca+c=
X-Received: by 2002:a05:600c:5395:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48716056890mr38986505e9.24.1774427749311;
        Wed, 25 Mar 2026 01:35:49 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64717e97sm47554979f8f.35.2026.03.25.01.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 01:35:48 -0700 (PDT)
Message-ID: <c78b03d4-045d-423e-9265-156641ae8dae@tuxon.dev>
Date: Wed, 25 Mar 2026 10:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 05/28] soc: renesas: rz-sysc: Populate
 readable_reg/writeable_reg in regmap config
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
 <20260311110357.1938200-6-claudiu.beznea.uj@bp.renesas.com>
 <acJYvRx1EYafqZD_@duo.ucw.cz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <acJYvRx1EYafqZD_@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 08:35:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22558

Hi, Pavel,

On 3/24/26 11:26, Pavel Machek wrote:
> Hi1
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> commit c432180a7d95081353a96fd6d5bd75b0fc8a27c3 upstream.
>>
>> Not all system controller registers are accessible from Linux. Accessing
>> such registers generates synchronous external abort. Populate the
>> readable_reg and writeable_reg members of the regmap config to inform the
>> regmap core which registers can be accessed. The list will need to be
>> updated whenever new system controller functionality is exported through
>> regmap.
>>
> 
>> +++ b/drivers/soc/renesas/r9a08g045-sysc.c
>> @@ -18,7 +37,57 @@ static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initc
>>   	.specific_id_mask = GENMASK(27, 0),
>>   };
>>   
>> +static bool rzg3s_regmap_readable_reg(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case SYS_XSPI_MAP_STAADD_CS0:
>> +	case SYS_XSPI_MAP_ENDADD_CS0:
>> +	case SYS_XSPI_MAP_STAADD_CS1:
>> +	case SYS_XSPI_MAP_ENDADD_CS1:
>> +	case SYS_GETH0_CFG:
>> +	case SYS_GETH1_CFG:
>> +	case SYS_PCIE_CFG:
>> +	case SYS_PCIE_MON:
>> +	case SYS_PCIE_ERR_MON:
>> +	case SYS_PCIE_PHY:
>> +	case SYS_I2C0_CFG:
>> +	case SYS_I2C1_CFG:
>> +	case SYS_I2C2_CFG:
>> +	case SYS_I2C3_CFG:
>> +	case SYS_I3C_CFG:
>> +	case SYS_USB_PWRRDY:
>> +	case SYS_PCIE_RST_RSM_B:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static bool rzg3s_regmap_writeable_reg(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case SYS_XSPI_MAP_STAADD_CS0:
>> +	case SYS_XSPI_MAP_ENDADD_CS0:
>> +	case SYS_XSPI_MAP_STAADD_CS1:
>> +	case SYS_XSPI_MAP_ENDADD_CS1:
>> +	case SYS_PCIE_CFG:
>> +	case SYS_PCIE_PHY:
>> +	case SYS_I2C0_CFG:
>> +	case SYS_I2C1_CFG:
>> +	case SYS_I2C2_CFG:
>> +	case SYS_I2C3_CFG:
>> +	case SYS_I3C_CFG:
>> +	case SYS_USB_PWRRDY:
>> +	case SYS_PCIE_RST_RSM_B:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
> 
> I'd not mind refactoring these two so that code could be shared.

OK, I'm going to prepare something for upstream.

Thank you for your review,
Claudiu

