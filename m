Return-Path: <SRS0=ZVZz=O3=lists.cip-project.org=bounce+64572+6798+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F226C433FE
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 00:59:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26D56113E
	for <cip-dev@archiver.kernel.org>; Thu,  7 Oct 2021 00:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C26D56113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CMMlYY4521723xJnwBwJ09mP; Wed, 06 Oct 2021 17:59:50 -0700
X-Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web12.5203.1633568387678644373
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 17:59:49 -0700
X-Received: by mail-oi1-f177.google.com with SMTP id n63so6590443oif.7
        for <cip-dev@lists.cip-project.org>; Wed, 06 Oct 2021 17:59:47 -0700 (PDT)
X-Gm-Message-State: 9BfaQrlkdGcafyeSggrvAfhex4520388AA=
X-Google-Smtp-Source: ABdhPJwWz8jF1/9Noo7VopuRQNr0CihE6RZKBjUVkiPTYm20GM+yyx/QCdhsiWeMUGQz3A6udKWxizCo54+DnxXAF1U=
X-Received: by 2002:aca:3192:: with SMTP id x140mr771397oix.66.1633568386341;
 Wed, 06 Oct 2021 17:59:46 -0700 (PDT)
MIME-Version: 1.0
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Oct 2021 09:59:10 +0900
Message-ID: <CAODzB9rKixC0p_tFV=qR7sTgPqS1ZxuXJJnkPufW+z-m8NFHxA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="QhF1F2PkFdbFFpYE33yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633568390;
 bh=Mnbs8kfXdIovVWqCxCxsUYRxBirkXybR1thmCSkMiZ4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ucNRC34SYFaDC2Ocjz2P2dxHcFig10n49aPtEeV8/OT25CnOi9YxIGCqcaVmRwB/6i5
 Mzw4PRgFkQZTjIXgSEHaCQTOdDSxMbSdXJYv/iGRZIz+3CFmW3GWn2julTAeRPvuU7PgH
 UV3HOfTH4OVjTM4EsXT87idUJEXqD8L+ST4=
Message-ID: <20211007005910.nrvJxPx0Z1xWdBgnMBjvDYRymR14UBKNZUAUaOsTuzg@z>

--QhF1F2PkFdbFFpYE33yb
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

This week reported  new CVEs.

* New CVEs

CVE-2021-41864: bpf: Fix integer overflow in prealloc_elems_and_freelist()

CVSS v3 score is not provided.

Patch 30e29a9a2bc6 (bpf: Fix integer overflow in prealloc_elems_and_freelist()
) fixes commit 557c0c6e7df8 ("bpf: convert stackmap to
pre-allocation") which has been introduced in 4.6-rc1. Therefore 4.4
kernel isn't affected this issue.

For 4.19 and 5.4, patch can be applied by "git am". For 4.9, patch can
be applied by "git am -3".

Fixed status

Fix patch has been merged into bpf tree, but not in the mainline yet.

CVE-2021-42008: net: 6pack: fix slab-out-of-bounds in decode_data

The 6pack module has slab out-of-bounds vulnerability in decode_data()
which allow local attacker can gain their privileges.
This bug has been fixed since 5.14-rc7. All stable kernels have
already been fixed.

Fixed status

cip/4.19: [4e370cc081a78ee23528311ca58fd98a06768ec7]
cip/4.19-rt: [4e370cc081a78ee23528311ca58fd98a06768ec7]
cip/4.4: [d66736076bd84742c18397785476e9a84d5b54ef]
cip/4.4-rt: [d66736076bd84742c18397785476e9a84d5b54ef]
mainline: [19d1532a187669ce86d5a2696eb7275310070793]
stable/4.14: [5e0e782874ad03ae6d47d3e55aff378da0b51104]
stable/4.19: [4e370cc081a78ee23528311ca58fd98a06768ec7]
stable/4.4: [d66736076bd84742c18397785476e9a84d5b54ef]
stable/4.9: [de9171c1d9a5c2c4c5ec5e64f420681f178152fa]
stable/5.10: [85e0518f181a0ff060f5543d2655fb841a83d653]
stable/5.4: [a73b9aa142691c2ae313980a8734997a78f74b22]

* Updated CVEs

CVE-2019-19449: mounting a crafted f2fs filesystem image can lead to
slab-out-of-bounds read access in f2fs_build_segment_manager in
fs/f2fs/segment.c

This patch has been merged since 5.10-rc1.
For 5.4, patch can be applied via git-am. For 4.4 and 4.19, patch can
be applied via git-am with -3 option.

Fixed status

mainline: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]
stable/5.10: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]

CVE-2021-37159: net: hso: do not call unregister if not registered

4.14, 4.19, and 5.4 have been fixed. 4.4 and 4.9 haven't been fixed
yet. However, patch can be applied to 4.4 and 4.9 without any
modification. According to cip-kernel-config, no CIP member use HSO
module.

Fixed status

mainline: [a6ecfb39ba9d7316057cea823b196b734f6b18ca]
stable/4.14: [4c0db9c4b3701c29f47bac0721e2f7d2b15d8edb]
stable/4.19: [f6cf22a1ef49f8e131f99c3f5fd80ab6b23a2d21]
stable/5.10: [115e4f5b64ae8d9dd933167cafe2070aaac45849]
stable/5.13: [eeaa4b8d1e2e6f10362673d283a97dccc7275afa]
stable/5.4: [fe57d53dd91d7823f1ceef5ea8e9458a4aeb47fa]

CVE-2021-38300: bpf, mips: Validate conditional branch offsets

This vulnerability is only affected to MIPS architecture. No cip
member use MIPS architecture.

5.10 has been fixed. Applying this fix to 4.4, 4.9, 4.19, and 5.4, it
needs to modify the patch.

Fixed status

mainline: [37cb28ec7d3a36a5bace7063a3dba633ab110f8b]
stable/5.10: [c61736a994fe68b0e5498e4e84e1c9108dc41075]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2021-3640: UAF in sco_send_frame function

Fixed in bluetooth-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/sco.c?id=99c23da0eed4fd20cae8243f2b51e10e66aa0951

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

--QhF1F2PkFdbFFpYE33yb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6798): https://lists.cip-project.org/g/cip-dev/message/=
6798
Mute This Topic: https://lists.cip-project.org/mt/86134956/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QhF1F2PkFdbFFpYE33yb--
