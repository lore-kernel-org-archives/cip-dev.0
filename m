Return-Path: <SRS0=6T9h=M4=lists.cip-project.org=bounce+64572+6656+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF1C4338F
	for <cip-dev@archiver.kernel.org>; Thu,  5 Aug 2021 00:48:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD08610FC
	for <cip-dev@archiver.kernel.org>; Thu,  5 Aug 2021 00:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DD08610FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jcOUYY4521723xapq7FDZ79R; Wed, 04 Aug 2021 17:48:25 -0700
X-Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web10.2812.1628124503019553378
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Aug 2021 17:48:25 -0700
X-Received: by mail-oi1-f174.google.com with SMTP id 21so5136161oin.8
        for <cip-dev@lists.cip-project.org>; Wed, 04 Aug 2021 17:48:22 -0700 (PDT)
X-Gm-Message-State: VnEWuxf0xXJP5nEU6Q0xjAqIx4520388AA=
X-Google-Smtp-Source: ABdhPJwJ4arGp4Sa9R2Ry8gUPjk/+IgoM4oiWVfKyT+lD9uWTnO3jqdLDMGO/Mcx2FbFZgAyJa+a0cdUutI4iB0Faeo=
X-Received: by 2002:a05:6808:1523:: with SMTP id u35mr1542673oiw.132.1628124501936;
 Wed, 04 Aug 2021 17:48:21 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 Aug 2021 09:47:46 +0900
Message-ID: <CAODzB9rBLCkGEOCZN03W4kX2KwTk58Jkar3r3nHVAzKOGVktNA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="j2fvGAVS2Cnt2KNeMP9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628124505;
 bh=360jdzdT07qsXM98QUdrcq5Ze7lICQIEGFWmSE57JBs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ib8q9FnqTzYlcMwaP/2a5AvMo7KYBgMewxGzLnnT65L+zTsVkqg1jIe4115pdcKqOJw
 eHxXOmvfyGM1ob/P1SfRjrSlYNxINlBWa9mE0WlQnfOSj2viS+tWImhDGbaJBLUw+SDBx
 fh5EHLw2yUFyDQPP4kJJeHkFqgzt/5tCHe0=

--j2fvGAVS2Cnt2KNeMP9z
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

* CVE short summary

** New CVEs

CVE-2021-3659: stable kernels are fixed

CVE-2021-35477: mainline, v5.10, and v5.13 are fixed

CVE-2021-34556: mainline, v5.10, and v5.13 are fixed

CVE-2021-3669: According to redhat bugzilla, it said "Not reported
upstream, patches are being worked on."

CVE-2021-3679: mainline and stable kernels are fixed

** Updated CVEs

CVE-2021-29256: vulnerability is in 3rd party module.

CVE-2021-31829: v4.4 is not affected this vulnerability. other stable
kernels are fixed

CVE-2021-3655: Updated v4.4 fixed status. stable kernels are fixed.

CVE-2021-22543: v4.19 and v5.10 are fixed. v4.4 uses another way to
get pfn. If v4.4 is vulnerable it needs to write its own patch.

CVE-2021-21781: v4.4 and v4.9 are fixed. all stable kernels are fixed.

CVE-2021-37159: mainline, v5.10, v5.13 are fixed as of 2021/08/05


** Traking CVEs

CVE-2021-31615: there is no fixed information as of 2021/08/05

CVE-2021-3640: there is no fixed information as of 2021/08/05


* CVE detail

New CVEs

CVE-2021-3659: NULL pointer dereference in llsec_key_alloc() in
net/mac802154/llsec.c

Stable kernels are fixed.

Fixed status

mainline: [1165affd484889d4986cf3b724318935a0b120d8]
stable/4.14: [d103fd20f0539e2bd615ed6f6159537cb7e2c5ba]
stable/4.19: [c166c0f5311dc9de687b8985574a5ee5166d367e]
stable/4.4: [cd19d85e6d4a361beb11431af3d22248190f5b48]
stable/4.9: [c3883480ce4ebe5b13dbfdc9f2c6503bc9e8ab69]
stable/5.10: [38731bbcd9f0bb8228baaed5feb4a1f76530e49c]
stable/5.4: [38ea2b3ed00fb4632a706f2c796d6aa4a884f573]


