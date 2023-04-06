Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E6FC7619A
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 00:20:21 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web10.147040.1680740416571304623
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Apr 2023 17:20:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=MD9s0uR1;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.170, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f170.google.com with SMTP id w13so16574407oik.2
        for <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 17:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112; t=1680740415;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57eg25LT5T/g77CKc7sxiPw2ZhdSbP4ScrnOeajax/k=;
        b=MD9s0uR15GfzZVGigm0fBOHRSCnp2On3TjWOKSSfm4DNSI3QbP6wsCZlduUPXZaI8N
         1aRI41JSrGSi9m1zXNq4YsUwbce+S7h3VMPW72+2b3DTdVGBbA4752uXRu9lm2dXE2bn
         JICkPKEVr1ilrpPoJu4suqS4zXbvd0uQpAqwLF7EigyCi0oCUut0luVhIqtna+4OPBvb
         s8cNmWhx0es7znCJXDzjfCKZsyf9s3vtd8BjEbwXXSUwSlzDWDko7tyi35R+nBKsOGzA
         FMx4PBT6XbCI1J0GMjwg8nK27tPg2yXHEs3AfrMMC2rwOHjlG2/2vuwxYUi4SNUqaHyT
         /wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680740415;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57eg25LT5T/g77CKc7sxiPw2ZhdSbP4ScrnOeajax/k=;
        b=TBgURFXE1k4mRFmEgvVFtO6qBoI3j47JqBLmu8KxstvKE54z40I81nvP2Q5OjMh80Z
         JyZ9v3T9daohTUNvhWtiQglnPKPHSQNTp4ffk3aBtxarz9nedQ3Jc1slmdTXdpOn2EMI
         mpWLBVhnZEpMdTK43flKoZdkS3nTcfwIGz3yklOOc8JcDFCP+hLd27O1c9qXwCNK0WFz
         CXGxPiFuqnQeZDtGkX/BbYcE/+JuaaAt66ntuiR++MdH14+A1aYeGY3mXzyp8stYqUga
         f3VynFgFnL5Ji9kuaufxRKrgI5ozC0HJYFdpbZOtTJbCEvelCBk0iUHZFITHaG24rU8X
         Ka8A==
X-Gm-Message-State: AAQBX9c1UealoF72JHBLSYtVFYP8TDFgk3C3Cz2wfJLlbsD4VHuxc/NF
	B6eqKcT7stKaQU6FviTnJLy2dPXHuTNKUvvKaTpr9riS+lf0l5gA5Ak=
X-Google-Smtp-Source: AKy350bLgNtXQzsgIs4XzGGnT+ucL+6jZyoaQm7G6YsTt1VvayO1ZFEjGPKdaCT8fqOw9fG8FsEL5nO3RUF1sAcvjN0=
X-Received: by 2002:aca:2103:0:b0:384:1e6a:bf10 with SMTP id
 3-20020aca2103000000b003841e6abf10mr1981099oiz.5.1680740415055; Wed, 05 Apr
 2023 17:20:15 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Apr 2023 09:19:38 +0900
Message-ID: <CAODzB9q+hmJJ8J2=C_CTYFZpp8WZ=aYmd42EOQ_yxhLE9o7=kg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Apr 2023 00:20:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11186

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 9 updated CVEs.

* New CVEs

CVE-2023-1670: xirc2ps_cs: Fix use after free bug in xirc2ps_detach

CVSS v3 score is not provided.

A use-after-free bug was found in PCMCIA xirc2ps driver.
Patche's Fixes tag is set to commit 1da177e ("Linux-2.6.12-rc2") so it
seems as if all stable kernels are affected.

Fixed status
mainline: [e8d20c3ded59a092532513c9bd030d1ea66f5f44]
stable/5.15: [4ab9e85a5ce0b2ef6e63abf861179898da613d78]
stable/6.1: [9d882229d365f68f74028252261ab14a8de7faed]
stable/6.2: [9c515f3290456bb6850bd7ee29d5bf6652d7f103]

CVE-2022-42432: Kernel information leak bug was found in netfilter subsystem

CVSS v3 score is not provided.

This vulnerability allows local attackers to disclose sensitive
information on affected installations of the Linux Kernel 6.0-rc2. An
attacker must first obtain the ability to execute high-privileged code
on the target system in order to exploit this vulnerability. The
specific flaw exists within the nft_osf_eval function. The issue
results from the lack of proper initialization of memory prior to
accessing it. An attacker can leverage this in conjunction with other
vulnerabilities to execute arbitrary code in the context of the
kernel. Was ZDI-CAN-18540.

