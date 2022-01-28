Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8823C433EF
	for <webhook@archiver.kernel.org>; Fri, 28 Jan 2022 06:19:31 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web10.3937.1643350769491117467
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 22:19:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=rvUq+E73;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.46,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f46.google.com with SMTP id
 c3-20020a9d6c83000000b00590b9c8819aso4822965otr.6
        for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 22:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CJxvi52KLhytNgk0kqwnP2mrDuV8nCyl/SDeqsxrU14=;
        b=rvUq+E731U9un87My2YGEWKYtGLjRzyzqKxWnX5fjfTBSS5l6+aL4OdTe4EVh4ugFA
         ZJ6g/eK+crwRdRkI5fnBxIl9QDJ5cYREBdpod1kFbNrHfTD589E8YbaFH8pT3Fa8+b8h
         /XppVPrKcqPx8bsl7lONAZ5X2xRlvDW7vNVpnHrYh5IYfbD81S0QEn+EgeY1TT3igXeF
         7sZFTeEh7Hpssl3fsvR5JIF7kmkgyRZCH0I45bJGThH+fuZ8GcIT7KSoVq0SinGnEi+/
         FYSn3KR4CfjrnkVPNrJL91HsjXgXSr6qtuh20iOlqyVyvN9pTwb6kKDIZmEELmtHyMUx
         JJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CJxvi52KLhytNgk0kqwnP2mrDuV8nCyl/SDeqsxrU14=;
        b=dy1ofqaxfrHOjqdD96MRaOmWSAaxNHxhvFtvKKNjrt5LuSB7teHPAOqvIO69kdtT3v
         WRxixRHJ1YNq64qJyFJSRyoSxBqwTeS9v0zyYuutIAlz2j13SagVYKJcC3OJFB5qqD4f
         +dOT5zz2Q1j+G/xrjSGpkufSlAga27Ddi6S81lUEfDC7Cme2VxBzLr4/Aj/sIwUTS46T
         TlRq8TPGTGwPyTe253mxHCh5fXOlCRY7sFsc/qiIG7pFc+XNYTYnN8+aIUKSE3X1nQPF
         RoOl+1ygGjcbQScs+959LiLGlkiA34qkOEKXCQmyPbQpWMvYUBufKA4Y2aLtIRQAAnNo
         2alA==
X-Gm-Message-State: AOAM531KCcrlF1+Awdr4NA9VQ1ZqnS6juyazHOgsflIgKjYBKP3NTwE1
	5W1KukzMD70p6mqE2lZ6+4dNkrxH5FcmsLneaZl/jO9SUCAluw==
X-Google-Smtp-Source: 
 ABdhPJwZ7Q93Qt95VwcGmG9+DJbjsskts7lnYF2PBsoAkNIwzXJXuYkbgObNsROIKnYxNyM08/DzI2HpRYd2QOQ38rM=
X-Received: by 2002:a9d:6d13:: with SMTP id o19mr4033097otp.232.1643350768544;
 Thu, 27 Jan 2022 22:19:28 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAODzB9oLrBx-866T7ywB4CT4o4Nvkk8WrH-X+DGzsSMt=NswGA@mail.gmail.com>
 <TYAPR01MB625245CB9B3199BE4A7E812492219@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB625245CB9B3199BE4A7E812492219@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Fri, 28 Jan 2022 15:18:52 +0900
Message-ID: 
 <CAODzB9rJ8VCxHEqs0Sf9B=nb4cb0bvtDk3YnGUKYCT+aGBG+qQ@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jan 2022 06:19:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7516

Hi !