CVE-2021-35477: unprivileged BPF program can obtain sensitive
information from kernel memory via a speculative store bypass
side-channel attack because the technique used by the BPF verifier to
manage speculation is unreliable

CVE-2021-34556 and CVE-2021-35477 are fixed by the same commits.
commit 2039f26f3aca fixes af86ca4e3088(introduced by v4.17-rc7) and
f7cf25b2026d(introduced by v5.3-rc1).

Fixed status
mainline: [f5e81d1117501546b7be050c5fbafa6efd2c722c,
2039f26f3aca5b0e419b98f65dd36481337b86ee]
stable/5.10: [bea9e2fd180892eba2574711b05b794f1d0e7b73,
0e9280654aa482088ee6ef3deadef331f5ac5fb0]
stable/5.13: [ddab060f996e17b38bb181c5fd11a83fd1bfa0df,
0b27bdf02c400684225ee5ee99970bcbf5082282]

CVE-2021-34556: unprivileged BPF program can obtain sensitive
information from kernel memory via a speculative store bypass
side-channel attack because of the possibility of uninitialized memory
locations on the BPF stack

CVE-2021-34556 and CVE-2021-35477 are fixed by same commits. commit
2039f26f3aca fixes af86ca4e3088(introduced by v4.17-rc7) and
f7cf25b2026d(introduced by v5.3-rc1).

Fixed status
mainline: [f5e81d1117501546b7be050c5fbafa6efd2c722c,
2039f26f3aca5b0e419b98f65dd36481337b86ee]
stable/5.10: [bea9e2fd180892eba2574711b05b794f1d0e7b73,
0e9280654aa482088ee6ef3deadef331f5ac5fb0]
stable/5.13: [ddab060f996e17b38bb181c5fd11a83fd1bfa0df,
0b27bdf02c400684225ee5ee99970bcbf5082282]

CVE-2021-3669: reading /proc/sysvipc/shm does not scale with large
shared memory segment counts

According to redhat bugzilla, it said "Not reported upstream, patches
are being worked on.  It is not considered high impact because of the
requirements and need to have massive amount of shm (usually well
above ulimits) ".

https://bugzilla.redhat.com/show_bug.cgi?id=1986473#c10

CVE-2021-3679: racing: Fix bug in rb_per_cpu_empty() that might cause deadloop

mainline and stable kernels are fixed.

Fixed status
mainline: [67f0d6d9883c13174669f88adac4f0ee656cc16a]
stable/4.14: [76598512d5d7fc407c319ca4448cf5348b65058a]
stable/4.19: [6a99bfee7f5625d2577a5c3b09a2bd2a845feb8a]
stable/4.4: [afa091792525dfa6c3c854069ec6b8a5ccc62c11]
stable/4.9: [7db12bae1a239d872d17e128fd5271da789bf99c]
stable/5.10: [757bdba8026be19b4f447487695cd0349a648d9e]
stable/5.13: [917a5bdd114a27c159796928cb3c09723a51d1c7]
stable/5.4: [f899f24d34d964593b16122a774c192a78e2ca56]

Updated CVEs

CVE-2021-29256: The Arm Mali GPU kernel driver allows an unprivileged
user to achieve access to freed memory, leading to information
disclosure or root privilege escalation

This driver is 3rd party module which is provided by ARM. Mainline
kernel doesn't provide driver code.
Bifrost and Valhall are fixed but Midgard driver is not fixed as of 2021/08/03.

CVE-2021-31829: kernel/bpf/verifier.c in the Linux kernel through
5.12.1 performs undesirable speculative loads, leading to disclosure
of stack content via side-channel attacks, aka CID-801c6058d14a

According to commit b9b34ddbe207, this CVE is introdueced by
979d63d50c0c. Also 979d63d50c0c fixes commit b215739 which was
released v4.15-rc8. so v4.4 is not affected this vulnerability.