This bug was introduced by commit 22c7652 ("netfilter: nft_osf: Add
version option support") in 5.2-rc1.
The commit 22c7652 is not backported to 4.19, 4.14, and 4.4 kernels so
that they are not affected.

Fixed status
mainline: [559c36c5a8d730c49ef805a72b213d3bba155cc8]
stable/5.10: [5d75fef3e61e797fab5c3fbba88caa74ab92ad47]
stable/5.15: [816eab147e5c6f6621922b8515ad9010ceb1735e]
stable/5.4: [721ea8ac063d70c2078c4e762212705de6151764]

CVE-2023-1838: Fix double fget() in vhost_net_set_backend()

CVSS v3 score is not provided.

A use-after-free flaw was found in vhost_net_set_backend in
drivers/vhost/net.c in virtio network subcomponent in the Linux kernel
due to a double fget. This flaw could allow a local attacker to crash
the system, and could even lead to a kernel information leak problem.

Fixed status
mainline: [fb4554c2232e44d595920f4d5c66cf8f7d13f9bc]
stable/4.19: [6ca70982c646cc32e458150ee7f2530a24369b8c]
stable/5.10: [ec0d801d1a44d9259377142c6218885ecd685e41]
stable/5.15: [42d8a6dc45fc6619b8def1a70b7bd0800bcc4574]
stable/5.4: [3a12b2c413b20c17832ec51cb836a0b713b916ac]

CVE-2023-20941: Privilege escalation bug was found in usb gadget driver

CVSS v3 score is not provided.

This bug fixes drivers/usb/gadget/function/f_accessory.c which is not
in the mainline kernel.
So, this bug is android kernel specific so that mainline and stable
kernels aren't affected.

* Updated CVEs

CVE-2022-4269: kernel: net: CPU soft lockup in TC mirred
egress-to-ingress action

stable 5.15, 6.1, and 6.2 were fixed.

Fixed status
mainline: [ca22da2fbd693b54dc8e3b7b54ccc9f7e9ba3640]
stable/5.15: [169a41073993add6b0cfdc44e168e75f92f4834d]
stable/6.1: [4c8fc3fe28e47e2a495444347375f7354c24b018]
stable/6.2: [8c9e553c58a491ad328c622441e08178373442dc]

CVE-2022-4379: NFSD: fix use-after-free in __nfs42_ssc_open()

stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [75333d48f92256a0dec91dbf07835e804fc411c0]
stable/5.10: [01e4c9c03de8a9f8839cb7342bc4bccf9104efe5]
stable/5.15: [ec5b7814353532243e8a9147d232a32549174909]
stable/6.1: [650b69b17cfd79f51476d93c2c63bfb73280a77a]

CVE-2023-1583: kernel: NULL pointer dereference in io_file_bitmap_get
in io_uring/filetable.c

stable 6.1 and 6.2 were fixed.

Fixed status
mainline: [02a4d923e4400a36d340ea12d8058f69ebf3a383]
stable/6.1: [7b100a45dc19ffd708f364ba66601efaca1ccf56]
stable/6.2: [2ff9f7319b915acc42cf8fcf743589f926f4a014]

CVE-2023-28866: Bluetooth: HCI: Fix global-out-of-bounds

stable 6.1 and 6.2 were fixed.

Fixed status
mainline: [bce56405201111807cc8e4f47c6de3e10b17c1ac]
stable/6.1: [b3168abd24245aa0775c5a387dcf94d36ca7e738]
stable/6.2: [8497222b22b591c6b2d106e0e3c1672ffe4e10e0]

CVE-2023-28466: net: tls: fix possible race condition between
do_tls_getsockopt_conf() and do_tls_setsockopt_conf()

stable 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [49c47cc21b5b7a3d8deb18fc57b0aa2ab1286962]
stable/5.10: [1fde5782f187daa05919d2bebd872df8ebcc00d1]
stable/5.15: [0b54d75aa43a1edebc8a3770901f5c3557ee0daa]
stable/5.4: [754838aa02050ff3d8675bef79d172097218ea71]
stable/6.1: [14c17c673e1bba08032d245d5fb025d1cbfee123]
stable/6.2: [5231fa057bb0e52095591b303cf95ebd17bc62ce]

CVE-2022-4744: tun: avoid double free in tun_free_netdev

stable 4.19 and 5.4 were fixed.

Fixed status
mainline: [158b515f703e75e7d68289bf4d98c664e1d632df]
stable/4.19: [8eb43d635950e27c29f1e9e49a23b31637f37757]
stable/5.10: [a01a4e9f5dc93335c716fa4023b1901956e8c904]
stable/5.15: [3cb5ae77799e8ed6ec3fec0b6b4cd07f01650cc5]
stable/5.4: [0c0e566f0387490d16f166808c72e9c772027681]

CVE-2023-0590: net: sched: fix race condition in qdisc_graft()

stable 5.4 was fixed.

Fixed status
mainline: [ebda44da44f6f309d302522b049f43d6f829f7aa]
stable/5.10: [7aa3d623c11b9ab60f86b7833666e5d55bac4be9]
stable/5.15: [ce1234573d183db1ebcab524668ca2d85543bf80]
stable/5.4: [0f5c0e0a4c0b081e5f959578a8e56c7921e63a2d]

CVE-2023-1670: xirc2ps_cs: Fix use after free bug in xirc2ps_detach

stable 4.14, 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [e8d20c3ded59a092532513c9bd030d1ea66f5f44]
stable/4.14: [fe7eebebca51d56b900331c3052a6342731f1117]
stable/4.19: [526660c25d3b93b1232a525b75469048388f0928]
stable/5.10: [bfeeb3aaad4ee8eaaefe5d9edd9b2ccb5d9b7505]
stable/5.15: [4ab9e85a5ce0b2ef6e63abf861179898da613d78]
stable/5.4: [a07ec453e86abbd14e2d06d59367b4dd11437358]
stable/6.1: [9d882229d365f68f74028252261ab14a8de7faed]
stable/6.2: [9c515f3290456bb6850bd7ee29d5bf6652d7f103]

CVE-2023-23454: net: sched: cbq: dont intepret cls results when asked to drop

stable 4.14 and 4.19 were fixed.

Fixed status
mainline: [caa4b35b4317d5147b3ab0fbdc9c075c7d2e9c12]
stable/4.14: [c4b1e702dc841a79664c5b8000fd99ffe9b3e9c2]
stable/4.19: [8ed4c82571d848d76877c4d70687686e607766e3]
stable/5.10: [b2c917e510e5ddbc7896329c87d20036c8b82952]
stable/5.15: [04dc4003e5df33fb38d3dd85568b763910c479d4]
stable/5.4: [6b17b84634f932f4787f04578f5d030874b9ff32]
stable/6.0: [cde7091efe3fcc0b19f736acd0163499d1fd6d31]
stable/6.1: [dc46e39b727fddc5aacc0272ef83ee872d51be16]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

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

