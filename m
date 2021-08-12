Return-Path: <SRS0=DYVU=ND=lists.cip-project.org=bounce+64572+6673+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90B3C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 00:34:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F031460F21
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 00:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F031460F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id i4rqYY4521723xyix9R9JfLb; Wed, 11 Aug 2021 17:34:37 -0700
X-Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web09.16152.1628728473367262655
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Aug 2021 17:34:35 -0700
X-Received: by mail-ot1-f46.google.com with SMTP id z9-20020a9d62c90000b0290462f0ab0800so5586119otk.11
        for <cip-dev@lists.cip-project.org>; Wed, 11 Aug 2021 17:34:33 -0700 (PDT)
X-Gm-Message-State: EVtSfe8nUjt60LtFOtUbG8TQx4520388AA=
X-Google-Smtp-Source: ABdhPJwTrKWAUiHGLYioyqh5k/BPHV4RcOY1OWPw2KHTbyKtNV1jo7QSdTRYyVI5aaoXvutB0Nty8QTZbKqURTLXZeo=
X-Received: by 2002:a9d:2903:: with SMTP id d3mr1245195otb.117.1628728472264;
 Wed, 11 Aug 2021 17:34:32 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Aug 2021 09:33:56 +0900
Message-ID: <CAODzB9q2GjB-rsuq-Ro43yZvVKHY-joQKiXWYx_iqowfwexVCA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="atF1Xe2OkRMNQ1Op0Gab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628728477;
 bh=x9E1Q+0YZmEC+NpxeRaDv4doeSep6z+T6pIULviO5nI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NKAiQsx4eFDPgnRqStRWvOv4KQP9ZaXPtnCVlih1zZcsU1nJKVoPL83jzvc1p5MeqIk
 1dhqZVnu+KYajRE9A1Sbk2PSwtlEQqT+9C2hEFdOhJOvOYCIHO383qmX5Y62Xos7LjeRq
 42PgosZ+yM3+s3Q90FaYmdYXH3OSPpAcHw4=

--atF1Xe2OkRMNQ1Op0Gab
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

* CVE short summary

** New CVEs

CVE-2021-3635: There is no detailed information as of 2021/08/12

CVE-2021-38160: mainline and stable kernels are fixed.

CVE-2021-38166: Fixed in bfp tree. Not fixed in mainline as of 2021/08/12

CVE-2021-38198: mainline and v5.10 are fixed as of 2021/08/12

CVE-2021-38199: mainline, v4.19, and v5.X kernels are fixed. This CVE
introduced by commit 5c6e5b6 which is in since v4.8-rc1

CVE-2021-38200: This CVE only affects PowerPC architecture

CVE-2021-38201: This CVE is introduced since v5.11-rc1 so before 5.11
kernels aren't affected

CVE-2021-38202: This CVE is introduced since v5.13-rc1 so before 5.13
kernels aren't affected

CVE-2021-38203: This CVE is introduced since v5.13-rc1 so before 5.13
kernels aren't affected

CVE-2021-38204: mainline and stable kernels are fixed

CVE-2021-38205: mainline is fixed as of 2021/08/12

CVE-2021-38206: mainline and 5.10 are fixed. This CVE affects since v5.9

CVE-2021-38207: mainline and 5.10 are fixed. This CVE affects since v5.6-rc4

CVE-2021-38208: mainline and stable kernels are fixed as of 2021/08/21

CVE-2021-38209: mainline and 5.10 are fixed. This CVE is introduced
since 5.7-rc1 so before 5.7 kernels aren't affected this CVE.

** Updated CVEs

No update.

** Traking CVEs

CVE-2021-31615: there is no fixed information as of 2021/08/12

CVE-2021-3640: there is no fixed information as of 2021/08/12


* CVE detail

New CVEs

CVE-2021-3635: flowtable list del corruption with kernel BUG at
lib/list_debug.c:50

According to the redhat bugzilla, it said "A flaw was found in the
Linux kernels netfilter implementation. A missing generation check
during DELTABLE processing causes it to queue the DELFLOWTABLE
operation a second time possibly leading to data corruption and denial
of service.  An attacker must have either root or CAP_SYS_ADMIN
capabilities to exploit this flaw."  However, there is no more
detailed information as of 2021/08/12.

Fixed status

None

CVE-2021-38160: virtio_console: Assure used length from device is limited

Fixed status