On Thu, Jan 27, 2022 at 5:21 PM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Masami Ichikawa
> > Sent: Thursday, January 27, 2022 8:51 AM
> > To: cip-dev <cip-dev@lists.cip-project.org>
> > Subject: [cip-dev] New CVE entries in this week
> >
> > Hi !
> >
> > It's this week's CVE report.
> >
> > This week reported 4 new CVEs.
> >
> > * New CVEs
> >
> > CVE-2022-0322: sctp: account stream padding length for reconf chunk
> >
> > CVSS v3 score is not provided
> >
> > This issue was introduced by commit cc16f00 ("sctp: add support for
> > generating stream reconf ssn reset request chunk") at 4.11-rc1 so 4.9 and 4.4
> > aren't affected by this issue. All kernels have been fixed.
> >
> > Fixed status
> >
> > mainline: [a2d859e3fc97e79d907761550dbc03ff1b36479c]
> > stable/4.14: [41f0bcc7d9eac315259d4e9fb441552f60e8ec9e]
> > stable/4.19: [c57fdeff69b152185fafabd37e6bfecfce51efda]
> > stable/5.10: [d84a69ac410f6228873d05d35120f6bdddab7fc3]
> > stable/5.4: [d88774539539dcbf825a25e61234f110513f5963]
> >
> > CVE-2022-0264: bpf: Fix kernel address leakage in atomic fetch
> >
> > CVSS v3 score is not provided
> >
> > A local user who has certain privileges is able to gather kernel internal memory
> > addresses.
> > This issue was introduced by commit 38086bf ("bpf: Propagate stack bounds
> > to registers in atomics w/ BPF_FETCH") that was merged in 5.12-rc1-dontuse.
> > Fixed in 5.17-rc1. so before 5.12 kernels aren't affected this issue.
> >
> > Fixed status
> >
> > mainline: [7d3baf0afa3aa9102d6a521a8e4c41888bb79882]
> > stable/5.15: [423628125a484538111c2c6d9bb1588eb086053b]
> >
> > CVE-2022-0330: drm/i915: Flush TLBs before releasing backing store
> >
> > CVSS v3 score is not provided
> >
> > Vulnerability in the i915 driver. Without an active IOMMU malicious userspace
> > can gain access (from the code executing on the GPU) to random memory
> > pages.
> >
> > Fixed status
> >
> > mainline: [7938d61591d33394a21bdd7797a245b65428f44c]
> >
> > CVE-2021-22600: net/packet: rx_owner_map depends on pg_vec
> >
> > CVSS v3 score: NIST: not provided
> > CVSS v3 score: CNA: 6.6 medium
> >
> > A double free bug in packet_set_ring() in net/packet/af_packet.c can be
> > exploited by a local user through crafted syscalls to escalate privileges or deny
> > service.
> > This issue was introduced by commit 61fad68 ("net/packet: tpacket_rcv:
> > avoid a producer race condition"). This commit was merged in 5.6.
> > However, it was backported to 5.4, 4.19, and 4.14 so that these kernels are also
> > affected but 4.4 and 4.9 are not backported.
>
> Because commit 61fad68 was not backported to 4.4 and 4.9.
> I think we need to make sure this is also needed for 4.4.
>

I did a quick check to apply 61fad68 ("net/packet: tpacket_rcv: avoid
a producer race condition"), it seems that we may at least need
following patches.

- 58d19b1 ("packet: vnet_hdr support for tpacket_rcv")
- 55655e3 ("net/packet: fix memory leak in packet_set_ring()")

Commit 55655e3 added a goto label to fix a bug which was introduced by
a commit 7f953ab ("af_packet: TX_RING support for TPACKET_V3"). The
commit 7f953ab is not backported to 4.4.y.  Backporting commit 7f953ab
seems like a heavy task.

> >
> > Fixed status
> >
> > mainline: [ec6af094ea28f0f2dda1a6a33b14cd57e36a9755]
> > stable/4.14: [a829ff7c8ec494eca028824628a964cde543dc76]
> > stable/4.19: [18c73170de6719491f79b04c727ea8314c246b03]
> > stable/5.10: [7da349f07e457cad135df0920a3f670e423fb5e9]
> > stable/5.15: [feb116a0ecc5625d6532c616d9a10ef4ef81514b]
> > stable/5.4: [027a13973dadb64ef4f19db56c9b619ee82c3375]
> >
>
> Best regards,
>   Nobuhiro
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#7496): https://lists.cip-project.org/g/cip-dev/message/7496
> Mute This Topic: https://lists.cip-project.org/mt/88710351/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/4520416/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

