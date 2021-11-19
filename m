Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDFBC433F5
	for <webhook@archiver.kernel.org>; Fri, 19 Nov 2021 06:42:13 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.5362.1637304131956153485
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Nov 2021 22:42:12 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AJ6g9g1021503
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 07:42:09 +0100
Received: from [139.22.32.112] ([139.22.32.112])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AJ6g8mi027189;
	Fri, 19 Nov 2021 07:42:08 +0100
Subject: Re: [cip-dev][isar-cip-core]RFC v2 9/9] swupdate: Backport patches
 from SWUpdate Master
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211117104012.xciipnpvpbb22ghn@MD1ZFJVC.ad001.siemens.net>
 <df72363b-5b34-98fe-b9b0-c6141931a98c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <87b21575-eba4-e45e-3dfd-84dd44af51de@siemens.com>
Date: Fri, 19 Nov 2021 07:42:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <df72363b-5b34-98fe-b9b0-c6141931a98c@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 06:42:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6957

On 17.11.21 12:36, Gylstorff Quirin wrote:
> 
> 
> On 11/17/21 11:40 AM, Christian Storm via lists.cip-project.org wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Backport the following patches to detect the correct partition to
>>> update.
>>> 388f1777 util: Add get_root source /proc/self/mountinfo
>>> 3914d2b7 util: Extend get_root to find LUKS devices
>>
>> Why not upgrade to a newer version of SWUpdate instead of backporting
>> stuff? There's no real advantage to stay on a "release" as SWUpdate
>> follows rolling releases -- granted, you have to do the qualification
>> but that applies to "releases" as well...
>>
> 
> The build of SWUpdate uses dpkg-gbp to follow the Debian build of
> SWUpdate with sources from [1].
> 
> As Debian only follows fixed release , currently 2021.04, I patched the
> version.
> This patchset is no longer necessary after Debian uses the next Release
> SWUpdate version.
> 

I agree that a single backport is better in this case. But as 2021.11 is
to appear soon, it may resolve this automatically for v3 already.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

