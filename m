Return-Path: <SRS0=7Llo=5X=lists.cip-project.org=bounce+64572+4557+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C86C2BA1A
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 01:44:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B6C206C0
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 01:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="iqlUFkoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B6C206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4557+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uPocYY4521723xswLvZwuCSx; Mon, 06 Apr 2020 18:44:09 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.1607.1586223846880345521
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Apr 2020 18:44:08 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0371i3DI023271; Tue, 7 Apr 2020 10:44:03 +0900
X-Iguazu-Qid: 34trpDa8KhQyyf7ddU
X-Iguazu-QSIG: v=2; s=0; t=1586223843; q=34trpDa8KhQyyf7ddU; m=rnyIMaArcxo3M5Qt03tZHwdhmZf97uq9k2W7yJksSVU=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 0371i1GY001707;
	Tue, 7 Apr 2020 10:44:02 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0371i1mk013530;
	Tue, 7 Apr 2020 10:44:01 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0371i1PQ020160;
	Tue, 7 Apr 2020 10:44:01 +0900
From: punit1.agrawal@toshiba.co.jp
To: Pavel Machek <pavel@ucw.cz>
Cc: cip-dev@lists.cip-project.org, cip-board@lists.cip-project.org,
        cip-members@lists.cip-project.org, cip-security@lists.cip-project.org
Subject: Re: [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
	<CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
	<CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
	<20200406224358.GC14162@amd.ucw.cz>
Date: Tue, 07 Apr 2020 10:44:00 +0900
In-Reply-To: <20200406224358.GC14162@amd.ucw.cz> (Pavel Machek's message of
	"Tue, 7 Apr 2020 00:43:58 +0200")
X-TSB-HOP: ON
Message-ID: <874ktwysrj.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7azZ1Quyfl6Nq8WDAQOZ9lOGx4520388AA=
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586223849;
 bh=GEnJe7XjcrvYT0o1Ygw+2O9sIYi4U7RfdrvWF8XXFYM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=iqlUFkoJmoTi43y8rGDsK7DsamuAAePM/72Pm9wFwRm5bVYTSbYV5R9HHc637c6zDOW
 HNpgVfrtUGPgvRA3BVAb7CZj1fD+wBqt0xfID7aJBzKq1S4iOtuzGbk5EkWJK7A44g/XQ
 ywJ0lNzXw0+SaQXG3YqivkipOn4IWWOCUc4=

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> The migration is complete.
>> 
>> You should receive an email shortly asking you to log in with your email
>> address and set a password.
>> 
>> One important note, please do NOT unsubscribe from the "main" list. This
>> would unsubscribe you from all of the CIP lists. "main" is an
>> administrative list used by Groups.io as a parent list to manage the other
>> lists. Please let me know if you have any questions or issues.
>
> And we have first problem.
>
>> 
>
> They seem to add this kind of trailer to the messages, breaking GPG
> signatures :-(.
>
> (I won't quote full trailer as it seems to contain some secrets?)

I wonder if it's possible to turn these off by the admin.

Also, another thing to test is the impact of the footer on applying
patches sent via email (git am / git apply).

-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.

View/Reply Online (#4557): https://lists.cip-project.org/g/cip-dev/message/4557
Mute This Topic: https://lists.cip-project.org/mt/72837893/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/727948398/xyzzy  [cip-dev@archiver.kernel.org]
-=-=-=-=-=-=-=-=-=-=-=-

