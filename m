Return-Path: <SRS0=+F5+=OG=lists.cip-project.org=bounce+64572+6739+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2F1C433EF
	for <cip-dev@archiver.kernel.org>; Thu, 16 Sep 2021 00:44:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60404610A4
	for <cip-dev@archiver.kernel.org>; Thu, 16 Sep 2021 00:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60404610A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8hsCYY4521723xkBksSmrtkx; Wed, 15 Sep 2021 17:44:36 -0700
X-Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web09.4852.1631753074815407019
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Sep 2021 17:44:36 -0700
X-Received: by mail-oo1-f48.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso1536231oon.1
        for <cip-dev@lists.cip-project.org>; Wed, 15 Sep 2021 17:44:34 -0700 (PDT)
X-Gm-Message-State: 5DxDdIGfJUc5SvW0L3qB2sEOx4520388AA=
X-Google-Smtp-Source: ABdhPJyTxsx1dZgOA5jD2XIupppxkarQOnvt9GMEeIZx4J+z00IS6z57dl2Bm7UX6AlQkj5QKEjWSu3qLBanFwTpzWY=
X-Received: by 2002:a05:6820:555:: with SMTP id n21mr2288359ooj.56.1631753073674;
 Wed, 15 Sep 2021 17:44:33 -0700 (PDT)
MIME-Version: 1.0
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Sep 2021 09:43:58 +0900
Message-ID: <CAODzB9rpFGi8xKkocVfEy-4wJFfR9AwkebC9kSrO3W=zK_PsTQ@mail.gmail.com>
Subject: [cip-dev] New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="R9poq5s6Hrw7MtlXdqXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631753076;
 bh=wgqIPVHkkj+CMg4F8vF7tpSLvDQlitxmbMoa7eHczTE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=t9oL8uCfHucDmAy5zWOUnC9zQ3/3MttyQvPdd73w5xGn4mxLm1IZoH8So43wb+tOi8p
 6U3GhcaIXjylaQaWvuYEN7t66ujLDHvFufaAH9S/C+wbrsmX7cik6P5vvrxKlBMZUB7Dn
 e8Mfs0L0I0E/qE4itE0vbskeVKHH4HoDR/8=

--R9poq5s6Hrw7MtlXdqXm
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

This week reported 4 new CVEs.

* New CVEs

CVE-2021-3744: crypto: ccp - fix resource leaks in ccp_run_aes_gcm_cmd()

This bug is in the AMD Cryptographic Coprocessor (CCP) driver. This
bug is related to CVE-2021-3744.

In the cip-kernel-config directory, 4.4 kernel uses this driver.

$ find . -type f | xargs grep -n "ccp-ops.c"
./4.4.y-cip-rt/x86/siemens_i386-rt.sources:1716:drivers/crypto/ccp/ccp-ops.c
./4.4.y-cip-rt/all.sources:3665:drivers/crypto/ccp/ccp-ops.c

Fixed status

Patch is available but it hasn't been merged yet.

CVE-2021-3764: DoS in ccp_run_aes_gcm_cmd() function

This vulnerability is a memory leak which will cause Dos attack.
This bug is in the AMD Cryptographic Coprocessor (CCP) driver. This
bug is related to CVE-2021-3764.

Fixed status

Patch is available but it hasn't been merged yet.

CVE-2021-3752: UAF in bluetooth

There is a use after free bug in bluetooth module.

Fixed status

This CVE hasn't been fixed in the mainline yet.

CVE-2021-38300: bpf, mips: Validate conditional branch offsets

This bug only affects bpf in mips architecture.  Patch is available,
but hasn't been merged yet.

Fixed status:

Not yet.

* Updated CVEs

CVE-2021-40490:  A race condition was discovered in
ext4_write_inline_data_end in fs/ext4/inline.c in the ext4 subsystem
in the Linux kernel through 5.13.13

kernel 5.4 has been fixed.

Fixed status

mainline: [a54c4613dac1500b40e4ab55199f7c51f028e848]
stable/5.10: [09a379549620f122de3aa4e65df9329976e4cdf5]
stable/5.13: [c764e8fa4491da66780fcb30a0d43bfd3fccd12c]
stable/5.14: [f8ea208b3fbbc0546d71b47e8abaf98b0961dec1]
stable/5.4: [9b3849ba667af99ee99a7853a021a7786851b9fd]

CVE-2021-3635: flowtable list del corruption with kernel BUG at
lib/list_debug.c:50

This vulnerability has been affected from 4.16-rc1 to 5.5-rc7.
Therefore 4.4 kernel, and above 5.5 kernels aren't affected.

Fixed status

cip/4.19: [8260ce5aeee4d7c4a6305e469edeae1066de2800]
cip/4.19-rt: [8260ce5aeee4d7c4a6305e469edeae1066de2800]
mainline: [335178d5429c4cee61b58f4ac80688f556630818]
stable/4.19: [8260ce5aeee4d7c4a6305e469edeae1066de2800]
stable/5.4: [8f4dc50b5c12e159ac846fdc00702c547fdf2e95]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2021-3640: UAF in sco_send_frame function

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.


Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--R9poq5s6Hrw7MtlXdqXm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6739): https://lists.cip-project.org/g/cip-dev/message/=
6739
Mute This Topic: https://lists.cip-project.org/mt/85642333/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--R9poq5s6Hrw7MtlXdqXm--
