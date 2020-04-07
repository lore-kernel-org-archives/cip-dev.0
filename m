Return-Path: <SRS0=Jww3=5X=lists.cip-project.org=bounce+64572+4559+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F95C2BA16
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 06:58:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B53720748
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 06:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eSP4dinN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B53720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4559+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sIIOYY4521723xylKg3z6cgo; Mon, 06 Apr 2020 23:58:41 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.4641.1586242719571225487
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Apr 2020 23:58:41 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0376wWm7027304
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2020 08:58:33 +0200
X-Received: from [139.22.39.199] ([139.22.39.199])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0376wVZd001195;
	Tue, 7 Apr 2020 08:58:31 +0200
Subject: Re: [cip-members] [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
To: cip-members@lists.cip-project.org, Pavel Machek <pavel@ucw.cz>,
        Konstantin Ryabitsev <mricon@kernel.org>
Cc: cip-dev@lists.cip-project.org, cip-board@lists.cip-project.org,
        cip-security@lists.cip-project.org,
        Neal Caidin <ncaidin@linuxfoundation.org>
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
 <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
 <20200406224358.GC14162@amd.ucw.cz>
 <874ktwysrj.fsf@kokedama.swc.toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <03bf3028-3ea5-55fa-cead-861db2f980ed@siemens.com>
Date: Tue, 7 Apr 2020 08:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <874ktwysrj.fsf@kokedama.swc.toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7NcCgWsLBUmFW1Z4a9c0g7YNx4520388AA=
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586242721;
 bh=64d2jmzIPg4iZCUcHLbNKuQYcLu55XO/tNqeW9xpIqs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eSP4dinNlGxAKmTdoIUnUBbFuzvnuBk4r2v+kJfHhEaOc4xZ4De6CXHhL6AUcuy4Wba
 nwpNIQM6v0v6HyJ55P1jzdtOUTqoGGpMafqv39MzCTdvGzGjLss6ZtrkcZ2TS4cRy5FVy
 EsXeKRpEMap/sGa9ErHftGspNoQI/2fnS6s=

On 07.04.20 03:44, punit1.agrawal@toshiba.co.jp wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
>> Hi!
>>
>>> The migration is complete.
>>>
>>> You should receive an email shortly asking you to log in with your email
>>> address and set a password.
>>>
>>> One important note, please do NOT unsubscribe from the "main" list. This
>>> would unsubscribe you from all of the CIP lists. "main" is an
>>> administrative list used by Groups.io as a parent list to manage the other
>>> lists. Please let me know if you have any questions or issues.
>>
>> And we have first problem.
>>
>>>
>>
>> They seem to add this kind of trailer to the messages, breaking GPG
>> signatures :-(.
>>
>> (I won't quote full trailer as it seems to contain some secrets?)
> 
> I wonder if it's possible to turn these off by the admin.
> 
> Also, another thing to test is the impact of the footer on applying
> patches sent via email (git am / git apply).
> 
> 
> 

Konstantin, could you have a look or organize help? This is a blocker 
for us, groups.io must not mess with messages.

But given that other projects are using this workflow as well, I 
strongly suspect there is a way to fix it.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.

View/Reply Online (#4559): https://lists.cip-project.org/g/cip-dev/message/4559
Mute This Topic: https://lists.cip-project.org/mt/72845465/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/727948398/xyzzy  [cip-dev@archiver.kernel.org]
-=-=-=-=-=-=-=-=-=-=-=-

