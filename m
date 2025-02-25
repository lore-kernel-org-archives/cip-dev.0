Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B0FC021A4
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 02:32:33 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
 by mx.groups.io with SMTP id smtpd.web10.2605.1740450745079823897
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 18:32:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=IYIkhHDO;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=npa4EBj7;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.51, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1740450731; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Qn+GemYL1XP6PxpYYY07nXgSq+5Esd5QsiK9iT15WIcVskP1Qb3+TV0XdFHqY6SOMA
    /qsEhE+QqD/y0KKdGdtHfaDRNSJcoKr9DkZq5MP3BqcBih8KWCYdeob0Q+G2hFDJOqSF
    G304Bogr788AZgw2zHZr4USft14YV9032j44sXi0U3yKHOHWEdzg4VXntA2oWYpWbw5F
    vdE0vnivB+m82R+X+9RtaeOL9F1iU/4hlptZGdtPIkjSVvk274iY07e8IDG7c7dIqpPM
    yDGBXb5WMCNZCsURC9BxgarkTGQNgldjI5FeLXbLP9nq/mkLB7r56vkJbD21Iw4qKUAr
    i9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740450731;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=GzNHkvYI0TK9nk1VN5IKFd9w8YkwJAFUEfWYx4QR244=;
    b=myKBn6nmcpu2ok50LaFzD5HmheEU2e4Sy3b45k+3+MNqP/oXVtKuyn//C90xAeCncg
    qnZu5VfdzG5eT4nNU8+7h9WU34WIO+Hv+KnMdwDFx/aXg8s1Xtd7jQpYuIgg7uMj7Vnq
    +k7W+hfdvv8VEt25AB5iQJwEwNoAufmBm4RMsqqvWUSU9fs4K7vru6EY151dG7AM74+F
    30MvWQMvhl7POvmF0ltqs0plhpCFfSmIBa3WvnkojlIw4DdTYBA77YW4yAkLX9AGQo77
    dk7ussAeMq/90OQXl8eTGgXcHwHQjSxEr+zmGRT88eoHTsd7p3Bz8A5BEnqiBg4m+TKa
    lPOA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740450731;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=GzNHkvYI0TK9nk1VN5IKFd9w8YkwJAFUEfWYx4QR244=;
    b=IYIkhHDOH2rHlEcm6ZILR13RN7WB3Uc0sFesHEPOV3DQLU0lprnFk26Ttzx6UNFz0J
    cUuV8xGdog6LOqQ+UU+6C9SKQENnG1tV+qry2OCKbNpDxpRH/yahjMwc3gZa9c6g5EMX
    yw63bYrN+hGcuO4eLb4vOUM5gMMLRTWhbTHJmyYpYQz0sAbINyuVwAUlNroj0eNq3ikL
    /M/yNjiRa4fGB4nblnCDUI7wa7TXnktXMQwMiOrhTXCb4jwWYFKxHqslYYf5saH5V+zq
    EVOUuF9dfMuIceC+u5AcJoTm8B7Kq0F66+scb3R+Sjs8koKg+a3y+Otrbk6fi8VCXZiN
    OgqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740450731;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=GzNHkvYI0TK9nk1VN5IKFd9w8YkwJAFUEfWYx4QR244=;
    b=npa4EBj7dHEfLFbNeaxCDI7i14j+2C4oXa2+g3yOYWtW7k8cvLIrSOCwDu5s6pQzuq
    s3drFRr9WdknYf4ewPCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app301.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.23 AUTH)
    with ESMTPSA id z0a38411P2WBB4p
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 25 Feb 2025 03:32:11 +0100 (CET)
Date: Tue, 25 Feb 2025 03:32:11 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	"Paul Barker via lists.cip-project.org" <paul.barker.ct@bp.renesas.com>,
	Ulrich Hecht <uli@kernel.org>
Message-ID: <1375087749.2807871.1740450731121@webmail.strato.de>
In-Reply-To: <20250221164929.357460-1-paul.barker.ct@bp.renesas.com>
References: <20250221164929.357460-1-paul.barker.ct@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-st] posix-clock: Fix backported
 timespec64 check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 02:32:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17904


> On 02/21/2025 5:49 PM CET Paul Barker via lists.cip-project.org <paul.barker.ct=bp.renesas.com@lists.cip-project.org> wrote:
> 
>  
> The backported check calls timespec64_valid_strict(ts), but in
> linux-4.4.y-st the `ts` argument is not a timespec64 instance. This
> leads to the following warning:
> 
>     kernel/time/posix-clock.c: In function 'pc_clock_settime':
>     kernel/time/posix-clock.c:345:31: warning: passing argument 1 of 'timespec64_valid_strict' from incompatible pointer type [-Wincompatible-pointer-types]
>       if (!timespec64_valid_strict(ts))
>                                    ^~
>     In file included from include/linux/time.h:7:0,
>                      from include/linux/ktime.h:24,
>                      from include/linux/rcupdate.h:47,
>                      from include/linux/idr.h:18,
>                      from include/linux/kernfs.h:14,
>                      from include/linux/sysfs.h:15,
>                      from include/linux/kobject.h:21,
>                      from include/linux/device.h:17,
>                      from kernel/time/posix-clock.c:20:
>     include/linux/time64.h:181:20: note: expected 'const struct timespec64 *' but argument is of type 'const struct timespec *'
>      static inline bool timespec64_valid_strict(const struct timespec64 *ts)
>                         ^~~~~~~~~~~~~~~~~~~~~~~
> 
> As struct timespec64 is larger than struct timespec, this could result
> in out-of-bounds memory access.
> 
> Fix this by passing the converted timespec64 instance to
> timespec64_valid_strict().
> 
> Fixes: 40ec979c6d01 ("posix-clock: Fix missing timespec64 check in pc_clock_settime()")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> 
> This patch has been tested on RZ/G1M using the linux-4.4.y-cip tree, but
> I'm sending it for linux-4.4.y-st as the issue is also present there. I
> currently have no way to test the -st tree without the corresponding
> cip patches.

Thanks, applied.

CU
Uli

