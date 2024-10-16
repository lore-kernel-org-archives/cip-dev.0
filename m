Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF04D2F7D2
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 22:49:30 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web10.36342.1729118960106559339
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Oct 2024 15:49:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=s9cZt0Vs;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e33c65d104so4027857b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 16 Oct 2024 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1729118959; x=1729723759; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywQxHwC9U2KfZhInp3PoE528tZTqk4jHE6UYiFe6YW0=;
        b=s9cZt0VsGZ59KWELoDClOZ4pPhSnGs4Ejr0We1TDoT62aF7CAnDWR5GUjJGN614kCm
         ohRCobdm4bNktCMyME4t0L/xh4PZSTpc7ZSnTAW6I6pksUQiqYvtZHcocUD7TUDy6hwB
         DQx4FggSgit0ObgI268E+MZFoaxLFQIO03Mrh2iE9EVOFXdh9ySHwVR7jo8RXLeFCcDM
         cY3d72lQLAaULHUd/QjAxS1qDSND6T9vYzzVQXd/M7/HuD5e+59Jb70irIS1JwWpNJWF
         mBF9170nc5w9K6uV2WBkjRdenD2x6VtNXxfruf3E6ON6r7wWGQcAz6tE5zJ/8mx1BPQX
         37aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729118959; x=1729723759;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywQxHwC9U2KfZhInp3PoE528tZTqk4jHE6UYiFe6YW0=;
        b=aXgx4ufcV7FAWBo+nUtiHUUgWr5s9Tk+Y9pakbMfFLWdMsanyrYGydEx/GOngDO+01
         Q+b9ijbok3Tmu/ga2cwBVVTyfX3w7wdJP1pejJJRw6BkJX0TzEOD2iF5oVfJ9tSi7kNu
         11JQGNca6F7FBT1960K2TD3jnbL2kno79Y45dq927NJh3frv2A6UZQfjXfWhkvlj6OcT
         QLf4Cn8yImVPximF9U73WX+U4TutSgJGdcxk0NwbxyaLgknabhyDGDHTeCMc2czG/0hv
         JmM0pfcVQLNONuUlyA3asWRmYv5IKo1I+M9xBPCn/FwsfaZdhHtjJTjXWqLYiu0Ba6XN
         L0OA==
X-Gm-Message-State: AOJu0YzSz/lXBPVvCQtHQzARi1BXaR7t4htICWWkXXgnbCViKIcsR/52
	ugEVMMSZ67ZqhKn4DQEfNUlaaBu6VWvK8cKnUlcrP9Mv6dCbSb3XJN8cbPazJYp3oaCjP6NRxPW
	MPzOLsRvU7EqRxA9u6BLTlgNGVPUwnPy5/+cGPIz1GVtCMM1m7Ko=
X-Google-Smtp-Source: AGHT+IFfWXVAQH1NDfi3QzAkTAXn/5qGdKUfZmGHzdKTPE2Zb0RGo2z7oK6Vujtd2n4pGcCyMenxiEHqhY31g1sFZoo=
X-Received: by 2002:a05:690c:7004:b0:6dd:76ce:d6c9 with SMTP id
 00721157ae682-6e3d41e8da5mr59941397b3.42.1729118958998; Wed, 16 Oct 2024
 15:49:18 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 17 Oct 2024 07:48:43 +0900
Message-ID: <CAODzB9pEx-ZYaaHq8c+mNG2vAxj-RZ678EsUTj1=8z8oL4oJWA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Oct 2024 22:49:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17046

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 14 updated CVEs.

* New CVEs
CVE-2024-47674: mm: avoid leaving partial pfn mappings around in error case

Announce: https://lore.kernel.org/linux-cve-announce/2024101538-CVE-2024-47674-ba1f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11.

Fixed status
mainline: [79a61cc3fc0466ad2b7b89618a6157785f0293b3]
stable/6.1: [65d0db500d7c07f0f76fc24a4d837791c4862cd2]
stable/6.6: [a95a24fcaee1b892e47d5e6dcc403f713874ee80]

* Updated CVEs

CVE-2024-26596: net: dsa: fix netdev_priv() dereference before check
on non-DSA netdevice events

