Return-Path: <SRS0=ctSX=MO=lists.cip-project.org=bounce+64572+6627+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8275BC6377A
	for <cip-dev@archiver.kernel.org>; Thu, 22 Jul 2021 02:03:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7AC600D1
	for <cip-dev@archiver.kernel.org>; Thu, 22 Jul 2021 02:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7AC600D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6627+4520388+10495289@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uLNEYY4521723xPfVouoffJx; Wed, 21 Jul 2021 19:03:29 -0700
X-Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web10.2595.1626919407003259236
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jul 2021 19:03:28 -0700
X-Received: by mail-ot1-f51.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so3906810otu.12
        for <cip-dev@lists.cip-project.org>; Wed, 21 Jul 2021 19:03:26 -0700 (PDT)
X-Gm-Message-State: Lbmd6v4OtuyYa3JbNg8W1XiVx4520388AA=
X-Google-Smtp-Source: ABdhPJzt2RNrfmpxya+4E+R8dxNlNWg6DAVCG2/u4Jz1ZESC5baKBnSs1I4UWYf7CZvrEDyQkEDQYG2smv/iLJQ9Flg=
X-Received: by 2002:a9d:6044:: with SMTP id v4mr26953639otj.117.1626919405943;
 Wed, 21 Jul 2021 19:03:25 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 22 Jul 2021 11:02:50 +0900
Message-ID: <CAODzB9oU+C6Gb2LQMyaUsiK9bvtU6C=P=at3ZDqDn74c0r+XSg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="iUxeDtTM4MDpmULTUxo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1626919409;
 bh=NeXbwYGAewLmJXTjY/RSG3LndLCskvCmZSL0EJbLZ+c=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fg1rwBP7X2db4GTtuvQnpJxI829k/4IpbJFBQzzN5wbfDa/vGt9szgBJKi/cw5OcGF+
 Zg6/3SQ721PkLz0JDuOLP7C97lCLsDj3n5UnjpEIyfTBHTnQuLTiTKc5dls5vQO2V1ExF
 Fymoxl7zIniv9VIWyPGzXXDgHCdwURQmE4M=

--iUxeDtTM4MDpmULTUxo8
Content-Type: text/plain; charset="UTF-8"

Hi !

Here is this week's CVE report.

* CVE short summary

** New CVEs

CVE-2021-21781: stable/4.19 and stable/5.10 are fixed. stable/4.4 is
not fixed yet.
CVE-2021-33909: stable/4.4, stable/4.19, and stable/5.10 are fixed.
CVE-2021-3655: stable/4.19 and stable/5.10 are fixed. stable/4.4 is
not fixed yet.
CVE-2021-37159: not fixed in mainline.

** Updated CVEs

CVE-2020-8835: stable/4.4, stable/4.19, and stable/5.10 aren't affected.

* CVE detail

New CVEs

- CVE-2021-21781: Arm SIGPAGE information disclosure vulnerability

The stable/4.4 kernel is not fixed yet. The stable/4.4 kernel's
get_signal_page() in arch/arm/kernel/signal.c seems to be vulnerabile
too.

Fixed commit

mainline: [9c698bff66ab4914bb3d71da7dc6112519bde23e]
stalbe/4.4: not fixed yet
stable/4.19: [80ef523d2cb719c3de66787e922a96b5099d2fbb]
stable/5.10: [7913ec05fc02ccd7df83280451504b0a3e543097]

- CVE-2021-33909: size_t-to-int vulnerability in Linux's filesystem layer

Fixed commit

mainline: [8cae8cd89f05f6de223d63e6d15e31c8ba9cf53b]
stable/4.19: [6de9f0bf7cacc772a618699f9ed5c9f6fca58a1d]
stable/4.4: [3533e50cbee8ff086bfa04176ac42a01ee3db37d]
stable/5.10: [174c34d9cda1b5818419b8f5a332ced10755e52f]

- CVE-2021-3655: missing size validations on inbound SCTP packets

stable/4.4(v4.4.276) contains upstream commit
50619dbf8db77e98d821d615af4f634d08e22698
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v4.4.276&id=48cd035cad5b5fad0648aa8294c4223bedb166dd).

Fixed commit

mainline: [0c5dc070ff3d6246d22ddd931f23a6266249e3db,
50619dbf8db77e98d821d615af4f634d08e22698,
    b6ffe7671b24689c09faa5675dd58f93758a97ae,
ef6c8d6ccf0c1dccdda092ebe8782777cd7803c9]
stable/4.19: [c7a03ebace4f9cd40d9cd9dd5fb2af558025583c,
dd16e38e1531258d332b0fc7c247367f60c6c381]
stable/5.10: [d4dbef7046e24669278eba4455e9e8053ead6ba0,
6ef81a5c0e22233e13c748e813c54d3bf0145782]

- CVE-2021-37159: hso_free_net_device in drivers/net/usb/hso.c in the
Linux kernel through 5.13.4 calls unregister_netdev without checking
for the NETREG_REGISTERED state, leading to a use-after-free and a
double free.

Original patch is not  merged.

Updated CVEs

- CVE-2020-8835: bpf verifier (kernel/bpf/verifier.c) did not properly
restrict the register bounds for 32-bit operations, leading to
out-of-bounds reads and writes in kernel memory

This CVE is introduced in v5.5-rc1; fixed in v5.7-rc1. Therefore
stable/4.4, stable/4.19, and stable/5.10 aren't affected.

From last week CVEs

CVE-2021-29256: not fixed in mainline yet
CVE-2021-31615: not fixed in mainline yet


Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--iUxeDtTM4MDpmULTUxo8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6627): https://lists.cip-project.org/g/cip-dev/message=
/6627
Mute This Topic: https://lists.cip-project.org/mt/84371343/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iUxeDtTM4MDpmULTUxo8--
