Return-Path: <SRS0=8A2c=5X=lists.cip-project.org=bounce+64572+4564+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D22C2BA2B
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 15:17:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24BA20753
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="J/0BGBXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24BA20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4564+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id j4stYY4521723x8CtB3c34FH; Tue, 07 Apr 2020 08:17:57 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.11099.1586272672573780025
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2020 08:17:55 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 037FHlgo008256
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2020 17:17:47 +0200
X-Received: from [139.22.135.123] ([139.22.135.123])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 037FHidN026695;
	Tue, 7 Apr 2020 17:17:45 +0200
Subject: Re: [cip-members] [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
To: Konstantin Ryabitsev <mricon@kernel.org>,
        Neal Caidin <ncaidin@linuxfoundation.org>
Cc: cip-members@lists.cip-project.org, Pavel Machek <pavel@ucw.cz>,
        cip-dev@lists.cip-project.org, cip-board@lists.cip-project.org,
        cip-security@lists.cip-project.org
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
 <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
 <20200406224358.GC14162@amd.ucw.cz>
 <874ktwysrj.fsf@kokedama.swc.toshiba.co.jp>
 <03bf3028-3ea5-55fa-cead-861db2f980ed@siemens.com>
 <20200407151223.5nj4433u3il264zk@chatter.i7.local>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <eced03e3-465b-2b81-ee43-a78cce6ee35c@siemens.com>
Date: Tue, 7 Apr 2020 17:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407151223.5nj4433u3il264zk@chatter.i7.local>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ctohC7Ub0mzsLfWUPlqCrmmPx4520388AA=
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586272677;
 bh=5Tpd8vwVljQG882WttH87iqDrXdSBWXAk5fSdu1w2RQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=J/0BGBXK+tV8q4wkjeJVV7KOfZZlgmDxtCPnrdvvC4hGrRudGF64LmH+gFVTicE/I/1
 8kcVSYG2z7zL8AQRiGgpKx1M8nBaj9ctl3KUsKVqMiI7BJ8A8X/7iESmYGbpi2J+klhNr
 UBTK//bztYSKVO0pHquVKHiY4Oo1bYqWdgo=

On 07.04.20 17:12, Konstantin Ryabitsev wrote:
> On Tue, Apr 07, 2020 at 08:58:31AM +0200, Jan Kiszka wrote:
>>
>> Konstantin, could you have a look or organize help? This is a blocker for
>> us, groups.io must not mess with messages.
>>
>> But given that other projects are using this workflow as well, I strongly
>> suspect there is a way to fix it.
> 
> On each list's "Settings" page there is an option called:
> 
> Separate Message Footers
> (Place message footers in a separate MIME part)
> 
> That's the one you want enabled.

Perfect! Neal, you are admin? Can you change that?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.

View/Reply Online (#4564): https://lists.cip-project.org/g/cip-dev/message/4564
Mute This Topic: https://lists.cip-project.org/mt/72845465/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/727948398/xyzzy  [cip-dev@archiver.kernel.org]
-=-=-=-=-=-=-=-=-=-=-=-