stable/6.6 was fixed.

Fixed status
stable/6.6: [69a1e2d938dbbfcff0e064269adf60ad26dbb102]
stable/6.7: [dbd909c20c11f0d29c0054d41e0d1f668a60e8c8]

CVE-2024-26785: iommufd: Fix protection fault in iommufd_test_syz_conv_iova

stable/6.6 was fixed.

Fixed status
stable/6.6: [fd4d5cd7a2e8f08357c9bfc0905957cffe8ce568]
stable/6.7: [fc719ecbca45c9c046640d72baddba3d83e0bc0b]

CVE-2024-26836: platform/x86: think-lmi: Fix password opcode ordering
for workstations

stable/6.6 was fixed.

Fixed status
stable/6.6: [2deb10a99671afda30f834e95e5b992a805bba6a]

CVE-2024-26876: drm/bridge: adv7511: fix crash on irq during probe

stable/6.6 was fixed.

Fixed status
stable/6.6: [50f4b57e9a9db4ede9294f39b9e75b5f26bae9b7]
stable/6.8: [28a94271bd50e4cf498df0381f776f8ea40a289e]

CVE-2024-26972: ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

stable/6.6 was fixed.

Fixed status
stable/6.6: [b9077897329384b92435f9cafd7ee3c11a3eaa70]
stable/6.8: [62b5ae00c2b835639002ce898ccb5d82c51073ae]

CVE-2024-27011: netfilter: nf_tables: fix memleak in map from abort path

stable/6.6 was fixed.

Fixed status
stable/6.6: [a1bd2a38a1c6388fc8556816dc203c3e9dc52237]
stable/6.8: [49d0e656d19dfb2d4d7c230e4a720d37b3decff6]

CVE-2024-27012: netfilter: nf_tables: restore set elements when delete set fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [164936b2fc88883341fe7a2d9c42b69020e5cafd]
stable/6.8: [86658fc7414d4b9e25c2699d751034537503d637]

CVE-2024-27072: media: usbtv: Remove useless locks in usbtv_video_free()

stable/6.6 was fixed.

Fixed status
stable/6.6: [dea46e246ef0f98d89d59a4229157cd9ffb636bf]
stable/6.8: [3e7d82ebb86e94643bdb30b0b5b077ed27dce1c2]

CVE-2024-35963: Bluetooth: hci_sock: Fix not validating setsockopt user input

stable/6.6 was fixed.

Fixed status
stable/6.6: [0c18a64039aa3f1c16f208d197c65076da798137]
stable/6.8: [50173882bb187e70e37bac01385b9b114019bee2]

CVE-2024-35964: Bluetooth: ISO: Fix not validating setsockopt user input

stable/6.6 was fixed.

Fixed status
stable/6.6: [6a6baa1ee7a9df33adbf932305053520b9741b35]
stable/6.8: [0c4a89f4690478969729c7ba5f69d53d8516aa12]

CVE-2024-35965: Bluetooth: L2CAP: Fix not validating setsockopt user input

stable/6.6 was fixed.

Fixed status
stable/6.1: [9d42f373391211c7c8af66a3a316533a32b8a607]
stable/6.6: [28234f8ab69c522ba447f3e041bbfbb284c5959a]
stable/6.8: [8ee0c132a61df9723813c40e742dc5321824daa9]

CVE-2024-36478: null_blk: fix null-ptr-dereference while configuring
'power' and 'submit_queues'

stable/6.6 was fixed.

Fixed status
stable/6.6: [aaadb755f2d684f715a6eb85cb7243aa0c67dfa9]
stable/6.9: [5d0495473ee4c1d041b5a917f10446a22c047f47]

CVE-2024-36936: efi/unaccepted: touch soft lockup during memory accept

stable/6.6 was fixed.

Fixed status
stable/6.6: [e115c1b5de55a105c75aba8eb08301c075fa4ef4]

CVE-2024-38594: net: stmmac: move the EST lock to struct stmmac_priv

stable/6.6 was fixed.

Fixed status
stable/6.6: [b538fefeb1026aad9dcdcbb410c42b56dff8aae9]
stable/6.9: [6f476aff2d8da1a189621c4c16a76a6c534e4312]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

