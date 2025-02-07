Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D8EC0219B
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 02:57:39 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.web11.60624.1738897048173161044
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Feb 2025 18:57:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=tDpuzfaf;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=ZqYhgVbf;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1738897032; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YwZsPpRE4NX0yfmWMyf3NBAKe/mGL5kp/okOT5Brxf1blPkr4Mdo+wNyUkGcUHpJq9
    WMFWRTAlct6f27tyQoUItUQ8vvqSV3/12g3HpRp2373LTTiTdwgUVAUM4Kx7shg3VjsD
    wgowo6/QS5h9ns8Y700OmpHgnyC97qg4peQ7mdiMLiuizsoF/yDOtI1eDQfaFYSTKf5e
    MD5wUihnzClV+FUKThL1iEgBJcaMUnbiR391EIEvxwlSXds6tkyT2zZd152SCEPFImYI
    bvAFbd+nGYMnc4pIzXCOAu1mwrimrtKSn6jE1fasa4abnmP7g38Gpse0Hxpycu4/Z39D
    NNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1738897032;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xwd/PqQCxYcLVnQq92U7/mMhs25C2P/KKQtu4mIBe1c=;
    b=gMdaNqxHMtEFQbNkcyR/LrQOfV+GuscBspp2omxTnrktFOmAGJJbEApfb2z6gNnVD9
    oIm9DkmNaxZNiLk9Eiz340eIOafq4mKZ/1LSw2Fxzfahdxw12DtDuTkvGw0UYveumjsa
    fCijorQ4yC78nVerfrJMWXxdiiRB+6qhu5ym80ZvOO13wMlK5rDdASL0g5B28RKqizob
    +Kep+3h4yMbQJT4/lF9Pyxk3YPnze8sd13JIxMbtIhTZAUcaC+/cO8F2fZrhN6ziFOz/
    XkQQfJJZA34orI2k1z2gtkNA5qFBVZTDsX6B2hVTQWOvpVtCI3nIaipe4T41vkEypb6Z
    PWhw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1738897032;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xwd/PqQCxYcLVnQq92U7/mMhs25C2P/KKQtu4mIBe1c=;
    b=tDpuzfaf0KzCApgv49L9UKNq+PtSbhIXTAsxpDrz6mf3MkbyDNdi1KK9QQbjBLGFFX
    QiutsJkUQA2av6SRQkLgr/g/fevGL/LibSRLTSqGcd6SgG8ohPWTir5xe7VYrJ35JK0Q
    Lj1zb5NLFkqocP2Vvwwu2Xr9zDTF4Fmbz6ULQ09ctgvjP0X/XDkEDPPHtPcAPFrhkHQV
    pvTKAlDRwJYOnmgswhXTEDPPJDUIUTGF5Fi3K2gQ6VcjlLHqaTKUc9d50iG7WfBZalWr
    HUUpmQ5xayzAXnzwOgn2nvRC+I+Mp+yTK9wJwfbFhLz1s89+EKB3GrqTaGem4tDjHNhm
    Uu/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1738897032;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=xwd/PqQCxYcLVnQq92U7/mMhs25C2P/KKQtu4mIBe1c=;
    b=ZqYhgVbfp78PdV0Dr39dnHUd7FZG7bbym78HhdcJ9pqqXL4rBaX63H8DE16GpZV7v3
    hyicO4uTzeMlQ48w87Bg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRNGthE="
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.22 AUTH)
    with ESMTPSA id z137931172vC1TS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 7 Feb 2025 03:57:12 +0100 (CET)
Date: Fri, 7 Feb 2025 03:57:12 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1939235882.106210.1738897032804@webmail.strato.de>
Subject: Request for reviews for 4.19-st1, 4.19-cip117
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 02:57:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17765

Hi!

Here's the manual backports for the first self-maintained 4.19 kernel release. They can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

17758948061a2 RDMA/bnxt_re: Fix max_qp_wrs reported
60f86dfde2f27 net/sched: netem: account for backlog updates from child qdisc
e3f9d1479533a net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
60a6e1e938430 netfilter: nft_set_hash: skip duplicated elements pending gc run
db3db8b23fc26 drm/etnaviv: flush shader L1 cache after user commandstream
a31241e036c2e usb: yurex: make waiting on yurex_write interruptible
b1463eec3417a perf trace: Avoid garbage when not printing a syscall's arguments
49d9f78101f9b scsi: qedf: Fix a possible memory leak in qedf_alloc_and_init_sb()
86a1a175bdd56 mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
65f2a31dfeec1 ALSA: hda/realtek: Set PCBeep to default value for ALC274

Thanks for having a look.

CU
Uli

