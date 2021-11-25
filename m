Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5970BC433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 10:28:46 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.10435.1637836125333750045
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 02:28:46 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1APASgmY006626
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Nov 2021 11:28:42 +0100
Received: from [167.87.34.251] ([167.87.34.251])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1APASeMO018503;
	Thu, 25 Nov 2021 11:28:41 +0100
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        kazuhiro3.hayashi@toshiba.co.jp
References: 
 <TYCPR01MB84234CF202EC19BCBE72D233E1619@TYCPR01MB8423.jpnprd01.prod.outlook.com>
 <63eb7f13-cf72-bd5c-e62e-f0fe2d773c67@siemens.com>
 <TYCPR01MB84234222EC358E4F72483333E1619@TYCPR01MB8423.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [cip-dev] Replacing BBB kernel config: Status and AIs
Message-ID: <9f0339ef-2a01-90f7-60bf-7d4bd5c95f57@siemens.com>
Date: Thu, 25 Nov 2021 11:28:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: 
 <TYCPR01MB84234222EC358E4F72483333E1619@TYCPR01MB8423.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 10:28:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7016

Hi Kazu,

On 11/24/21 2:02 PM, Kazuhiro Hayashi via lists.cip-project.org wrote:
> Hi Quirin,
> 
> [...]
>>
>> Sorry, v2 was lying around at [1].
>>
>>
>> [1]:
>> https://gitlab.com/Quirin.Gy/cip-kernel-config/-/tree/feature/bbb-isar-config
> 
> OK, thanks for creating these patches!
> 
>>
>> Testing is missing.
> 
> Toshiba members can test them using our BBB.
> Please let me know if you already have the steps to testing.
> 
> Best regards,
> Kazu
> 
[1] containts the current state of the integration of [2] into  
isar-cip-core. It can be tested for booting, but for SWUpdate test the
u-boot environment is not correct.


[1]:  
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/bbb/cip-kernel-defconfig
[2]:  
https://gitlab.com/Quirin.Gy/cip-kernel-config/-/tree/feature/bbb-isar-config

Best regards
Quirin
[...]


