Return-Path: <SRS0=Qdcm=NY=lists.cip-project.org=bounce+64572+6713+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6074C432BE
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 01:06:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CF861074
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 01:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19CF861074
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4B3UYY4521723xalIeVn46Xa; Wed, 01 Sep 2021 18:06:10 -0700
X-Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web11.951.1630544768296389187
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Sep 2021 18:06:09 -0700
X-Received: by mail-ot1-f45.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso494463ots.5
        for <cip-dev@lists.cip-project.org>; Wed, 01 Sep 2021 18:06:08 -0700 (PDT)
X-Gm-Message-State: PhCi16rNDWPYiXqScSxPPElVx4520388AA=
X-Google-Smtp-Source: ABdhPJw/r1KCP0v892zQJQI69SNvEjpVIdZUy3b0r+milYRxeExABzFc6ecJhY6qIbvopGCBwydN2AHeCLFIEaQcVyk=
X-Received: by 2002:a9d:12b1:: with SMTP id g46mr428026otg.179.1630544767089;
 Wed, 01 Sep 2021 18:06:07 -0700 (PDT)
MIME-Version: 1.0
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Sep 2021 10:05:31 +0900
Message-ID: <CAODzB9orf2AFV9fRwu-VBJxOiJTKvcyhHmihpy3EXH3yB5PEXA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="S456SvVXnNcYnQv2Fg4W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1630544770;
 bh=tWaMzovN1okRHRpZEEIs3nTAi4M4Gat/DZ+ZYcNCrfo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Bt1m3+l6oVyn9J3EefQTNjkqh4qTU8/8olAoGM6vilDH8kjZGO3cOupGDZGFP3tKCjm
 tfugvis4tHHxzkL1kTeJZv8HuxOM4VtWyCx92EtTbue9AHi2sek1QkCva38bsTc5UJki7
 CcEr23woW2jlK9nxsEtrgFGbWsPLCorBqQE=

--S456SvVXnNcYnQv2Fg4W
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

* CVE short summary

** New CVEs

CVE-2021-3739: mainline is fixed. before 4.20-rc1 kernels aren't affected.

CVE-2021-3743: mainline is fixed. before 4.15-rc1 kernels aren't affected.

CVE-2021-3753: mainline is fixed. 4.4 and 4.19 kernels are affected.

** Updated CVEs

CVE-2020-3702: 4.14, 4.19, 5.10, 5.4 kernels are fixed

CVE-2021-3653:stable kernels are fixed.

CVE-2021-3656: stable are fixed. 4.4 is not affected.

CVE-2021-3600: Patches for 4.19 exist in stable-rc tree as of 2021/09/02.

** Tracking CVEs

CVE-2021-31615: No fix information as of 2021/09/02.

CVE-2021-3640: No fix information as of 2021/09/02.

CVE-2020-26555: No fix information as of 2021/09/02.

CVE-2020-26556: No fix information as of 2021/09/02.

CVE-2020-26557: No fix information as of 2021/09/02.

CVE-2020-26559: No fix information as of 2021/09/02.

CVE-2020-26560: No fix information as of 2021/09/02.

CVE-2021-3600: mainline, 5.10, 5.4 are fixed. 4.4 isn't affected. 4.19
will be fixed in stable tree.

* CVE detail

New CVEs

CVE-2021-3739: btrfs: fix NULL pointer dereference when deleting
device by invalid id

Fixed in btrfs tree but not fixed in mainline yet.
This vulnerability has been introduced since 4.20-rc1 so before 4.20
kernel aren't affected this vulnerability.

Fixed status

mainline: [e4571b8c5e9ffa1e85c0c671995bd4dcc5c75091]

CVE-2021-3743: out-of-bound Read in qrtr_endpoint_post in net/qrtr/qrtr.c

The Qualcomm's IPC router protocol(qrtr) has been introduced since
4.15-rc1 so before 4.15 kernels aren't affected.
Checked on cip-kernel-config, it looks like no CIP member enables QRTR.

Fixed status

mainline: [7e78c597c3ebfd0cb329aa09a838734147e4f117]

CVE-2021-3753: A out-of-bounds caused by the race of KDSETMODE in vt

Commit ffb324e6f874121f7dce5bdae5e05d02baae7269 introduced race
condition and oob bug. The commit ffb324e6f874 have been backported to
4.4 and 4.19.

Fixed status

mainline: [2287a51ba822384834dafc1c798453375d1107c7]

Updated CVEs

CVE-2020-3702: Specifically timed and handcrafted traffic can cause
internal errors in a WLAN device that lead to improper layer 2 Wi-Fi
encryption with a consequent possibility of information disclosure
over the air for a discrete set of traffic

Vulnerability in ath9k driver. 4.4.y-cip/arm/siemens_imx6_defconfig
and 4.4.y-cip/arm/moxa_mxc_defconfig use ath9k.

Fixed status

mainline: [56c5485c9e444c2e85e11694b6c44f1338fc20fd,
73488cb2fa3bb1ef9f6cf0d757f76958bd4deaca,
  d2d3e36498dd8e0c83ea99861fac5cf9e8671226,
144cd24dbc36650a51f7fe3bf1424a1432f1f480,
  ca2848022c12789685d3fab3227df02b863f9696]
