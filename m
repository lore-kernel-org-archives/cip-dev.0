Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BFBC25B7E
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 08:02:29 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.web10.16322.1717488148687037338
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jun 2024 01:02:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Qiil9kVC;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=uhXlwuQa;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1717488140; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YmjI0Hl8C1caGeKXzN60LFgu9ZP1wZAZohtn35V1sLPuePWyKN6nwoFKYgx5fRjfyz
    RQjfT1AqDgYOPBFSUlurlVJbxL224T2RQ7N3bM07JhTd+DZUv1VcNJNjo+FtRKdU4ez8
    /GGTNyyn7KixB1zzNV1ElvPpLzaJankA6t/oDOFL1p2mSK5z71gJtKQ1z0u930rn127r
    81t6dBGcggwdSFjXtKCAOirufQjrza1Nm9N9FdtrKKNJxgDz3XG4xFlppon5GOWyAJ8I
    ylLyJRGHocOY5nrvsv/9ItJCztunsamZpQ16TNRUsLgHCz7ad4BKXmcWUyhhii6tkokG
    AhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1717488140;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=JfXBDrTwbrIUbd8Pm/5850K90TjIImAHMwka/TYImmU=;
    b=W9d+y+E5bOLjV73P+G12mKiE5mu8C3bb92XCFASUdIxoj4z99s5pQJqN4NW5ayCoKL
    jUZUhhYtrg7dV/3nB1PoJ5zWvzeoylJIARBbK1RGXOmGvOdpUVQAZsIdt9E1ER7TjFC6
    lCSXiTqTU4zJySiwJm035STLotoc3oAs03oalnyRUMYker2V3Rdv+kUP7rRDo9l6oSkd
    MN0GH9h60onLeuHjXu3VN4qhzWOylAZ+k0LFpmkUkeI0HyNXrS6n8vBoAgk2QsvTaSxM
    NXBXB6SYFdcxkdPufZ6r8LRTXNYWY+2wzvp3CS6NPPhYeXWunbC5cERa/nFE1U9PRsSA
    AQww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1717488140;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=JfXBDrTwbrIUbd8Pm/5850K90TjIImAHMwka/TYImmU=;
    b=Qiil9kVC0wVsIIGeT8Sr4kfZxxYMsXpZ7qmpuao+Eiudbx8Q6TU/Vfj5fnbgRCGlJe
    vLWvU16BE3fEuImgmrK++kZbclyy2rS8U04Sr5iOmUYEkfPHslkZPExxE10tVIBfkZ8G
    WIJKEL/4JXQnbZEzgrtz32vIdtT4g7EWzDzQD7itiUM5omAcJnfPruQyQlwJ30ruZq2/
    ky9gIFqIAReytmYUUTK9L9GVOuWeVypry6MSsIWoUvnDtmZ6CNSG4A9fhF4XKYj/433i
    4+D6OpCclg3qrMY69G5doLN9n7iMjD4FexPhUoHIfpgoAmm5TqWr3puiCkWF4U8aMx8+
    vz1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1717488140;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=JfXBDrTwbrIUbd8Pm/5850K90TjIImAHMwka/TYImmU=;
    b=uhXlwuQa9LOpP1XOnaA4z7FciCOaUKlI0uTo5qT8+u74UEqM+ZYGUYdOnNoa7MhoBm
    Mc+0NTRHyJgOVZpADSCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7sKNcZuec1/lEjXyi1DCFOscFCe8bGtzH2tsY51y9cL"
Received: from ox-live-app403.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z08c3e05482JKhI
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 4 Jun 2024 10:02:19 +0200 (CEST)
Date: Tue, 4 Jun 2024 10:02:19 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, pavel@denx.de
Message-ID: <157181902.881868.1717488139535@webmail.strato.com>
In-Reply-To: <OS0PR01MB638863B7585B3FAC22D71C5692F82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <1638796688.696518.1717408079442@webmail.strato.com>
 <OS0PR01MB638863B7585B3FAC22D71C5692F82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Subject: Re: [cip-dev] Request for reviews for 4.4-st53, 4.4-cip88
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev64
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 08:02:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16101


> On 06/04/2024 9:15 AM CEST Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
> I may be wrong but it looks like some of the commit hashes are different.
> 
> > ** m | 4a5a57338 d10129 o+ | ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
> > ** m | 6ffbcb370 9af503 o+ | btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()
[...]

These lines are copied verbatim (except for the "m" tag) from the output of the lts-commit-list/bin/create.py script and contain the commit hashes from the stable kernel.

> As for all commits, how about recording the commits cherry-pick?

That's an option for the v4.4.org file, but for the pre-release kernel the hashes will change, possibly multiple times. Maybe I should just omit them here to avoid confusion?

CU
Uli

