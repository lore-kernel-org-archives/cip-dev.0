Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A41CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 07:35:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.124483.1781508931033973227
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 00:35:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=78qu=el=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 331B14440F;
	Mon, 15 Jun 2026 07:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7091F000E9;
	Mon, 15 Jun 2026 07:35:28 +0000 (UTC)
Message-ID: <5dd61d89-971a-4a8a-a95d-c3d9723f6566@tuxon.dev>
Date: Mon, 15 Jun 2026 10:35:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding
 attributes
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
 "pavel@nabladev.com" <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
 <20260611104532.2532863-22-claudiu.beznea@tuxon.dev>
 <TY3PR01MB113463A4C767A966DE71DE7CC86192@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113463A4C767A966DE71DE7CC86192@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jun 2026 07:35:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23135

Hi, Biju,

On 6/13/26 08:54, Biju Das wrote:
> 
> Hi Claudiu,
> 
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of claudiu beznea via
>> lists.cip-project.org
>> Sent: 11 June 2026 11:46
>> To: nobuhiro.iwamatsu.x90@mail.toshiba; pavel@nabladev.com
>> Cc: cip-dev@lists.cip-project.org
>> Subject: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding attributes
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> In v6.1 CIP the drivers that are involved for the USB to work on the Renesas RZ/G2L based devices are
>> the following:
>> - rzg2l_usbphy_ctrl
>> - phy_rcar_gen3_usb2
>> - ochi, echi, renesas_usbhs
>>
>> The drivers tree is as follows:
>>
>>          +-----------------------------------------------------------+
>>          |                                                           |
>>         \ /                                                          |
>>          `                                                           |
>> rzg2l_usbphy_ctrl <--> phy_rcar_gen3_usb2 <--+--> ohci <------------+
>>                                               +--> ehci <------------+
>>                                               +--> renesas_usbhs  <--+
>>
>> Where:
>> - rzg2l_usbphy_ctrl provides reset signals to phy_rcar_gen3_usb2 and
>>    OHCI, EHCI, renesas_usbhs drivers
>> - phy_rcar_gen3_usb3_usb2 request reset signals from rzg2l_usbphy_ctrl
>>    and provides PHYs to OHCI, EHCI, renesas_usbhs
>> - OHCI, EHCI, renesas_usbhs drivers gets resets from rzg2l_usbphy_ctrl
>>    driver and PHYs from phy_rcar_gen3_usb2
>>
>> In the current v6.1 CIP tree, unbinding any of the providers in the mentioned diagram does not force
>> the unbinding of the consumers. 

This is the problem that leads to failures (it is not about the harmless stack 
traces fixed by your patch). The problem is that the consumer drivers ends up 
using references to the provider drivers that were unbound. The unbind of a 
provider driver don't lead to the unbind of the consumer driver.

> In these scenarios, the consumers remain with stale resources.
>> Subsequent operations that require resources from the providers will fail, either silently or loudly
>> (crashes). Rebinding the previously unbound provider does not resolve the issue either.
> 
> Not sure, have you tried with this patch[1]?

The problem addressed by this patch is not simply the harmless WARN_ON() stack 
trace displayed due to the regulator but rather crashes which leads to system 
being unavailable. This is because some drivers are still using references (e.g. 
PHY handles) to the drivers that were previously unbound/bound.

> 
> On mainline while adding RZ/G3L USB2.0 host support, I used to get WARN_ON for regulator enable count during
> PHY unbind/bind and is fixed by[1]

Is not about the harmless WARN_ON() but failures that lead to system crashes.

Thank you,
Claudiu

> 
> PHY unbind releases regulator, PHYS to OHCI/EHCI, so I get USB disconnect
> 
> PHY bind acquire vbus regulator, PHYS to OHCI/EHCI, and I get USB connect
> 
> [1] https://lore.kernel.org/20260612143048.317907-10-biju.das.jz@bp.renesas.com/T/#u
> 
> Cheers,
> Biju
> 
>>
>> The only way the unbind/bind sequence works for the above-mentioned scenario is to perform the unbind
>> starting with the consumers and ending with the providers, and to perform the bind starting with the
>> providers and ending with the consumers.
>>
>> Suppress the binding attributes.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>   drivers/phy/renesas/phy-rcar-gen3-usb2.c | 1 +  drivers/reset/reset-rzg2l-usbphy-ctrl.c  | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>> index 03d6183a385f..a67a9e688dca 100644
>> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>> @@ -903,6 +903,7 @@ static struct platform_driver rcar_gen3_phy_usb2_driver = {
>>   		.name		= "phy_rcar_gen3_usb2",
>>   		.of_match_table	= rcar_gen3_phy_usb2_match_table,
>>   		.pm		= pm_ptr(&rcar_gen3_phy_usb2_pm_ops),
>> +		.suppress_bind_attrs = true,
>>   	},
>>   	.probe	= rcar_gen3_phy_usb2_probe,
>>   	.remove = rcar_gen3_phy_usb2_remove,
>> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
>> index 3f88550a6946..3af61bbe7f98 100644
>> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
>> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
>> @@ -343,6 +343,7 @@ static struct platform_driver rzg2l_usbphy_ctrl_driver = {
>>   		.name		= "rzg2l_usbphy_ctrl",
>>   		.of_match_table	= rzg2l_usbphy_ctrl_match_table,
>>   		.pm		= pm_ptr(&rzg2l_usbphy_ctrl_pm_ops),
>> +		.suppress_bind_attrs = true,
>>   	},
>>   	.probe	= rzg2l_usbphy_ctrl_probe,
>>   	.remove	= rzg2l_usbphy_ctrl_remove,
>> --
>> 2.43.0
> 


