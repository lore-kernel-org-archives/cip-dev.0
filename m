Return-Path: <SRS0=2nMu=7Q=lists.cip-project.org=bounce+64572+4670+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C2DC433E0
	for <cip-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:29:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56905206A2
	for <cip-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HJokQG3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56905206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4670+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gLZRYY4521723xEaF6FXltYe; Wed, 03 Jun 2020 08:29:47 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.16402.1591198184788355037
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 08:29:45 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 053FTeJj004739
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2020 17:29:40 +0200
X-Received: from [139.22.36.189] ([139.22.36.189])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 053FTcXv016419;
	Wed, 3 Jun 2020 17:29:39 +0200
Subject: Re: [cip-dev] FW: Needs of security patches on reference platforms
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@ucw.cz>
Cc: masashi.kudo@cybertrust.co.jp
References: <TY2PR01MB497299162A4205C540691913A0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <TY2PR01MB497220F7BDB51660FF9B221FA0B10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <e6529e13-4bb7-1105-9bc8-f84bc0b3132f@siemens.com>
 <20200603152151.GA16550@amd>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <bd7541d9-3349-915e-8c73-45de6c50cabc@siemens.com>
Date: Wed, 3 Jun 2020 17:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603152151.GA16550@amd>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3ILSdhfaALgvvxcWjKBpptJix4520388AA=
Content-Type: multipart/mixed; boundary="2EccLTKLjvxfx4KwjkEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591198187;
 bh=Wcq8m2WKIxdue44J8C8doNIA4BW0rHfSbGlfbg8zdGg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=HJokQG3mINlaFuliu5zAib8PmCRPrbeMBgZbq0bFx5kFu93rZK8Lel/n97z7eo82swY
 L/K3K4mz7mr4lkV5E0xJRUPlR8oh12UOdjT+mC8HhD+3aKfAftzBEYx+qjULEZVEh0xjv
 2/UkZmo7a6Gq/64GBCksN5if8YlGoGqlMP8=

--2EccLTKLjvxfx4KwjkEx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 03.06.20 17:21, Pavel Machek wrote:
> Hi!
> 
>>> At the IRC meeting (May 14th), the following two security patches were discussed. 
>>>
>>>  a. CVE related to KVM SVM on x86,
>>>  b. XDP sockets enabled for Cyclone V
>>>
>>> They were recently ported to upstream, and we would like to decide whether they should be backported to CIP or not.
>>
>> Why did not stable pick them up? Because they require active backporting
>> work to make them apply?
> 
> Yes, IIRC.
> 
>>> Regarding a., SVM is for AMD CPUs only, so it might not actually be used.
>>> If it is the case, we would like to ignore this patch.
>>
>> In general, KVM on AMD was surely a niche over the past years. Since
>> Ryzen, this changed again, also for embedded.
>>
>> That said, I'm not aware of active use on our side at this point, but I
>> may not have the full overview, and I can't speak for other members.
>>
>>>
>>> Regarding b., XDP (express data path) is used for network intensive workloads to bypass certain parts of the network stack So, it may be used by big tech / web stuff, not embedded.
>>
>> XDP plays an essential role in deterministic networking, thus is
>> absolutely an embedded thing as well. But that usually goes along with
>> TSN, though it may not be limited to it.
> 
> Ok, good to know.
> 
> So... there are few reasons why it is important to know what is in use
> or not:
> 
> 1) If we see patch in stable, how much effort should be spent
> reviewing it?
> 
> 2) If we see a bad bug (probably CVE) that needs a backport, should we
> backport this one? (or wait for someone else to do the work?)
> 

For the TSN case I would say it is rather unlikely that this is already
in use with any of our current CIP kernels. But I may miss earlier use
cases besides TSN. For now, I would not invest specifically until we
have a clearer indication of its relevance in our current kernels.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--2EccLTKLjvxfx4KwjkEx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4670): https://lists.cip-project.org/g/cip-dev/message=
/4670
Mute This Topic: https://lists.cip-project.org/mt/74496040/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--2EccLTKLjvxfx4KwjkEx--
