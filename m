Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA545CF8570
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 08:59:02 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
 by mx.groups.io with SMTP id smtpd.web11.6931.1727945939269385199
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Oct 2024 01:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=g7lBF0J5;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=PwD/oDjf;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.23, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1727945930; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j0xKu6EzgHDZgf88V8PswAfqaPDuKQzbi/+GOKro3Ry6PlUHiau61TPJkNxn4d5tFC
    /CfqMt6C0Pj8/O0gt13U4Wym/B+uBL0P3R236WkffCBAtpbb9oqNkRkPhC6DKkKBUPbQ
    EWPFzmVo3wLLm8GfDrvlRBfm3cDg/zE/IfZ+EQVZcrhIJN8wwF2seFNgjDMZqtgG3yWf
    WcbCJxdxuEzCRhQPrcsM/WhSPnCcCNxsWVrmmYemBv4zX5IRBJm2LQ+r+k3CBPjg0Sn+
    ONEFGSy7IXsKLONt6r8cL/NxdgWnmf7+8F2NuAPJKUD1GrNJjqe1L63DGXl/xp0FbxYX
    iLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727945930;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yCD2es1W7l74Kz0WEEBW1REs+0YDwn+NqRD9l5Q/b4Q=;
    b=hoTrQKGs7vOKniG9VIbjSLfIh9v6dpy2VLkqV7iRyCvV2llOqe1Ia9voB4GownKX4J
    rD0qtIIAaBMxlpReA4pWhiF1wIhItq86OK7CBjck0DE8CnAvYIVt/uQaCGL8qHR+8lhO
    LnJ1NGoHTH61oCmPlmalvAc+HXCYx3dThH5nekaOVPVbUHOWdLN3zbmifzTh9/DSXlpw
    G/S6aiRLAVHSbdkT8tbf9DtPsaMzGf1bLM6SwHWmqTuwLo2m+pqD5rQ3wy08b2h+5plX
    OG2Rw9izFp3QvH5YeyDJL4m+qJfHehUkIRePNbDSZ+A3ZcOcV6Kb4PN0DjrJ4fSxfqJ/
    lIwg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727945930;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yCD2es1W7l74Kz0WEEBW1REs+0YDwn+NqRD9l5Q/b4Q=;
    b=g7lBF0J5d4jGBt5fwxPHdg3VH1y422/Q/4zRpzjU3I8S55b3x4Wmr/csU4oTIDfTWs
    jya9MaBcbt7XlUIHSb4suMf98U4bRNk7qmdejcmOkc7buwoD1rE+ABQrJleagNyEISF+
    xrKoSFwfa/vJjZsTI+ckvGGAH3hNiVj/tfM5M/5eUtIBSYwyd431RDd+ov+MXXpqwyAU
    GAVqTHVcIGKQxGeXaIRXV83UAgZflMDpZwV3Q9LeLyul17xXY4aqC2v/O+3x0jdMqAyZ
    R8IOp2vghnUz16t/beC0XK0KGPoVP9yxAqEnlDe5YFpTxu5xi3JiG/YVQlrf/OM35D9Z
    bXpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727945930;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yCD2es1W7l74Kz0WEEBW1REs+0YDwn+NqRD9l5Q/b4Q=;
    b=PwD/oDjfku7pyBP0eB2vi2BHH42VSsk7WMCnlwJfSNd+GQi66Wh6b0MmvDvjQDbUPG
    NEJfEmtE5+NP0JJ6tsCQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7sKNcZues1/lUmEGzg83Zu3jHdWLehJBooVOt2FTste"
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0d2fd0938wokni
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 3 Oct 2024 10:58:50 +0200 (CEST)
Date: Thu, 3 Oct 2024 10:58:50 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1841375864.2314304.1727945930345@webmail.strato.de>
Subject: Request for reviews for 4.4-st57, 4.4-cip92
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev68
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 08:59:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16990

Hi!

Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

cb18618cde9e0b rtmutex: Drop rt_mutex::wait_lock before scheduling
2cf61544745a4a nilfs2: protect references to superblock parameters exposed in sysfs
70b6df109f705e nilfs2: replace snprintf in show functions with sysfs_emit
c238fad7c56339 of/irq: Prevent device address out-of-bounds read in interrupt map walk
f6a9c01857b6ce btrfs: clean up our handling of refs == 0 in snapshot delete
d8503ffe1bf81c cgroup: Protect css->cgroup write under css_set_lock
2e25daf10039e9 udf: Avoid excessive partition lengths
87dc99ef544f29 nilfs2: fix missing cleanup on rollforward recovery error
28636a45c5431b mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
2e18d3c2de0487 sch/netem: fix use after free in netem_dequeue
fac14924bceef0 block: initialize integrity buffer to zero before writing it to media
35c4dde44c6041 dm suspend: return -ERESTARTSYS instead of -EINTR
c283ebf19e5280 drm/amdgpu: Using uninitialized value *size when calling amdgpu_vce_cs_reloc
b915a8926cf4fb Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
9a02ec8b8d3f53 f2fs: fix to do sanity check in update_sit_entry
be060e6fdb11b1 quota: Remove BUG_ON from dqget()
1f43ccdf08b610 fuse: Initialize beyond-EOF page contents before setting uptodate

Thanks for having a look.

CU
Uli

