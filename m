Return-Path: <SRS0=tYGM=NK=lists.cip-project.org=bounce+64572+6694+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CCCC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 00:13:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8292A610A5
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 00:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8292A610A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KJfsYY4521723xxQsMNciPyZ; Wed, 18 Aug 2021 17:13:08 -0700
X-Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web11.62674.1629331985702820933
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Aug 2021 17:13:07 -0700
X-Received: by mail-ot1-f46.google.com with SMTP id x10-20020a056830408a00b004f26cead745so6417152ott.10
        for <cip-dev@lists.cip-project.org>; Wed, 18 Aug 2021 17:13:05 -0700 (PDT)
X-Gm-Message-State: XotRLRRUTmM6IidlANvZVYjDx4520388AA=
X-Google-Smtp-Source: ABdhPJxk221sTiFeNagSjJqK0szxYEoHRG1LSSSpLO+OI7RmqOM54kyEhNBJOPGIyFpncDwJl8U1CMdV/rlUTbBpKe8=
X-Received: by 2002:a05:6830:b8b:: with SMTP id a11mr9385727otv.179.1629331984567;
 Wed, 18 Aug 2021 17:13:04 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Aug 2021 09:12:28 +0900
Message-ID: <CAODzB9ra5A_NkvqgPMhXc8PR17gaC+R3FU4mfA-_scKGo1Mspw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="bdpbjWKMnLAHiNtKK7jw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629331988;
 bh=NHjhP8PrAqLUNqPKIHHRLX5TgpcURYxXLovwT9yfCPU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=JmIOORnp7EU83sscgI3WIS3l4Q1HJE1jqNxPHORKYajbIZmnnqiZQwZwzNzkMlJldKu
 CZKG5Mv8KyYFGendl2d66dkYYWab8t2SLDbGzButFKeFa/1HSXREljRYnx+kyL+UMnytj
 OkKyUZtTgQaPU1ZCL+LFH9NN+t2jyUpzJSk=

--bdpbjWKMnLAHiNtKK7jw
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

* CVE short summary

** New CVEs

CVE-2021-3653: mainline, 5.10, 5.13, 5.4 are fixed.

CVE-2021-3656: mainline, 5.10, 5.13, 5.4 are fixed. 4.4 is not affected.

** Updated CVEs

CVE-2021-33624: mainline, 4.19, 5.10, 5,12, 5.4 are fixed. 4.4 is not
affected by this vulnerability.

CVE-2021-38198: mainline, 4.19, 5.10, 5.4 are fixed. 4.4 affects this
vulnerability.

CVE-2021-38205: mainline and stable kernels are fixed.

** Tracking CVEs

CVE-2021-31615: there is no fixed information as of 2021/08/12

CVE-2021-3640: there is no fixed information as of 2021/08/12


* CVE detail

New CVEs

CVE-2021-3653: KVM: nSVM: avoid picking up unsupported bits from L2 in int_ctl

CVE-2021-3653 and CVE-2021-3656 are vulnerable when nested kvm is enabled.

Patch for 4.19 is backported by
https://lore.kernel.org/stable/20210816140240.11399-2-pbonzini@redhat.com/
but not applyed yet.

Fixed status

mainline: [0f923e07124df069ba68d8bb12324398f4b6b709]
stable/5.10: [c0883f693187c646c0972d73e525523f9486c2e3]
stable/5.13: [a0949ee63cf95408870a564ccad163018b1a9e6b]
stable/5.4: [7c1c96ffb658fbfe66c5ebed6bcb5909837bc267]

CVE-2021-3656: KVM: nSVM: always intercept VMLOAD/VMSAVE when nested

This vulnerability has been introduced since 4.13-rc1 so that 4.4
kernel is not affected.
CVE-2021-3653 and CVE-2021-3656 are vulnerable when nested kvm is enabled.

Patch for 4.19 is backported by
https://lore.kernel.org/stable/20210816140240.11399-9-pbonzini@redhat.com/
but not applyed yet.

Fixed status

mainline: [c7dfa4009965a9b2d7b329ee970eb8da0d32f0bc]
stable/5.10: [3dc5666baf2a135f250e4101d41d5959ac2c2e1f]
stable/5.13: [639a033fd765ed473dfee27028df5ccbe1038a2e]
stable/5.4: [a17f2f2c89494c0974529579f3552ecbd1bc2d52]

