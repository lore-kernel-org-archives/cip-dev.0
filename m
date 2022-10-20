Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99001C4332F
	for <webhook@archiver.kernel.org>; Thu, 20 Oct 2022 13:10:56 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.9249.1666271446019721035
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Oct 2022 06:10:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=O9L5pPk/;
 spf=pass (domain: miraclelinux.com, ip: 209.85.216.41, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-pj1-f41.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso2988090pjq.1
        for <cip-dev@lists.cip-project.org>; Thu, 20 Oct 2022 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/J9f1zByPDgh5OzOn99wiSA4dRPE3N5NovTKaItKpo=;
        b=O9L5pPk/AhlfqhnZ4Hgp/4XkS6yrXpmGK9njf5ID17gflnTfMKoC4z5WuaLu7ig6Ko
         Ueru4HZ4S5mDDVYAaMXcSzGcAKmAqGefCMq4nycenU9w2EK0ZDHCUJMlB1WFOY20mqH2
         YsehNkom0Zazj5TjSPU35Lx9g/IavxNuj4H1qhpm7BQxblirsOBGueFr08uJaaacRBmJ
         vyPVJ6NalfDgfBSI2qbVYqv+cAL9Jp2mH1WIECvWAkfrMuH93Kw+H0oD7wf/xu912gXS
         E4xWBxgLdny0egdJ+3iVQwN1BdmjgXjHSZj46q7JEmYtG6Msg7t+7JD06Chk9ExGxa2W
         wMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/J9f1zByPDgh5OzOn99wiSA4dRPE3N5NovTKaItKpo=;
        b=Zt8EUMvfKYfdNmNQDO5Pxrns2MIrqv0HAW1tI0aSUxYvvAA3wWXF/TYjeLW70SbKbR
         UaTSM/tBov0+BeYCN93CBZ1Db4ABfTRIzWmQDzoLLmnRfnWmIWquheqkNYAqmOFcRT3i
         jt7dfsIIz2+h8+rf7pZfIDzgCECKWDMERhZEgTGs2uTNzNXBd43hyElQ+OSf/d7pVb+d
         vHbI97aT6FoSKD5mwvmAgMbu6xkwiSqKyv4QbJshaHWHfdVQY+sj0mFPjren2gezu+bJ
         vNfnMuYvTY3/RHhdp7ECaPN0ZUBwoUJiQX0tXDtTFDBJ3ujwzRziJm1Ah6rKSlqv6GjQ
         uL9A==
X-Gm-Message-State: ACrzQf2P8Wf5xwkR186KGSTwA1K8fFM/AGtBUK4dNymFrMKyvQoSZSST
	E/cBzx11vKiIgV+aY1IJ9NOXpooEfFOA7yi+UPVvtegKqHviSQ==
X-Google-Smtp-Source: AMsMyM5nthX8dHHoZf0wiIJFFUNJWLjVTSDEIK4vbLpFZRZqzkLN61fuX8zic15fWN+RsP0MpCV/QjNOPM6WATgK1vA=
X-Received: by 2002:a17:902:b589:b0:17f:5756:b3f9 with SMTP id
 a9-20020a170902b58900b0017f5756b3f9mr13853494pls.14.1666271444636; Thu, 20
 Oct 2022 06:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9q+zmEqdu1=u7JESKbqgDvkAjXaeRPXELRm7Gyg+-76FA@mail.gmail.com>
 <20221020075759.GA17249@amd>
In-Reply-To: <20221020075759.GA17249@amd>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Oct 2022 22:10:08 +0900
Message-ID: <CAODzB9pgiGjwpuKG3D7LyXeWyJaXf2NbwYxwmj=v4A_ZGD4EYw@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Oct 2022 13:10:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9796

Hi.

On Thu, Oct 20, 2022 at 4:58 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > CVE-2022-3523: mm/memory.c: fix race when faulting a device private page
> >
> > CVSS v3 score is not provided(NIST).
> > CVSS v3 score is 5.3 MEDIUM(VulDB).
> >
> > A vulnerability was found in Linux Kernel. It has been classified as
> > problematic. Affected is an unknown function of the file mm/memory.c
> > of the component Driver Handler. The manipulation leads to use after
> > free.
> ...
> > This fix is based on Memory folios feature so that it cannot apply to
> > older kernels straightly.
>
> Sounds like fun, but changelog also says:
>
>     During normal usage it is unlikely these will cause any problems.
>     However
>         without these fixes it is possible to crash the kernel from
>     userspace.
>         These crashes can be triggered either by unloading the kernel
>     module or
>         unbinding the device from the driver prior to a userspace task
>     exiting.
>
> Yeah, so.. don't let untrusted users play with modules / device
> bindings. We don't do that by default.
>
> > CVE-2022-3524: tcp/udp: Fix memory leak in ipv6_renew_options().
> >
> > A vulnerability was found in Linux Kernel. It has been declared as
> > problematic. Affected by this vulnerability is the function
> > ipv6_renew_options of the component IPv6 Handler. The manipulation
> > leads to memory leak. The attack can be launched remotely.
> >
> > CVSS v3 score is 7.5 HIGH(NIST).
> > CVSS v3 score is 4.3 MEDIUM(VulDB).
> >
> > Kernel 4.4 is also affected by this issue. applying this fix needs to
> > modify the patch.
> >
> > Fixed status
> > mainline: [3c52c6bb831f6335c176a0fc7214e26f43adbd11]
>
> Sounds like more fun.
>
> > CVE-2022-3535: net: mvpp2: fix mvpp2 debugfs leak
> >
> > CVSS v3 score is not provided(NIST).
> > CVSS v3 score is 3.5 LOW(VulDB).
> >
> > A vulnerability classified as problematic was found in Linux Kernel.
> > Affected by this vulnerability is the function mvpp2_dbgfs_port_init
> > of the file drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c of the
> > component mvpp2. The manipulation leads to memory leak.
> >
> > Introduced by commit 21da57a ("net: mvpp2: add a debugfs interface for
> > the Header Parser") in 4.19-rc1.
> > 4.4, 4.9, 4.10, and 4.19 kernels are not affected by this issue.
>
> 4.19-rc1 means that 4.19 is affected, and indeed that commit is in
> 4.19-stable. Due to severity of the vulnerability (very low), I don't
> think we care much.
>

oops, you're right. 4.19 is affected.
4.19 is not listed in the ignore section in CVE-2022-3535.yml. so I
made a mistake when writing this report.

> > CVE-2022-3565: mISDN: fix use-after-free bugs in l1oip timer handlers
> >
> > CVSS v3 score is not provided(NIST).
> > CVSS v3 score is 4.6 MEDIUM(VulDB).
> >
> > A vulnerability, which was classified as critical, has been found in
> > Linux Kernel. Affected by this issue is the function del_timer of the
> > file drivers/isdn/mISDN/l1oip_core.c of the component Bluetooth. The
> > manipulation leads to use after free.
>
> "Critial" -- really? mISDN does not have much to do with bluetooth. i
> don't think we care.
>

I think it is not a critical vulnerability. Sometimes NVD's
description is exaggerated :(

> > CVE-2022-3566: tcp: Fix data races around icsk->icsk_af_ops.
> >
> > CVSS v3 score is not provided(NIST).
> > CVSS v3 score is 4.6 MEDIUM(VulDB).
> >
> > A vulnerability, which was classified as problematic, was found in
> > Linux Kernel. This affects the function tcp_getsockopt/tcp_setsockopt
> > of the component TCP Handler. The manipulation leads to race
> > conditions.
>
> There's no race in the compile code assuming sane compiler; this is
> just READ_ONCE() annotation for the tools.
>
> I wonder if we should simply ignore anything that is "medium" or
> lower? This is not too useful. There are _lot_ of READ_ONCE
> annotations:
>

I think it is okay to ignore low score vulnerabilities.
I think it is okay to ignore low score vulnerabilities. I think if
vulnerability to local privilege escalation/remote code
execution/remote DoS, the score will get high or at least medium.

> rc-v5.10.132.list:a just a READ_ONCE annotation |dd36fc0e5 1f1be0 o: 5.10| sysctl: Fix data races in proc_dointvec().
> rc-v5.10.132.list:a just a READ_ONCE annotation |3c353ca70 4762b5 o: 5.10| sysctl: Fix data races in proc_douintvec().
> rc-v5.10.132.list:a just a READ_ONCE annotation |2d706aadb f613d8 o: 5.10| sysctl: Fix data races in proc_dointvec_minmax().
> rc-v5.10.132.list:a just a READ_ONCE annotation |23f9db9f8 2d3b55 o: 5.10| sysctl: Fix data races in proc_douintvec_minmax().
> rc-v5.10.132.list:a just a READ_ONCE annotation |3b18d2877 c31bcc o: 5.10| sysctl: Fix data races in proc_doulongvec_minmax().
> rc-v5.10.132.list:a just a READ_ONCE annotation |fbb481c6c e87782 o: 5.10| sysctl: Fix data races in proc_dointvec_jiffies().
> rc-v5.10.132.list:a just a READ_ONCE annotation |569565b31 47e6ab o: 5.10| tcp: Fix a data-race around sysctl_tcp_max_orphans.
> rc-v5.10.132.list:a just a READ_ONCE annotation |1ffd2f3ca 3d32ed o: 4.19| inetpeer: Fix data-races around sysctl.
> rc-v5.10.132.list:a just a READ_ONCE annotation |759957e29 310731 o: 4.19| net: Fix data-races around sysctl_mem.
> rc-v5.10.132.list:a not a minimum fix, just a READ_ONCE annotation |2afb079f1 dd44f0 o: 4.9| cipso: Fix data-races around sysctl.
> rc-v5.10.132.list:a just a READ_ONCE annotation |cc7dc7f73 48d7ee o: 4.9| icmp: Fix data-races around sysctl.
> rc-v5.10.132.list:a just a READ_ONCE annotation |ecc3b5b6d 73318c o: 5.10| ipv4: Fix a data-race around sysctl_fib_sync_mem.
> rc-v5.10.132.list:a just a READ_ONCE annotation |8c0062e3d 2a4eb7 o: 4.19| icmp: Fix a data-race around sysctl_icmp_ratelimit.
> rc-v5.10.132.list:a just a READ_ONCE annotation |abf7c1c68 1ebcb2 o: 4.19| icmp: Fix a data-race around sysctl_icmp_ratemask.
> rc-v5.10.132.list:a not a minimum fix, just a READ_ONCE annotation |66a01e657 e49e4a o: 4.9| ipv4: Fix data-races around sysctl_ip_dynaddr.
> rc-v5.10.132.list:a just a READ_ONCE annotation |a9f8eb955 bdf00b o: 5.10| nexthop: Fix data-races around nexthop_compat_mode.
> rc-v5.10.137.list:a just a READ_ONCE annotation |6a5c5b381 4915d5 o: 5.10| inet: add READ_ONCE(sk->sk_bound_dev_if) in INET_MATCH()
> rc-v5.10.137.list:a just a READ_ONCE annotation, not a minimum fix |8d69424fb 5d368f o: 5.10| ipv6: add READ_ONCE(sk->sk_bound_dev_if) in INET6_MATCH()
> rc-v5.10.137.list:a just a READ_ONCE annotation |1651eed8e 08a75f o: 5.10| tcp: Fix data-races around sysctl_tcp_l3mdev_accept.
> rc-v5.10.140.list:a just a READ_ONCE annotation |1cf035989 027395 o: 5.10| net: Fix data-races around sysctl_[rw]mem(_offset)?.
> rc-v5.10.140.list:a just a READ_ONCE annotation |c430cce0f 1227c1 o: 5.10| net: Fix data-races around sysctl_[rw]mem_(max|default).
> rc-v5.10.140.list:a just a READ_ONCE annotation |0ca09591c 5dcd08 o: 5.10| net: Fix data-races around netdev_max_backlog.
> rc-v5.10.140.list:a just a READ_ONCE annotation |c9a25e523 61adf4 o: 4.19| net: Fix data-races around netdev_tstamp_prequeue.
> rc-v5.10.140.list:a just a READ_ONCE annotation |33a56c470 7de6d0 o: 5.10| net: Fix data-races around sysctl_optmem_max.
> rc-v5.10.140.list:a just a READ_ONCE annotation |b88a8545b d2154b o: 4.9| net: Fix a data-race around sysctl_tstamp_allow_data.
> rc-v5.10.140.list:a just a READ_ONCE annotation |ff5a88e37 c42b7c o: 4.9| net: Fix a data-race around sysctl_net_busy_poll.
> rc-v5.10.140.list:a just a READ_ONCE annotation |b99764a7c e59ef3 o: 4.9| net: Fix a data-race around sysctl_net_busy_read.
> rc-v5.10.140.list:a just a READ_ONCE annotation |6d73091c1 fa45d4 o: 4.19| net: Fix a data-race around netdev_budget_usecs.
> rc-v5.10.140.list:a just a READ_ONCE annotation |99e03c89b 3c9ba8 o: 4.9| net: Fix a data-race around sysctl_somaxconn.
> rc-v5.10.140-sep7.list:a just a READ_ONCE annotation |b88a8545b d2154b o: 4.9| net: Fix a data-race around sysctl_tstamp_allow_data.
> rc-v5.10.140-sep7.list:a just a READ_ONCE annotation |ff5a88e37 c42b7c o: 4.9| net: Fix a data-race around sysctl_net_busy_poll.
> rc-v5.10.140-sep7.list:a just a READ_ONCE annotation |b99764a7c e59ef3 o: 4.9| net: Fix a data-race around sysctl_net_busy_read.
> rc-v5.10.140-sep7.list:a just a READ_ONCE annotation |99e03c89b 3c9ba8 o: 4.9| net: Fix a data-race around sysctl_somaxconn.
> rc-v5.10.14X-pre.list:a just a READ_ONCE annotation 5.10 05/16] cgroup: Remove data-race around cgrp_dfl_visible
> rc-v5.10.150.list:a just a READ_ONCE annotation |1b3ae95b2 aacd46 o: 4.9| tcp: annotate data-race around tcp_md5sig_pool_populated
>
> > CVE-2022-3567: ipv6: Fix data races around sk->sk_prot.
> >
> > CVSS v3 score is not provided(NIST).
> > CVSS v3 score is 4.6 MEDIUM(VulDB).
> >
> > A vulnerability has been found in Linux Kernel and classified as
> > problematic. This vulnerability affects the function
> > inet6_stream_ops/inet6_dgram_ops of the component IPv6 Handler. The
> > manipulation leads to race conditions.
> >
> > According to the commit log, commit 086d490 ("ipv6: annotate some
> > data-races around sk->sk_prot") fixes a race condition bug but it was
> > not enough.
> > Therefore it seems that both commit 086d490 and 364f997 need to fix
> > this issue.
>
> This is a tiny bit more serious than usual READ_ONCE annotations,
> but...
>
> > CVE-2022-3541: eth: sp7021: fix use after free bug in
> > spl2sw_nvmem_get_mac_address
> >
> > CVSS v3 score is 7.8 HIGH(NIST).
> > CVSS v3 score is 5.5 MEDIUM(VulDB).
> >
> > A vulnerability classified as critical has been found in Linux Kernel.
> > This affects the function spl2sw_nvmem_get_mac_address of the file
> > drivers/net/ethernet/sunplus/spl2sw_driver.c of the component BPF. The
> > manipulation leads to use after free.
>
> Component BPF?
>
> > CVE-2022-3594: r8152: Rate limit overflow messages
> >
> > CVSS v3 score is not provided(NIST).
> > CVSS v3 score is 5.3 MEDIUM(VulDB).
> >
> > A vulnerability was found in Linux Kernel. It has been declared as
> > problematic. Affected by this vulnerability is the function
> > intr_callback of the file drivers/net/usb/r8152.c of the component
> > BPF. The manipulation leads to logging of excessive data. The attack
> > can be launched remotely.
> >
> > Fixed status
> > mainline: [93e2be344a7db169b7119de21ac1bf253b8c6907]
>
> The "attack" is writing line to syslog. Seems like every bug can get a
> CVE if someone tries.
>

yeah, even though remote user could write lots of data in the syslog
with this issue, it seems to be a normal bug.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#9795): https://lists.cip-project.org/g/cip-dev/message/9795
> Mute This Topic: https://lists.cip-project.org/mt/94444803/4520416
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

