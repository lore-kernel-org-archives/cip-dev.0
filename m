Return-Path: <SRS0=/eeW=5X=lists.cip-project.org=bounce+64572+4565+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B915EC2BA2B
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 15:37:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E1420678
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="djE3DxGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E1420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4565+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3iFvYY4521723xdKGPuQwYfe; Tue, 07 Apr 2020 08:37:33 -0700
X-Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
 by mx.groups.io with SMTP id smtpd.web12.10973.1586272352214161689
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2020 08:12:32 -0700
X-Received: by mail-qk1-f195.google.com with SMTP id 130so1979678qke.4
        for <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2020 08:12:32 -0700 (PDT)
X-Gm-Message-State: zAhl9it2iwtzfFgvpCPZFBRux4520388AA=
X-Google-Smtp-Source: APiQypI+n5449+PtVNuAfgs9BxQLA/Ev5Omw8G4gwAxFy/gTE03qvWNTfuNBDPndNhzdpe1MLQXyHg==
X-Received: by 2002:a37:c47:: with SMTP id 68mr2840199qkm.168.1586272351288;
        Tue, 07 Apr 2020 08:12:31 -0700 (PDT)
X-Received: from chatter.i7.local (cs-tor.bu.edu. [204.8.156.142])
        by smtp.gmail.com with ESMTPSA id h11sm16795302qtr.38.2020.04.07.08.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 08:12:30 -0700 (PDT)
Date: Tue, 7 Apr 2020 11:12:23 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-members@lists.cip-project.org, Pavel Machek <pavel@ucw.cz>,
	cip-dev@lists.cip-project.org, cip-board@lists.cip-project.org,
	cip-security@lists.cip-project.org,
	Neal Caidin <ncaidin@linuxfoundation.org>
Subject: Re: [cip-members] [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
Message-ID: <20200407151223.5nj4433u3il264zk@chatter.i7.local>
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
 <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
 <20200406224358.GC14162@amd.ucw.cz>
 <874ktwysrj.fsf@kokedama.swc.toshiba.co.jp>
 <03bf3028-3ea5-55fa-cead-861db2f980ed@siemens.com>
MIME-Version: 1.0
In-Reply-To: <03bf3028-3ea5-55fa-cead-861db2f980ed@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586273853;
 bh=P7RXIQUchONEgiP+zadtkBXEyUEw3GdVyMVeMSlkQk0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=djE3DxGUFjMI7br/Ya7Bef3t3dDIjj3YBTCaLx+pbjFUlkCoE8wxEegWGKve3U+6sn0
 UeL/TLalZ5EhUB0r98PfLzGYuiZVdzFSX5gz8qJ784r2Zwy4/MSKMLt9voL9DfcQ/bXpk
 epM7x6moyMjZFZQskR/GBKK0qSADRLZLuM0=

On Tue, Apr 07, 2020 at 08:58:31AM +0200, Jan Kiszka wrote:
> 
> Konstantin, could you have a look or organize help? This is a blocker for
> us, groups.io must not mess with messages.
> 
> But given that other projects are using this workflow as well, I strongly
> suspect there is a way to fix it.

On each list's "Settings" page there is an option called:

Separate Message Footers
(Place message footers in a separate MIME part)

That's the one you want enabled.

-K

-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.

View/Reply Online (#4565): https://lists.cip-project.org/g/cip-dev/message/4565
Mute This Topic: https://lists.cip-project.org/mt/72845465/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/727948398/xyzzy  [cip-dev@archiver.kernel.org]
-=-=-=-=-=-=-=-=-=-=-=-

