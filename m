Return-Path: <SRS0=F7dp=M5=lists.cip-project.org=bounce+64572+6658+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8B3C4338F
	for <cip-dev@archiver.kernel.org>; Fri,  6 Aug 2021 00:47:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C8160F14
	for <cip-dev@archiver.kernel.org>; Fri,  6 Aug 2021 00:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59C8160F14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IJB3YY4521723xqihOFSxkVb; Thu, 05 Aug 2021 17:47:02 -0700
X-Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web11.2051.1628210820305556676
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Aug 2021 17:47:02 -0700
X-Received: by mail-oi1-f172.google.com with SMTP id o185so9791348oih.13
        for <cip-dev@lists.cip-project.org>; Thu, 05 Aug 2021 17:47:00 -0700 (PDT)
X-Gm-Message-State: MCibwey9sIOoLGg9P9g6m0f3x4520388AA=
X-Google-Smtp-Source: ABdhPJyDu4WaC3AL+I99w9eQLFrXPvhfXfTZz5I0p9x62RMJHwLqszA2T3LUarHAnmxXdPQA4zKGAqvoG62QZ8BUyWE=
X-Received: by 2002:a05:6808:1408:: with SMTP id w8mr3697304oiv.116.1628210818802;
 Thu, 05 Aug 2021 17:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9rBLCkGEOCZN03W4kX2KwTk58Jkar3r3nHVAzKOGVktNA@mail.gmail.com>
 <20210805090007.GA10560@amd>
In-Reply-To: <20210805090007.GA10560@amd>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Fri, 6 Aug 2021 09:46:22 +0900
Message-ID: <CAODzB9ozqyG9oBbi9nbusY7vpsTU4j5JHM9Fi=Jf7zq7Gz8-qA@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="gXoAqQhlw5zOWissX3Xc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628210822;
 bh=cygow5Rj6Kscs79ltFM+XspqoUf2i+N0B7HSmuvWls4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=kgKgtwlUqoNdqAyVvkgeS10EcWUqW8ASNF3PlixW2RPujGJVSoprs8GF3hp00ugTHB8
 8/I7qXRYSeP414YX3XOMOnvzIfQgCEZZVsa4bHGKZ2FWKmbxGoBORDlB8NFqorwzNeCEZ
 LMLzE4deTaESRaNfNsxKUlbG0bGKnvyhSh4=

--gXoAqQhlw5zOWissX3Xc
Content-Type: text/plain; charset="UTF-8"

Hi!

On Thu, Aug 5, 2021 at 6:00 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > ** Updated CVEs
>
> > CVE-2021-22543: v4.19 and v5.10 are fixed. v4.4 uses another way to
> > get pfn. If v4.4 is vulnerable it needs to write its own patch.
>
> 4.4 is very different in that area, and KVM is not exactly our
> focus. A lot of research would be needed. I guess we can simply ignore
> this one.
>
> > * CVE detail
> >
> > CVE-2021-35477: unprivileged BPF program can obtain sensitive
> > information from kernel memory via a speculative store bypass
> > side-channel attack because the technique used by the BPF verifier to
> > manage speculation is unreliable
> >
> > CVE-2021-34556 and CVE-2021-35477 are fixed by the same commits.
> > commit 2039f26f3aca fixes af86ca4e3088(introduced by v4.17-rc7) and
> > f7cf25b2026d(introduced by v5.3-rc1).
> >
> > Fixed status
> > mainline: [f5e81d1117501546b7be050c5fbafa6efd2c722c,
> > 2039f26f3aca5b0e419b98f65dd36481337b86ee]
> > stable/5.10: [bea9e2fd180892eba2574711b05b794f1d0e7b73,
> > 0e9280654aa482088ee6ef3deadef331f5ac5fb0]
> > stable/5.13: [ddab060f996e17b38bb181c5fd11a83fd1bfa0df,
> > 0b27bdf02c400684225ee5ee99970bcbf5082282]
>
> Yes, speculation is huge problem, and getting BPF right with broken
> CPUs will be hard. I'd hope CIP people are not using untrusted BTF
> programs, and that we can ignore it.
>

I agree. Don't run untrusted programs on production system is most
important thing.
Ignore  both CVE-2021-34556 and CVE-2021-35477.

> > CVE-2021-3669: reading /proc/sysvipc/shm does not scale with large
> > shared memory segment counts
> >
> > According to redhat bugzilla, it said "Not reported upstream, patches
> > are being worked on.  It is not considered high impact because of the
> > requirements and need to have massive amount of shm (usually well
> > above ulimits) ".
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1986473#c10
>
> DoS only, and only in unusual configuration. I believe we can ignore
> this one.
>

I agree.

> > CVE-2021-37159: hso_free_net_device in drivers/net/usb/hso.c in the
> > Linux kernel through 5.13.4 calls unregister_netdev without checking
> > for the NETREG_REGISTERED state, leading to a use-after-free and a
> > double free.
> >
> > The mainline, 5.10, 5.13 are fixed.
> >
> > Fixed status
> > mainline: [a6ecfb39ba9d7316057cea823b196b734f6b18ca]
> > stable/5.10: [115e4f5b64ae8d9dd933167cafe2070aaac45849]
> > stable/5.13: [eeaa4b8d1e2e6f10362673d283a97dccc7275afa]
>
> I guess we could try to rework the function in similar way 5.10 did,
> but... we are not using HSO in our configs, and I have hard time
> imagining how "attacker" would trigger it. So this is... just a
> bug. I'd suggest ignoring.
>

Thank you for checking the configuration. We don't use HSO configs so
that we don't have attack surface therefore we can ignore it.

> Best regards,
>                                                                 Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--gXoAqQhlw5zOWissX3Xc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6658): https://lists.cip-project.org/g/cip-dev/message/=
6658
Mute This Topic: https://lists.cip-project.org/mt/84675707/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gXoAqQhlw5zOWissX3Xc--
