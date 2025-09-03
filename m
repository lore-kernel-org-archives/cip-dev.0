Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC4CCA1011
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 14:39:13 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
 by mx.groups.io with SMTP id smtpd.web10.14305.1756910348338907134
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 07:39:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=bYv16OXL;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=7EIa0F+/;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.166, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1756910319; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=txFvN1KiPaBa96eVmaK47jYHBzqNjxmeWboXnOrVEN34ur4eHHqiQ5+iJf9v6pA+YE
    5qkksPyujnD/HR1C4hyThJRkIQuJYSpi+I4S1AUsiuL4TS6VOyylKaa4TcdesRe77eJy
    AOZqgkxyYUl1Cj4+ZYBkzwoqvTv+Qbf0Vt22QMjqYNlUC3qDs2ICC3uV/XiwxK6yKSGA
    GQrbYPsQ1hk2H0w9Xg+iP/owjq7HZPrXz4udxBHNWhH209k/yNKWY7+6g49vGpnoeYGy
    CMWfGkLHZkydOGOUrvy3E0UfGL/apaFcOz7q0AcKA34yOdJq/x4vnHEC76DK07bEpInc
    j3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756910319;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=73B2aXFZcjUIKRhCHrSPWZx2xO73a6CVHfidgndTkVI=;
    b=e37YGEB7V5qigzdKlz+y1zm3QZ7UqyFoipfLioYfAblUN8t0cpK27ht17UWgbErSsf
    Bh7iMeKjBtebslsfrzh+1RPmsONft1kKRgPgD5X7jBxpfNeOwXYXaTHWlKtPUPxl6Bdw
    VvxhdlItcDMvtKIO32K2TjJxCLETVamNq186UIwDHhBDGmWxw60RlMidaTQTezbWZ3JT
    878aTkx76Y0fU4jmO+mTJWvwCoYTX3iJ1ixcMlYQRcJkgQvrmcBwHe2CpHeJbo49esVt
    Ij5BbUL1dxkRykhM3KfxPLkiBqzn9VCyFH9EY5Fw2tG8FLzs/HkiWMmG31QD6g1Eo2Z/
    Jq0g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756910319;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=73B2aXFZcjUIKRhCHrSPWZx2xO73a6CVHfidgndTkVI=;
    b=bYv16OXLh0BQAplNNzD95VUXPSHCR+KqPtUYEpDwCyNG7Rk16jNR9ZpIlE/YeuvXGR
    fUzsWNxRcxasvCc+BQ0GCetlBlKAHMLHP2raK2SgY7JLuXHg2s/1Zn/fbZSnh1vhWS32
    ZvuUCijwHp1jmkgrSWbwKmNlzBQZGgC756ppHgjo6ygF1XEhJ9uHAqCeS40ws2rpay5O
    02yYCLh+ZjCngQWtL6ZzhLNUPjsDOLswObtnx+WV1JVlbBX+dJ4WlUn+IQSp59YwNoKH
    uyxJNR14cyEyoR8QPO2iXWEaIT30p9tSO3v1+L9QKZQ6EKpGDcV04+hXDOtOoS6fPmSP
    Y81g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756910319;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=73B2aXFZcjUIKRhCHrSPWZx2xO73a6CVHfidgndTkVI=;
    b=7EIa0F+/wKC15+s1v3Ec+IVCNxgH04EjvtU2qd92BSsGVdqPcWzkV89wnFOf/KvNfT
    FDqKEE85AUrZb70PSjAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKzK+A+UOEY="
Received: from open-xchange-core-mw-gw-18.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff62183Eccp0x
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Sep 2025 16:38:38 +0200 (CEST)
Date: Wed, 3 Sep 2025 16:38:38 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: kazunori.kobayashi@miraclelinux.com,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <165242228.250961.1756910318537@webmail.strato.de>
In-Reply-To: <42de8250-d98b-40e5-9e8a-d6bbb1ca8b6b@miraclelinux.com>
References: <1602384696.84101.1755530487321@webmail.strato.de>
 <42de8250-d98b-40e5-9e8a-d6bbb1ca8b6b@miraclelinux.com>
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip123
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 43922
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 14:39:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19997


> On 09/03/2025 8:31 AM CEST Kazunori Kobayashi via lists.cip-project.org >=
 I ran into the following compilation error with=C2=A0omap2plus_defconfig a=
pplied in this kernel version.
> | /buildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x=
-evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/kernel-=
source/drivers/media/platform/omap3isp/ispccdc.c: In function 'ccdc_lsc_con=
fig': | /buildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/build_am=
335x-evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/ker=
nel-source/drivers/media/platform/omap3isp/ispccdc.c:452:3: error: implicit=
 declaration of function 'dma_sync_sgtable_for_cpu'; did you mean 'dma_sync=
_single_for_cpu'? [-Werror=3Dimplicit-function-declaration] | dma_sync_sgta=
ble_for_cpu(isp->dev, &req->table.sgt, | ^~~~~~~~~~~~~~~~~~~~~~~~ | dma_syn=
c_single_for_cpu | CC [M] drivers/media/rc/keymaps/rc-avermedia-a16d.o | /b=
uildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x-evmsk=
_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/kernel-source=
/drivers/media/platform/omap3isp/ispccdc.c:461:3: error: implicit declarati=
on of function 'dma_sync_sgtable_for_device'; did you mean 'dma_sync_single=
_for_device'? [-Werror=3Dimplicit-function-declaration] | dma_sync_sgtable_=
for_device(isp->dev, &req->table.sgt, | ^~~~~~~~~~~~~~~~~~~~~~~~~~~ | dma_s=
ync_single_for_device
> It seems caused by the following change.
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/3483db997d49=
1ba78957eb04743f6bb2ecc242aa
> This change seems merged from the 5.4 based kernel, but some other depend=
encies would also be needed to pass the compilation.

Thanks for the report.

Looks like it's missing "dma-mapping: add generic helpers for mapping sgtab=
le objects". I pushed a backport to the rc tree (https://git.kernel.org/pub=
/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc), pleas=
e check if it works.

I have also added omap2plus_defconfig to my local build configs.

CU
Uli