Fixed status
mainline: [b9b34ddbe2076ade359cd5ce7537d5ed019e9807,
801c6058d14a82179a7ee17a4b532cac6fad067f]
stable/4.14: [4d542ddb88fb2f39bf7f14caa2902f3e8d06f6ba,
19e4f40ce75079b9532f35f92780db90104648f1]
stable/4.19: [0e2dfdc74a7f4036127356d42ea59388f153f42c,
bd9df99da9569befff2234b1201ac4e065e363d0]
stable/5.10: [2cfa537674cd1051a3b8111536d77d0558f33d5d,
2fa15d61e4cbaaa1d1250e67b251ff96952fa614]
stable/5.4: [53e0db429b37a32b8fc706d0d90eb4583ad13848,
8ba25a9ef9b9ca84d085aea4737e6c0852aa5bfd]

CVE-2021-3655: missing size validations on inbound SCTP packets

Update v4.4 fixed status. stable kernels are fixed.

Fixed status
mainline: [0c5dc070ff3d6246d22ddd931f23a6266249e3db,
50619dbf8db77e98d821d615af4f634d08e22698,
    b6ffe7671b24689c09faa5675dd58f93758a97ae,
ef6c8d6ccf0c1dccdda092ebe8782777cd7803c9]
stable/4.19: [c7a03ebace4f9cd40d9cd9dd5fb2af558025583c,
dd16e38e1531258d332b0fc7c247367f60c6c381]
stable/4.4: [48cd035cad5b5fad0648aa8294c4223bedb166dd]
stable/4.9: [c7da1d1ed43a6c2bece0d287e2415adf2868697e]
stable/5.10: [d4dbef7046e24669278eba4455e9e8053ead6ba0,
6ef81a5c0e22233e13c748e813c54d3bf0145782]

CVE-2021-22543: An issue was discovered in the Linux: KVM through
Improper handling of VM_IO|VM_PFNMAP vmas in KVM can bypass RO checks
and can lead to pages being freed while still accessible by the VMM
and guest

The hva_to_pfn_remapped() doesn't exist in v4.4 kernel and it use
different way to get pfn.
If v4.4 affects this CVE, it'll need to write a patch.

Fixed status
mainline: [f8be156be163a052a067306417cd0ff679068c97]
stable/4.19: [117777467bc015f0dc5fc079eeba0fa80c965149]
stable/5.10: [dd8ed6c9bc2224c1ace5292d01089d3feb7ebbc3]
stable/5.12: [c36fbd888dcc27d365c865e6c959d7f7802a207c]
stable/5.4: [bb85717e3797123ae7724751af21d0c9d605d61e]

CVE-2021-21781: Arm SIGPAGE information disclosure vulnerability

All stable kernels are fixed.

Fixed status
mainline: [9c698bff66ab4914bb3d71da7dc6112519bde23e]
stable/4.14: [b71cc506778eb283b752400e234784ee86b5891c]
stable/4.19: [80ef523d2cb719c3de66787e922a96b5099d2fbb]
stable/4.4: [8db77dca7e1d1d1d6aa9334207ead57853832bb7]
stable/4.9: [aa1b5f2fe4532e99986f1eee2c04bb7d314e3007]
stable/5.10: [7913ec05fc02ccd7df83280451504b0a3e543097]
stable/5.4: [f49bff85b6dbb60a410c7f7dc53b52ee1dc22470]

CVE-2021-37159: hso_free_net_device in drivers/net/usb/hso.c in the
Linux kernel through 5.13.4 calls unregister_netdev without checking
for the NETREG_REGISTERED state, leading to a use-after-free and a
double free.

The mainline, 5.10, 5.13 are fixed.

Fixed status
mainline: [a6ecfb39ba9d7316057cea823b196b734f6b18ca]
stable/5.10: [115e4f5b64ae8d9dd933167cafe2070aaac45849]
stable/5.13: [eeaa4b8d1e2e6f10362673d283a97dccc7275afa]

Currenty traking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fixed information as of 2021/08/03

CVE-2021-3640: UAF in sco_send_frame function

There is no fixed information as of 2021/08/03.

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--j2fvGAVS2Cnt2KNeMP9z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6656): https://lists.cip-project.org/g/cip-dev/message=
/6656
Mute This Topic: https://lists.cip-project.org/mt/84675707/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--j2fvGAVS2Cnt2KNeMP9z--
