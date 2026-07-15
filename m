Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2DFC44507
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 22:07:48 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.409.1784153258426681600
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 15:07:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=Vw6hXksr;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.41, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-667f0cfb2bfso1135761d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 15:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784153257; cv=none;
        d=google.com; s=arc-20260327;
        b=YPA+wo2ya3LI0+hI51A/bfoM9D+mbeN6Ma/hYKkYHpD54VVUWJr8EujdeI8NxnhMcz
         nE3xgbQJSbh7Vk0ZL8ThWz71zBRQBPzac4+4qc/Nrvxzy0ZPbPDsEB8rI8IGNt4SYEr4
         r8VYweFkEO105azB3pBVhSRlxFKQsWguS1f18wJEg2907NHSPf1GS5FvvetQCNLSbVhf
         gsvRf/+Ky4NAVegamYdaldQU8L4YBiJRRK4DP0gBtnIMSJWhdm1vTJWzIrXTBAmk042N
         cXeYTWoff/4pj7ae3osYbgtTtHEaSFPyRRO2Wy0VyT7OTHaB0I9uyi1KoRyJpYFT4kxb
         mV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=N77syWBwVCf/XZwG4YEYAQx8qqFRscibugzUWUoyeGo=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=GrlwNWloEO5Ff3DNKEmFWpdT7BFBaKKWjRMYoWjNiuWzUQkwFVQUWQZ5gA34IEZF3e
         n0AzeZa+nLttBnRgAhyX2prxIsfiXf1pfhUdwdEshKS7P9ALqxeoS1GsIO/Z4qUdVRCk
         5snvXtA+k+Fg76TfEkLbzpoXjCFlkQjTOSrFzqzLFNCPhNoBIVPhlvLJ9IlwBq6ulyIP
         EG9gj70RuLe/3e5bDph5Tz5SPAWe1penLL8OUc3PSuq/VckSsIDBxgUZPbvsaBi3pOIO
         l63SlKbuTjib1SvlFbYd7TTxN71MX7uKcH9l8YIlhpFKFKKPPX60+IsmP6WIH8v1jufa
         qpHg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1784153257; x=1784758057; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=N77syWBwVCf/XZwG4YEYAQx8qqFRscibugzUWUoyeGo=;
        b=Vw6hXksrFIP9DdrrDXx9touRXlujfJah4C5+GvwzQ0oIisjUOZcWaR39QK67l6yFvo
         a/Lukca5m7TwTApHy61ot+oXml2D74PlERdywdnHFGmHWx+Ooy4tmTftaDc7TU5WZdbg
         BVc6YvUSjwwYGUgsA1eXG6f9+NRFPS7NdKh+dLODOXeM9HAqJi7cyfjWB0xRnYeUCHzK
         22RXj/b7OvIa3tnq8q5Nld30vtU7fFNlsaIL1V2IhMI0TPhSVjbVIdgopb+X0dZhsUuF
         XeuxLu+RpKjyTsX8fTgkA7dfpBEDrQuI56wSJSkCG/jtcEvxZNGgt/oNITmhDt/HSQde
         uUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784153257; x=1784758057;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N77syWBwVCf/XZwG4YEYAQx8qqFRscibugzUWUoyeGo=;
        b=kaRJ4mx26D4wgxEOnzjgXmDkwj8QkAJ9GNm4gBIW88mTZ6JIqHk1u/npQeeEWip/Je
         3lyc7OYl8nlCucwAEiWT7vpu00DkRKIVIv8soH6dlOcDXLBnVcpZsaF3GEeTSb8swbHa
         YMlbp2wCjYCGUtekLZsi6k4bQP1i+YAKGUr+Qnem30H+xlB7xrKRgxLYRN7ZGxkjt04F
         5I9oPRJLDMIVZz257IACE9xrH84BKzjhHIPehHkTLwwzbvc1JoGuM9SL3jU5EUIsEl5A
         me+nhQnx3Zs6HIjHuSMSwgndokHxbBa4feiudM4wsUBWNtQC4L3wRII2wss3nDKOVB2e
         O6Ow==
X-Gm-Message-State: AOJu0Yxxdt1GtbxXOc12WjIT4vSEatgRcTGgEFVX4upsD4SOv+0ACMPy
	2CNJn+IGRfApLbbH90OqNZF5/xiuUqjdSW31/HcOEiZH13noNubHxpf7kD8IVZZLXH2Js8u0ZpA
	JZL1GQPuiVoNkhfR2AdSkC/Aa+5NEHPu2X9epKeFiAxUvaV8v4hVluZE=
X-Gm-Gg: AfdE7cmOtmqfmAVle1oqTrSsG9edlE8Az9b7s/p18DhriIccZngLYBF98xpM7NquomA
	IrrdEl4ltb5jJBh8oWg0EpoGW/6yXGss4BVsgVdu+Phx2pklugbI11eD+eNDhZU6i7BVK4Ku6Dm
	DTJ4VsnsmN8a1EsklC1SiN90q5ZREypInNFzJAOuuyTDm1ei3+JWCgHwuBdofhDgDEBVJC70lRd
	NREQx8lpeGsrKTIjRRp/yxNKCIhAr24t2VhRDI2+GAuQ+htBLLHXJXSB8g9pBFHcI2oNWMToDhB
	6EM03khBo0GHEAybPljECRu82sJ2f/ZrLw==
X-Received: by 2002:a53:ac9d:0:b0:667:e2e1:4c with SMTP id 956f58d0204a3-668076cafcbmr5115798d50.2.1784153257261;
 Wed, 15 Jul 2026 15:07:37 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Jul 2026 07:07:01 +0900
X-Gm-Features: AUfX_mzFMkAXtCaZIPngDNzp-td_waFTdh6RArEwUVlMiS3Ywg-ziU6lA9y9iBQ
Message-ID: <CAODzB9p684-qvu9bvwoaGHX4FfEEpsL05ELp6+4ZXvdi73P7Fw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 22:07:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23600

Hi!

It's this week's CVE report.

This week reported 3 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2026-53363: xfrm: iptfs: preserve shared-frag marker in
iptfs_consume_frags()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53363

Introduced by commit b96ba31 ("xfrm: iptfs: share page fragments of
inner packets") in v6.14-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9096a5a170e7ecd6467bc2e08668ec39897cda7]
stable/6.18: [dd66f7f6e360ee82cd905517726f8e9091265de5]

CVE-2026-53364: Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53364

Introduced by commit a7bcffc ("Bluetooth: Add PA_LINK to distinguish
BIG sync and PA sync connections") in v6.17-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfa9d28960ed677d556bdf097073bc3129686229]
stable/6.18: [e6b78019664dfe37c3dc707f50e7b453d6c7726d]

CVE-2026-53365: vsock/virtio: fix zerocopy completion for multi-skb sends

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53365

Introduced by commit 581512a ("vsock/virtio: MSG_ZEROCOPY flag
support") in v6.7-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae38d9179190a956e2a87a69ef1dd6f451b51c4d]
stable/6.18: [76b995bc57bd90cb6e954e1966fbd8786da47f0d]

* Updated CVEs

No updated CVEs.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