mainline: [d00d8da5869a2608e97cfede094dfc5e11462a46]
stable/4.14: [56cf748562d3cbfd33d1ba2eb4a7603a5e20da88]
stable/4.19: [b5fba782ccd3d12a14f884cd20f255fc9c0eec0c]
stable/4.4: [187f14fb88a9e62d55924748a274816fe6f34de6]
stable/4.9: [9e2b8368b2079437c6840f3303cb0b7bc9b896ee]
stable/5.10: [f6ec306b93dc600a0ab3bb2693568ef1cc5f7f7a]
stable/5.13: [21a06a244d2576f93cbc9ce9bf95814c2810c36a]
stable/5.4: [52bd1bce8624acb861fa96b7c8fc2e75422dc8f7]

CVE-2021-38166: bpf: Fix integer overflow involving bucket_size

This CVE is introcued by commit 057996380a42 ("bpf: Add batch ops to
all htab bpf map") which was in since 5.6-rc1.

Fixed status

None

CVE-2021-38198: KVM: X86: MMU: Use the correct inherited permissions
to get shadow page

Fixed status

mainline: [b1bd5cba3306691c771d558e94baa73e8b0b96b7]
stable/5.10: [6b6ff4d1f349cb35a7c7d2057819af1b14f80437]

CVE-2021-38199: NFSv4: Initialise connection to the server in
nfs4_alloc_client()

This CVE is introduced by commit 5c6e5b6 ("NFS: Fix an Oops in the
pNFS files and flexfiles connection setup to the DS") which was in
v4.8-rc1. So, v4.4 is not affected this CVE.

Fixed status

mainline: [dd99e9f98fbf423ff6d365b37a98e8879170f17c]
stable/4.19: [743f6b973c8ba8a0a5ed15ab11e1d07fa00d5368]
stable/5.10: [ff4023d0194263a0827c954f623c314978cf7ddd]
stable/5.13: [b0bfac939030181177373f549398ba94c384713d]
stable/5.4: [81e03fe5bf8f5f66b8a62429fb4832b11ec6b272]

CVE-2021-38200: powerpc/perf: Fix crash with
'perf_instruction_pointer' when pmu is not set

This CVE only affects PowerPC architecture so we don't have to track it.

Fixed status

mainline: [60b7ed54a41b550d50caf7f2418db4a7e75b5bdc]

CVE-2021-38201: net/sunrpc/xdr.c in the Linux kernel before 5.13.4
allows remote attackers to cause a denial of service
(xdr_set_page_base slab-out-of-bounds access) by performing many NFS
4.2 READ_PLUS operations.

This CVE is introduced by commit 8d86e37 ("SUNRPC: Clean up helpers
xdr_set_iov() and xdr_set_page_base()") which is in since v5.11-rc1.
So, we don't have to track it.

Fixed status

mainline: [6d1c0f3d28f98ea2736128ed3e46821496dc3a8c]
stable/5.13: [a02357d7532b88e97329bd7786c7e72601109704]

CVE-2021-38202: fs/nfsd/trace.h in the Linux kernel before 5.13.4
might allow remote attackers to cause a denial of service
(out-of-bounds read in strlen) by sending NFS traffic when the trace
event framework is being used for nfsd.

This CVE is introduced by commit 6019ce0 ("NFSD: Add a tracepoint to
record directory entry encoding") which is in since v5.13-rc1.
We don't have to track it.

Fixed status

mainline: [7b08cf62b1239a4322427d677ea9363f0ab677c6]
stable/5.13: [7605bff387a9972038b217b6c60998778dbae931]

CVE-2021-38203: btrfs: fix deadlock with concurrent chunk allocations
involving system chunks

This CVE is introduced since v5.13-rc1 so 5.10, 4.19, 4.4 kernels
aren't affected. We don't have to track it.

Fixed status

mainline: [1cb3db1cf383a3c7dbda1aa0ce748b0958759947]
stable/5.13: [789b24d9950d3e67b227f81b3fab912a8fb257af]

CVE-2021-38204: usb: max-3421: Prevent corruption of freed memory

Fixed status

mainline: [b5fdf5c6e6bee35837e160c00ac89327bdad031b]
stable/4.14: [edddc79c4391f8001095320d3ca423214b9aa4bf]
stable/4.19: [51fc12f4d37622fa0c481604833f98f11b1cac4f]
stable/4.4: [fc2a7c2280fa2be8ff9b5af702368fcd49a0acdb]
stable/4.9: [ae3209b9fb086661ec1de4d8f4f0b951b272bbcd]
stable/5.10: [7af54a4e221e5619a87714567e2258445dc35435]
stable/5.13: [d4179cdb769a651f2ae89c325612a69bf6fbdf70]
stable/5.4: [863d071dbcd54dacf47192a1365faec46b7a68ca]

CVE-2021-38205: net: xilinx_emaclite: Do not print real IOMEM pointer

xemaclite_of_probe() in drivers/net/ethernet/xilinx/xilinx_emaclite.c
leaks kernel memory layout.

Fixed status

mainline: [d0d62baa7f505bd4c59cd169692ff07ec49dde37]
stable/5.13: [8722275b41d5127048e1422a8a1b6370b4878533]

CVE-2021-38206: mac80211: Fix NULL ptr deref for injected rate info

This CVE is introduced by commit cb17ed2 ("mac80211: parse radiotap
header when selecting Tx queue") which is in since 5.9-rc1.
Therefore before 5.9 kernels aren't affected.

Fixed status

mainline: [bddc0c411a45d3718ac535a070f349be8eca8d48]
stable/5.10: [f74df6e086083dc435f7500bdbc86b05277d17af]
stable/5.4: [b6c0ab11c88fb016bfc85fa4f6f878f5f4263646]

CVE-2021-38207: net: ll_temac: Fix TX BD buffer overwrite

This CVE is introduced by commit 84823ff ("net: ll_temac: Fix race
condition causing TX hang") which is in since v5.6-rc4. so before
5.6-rc kernels aren't affected.

Fixed status

mainline: [c364df2489b8ef2f5e3159b1dff1ff1fdb16040d]
stable/5.10: [cfe403f209b11fad123a882100f0822a52a7630f]
stable/5.4: [b6c0ab11c88fb016bfc85fa4f6f878f5f4263646]

CVE-2021-38208: net/nfc/llcp_sock.c in the Linux kernel before 5.12.10
allows local unprivileged users to cause a denial of service (NULL
pointer dereference and BUG) by making a getsockname call after a
certain type of failure of a bind call.

Fixed status

mainline: [4ac06a1e013cf5fdd963317ffd3b968560f33bba]
stable/4.14: [ffff05b9ee5c74c04bba2801c1f99b31975d74d9]
stable/4.19: [93e4ac2a9979a9a4ecc158409ed9c3044dc0ae1f]
stable/4.4: [eb6875d48590d8e564092e831ff07fa384d7e477]
stable/4.9: [39c15bd2e5d11bcf7f4c3dba2aad9e1e110a5d94]
stable/5.10: [48ee0db61c8299022ec88c79ad137f290196cac2]
stable/5.4: [5d4c4b06ed9fb7a69d0b2e2a73fc73226d25ab70]

CVE-2021-38209: net/netfilter/nf_conntrack_standalone.c in the Linux
kernel before 5.12.2 allows observation of changes in any net
namespace because these changes are leaked into all other net
namespaces. This is related to the NF_SYSCTL_CT_MAX,
NF_SYSCTL_CT_EXPECT_MAX, and NF_SYSCTL_CT_BUCKETS sysctls.

This CVE is introduced by commit d0febd8 ("netfilter: conntrack:
re-visit sysctls in unprivileged namespaces") which is in since
5.7-rc1. Therefore before 5.7 kernels aren't affected this CVE.

Fixed status

mainline: [2671fa4dc0109d3fb581bc3078fdf17b5d9080f6]
stable/4.14: [68122479c128a929f8f7bdd951cfdc8dd0e75b8f]
stable/4.19: [9b288479f7a901a14ce703938596438559d7df55]
stable/4.9: [da50f56e826e1db141693297afb99370ebc160dd]
stable/5.10: [d3598eb3915cc0c0d8cab42f4a6258ff44c4033e]
stable/5.4: [baea536cf51f8180ab993e374cb134b5edad25e2]

Updated CVEs

No update.

Currenty traking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fixed information as of 2021/08/12.

CVE-2021-3640: UAF in sco_send_frame function

There is no fixed information as of 2021/08/12.

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--atF1Xe2OkRMNQ1Op0Gab
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6673): https://lists.cip-project.org/g/cip-dev/message/=
6673
Mute This Topic: https://lists.cip-project.org/mt/84830495/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--atF1Xe2OkRMNQ1Op0Gab--
