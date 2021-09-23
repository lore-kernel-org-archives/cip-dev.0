Return-Path: <SRS0=tWdu=ON=lists.cip-project.org=bounce+64572+6744+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E667C433EF
	for <cip-dev@archiver.kernel.org>; Thu, 23 Sep 2021 01:52:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF93561050
	for <cip-dev@archiver.kernel.org>; Thu, 23 Sep 2021 01:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF93561050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 70jMYY4521723x0eFWscoYaj; Wed, 22 Sep 2021 18:52:55 -0700
X-Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.2352.1632361973771748443
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Sep 2021 18:52:54 -0700
X-Received: by mail-oi1-f181.google.com with SMTP id o66so7391229oib.11
        for <cip-dev@lists.cip-project.org>; Wed, 22 Sep 2021 18:52:53 -0700 (PDT)
X-Gm-Message-State: Ncy2SiWouCHjPhr2PYuk8vnnx4520388AA=
X-Google-Smtp-Source: ABdhPJwGtm1GBrwWVJIAbBk1eZVZ9VM1CkNTdS/H2Z8Muvuv2E0Eowu0xB0iGQ2+biNb1wR7j022pU6tx9x5/xkVFdU=
X-Received: by 2002:a05:6808:545:: with SMTP id i5mr1863649oig.66.1632361972733;
 Wed, 22 Sep 2021 18:52:52 -0700 (PDT)
MIME-Version: 1.0
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Sep 2021 10:52:17 +0900
Message-ID: <CAODzB9pPj1HnfS6RrZyPNqFs7TeN3UTH_YC6Kx91gSVdSYostQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="0IsqFU4ErlTn5blrOorG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632361975;
 bh=Gee1ltlVFN6d3GJqoU24Va0boLSj1NeREXly/QXT8d0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=kFsbRT/QNMyInPV3Cc1Z/Y9fe8msNvnLEvCIBkeK/YDf4V+hp27oIjfX1n6QoGeP4Jp
 BqDEnsEgRphYPvSRCSHIvbbG6tQdXgvhP78ek8pqyVONRX4qiTEh2EKpoKaXiTDO4NvkN
 OMuEZH4E/VtWxIah9GYhYimibfxESr4NgE8=

--0IsqFU4ErlTn5blrOorG
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

This week reported 2 new CVEs.

* New CVEs

CVE-2021-41073: io_uring: ensure symmetry in handling iter types in
loop_rw_iter()

CVSS v3 score is not provided.

This CVE is affected from 5.10-rc1 to 5.15-rc2. All stable kernels are fixed.

Fixed status

mainline: [16c8d2df7ec0eed31b7d3b61cb13206a7fb930cc]
stable/5.10: [ce8f81b76d3bef7b9fe6c8f84d029ab898b19469]
stable/5.14: [71e32edd2210d0304e93ac110814b5a4b3a81dc0]

CVE-2021-3773: lack of port sanity checking in natd and netfilter
leads to exploit of OpenVPN clients

CVSS v3 score is not provided.

The details of the vulnerability has been published on
https://breakpointingbad.com/2021/09/08/Port-Shadows-via-Network-Alchemy.html
.

Fixed status

Not fixed yet.

* Updated CVEs

CVE-2020-16119:  net: dccp: fix structure use-after-free

stable kernels have been fixed this week. All stable kernels are fixed.

Fixed status

mainline: [d9ea761fdd197351890418acd462c51f241014a7]
stable/4.14: [a1bb3c064bf5f2d8c3e9368a9152b1224a9dd64a]
stable/4.19: [dfec82f3e5b8bd93ab65b7417a64886ec8c42f14]
stable/4.4: [1969452d411a73a3125c326c6db0c8433f31dfd5]
stable/4.9: [40ea36ffa7207456c3f155bbab76754d3f37ce04]
stable/5.10: [6c3cb65d561e76fd0398026c023e587fec70e188]
stable/5.14: [51f7b364a2d120cea956b2bb5ccaad29bbf8abce]
stable/5.4: [5ab04a4ffed02f66e8e6310ba8261a43d1572343]

CVE-2020-3702: Specifically timed and handcrafted traffic can cause
internal errors in a WLAN device that lead to improper layer 2 Wi-Fi
encryption with a consequent possibility of information disclosure
over the air for a discrete set of traffic

stable kernel 4.4 and 4.9 have been fixed this week. This
vulnerability has been fixed since 5.12-rc1-dontuse.
All stable kernels are fixed.

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
stable/4.4: [4d6b4335838fd89419212e1e486c415ec36fb610,
5d97f20dc21f3f4b14105590f729e513b0c4921d,
    85d371eb7259c2e6aecd0b77c3f8c193c9593624,
1c8e25862a00a539803fa60eb7a907143688b178,
    3fd07178fbf012db0b38488ea2e0069412250dd2]
stable/4.9: [ea3f7df20fc8e0b82ec0e065b0b0d38e55fd7775,
74adc24d162e67d8862edaf701de620f36f98215,
    d7d4c3c60342deba706fd76ef09d8af68b9a64d8,
13c51682b07a5db4d9efb514e700407c6da22ff9,
    7afed8faf42d8358a165ba554891085e10b1f7a0]
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

CVE-2021-40490: ext4: fix race writing to an inline_data file while
its xattrs are changing

4.4, 4.9, 4.14, and 4.19 kernels have been fixed this week. All stable
kernels are fixed.

Fixed status

mainline: [a54c4613dac1500b40e4ab55199f7c51f028e848]
stable/4.14: [9569234645f102025aaf0fc83d3dcbf1b8cbf2dc]
stable/4.19: [c481607ba522e31e6ed01efefc19cc1d0e0a46fa]
stable/4.4: [69d82df68fbc5e368820123200d7b88f6c058350]
stable/4.9: [7067b09fe587cbd47544a3047a40c64e4d636fff]
stable/5.10: [09a379549620f122de3aa4e65df9329976e4cdf5]
stable/5.13: [c764e8fa4491da66780fcb30a0d43bfd3fccd12c]
stable/5.14: [f8ea208b3fbbc0546d71b47e8abaf98b0961dec1]
stable/5.4: [9b3849ba667af99ee99a7853a021a7786851b9fd]

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

--0IsqFU4ErlTn5blrOorG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6744): https://lists.cip-project.org/g/cip-dev/message/=
6744
Mute This Topic: https://lists.cip-project.org/mt/85805475/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0IsqFU4ErlTn5blrOorG--
