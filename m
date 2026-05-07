Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF274CD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 11:05:17 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9001.1778151916183334992
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 04:05:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=gCYOxTgk;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=d5FCYETN;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.50, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1778151906; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bPGpsh1C+MQZadL/4+0792QaiFPQfgp8K0dg+BiOwgnj8TcGmSnUPWGy2vD/LZ6mWS
    sHV62dEJMfnLoUs9BtyIxjBYLOt/bGbEVSFRl3US14HqCghQHUQg6h7E+eeHptmLWeRb
    abk39p8B9COXGytuGmPinu+5jULpASk5/dckfWbYi57LtInWPH+A62zNNz33cU5AgHGN
    jnG5TDnJgwuhrBsvO0aLY8eUmueweSUXFW0znYWIf9iXErCAwMEfvni8k+ge/PTcY94p
    /Yq4e250Kn8RZS1jb0z0NMpoZHUyn3e9HDRysLdh3Tfx/zkQyxcAGnu0zeio/+9YLCTW
    sO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1778151906;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=J+tE24HxcJLk8eRs5PJbuEotl8qthGXvA9bd0uTflZg=;
    b=kPuzkwhfx8+x27M+WtnqQAh1ybTl3e3gjQXE0Wnf4TwJix6S2Njz2RxbCb9mXmTYRx
    FiysMHjMMBuNu9EugE7JgMppEGv04ZkFBgOt7wkRkdXgzRDPzdgJ5Z6sjIQovOw5mOYZ
    bxueS0xleBctQjmi9qTIbIKf+T03PH/6gSB1xoIuDItRUJXRixm5N9m+Buu4kYZQQRap
    B8biMu3+Dkx66VNdr62x27MEeOHK2UbeRLcW/qhnVJ/uKpV9JXbgLNyNjYgqtSigxX3G
    hooL/ln4DfYzQk9ItnoaCmCfU71qWZcUnRAnAN1apEVuU6aQ5ykN1uE4Qh3sTJDbfk+7
    6AmQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1778151906;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=J+tE24HxcJLk8eRs5PJbuEotl8qthGXvA9bd0uTflZg=;
    b=gCYOxTgkhdaGpWOZz020mxT7CyBk7uW+xe0ndZicjPCYxlLh6Nq+rOQ6gZt15DOjpA
    REn6V/XqzWXuGgv3PSiwNBrvyKVuRFMAvJLvLN9CZUAMEO3qfJPwS5pjpa6n39ZzZLDk
    aM+fBpniEvfVonkwBEnd9Udayt2V77KHUpBY+TntZtXkahmmaUSH9M/Cb6Qe5bKOvPfb
    +Q1NIK9soN9e2opf6chVpn/sjbKQDZJMqH+OZqTFCqxkzZZLcqxM9cd0ye8x0n3kVemL
    +l7fN2fEXjxKXzQIi89Nw8m/GRnKFAEYcGw/1Gxw+9LhVkNSDRH78fLtL7V5xC7ybcdY
    BJ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1778151906;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=J+tE24HxcJLk8eRs5PJbuEotl8qthGXvA9bd0uTflZg=;
    b=d5FCYETNg9jQtA9IzUUXdKgNNCSRNx20pWrcgViE6K49IMkfcWo1/yonkeMlPDmFbX
    nJG700+nIutqjgaq5OAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-8.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e247B55LLo
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 7 May 2026 13:05:05 +0200 (CEST)
Date: Thu, 7 May 2026 13:05:05 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: iwamatsu@gmail.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1534687219.701226.1778151905754@webmail.strato.de>
In-Reply-To: <CACe6DC5-xC4N2497RRuD_Rrb1EqT4gNqnrrC+JpB2T5hkkMsuQ@mail.gmail.com>
References: <483138290.348854.1777919283323@webmail.strato.de>
 <CACe6DC5-xC4N2497RRuD_Rrb1EqT4gNqnrrC+JpB2T5hkkMsuQ@mail.gmail.com>
Subject: Re: [cip-dev] Request for review for 4.19-st16, 4.19-cip132
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 38686
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 11:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22903

> On 05/05/2026 11:09 PM CEST Nobuhiro Iwamatsu via lists.cip-project.org <iwamatsu=gmail.com@lists.cip-project.org> wrote:
> a5c28748776c3 soc: fsl: qbman: fix race condition in qman_destroy_fq
> This commit will result in several build errors.
> ```
> drivers/soc/fsl/qbman/qman.c: In function 'qman_destroy_fq':
> drivers/soc/fsl/qbman/qman.c:1751:34: error: implicit declaration of
> function 'qman_shutdown_fq' [-Werror=implicit-function-declaration]
>  1751 |                         leaked = qman_shutdown_fq(fq->fqid);
>       |                                  ^~~~~~~~~~~~~~~~
> drivers/soc/fsl/qbman/qman.c: At top level:
> drivers/soc/fsl/qbman/qman.c:2604:12: error: static declaration of
> 'qman_shutdown_fq' follows non-static declaration
>  2604 | static int qman_shutdown_fq(u32 fqid)
>       |            ^~~~~~~~~~~~~~~~
> drivers/soc/fsl/qbman/qman.c:1751:34: note: previous implicit
> declaration of 'qman_shutdown_fq' with type 'int()'
>  1751 |                         leaked = qman_shutdown_fq(fq->fqid);
>       |                                  ^~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:303:
> drivers/soc/fsl/qbman/qman.o] Error 1
> make[3]: *** [scripts/Makefile.build:544: drivers/soc/fsl/qbman] Error 2
> ```

Thanks for testing. I dropped the patch, the code is not enabled in any CIP configs anyway.

CU
Uli