stable/4.14: [2cbb22fd4b4fb4d0822d185bf5bd6d027107bfda,
20e7de09cbdb76a38f28fb71709fae347123ddb7,
  995586a56748c532850870523d3a9080492b3433,
f4d4f4473129e9ee55b8562250adc53217bad529,
  61b014a8f8de02bedc56f76620170437f5638588]
stable/4.19: [dd5815f023b89c9a28325d8a2a5f0779b57b7190,
d2fd9d34210f34cd0ff5b33fa94e9fcc2a513cea,
  fb924bfcecc90ca63ca76b5a10f192bd0e1bb35d,
7c5a966edd3c6eec4a9bdf698c1f27712d1781f0,
  08c613a2cb06c68ef4e7733e052af067b21e5dbb]
stable/5.10: [8f05076983ddeaae1165457b6aa4eca9fe0e5498,
6566c207e5767deb37d283ed9f77b98439a1de4e,
  2925a8385ec746bf09c11dcadb9af13c26091a4d,
609c0cfd07f0ae6c444e064a59b46c5f3090b705,
  e2036bc3fc7daa03c15fda27e1818192da817cea]
stable/5.4: [0c049ce432b37a51a0da005314ac32e5d9324ccf,
add283e2517a90468ce223465e0f4360128bb650,
  b7d593705eb4f0655a70f0207f573fb1edb80bda,
c6feaf806da6a0deecc2fe41adb3443cdecba347,
  23f77ad13f8176314b7c51f71b9ac7c5c6d10b7b]

CVE-2021-3653: KVM: nSVM: avoid picking up unsupported bits from L2 in int_ctl

Fixed status

mainline: [0f923e07124df069ba68d8bb12324398f4b6b709]
stable/4.14: [26af47bdc45e454877f15fa7658a167bb9799681]
stable/4.19: [42f4312c0e8a225b5f1e3ed029509ef514f2157a]
stable/4.4: [53723b7be26ef31ad642ce5ffa8b42dec16db40e]
stable/4.9: [29c4f674715ba8fe7a391473313e8c71f98799c4]
stable/5.10: [c0883f693187c646c0972d73e525523f9486c2e3]
stable/5.13: [a0949ee63cf95408870a564ccad163018b1a9e6b]
stable/5.4: [7c1c96ffb658fbfe66c5ebed6bcb5909837bc267]


CVE-2021-3656: KVM: nSVM: always intercept VMLOAD/VMSAVE when nested

Fixed status

mainline: [c7dfa4009965a9b2d7b329ee970eb8da0d32f0bc]
stable/4.14: [6ed198381ed2496fbc82214108e56a441d3b0213]
stable/4.19: [119d547cbf7c055ba8100309ad71910478092f24]
stable/5.10: [3dc5666baf2a135f250e4101d41d5959ac2c2e1f]
stable/5.13: [639a033fd765ed473dfee27028df5ccbe1038a2e]
stable/5.4: [a17f2f2c89494c0974529579f3552ecbd1bc2d52]
stable/4.4: Not affected

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information as of 2021/08/26.

CVE-2021-3640: UAF in sco_send_frame function

There is no fix information as of 2021/08/26.

CVE-2020-26555: BR/EDR pin code pairing broken

There is no fix information as of 2021/08/26.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information as of 2021/08/26.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information as of 2021/08/26.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information as of 2021/08/26.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information as of 2021/08/26.

CVE-2021-3600: eBPF 32-bit source register truncation on div/mod

The vulnerability has been introduced since 4.15-rc9. 4.4 is not
affected. 4.19 is not fixed yet as of 2021/08/26.
Patches have been sent to stable
kernel(https://lore.kernel.org/stable/YSj43Lpw9bilHuIn@kroah.com/T/#t).
Then these have been included in stable-rc tree. These patch set
addressed to fix CVE-2021-3444 and CVE-2021-3600.

Discussion: https://lore.kernel.org/stable/YSd1q9Llm1vsWbXT@mussarela/T/#t

Patches in stable-rc tree.

bpf: Do not use ax register in interpreter on div/mod:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/4.19&id=5179c6c58d0a2a05eeadd1bc0431bee01609d5b2
bpf: Fix 32 bit src register truncation on div/mod:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/4.19&id=ca13f215fc36e37cf46d624b8c0ee71c10e231b1
bpf: Fix truncation handling for mod32 dst reg wrt zero:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/4.19&id=a84037fcded8a9513f4838079cef85c516036f23


mainline: [e88b2c6e5a4d9ce30d75391e4d950da74bb2bd90]
stable/5.10: [1d16cc210fabd0a7ebf52d3025f81c2bde054a90]
stable/5.4: [78e2f71b89b22222583f74803d14f3d90cdf9d12]

Regards,

--S456SvVXnNcYnQv2Fg4W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6713): https://lists.cip-project.org/g/cip-dev/message/=
6713
Mute This Topic: https://lists.cip-project.org/mt/85318439/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--S456SvVXnNcYnQv2Fg4W--
