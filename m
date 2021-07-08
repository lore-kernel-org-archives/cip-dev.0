Return-Path: <SRS0=Kzyx=MA=lists.cip-project.org=bounce+64572+6608+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE382C07E95
	for <cip-dev@archiver.kernel.org>; Thu,  8 Jul 2021 00:22:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B5361C53
	for <cip-dev@archiver.kernel.org>; Thu,  8 Jul 2021 00:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B5361C53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6608+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RBVjYY4521723xdbhE9wmKp1; Wed, 07 Jul 2021 17:22:30 -0700
X-Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.5472.1625703748783291093
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jul 2021 17:22:29 -0700
X-Received: by mail-ot1-f54.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so4132272oti.2
        for <cip-dev@lists.cip-project.org>; Wed, 07 Jul 2021 17:22:28 -0700 (PDT)
X-Gm-Message-State: 9woFQvpvUZp1SzDah2b81PJDx4520388AA=
X-Google-Smtp-Source: ABdhPJxZQA3whBAhxuCugy4yCSvGAJ1ea6nEA3Dp2Qi4UmzCxgiB/eStmDwOFcHb8MRVaZZycYj/M7Z9wDKjj3oscaQ=
X-Received: by 2002:a05:6830:314c:: with SMTP id c12mr10165463ots.106.1625703747846;
 Wed, 07 Jul 2021 17:22:27 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 8 Jul 2021 09:21:52 +0900
Message-ID: <CAODzB9o6L1L7z=HBNDQUc8yxHy9ZehgCjWhUmke3uuMJ6qpp9A@mail.gmail.com>
Subject: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="2vvpP2gYvoTviLAqsHX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625703750;
 bh=GkpbPvlC0MB4nXowO+9QA3/xtgDmjnCHWeNYHggxyV0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Gk+YimXWbpobN5ja6Iv5boDBHrTButrPAQp1nDcF5LulrsZTtO0BgkNqdxvcCMJmfPY
 GnPp9dfERvbCgjx/1LLiiqEtwwMjcNxu1ilbuGs75d8p8BecYMvUSFb/PIxjGxqniiDAd
 l5SS/r01e2eUJX2dhxqBkaCXn0tyw45RCAc=

--2vvpP2gYvoTviLAqsHX9
Content-Type: text/plain; charset="UTF-8"

Hi!

These are the new issues this week:

* 2021/06/30

CVE-2020-28097 -- vgacon_scrolldelta out-of-bounds read

This commit removes software scrollback support. So,
CONFIG_VGACON_SOFT_SCROLLBACK option is removed from kernel.
Accoring to the cip-kernel-config repo, following configs set
CONFIG_VGACON_SOFT_SCROLLBACK option.

- 4.19.y-cip/x86/cip_qemu_defconfig
- 4.19.y-cip/x86/plathome_obsvx2.config
- 4.19.y-cip-rt/x86/siemens_i386-rt.config
- 4.4.y-cip/x86/cip_qemu_defconfig

This vulnerability affects before Linux 5.8.10 therefore Linux 5.10.y
series do not affect.

CVE-2020-36387 -- fs/io_uring.c has a use-after-free related to
io_async_task_func and ctx reference holding

This CVE affects before Linux 5.8.2. However io_uring was introduced
at Linux 5.1 so that CIP kernels aren't affected by this
vulnerability.

CVE-2021-29256.yml -- Mali GPU Kernel Driver elevates CPU RO pages to writable

Following GPU architectures are affected.

- Bifrost r16p0 through r29p0 before r30p0
- Valhall r19p0 through r29p0 before r30p0
- Midgard r28p0 through r30p0

CVE-2021-31615 -- InjectaBLE: Injecting malicious traffic into
established Bluetooth Low Energy connections

Unencrypted Bluetooth Low Energy baseband links in Bluetooth Core
Specifications 4.0 through 5.2 are affected.

* 2021/07/08

CVE-2021-35039 -- Without CONFIG_MODULE_SIG, verification that a
kernel module is signed, for loading via init_module, does not occur
for a module.sig_enforce=1 command-line argument.

This CVE affects v4.15 to v5.12, so v4.4 kernel doesn't affect.

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--2vvpP2gYvoTviLAqsHX9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6608): https://lists.cip-project.org/g/cip-dev/message=
/6608
Mute This Topic: https://lists.cip-project.org/mt/84058381/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2vvpP2gYvoTviLAqsHX9--
