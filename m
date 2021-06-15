Return-Path: <SRS0=mEFl=LJ=lists.cip-project.org=bounce+64572+6523+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B317C48BDF
	for <cip-dev@archiver.kernel.org>; Tue, 15 Jun 2021 07:37:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A905C6140B
	for <cip-dev@archiver.kernel.org>; Tue, 15 Jun 2021 07:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A905C6140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6523+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GTavYY4521723xJqNlSjs16T; Tue, 15 Jun 2021 00:37:23 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.6228.1623742642170754882
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jun 2021 00:37:22 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 15F7bKGl002319
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 15 Jun 2021 09:37:20 +0200
X-Received: from [167.87.43.222] ([167.87.43.222])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 15F7bJjJ020754;
	Tue, 15 Jun 2021 09:37:19 +0200
Subject: Re: [cip-dev][isar-cip-dev][PATCH 2/2] swupdate: Add option to use swupdate-handler-roundrobin
To: cip-dev@lists.cip-project.org,
        "Storm, Christian (CT RDA IOT SES-DE)" <christian.storm@siemens.com>
References: <20210614111926.qqfyezqnp6pbslk4@MD1ZFJVC.ad001.siemens.net>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <2172b597-ebfc-e4b3-57a8-61f6a8689e68@siemens.com>
Date: Tue, 15 Jun 2021 09:37:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614111926.qqfyezqnp6pbslk4@MD1ZFJVC.ad001.siemens.net>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0rY8Ds5Fac4CTNZlrWj5f2eux4520388AA=
Content-Type: multipart/mixed; boundary="wYH3JCy9o0TNwC1Lpj8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623742643;
 bh=KfudY1zoVsbqDCozeaw1K8MH18/oSJNTo4m16e5+wOc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=k/RKVhSVEgJS3KorRj0MJt4EbyXPsGN7f+JPTpYtBiPnbROu7/OABYuI3b1RWRKF9Br
 EOilO96bixGP/DHuZfZ8OgRxVH9V+kFLQ3+eLqQ2b+KligqOKLYzJ4ESk8bQunmlG9tHw
 30GwCPqHrcEc52YVB9eSIIXHUqw/i1wvxYM=

--wYH3JCy9o0TNwC1Lpj8r
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 6/14/21 1:19 PM, Christian Storm via lists.cip-project.org wrote:
> Hi Quirin,
> 
>> --- a/recipes-core/images/files/secure-boot/sw-description.tmpl
>> +++ b/recipes-core/images/files/secure-boot/sw-description.tmpl
>> @@ -14,16 +14,22 @@ software =
>>       name = "secure boot update"
>>       images: ({
>>               filename = "${ROOTFS_PARTITION_NAME}";
>> -            device = "fedcba98-7654-3210-cafe-5e0710000001,fedcba98-7654-3210-cafe-5e0710000002";
>> +            device = "sda4,sda5";
> 
> Did you intentionally go from UIDs to PATHs?
> Why not uniformly using UIDs?

This change was intentionally.

The `getroot` function in the new handler cannot use UUID if there is no 
root option in the kernel commandline.

As the initrd selects the root filesystem partition,the root option was 
not added to the kernel command line.
> 
> 
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini
>> @@ -0,0 +1,20 @@
>> +[image]
>> +chainhandler=raw
>> +
>> +[image.selector]
>> +method=getroot_rr
>> +key=root
>> +
>> +[image.bootenv]
>> +ustate=1
> 
> Are you sure you really need setting ustate these days?

I missed that - It is no longer necessary. I will update in v2.

> 
> 
> 
> Kind regards,
>     Christian

Thanks for the review and Kind regards,
Quirin

--wYH3JCy9o0TNwC1Lpj8r
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6523): https://lists.cip-project.org/g/cip-dev/message=
/6523
Mute This Topic: https://lists.cip-project.org/mt/83469366/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wYH3JCy9o0TNwC1Lpj8r--
