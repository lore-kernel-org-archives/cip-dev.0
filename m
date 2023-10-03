Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6EAE75432
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 07:22:56 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web11.102940.1696317775241790267
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Oct 2023 00:22:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=X3wzrF+U;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=sHQWNfhK;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1696317771; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ldQbHEe+WdhIXiTFN9G3wdzp02SAZ0fsrN5Y3y2Mdw8r2hpJWVJz7RvKArj5ODedPL
    CuEs7mKAQzdMAbn/PUYero7lo7UsYDlxVnmg51EZCC3AZjCPyzu0X8peUcSKkfY3mY/a
    P5jGlbZPJSEQUuR2aaUgkBFtFGtvevnGVnX+VNKlsa96j3TNQqFAtN1qCzxPik+pfzVj
    s/sH4bFxtb7KBZ1KjNGdYtQ6d1iqrD0fsvd+ZrE66yJAakCwxn7Mhl3StHZaWwxayMIj
    0wThkOppG+skPrGtXujTWmlrIh1+VcuFSGmidqiVBnQxK4PcynNCrv+2ErYEXHPavu67
    Umww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696317771;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=kJrL69US86arWFObL6V86UXJ4Iw2CWRo5jZrXldA9Wo=;
    b=BWdKIK1NGlHvLIzuDmFHpDrBKundfKV+5kU60OdkiY7rOUGb6dqBEzu38OKoqJ//SC
    sM8QIlOcc+nWTPltENEdt/CyOaAzbTcNeJCadeiL877Iw18sPHvZLwfjJNRMrOHGBYlu
    tOBcYHnV5qZLvJq0eMreHQofKG24hganQXzazcFv5L/gWUtFzasU7gVGMT3C78G2xnD5
    ZZXAwtDlYRtwOtbkIUxfxlVCnjtrjioq0IGlozMF6F5pPoz8frh0hilvmZjmbC2yVlAv
    WNfllJ1RaqOTZAolf6G4PviXCr0dow7Nz+RHGbsX9Opng5MYrAEiRr+Uj1NvCCratHuF
    zlvQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696317771;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=kJrL69US86arWFObL6V86UXJ4Iw2CWRo5jZrXldA9Wo=;
    b=X3wzrF+UbQ+ZMHZ5xSd8uxct92onHQDNdb5vSpofCrI1MDd9MnMDuoRYL3qBpTwFWu
    71E8TUDqY/jDiSwYMa/T9r1OM5VIjwjCXf1e1rgriDAXt5aFySPluOj9DdNsJJoDAY+w
    FUrHv5tBAOnAhI76OyRiKSMUPlmBwUi/AqAxT9wlNs4A9VqAOAteCuu08D/Q0xgp3+wW
    NYuuK76siEm+DEbFXA3qduXnnIy9tsHAj4JTIRVgqpM4Wy8yXvrllLXPeh9qZpCBT+oj
    2z+tuqR55JV7N4ekFHFnHE31gK1Zeploy/cLEgxMmuQvCEDwZzVVt23HCW6WikQaxVBT
    rgfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696317771;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=kJrL69US86arWFObL6V86UXJ4Iw2CWRo5jZrXldA9Wo=;
    b=sHQWNfhKn/sbmdStcccaq4j4CFYaV56NVYtoOc4nGsScoOaCOg/5z8uaZs+lqZ/ic6
    TD0virs24pwZQkg7zbAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/xi15g=="
Received: from ox-live-app104.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.8.2 AUTH)
    with ESMTPSA id L04889z937MpXpt
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 3 Oct 2023 09:22:51 +0200 (CEST)
Date: Tue, 3 Oct 2023 09:22:51 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <809419142.671756.1696317771828@webmail.strato.com>
Subject: Request for reviews for 4.4-st45, 4.4-cip80
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev52
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Oct 2023 07:22:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13264

Hi!

Here are the manual backports for the upcoming 4.4-st45 and 4.4-cip80 releases that should be reviewed and that can currently be found in
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

As usual, most are trivial or near-trivial:

** m-| dbcfa782d 1b90af o+ | ipvs: Improve robustness to the ipvs sysctl
** m-| 69197b2b2 30188b o+ | rtnetlink: Reject negative ifindexes in RTM_NEWLINK
** m-| a345df7a7 19fd80 o  | udf: Handle error when adding extent to a file
** m-| dd59a78d3 0c8b0b o+ | regmap: rbtree: Use alloc_flags for memory allocations
** m-| 76b08ed96 a1db7b .+ | media: dib7000p: Fix potential division by zero
** m-| 4573b3a8b c05ce6 .+ | dmaengine: ste_dma40: Add missing IRQ check in d40_probe
** m-| 2f2a59053 3a21ff o  | ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer
** m-| b2f54ed77 7bf744 .  | media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer
** m-| 50abe4b37 e110f8 o  | btrfs: fix lockdep splat and potential deadlock after failure running delayed item
** mo| 58a3d1d4b 531076 o+ | ipvs: fix racy memcpy in proc_do_sync_threshold
** mo| 29410001f 9baeea .+ | serial: sc16is7xx: fix bug when first setting GPIO direction
** mo| 82e36f0c2 6372e2 f+ | NFSD: da_addr_body field missing in some GETDEVICEINFO replies

On the surface, this one is trivial as well, but I can't shake the feeling that I may have missed something here:

** m+| 72a1ad58c b888c5 o+ | igb: Avoid starting unnecessary workqueues

Thanks for having a look.

CU
Uli