Updated CVEs

CVE-2021-33624: Linux kernel BPF protection against speculative
execution attacks can be bypassed to read arbitrary kernel memory

The main patch 9183671af6dbf60a1219371d4ed73e23f43b49db fixes commit
b2157399cc9898260d6031c5bfe45fe137c1fbe7 which has been merged since
4.15-rc8 so 4.4 aren't affected this vulnerability.

Fixed status

mainline: [d203b0fd863a2261e5d00b97f3d060c4c2a6db71,
fe9a5ca7e370e613a9a75a13008a3845ea759d6e,
    9183671af6dbf60a1219371d4ed73e23f43b49db,
973377ffe8148180b2651825b92ae91988141b05]
stable/4.19: [0abc8c9754c953f5cd0ac7488c668ca8d53ffc90,
c510c1845f7b54214b4117272e0d87dff8732af6,
    9df311b2e743642c5427ecf563c5050ceb355d1d,
c15b387769446c37a892f958b169744dabf7ff23]
stable/5.10: [e9d271731d21647f8f9e9a261582cf47b868589a,
8c82c52d1de931532200b447df8b4fc92129cfd9,
    5fc6ed1831ca5a30fb0ceefd5e33c7c689e7627b]
stable/5.12: [408a4956acde24413f3c684912b1d3e404bed8e2,
68a1936e1812653b68c5b68e698d88fb35018835,
    4a99047ed51c98a09a537fe2c12420d815dfe296,
e5e2010ac3e27efa1e6e830b250f491da82d51b4]
stable/5.4: [283d742988f6b304f32110f39e189a00d4e52b92,
d2f790327f83b457db357e7c66f942bc00d43462,
    fd568de5806f8859190e6305a1792ba8cb20de61,
a0f66ddf05c2050e1b7f53256bd9c25c2bb3022b]

CVE-2021-38198: KVM: X86: MMU: Use the correct inherited permissions
to get shadow page

This vulnerability has been introduced since 2.6.20-rc4 so 4.4 affects
this CVE but patch didn't apply to 4.4
(https://lore.kernel.org/stable/162358450944186@kroah.com/). 4.19 also
failed to apply this patch but backport patch has been merged
recently(https://lore.kernel.org/stable/20210812174140.2370680-1-ovidiu.panait@windriver.com/).


Fixed status

mainline: [b1bd5cba3306691c771d558e94baa73e8b0b96b7]
stable/4.19: [4c07e70141eebd3db64297515a427deea4822957]
stable/5.10: [6b6ff4d1f349cb35a7c7d2057819af1b14f80437]
stable/5.4: [d28adaabbbf4a6949d0f6f71daca6744979174e2]

CVE-2021-38205: net: xilinx_emaclite: Do not print real IOMEM pointer

We talked about this CVE at previous weekly CVE report. Thank your for
Pavel to backport the patch.

Fixed status

mainline: [d0d62baa7f505bd4c59cd169692ff07ec49dde37]
stable/4.14: [1994eacac7af52da86e4b0cb6ae61621bef7393f]
stable/4.19: [9322401477a6d1f9de8f18e5d6eb43a68e0b113a]
stable/4.4: [3d4ba14fc5ffbe5712055af09a5c0cbab93c0f44]
stable/4.9: [ffdc1e312e2074875147c1df90764a9bae56f11f]
stable/5.10: [25cff25ec60690247db8138cd1af8b867df2c489]
stable/5.13: [8722275b41d5127048e1422a8a1b6370b4878533]
stable/5.4: [38b8485b72cbe4521fd2e0b8770e3d78f9b89e60]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fixed information as of 2021/08/19.

CVE-2021-3640: UAF in sco_send_frame function

There is no fixed information as of 2021/08/19.

Regards,


-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--bdpbjWKMnLAHiNtKK7jw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6694): https://lists.cip-project.org/g/cip-dev/message/=
6694
Mute This Topic: https://lists.cip-project.org/mt/84986288/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bdpbjWKMnLAHiNtKK7jw--
