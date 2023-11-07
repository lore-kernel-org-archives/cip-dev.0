Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57815C4332F
	for <webhook@archiver.kernel.org>; Tue,  7 Nov 2023 03:38:20 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
 by mx.groups.io with SMTP id smtpd.web10.3204.1699328293433623230
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Nov 2023 19:38:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=UY+rIi8J;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=YGRsWOPH;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.25, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1699328284; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FFysYe4rBcqt9X7ElI/xJ9ixVMYwgWsUPFxV3A2WQMAr9nbvlwBNPOmS4tF3GQ80Kk
    tFlNQnJ5ZMchgPcOeDxoCP7zACUk4b/diCaJbh9SPXJKo7Us3C9kygPnB3puRj1qavvX
    FdA3cbKQHtCSMn8fHcfqqzlY6cLugpT7hppFn36jg2dPNOVJxI1fQ2lhB5fB9g1dr/vY
    oRxq94ehZv6hWSYCaCxj+nNfouyPFdSuAPiAMg0KAWF/KMw+CN+3feyeTn9TV01IUtkM
    xbl8YcojR20gUuaNIbnFXWG8oZN7/fl31PLVFQ/WxKEbgALSVf34UmguO5q2lqTWlps6
    jxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699328284;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4xxRP8JQXwlfp/nlwNUtPyG/mSAYCvFBdemSLR2s2D8=;
    b=kw3PIkKdAQd4y8Y0GmSUhK/9hDLJTT3OJ4cY5ol5GOHemXEAhKN3DlrinqywFj26La
    ye0koBwmFUlnqL1/EAwc3o45h63ygOw0+m1VY+5ewS+htjeMJzJZqpcOaOrgav+j2e/t
    s/qAm9TOeG8xNSAhOGa83y5BRhEkQkmUwcp4UIg0f+7OHBBWGRs1AhrYFQWWO+umKW/2
    R2XWMKXlo0nqSF9BkSNzf9NaaRxiyh4npIrEmOHXZ8aBbF+kEJetIVuypHKuYG41oPIm
    2PtKlui7jAd0gqLknw/k3iG2M7BW2oIrG0+a2NnUHKgxrFnTt81UWfk84lT4WKIBmQ+3
    fz3Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699328284;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4xxRP8JQXwlfp/nlwNUtPyG/mSAYCvFBdemSLR2s2D8=;
    b=UY+rIi8JZENESTTfMRGYxqJjEsXCKwi7BoYZOObVf6kctMGSz6R+vMZiNNs2PW0SUd
    4nxg+H3fNRO8ncCUfHTM/jv+LrF5fdPdHQOJjZ1LRfs9XhQu8+9VT7NP3b08MLwsJNOz
    TPu6Ah8DBr+uN1dMQqsLhhWWEs1k6jPhfC6DBXLi32U5LEj8oBduH/DXZLTg3qXyM3Z3
    gWZYmhrCbU/B3U5DIxIxrpaxgyVNeQCnaPuuJnFo/mYKzwGpP1G/k/pqgG+49JTd/FHk
    2VVm5cHxzndu1iKBSoHxTT+E5kHrzZHbd+HeNDyGHvzOpo5pC2CwkBJm3HrXsTy70SKu
    ZhRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699328284;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4xxRP8JQXwlfp/nlwNUtPyG/mSAYCvFBdemSLR2s2D8=;
    b=YGRsWOPH1u8cFj/ap4bbNsDARtihGjVLdZpacHzdbi5N2uSxwKFnrZV1ZUUZ1kzPR8
    ma0gTQNWuCzkFgcXkcAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/x64iFM="
Received: from ox-live-app403.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.9.1 AUTH)
    with ESMTPSA id V6209fzA73c3fOC
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 7 Nov 2023 04:38:03 +0100 (CET)
Date: Tue, 7 Nov 2023 04:38:03 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <986159676.521058.1699328283618@webmail.strato.com>
Subject: Request for reviews for 4.4-st46, 4.4-cip81
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev54
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Nov 2023 03:38:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13537

Hi!

Here are the manual backports for the upcoming 4.4-st46 and 4.4-cip81 releases that should be reviewed and that can currently be found in
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

As always, most only required small context adjustments:

** m-| 96b58b9b3 4ff3ba .+ | powerpc/perf/hv-24x7: Update domain value check
** m-| e0eebcced 737dd8 o+ | ata: libahci: clear pending interrupt status
** m-| ee5732caa cce7fc o+ | serial: 8250_port: Check IRQ data before use
** m-| fb1084e63 7ee29f o+ | nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()
** m-| b40f31d74 391478 o+ | i2c: i801: unregister tco_pdev in i801_probe() error path
** m-| 18e301e10 d7f393  + | IB/mlx4: Fix the size of a buffer in add_port_entries()
** m-| 923b555ec 30188b o  | Revert "rtnetlink: Reject negative ifindexes in RTM_NEWLINK"
** m-| a24ba12f4 8fb8a8  + | RDMA/cxgb4: Check skb value for failure to allocate
** m-| ae40f2c3f 92d4ab o  | Bluetooth: vhci: Fix race when opening vhci device
** m-| f8d49412e a16eb2 o+ | KVM: x86: Mask LVTPC when handling a PMI
** m-| 56ff7abff 9e8bc2 .  | gpio: timberdale: Fix potential deadlock on &tgpio->lock
** m-| d9ce7d438 dcda16 o  | Bluetooth: hci_core: Fix build warnings

Slightly more involved:

** mo| f510d8ec0 b547b5 .+ | gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
** mo| ca0c4cc1d dac501 o  | HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect
** mo| 209971d45 7b5add o+ | ixgbe: fix crash with empty VF macvlan list
** m+| 5bdf93a2f 427694 o+ | usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call
** m+| 555e15e93 32671e o+ | perf: Disallow mis-matched inherited group reads

There are also a bunch of reverts fixing build failures in non-CIP configurations:

98c3c9673dfd9 Revert "usb: gadget: f_ncm: Add OS descriptor support"
607a9ba7667d2 Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"
a14a49dfa9693 Revert "x86/APM: drop the duplicate APM_MINOR_DEV macro"
c0cb2cd552d1e Revert "IB/hfi1: Fix possible panic during hotplug remove"
23b3e2863a88a Revert "neighbour: Remove unused inline function neigh_key_eq16()"

Thanks for having a look.

CU
Uli

