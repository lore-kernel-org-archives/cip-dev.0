Return-Path: <SRS0=ECdH=FO=lists.cip-project.org=bounce+64572+5949+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A9AC4361B
	for <cip-dev@archiver.kernel.org>; Thu, 10 Dec 2020 04:26:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A9B22D75
	for <cip-dev@archiver.kernel.org>; Thu, 10 Dec 2020 04:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A9B22D75
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5949+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id A6f5YY4521723xUKbaKpNxbc; Wed, 09 Dec 2020 20:26:58 -0800
X-Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.8584.1607574416952799077
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Dec 2020 20:26:57 -0800
X-Received: by mail-lf1-f42.google.com with SMTP id w13so6285549lfd.5
        for <cip-dev@lists.cip-project.org>; Wed, 09 Dec 2020 20:26:56 -0800 (PST)
X-Gm-Message-State: SNdjbUvshJrIQ0Pxn9oFklyPx4520388AA=
X-Google-Smtp-Source: ABdhPJzTFwDRqDg1zeWV4xfkKDoW49Zn2dajhla9RhXdP7bV/bbvts51qeknBR3D1kCGuuNJWNLfRw==
X-Received: by 2002:a19:500a:: with SMTP id e10mr2019776lfb.193.1607574414751;
        Wed, 09 Dec 2020 20:26:54 -0800 (PST)
X-Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v12sm467909lji.3.2020.12.09.20.26.54
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 20:26:54 -0800 (PST)
X-Received: by mail-lf1-f50.google.com with SMTP id a8so6297433lfb.3
        for <cip-dev@lists.cip-project.org>; Wed, 09 Dec 2020 20:26:54 -0800 (PST)
X-Received: by 2002:a19:2d47:: with SMTP id t7mr2042374lft.233.1607574414178;
 Wed, 09 Dec 2020 20:26:54 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 10 Dec 2020 12:26:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v641=SrfdDh9CS4fwWVrfuCG2O2oni9V_QsVJEza+g5mRg@mail.gmail.com>
Message-ID: <CAGb2v641=SrfdDh9CS4fwWVrfuCG2O2oni9V_QsVJEza+g5mRg@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2020-12-10
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="jaahLkziBNG5M6itfcOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607574418;
 bh=bcU5ORIiYyQuaTDQe4kdmH+cfsOqAzx3CN/Aa5JUl+s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=F8707X+syWgyuld+5VUUPGA4IAcxsgH+crvICLYIQKrlLjtKx2RJKF0an1JFgbR3zfN
 ZP19si8MVn6DhE36FLxVunRAb9YdSXGJYe2eVvF6fkWKFI2QpHyDqVYBrnJgyo+4ImfGc
 8GM7aL7uyogl/AIRZqsadWxDm9SiLlnCblM=

--jaahLkziBNG5M6itfcOg
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Here is the cip-kernel-sec report for this week.

This week we have five new issues:

- CVE-2020-27786 [rawmidi UAF race condition]
  - fixed for all stable kernels
- CVE-2020-27820 [drm/nouveau UAF]
  - fix in progress; ignore for CIP
- CVE-2020-27830 [speakup crash]
  - fixed in mainline; ignore for CIP
  - backport failed for v4.14 and v5.4
- CVE-2020-28588 [collect_syscall() data leak]
  - fixed but was not tagged for stable
- CVE-2020-29534 [io_uring FD leak across execve]
  - fixed for relevant stable kernels

Regarding nouveau, it seems that the driver is enabled in hitachi_omap
defconfigs for both 4.4 and 4.19. This doesn't make sense as the configs
are for OMAP platforms which AFAIK don't have PCI for a graphics card.
We should ask if this was added by accident and remove it.


Regards
ChenYu

--jaahLkziBNG5M6itfcOg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5949): https://lists.cip-project.org/g/cip-dev/message=
/5949
Mute This Topic: https://lists.cip-project.org/mt/78847618/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jaahLkziBNG5M6itfcOg--
