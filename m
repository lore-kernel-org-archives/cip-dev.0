Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D072C77B73
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 14:20:59 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web11.946.1683037248479159556
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 07:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=aSKOU+oa;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1683037244; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lgoHyLfXrbPdQ991M2ijPf7V5sXI6S8C88Gx3iVY+nuhy7g/zelVo8Fn07ZSBaEelu
    kKr65XQN+jPq4anxoMPC4GKiHFJ6MumxULuYEA6ddnrZCnoAhK1u/uKUYxs7lOzE9N9a
    aaWs90ul0VfYaXgKmpuiS+qv7T/p4mhb0Py/gZXzPZw0WbmXYdwG63ona1/HDU30EzP8
    YxsjFj79n+VdhEvgKnCXtgg3OKY2zJGXVkj4U5uBgt087l78wObVSZb9bu4HpwuRhdMu
    lO3Pylsh+NfOjuhsco87UsJyUtOvIPdh1KD+Rv8nIw5YTC5R1cAj7dkkx4k4e3F2V7X9
    aKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683037244;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=OfFAii8886z0XT8TR3LzqkVAM21NCsxTgr16P8AWHFg=;
    b=Kgw32nSyfsCvMcYLpOquffXy/5nvipFYYHSBB1CdHaMZENOnnCPIEfEjWSQOnHYK8p
    DTJ/B0VcbSHwjA5s2xq7xqMUZhZ5RqfbUv7+Ra06VvS6MFxnn7Wvf5JykyfX2uH1n4Ur
    3Ls3b8Fcp3n4jB2Eh7qmtlPviLeklBGafoS0OFLTPQbQU3urUAOe4kXAlikX4sAVCFVc
    OGCtBNCw8Y9QpZGxhKHRgAUbFdrwcfHZYiOcZyt8z7ctpqdHFMgmRZwBvaUQNIEgmZwP
    /rT9siZP614tnvtm9nA+ks5pJdxlIsOn7vO8B6yo/JLEUwl6iC9XI70jbdfdr82aemtq
    UnMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683037244;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=OfFAii8886z0XT8TR3LzqkVAM21NCsxTgr16P8AWHFg=;
    b=aSKOU+oa5/iOjLCXn8FiTFZQFesBDmsSmLeYld9QFDMszmzuahvCNb1YrcI6GMY/++
    vwPwAbjS5EZ36BTp5TklUh/5lG2GqJrILvAhn9DIiJOwuow6Gf9F081jku54uF929Liw
    Sdu+oe0wGDIy+vYJXRmMsnnxQrq5oltU7UGiCXSlHfyKelO/na7w/LAaI81smOLTpu5s
    a9kqVs61smoAdcWz26JuNAbvJ2wvkzqkY/7Cci/FzZqXnismErB+xi3bLPXxmJTA+jWu
    Wthecd7S8UF7FHoVYQ+ubZC1IAiaCvLcuOeb/MfBAXUcT5mn/UI8PKW+FKqHmbr28FGK
    n7DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683037244;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=OfFAii8886z0XT8TR3LzqkVAM21NCsxTgr16P8AWHFg=;
    b=61k/enzCxXhkWFahFVWmAlOPm06AbzHEJ1q/tw6YadXiCfb1Cg/pQgXAxl5uOkVq+F
    4mJwvqLz8Eer0c7pSCAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/wuMlg=="
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.4.0 AUTH)
    with ESMTPSA id N2af97z42EKiPZP
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 2 May 2023 16:20:44 +0200 (CEST)
Date: Tue, 2 May 2023 16:20:44 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, "Jan Kiszka via lists.cip-project.org"
 <jan.kiszka=siemens.com@lists.cip-project.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Pavel Machek <pavel@denx.de>
Message-ID: <1373319794.2397136.1683037244247@webmail.strato.com>
In-Reply-To: <af817b46-e9b1-5a3b-a66f-3f677933c606@siemens.com>
References: <af817b46-e9b1-5a3b-a66f-3f677933c606@siemens.com>
Subject: Re: [cip-dev] Potential 4.4 regression
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev41
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 14:20:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11380


> On 05/02/2023 3:59 PM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
> we are seeing
> 
> [   31.479488] ================================================
> [   31.505101] [ BUG: lock held when returning to user space! ]
> [   31.510778] 4.4.302-cip74-st39+ #1 Not tainted
> [   31.518272] ------------------------------------------------
> [   31.526443] systemd-udevd/207 is leaving the kernel with locks still held!
> [   31.550597] 1 lock held by systemd-udevd/207:
> [   31.560126]  #0:  (&dev->mutex){......}, at: [<ffffffff816cd4c3>] read_descriptors+0x43/0x120
> 
> since 4.4.302-cip74. -cip71 was fine. That kernel is patched (Xenomai/I-
> pipe), but the error is rather pointing to a vanilla issue. How about 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?id=572efb3c45b5c741f0642c63553d3979b2cb27b6 ?

Yes, that looks like a mangled commit. Could you try this:

diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 1d207c0b151cf..c7c32326d50ca 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -825,7 +825,6 @@ read_descriptors(struct file *filp, struct kobject *kobj,
         * Following that are the raw descriptor entries for all the
         * configurations (config plus subsidiary descriptors).
         */
-       usb_lock_device(udev);
        for (cfgno = -1; cfgno < udev->descriptor.bNumConfigurations &&
                        nleft > 0; ++cfgno) {
                if (cfgno < 0) {


...and see if it works then?

CU
Uli

