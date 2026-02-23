Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D3CEF5864
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 04:33:52 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29291.1771821229819071706
 for <cip-dev@lists.cip-project.org>;
 Sun, 22 Feb 2026 20:33:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=X8nqMoJQ;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=uFzg9jNr;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1771821216; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oa1Su+tm7bsAZbsovHR9aRWsAAfV2K6n2w4neU9s2DzLD0LW+AtAA8o5OUn02Mb4e7
    d9VnR5VY2ZHtcdUeD7whiuKUqaK0CA1PRdpD5t+7sntMJUIh4CPIOar/YM/JVTM8P3ag
    AcVsjcCKp+IdzjGsREY3WFfO9STPFOcKKDlmtsrZr+Bfac5JA+FMeBYlFijeqepZGund
    tWCDlasbCBcI5157M+myESYR3r3L4ug5Lx3LBFlPaPJSIFGHpPL4Hq8RJ7G4arBj9ZFr
    Lz0gj9rPmxX1pboKOxaetEuAXTnqZ5lZhjGWiSGSyxuvxLcvwC4LEeV6rqvgStLFX5Jv
    R5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771821216;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MaYZAgCzTuKOv6gZXob3R+ZdWdT76iYibJF0/kX1dSQ=;
    b=Sq0+jGNNqZBXX9a7dOBc6c9oGPCgMYCsgGyxuaYZfsiY283FTriwDAi/pqGvSriJHN
    dsStZFmBuEbpHCMjNytxN3tEPuF+9HZCz9L8kx08B+iWxAPh1xApenSKzv2tEDcJtbbG
    8T6XGmvlHrMdWOo+rzUnaNvGjiZxUBVlqG0ORWPq1WJM4NyV5rATfZwNmqC5sAIGcFh4
    u3DTP0gvnLK8zg0Vh0pIjTS6VtzTTAUnXADfFgyDD6xVt/eIYLvAToAKef6t4xDCi/68
    CkW2/Rbn1yQblyoiN0F3XwN/MfaoRs8Dl+XjrELSwMK0XlbdnSS0lvRhp/l1tSJkbwLm
    jmeg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771821216;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MaYZAgCzTuKOv6gZXob3R+ZdWdT76iYibJF0/kX1dSQ=;
    b=X8nqMoJQojLmRYizRIhYE6egr5/w3kTKGOy2pR6oAPElDh1qji50f8unA7IeKiqvtR
    nSTrzFaQgIhnRQvILbNgDkSkf6ic7jcieztw5wh0RWXBXQN6ATR0xjQWeqZdvpXBXhqO
    kV5+PGUk7GGkQV+u2MIpWnvNL/hVODODx6HJHTbLDNuw3w3aaOemb5cYojJuLdC2gEeF
    IJYJzBahOx8V0anEIH7Q7kekeG0PnxmOEBqQcJ47/BMSysmVNvLFuJHRHkKIivMV3sqD
    drMD/8xu5LWusydjIzvD9nP7FL5LVdOZ6f/UyJvgFP8vqSL4cTspYh00DSXYsYpDafZS
    cZIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771821216;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MaYZAgCzTuKOv6gZXob3R+ZdWdT76iYibJF0/kX1dSQ=;
    b=uFzg9jNrrqKoK+p9VU79M+T2JZFLx/Vj94v88UGZEH1sRmO5wxVuERYmWU88bf+c5t
    bw0Ko3/urgjfkdiTyPDA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRq2JA=="
Received: from open-xchange-core-mw-gw-34.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z92cbd21N4XaInq
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 23 Feb 2026 05:33:36 +0100 (CET)
Date: Mon, 23 Feb 2026 05:33:36 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: iwamatsu@gmail.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1825159101.48826.1771821216174@webmail.strato.de>
In-Reply-To: <CACe6DC6Lt0Y9vPfMb9NhgOg4FcMCWDaFxAR7c8oLh9rZt87SPA@mail.gmail.com>
References: <1504945381.404757.1771569526446@webmail.strato.de>
 <CACe6DC6Lt0Y9vPfMb9NhgOg4FcMCWDaFxAR7c8oLh9rZt87SPA@mail.gmail.com>
Subject: Re: [cip-dev] Request for review for 4.19-st13, 4.19-cip129
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 35842
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Feb 2026 04:33:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21905


> On 02/21/2026 6:21 AM CET Nobuhiro Iwamatsu via lists.cip-project.org <iwamatsu=gmail.com@lists.cip-project.org> wrote:
> Hi Uli,
> 
> The following commit requires a fix. Enabling the driver will cause a
> build error.
> 
> c85bc75effc21 fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe()
> ```
> drivers/video/fbdev/ssd1307fb.c: In function 'ssd1307fb_probe':
> drivers/video/fbdev/ssd1307fb.c:726:22: error: passing argument 1 of
> '__free_pages' from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>   726 |         __free_pages(vmem, get_order(vmem_size));
>       |                      ^~~~
>       |                      |
>       |                      u8 * {aka unsigned char *}
> In file included from ./include/linux/idr.h:16,
>                  from ./include/linux/kernfs.h:14,
>                  from ./include/linux/sysfs.h:16,
>                  from ./include/linux/kobject.h:20,
>                  from ./include/linux/device.h:16,
>                  from ./include/linux/backlight.h:12,
>                  from drivers/video/fbdev/ssd1307fb.c:9:
> ./include/linux/gfp.h:566:39: note: expected 'struct page *' but
> argument is of type 'u8 *' {aka 'unsigned char *'}     566 | extern
> void __free_pages(struct page *page, unsigned int order);
>       |                          ~~~~~~~~~~~~~^~~~
> ```
> 
> This can be fixed by cast to vmem.

Fixed, thanks!

CU
Uli

