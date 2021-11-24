Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A02C433FE
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 12:32:38 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.5520.1637757157243312882
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 04:32:37 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AOCWYQA015678
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 13:32:34 +0100
Received: from [139.22.38.174] ([139.22.38.174])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AOCWYkE012068;
	Wed, 24 Nov 2021 13:32:34 +0100
Subject: Re: [cip-dev] Replacing BBB kernel config: Status and AIs
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
References: 
 <TYCPR01MB84234CF202EC19BCBE72D233E1619@TYCPR01MB8423.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <63eb7f13-cf72-bd5c-e62e-f0fe2d773c67@siemens.com>
Date: Wed, 24 Nov 2021 13:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: 
 <TYCPR01MB84234CF202EC19BCBE72D233E1619@TYCPR01MB8423.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 12:32:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6996

Hi,

On 11/24/21 1:02 PM, Kazuhiro Hayashi via lists.cip-project.org wrote:
> Hello Jan, Quirin,
> 
> In CIP Core meeting today, we tried to discuss the current status of the activity[0]
> to replace the kernel config for BBB in isar-cip-core (bbb_defconfig)
> by cip-kernel-configs (cip_bbb_defconfig), but there was no enough time to conclude this.
> 
> Questions:
> Do you have any plan to create the patch v2[1] to add some configs to cip_bbb_defconfig (for both 4.4 and 4.19?)
> If yes, is the next step to create the patch v2 then test swupdate with 4.4 and 4.19 kernel on BBB?
> 
> You can find the meeting note[2] related to this topic.
> 
> [0] https://lore.kernel.org/cip-dev/f8f989ef-7ee2-42ee-a922-f53c6d2b07fe@siemens.com/T/#m864738e612f98752d216bc976135c274fd73eaa4
> [1] https://lore.kernel.org/cip-dev/f8f989ef-7ee2-42ee-a922-f53c6d2b07fe@siemens.com/T/#m4b75aee175603bd1f06a8eec2b47ac08bda85c5a
> [2] https://docs.google.com/document/d/1MwHdFd6QuXcdQfxvaLkcm1sqo9zEC-CWxjof8OJFXLM/edit#heading=h.e88ar5knf3z8

Sorry, v2 was lying around at [1].


[1]:  
https://gitlab.com/Quirin.Gy/cip-kernel-config/-/tree/feature/bbb-isar-config

Testing is missing.

> 
> Best regards,
> Kazu

Quirin

