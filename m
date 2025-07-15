Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF2C83F22
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 16:14:34 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
 by mx.groups.io with SMTP id smtpd.web10.13033.1752596070028501885
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 09:14:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=o+1fAQaM;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=XsuChMWo;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.216, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1752596059; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pUQPkPQzCAcdyDFzRrfFKx3KuDN9BBV4p6F2Tanbf8CDKNQlHd2wbHWYvGoPDEbTSR
    mt3U8sZ23pfvvY9LaC2FjMdvrhcJ1N4hOzFaRd8E9hwiZvn6n5H8gb02bxYVaf8GB/pO
    krBWIdgBzG0sEbYK7K//89+Tk/CfEE6GhdSOoO15eBuyGRU6C1ka3DRhbOjoEzD+GtEm
    6Cr5mPOXnrQeEFXOXRSI/Rwa4AMFJTfxCXJpoYmZLkVbD/WCbwiQLIV/uOZZap6QWscj
    Hl4JpCBNcgYTBfj7p7PHAFs71Gj/mCv14qGBCLiVlgoQw8kc4sXqhBchhq3oJWLaYx2T
    3NdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1752596059;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=YC4bmDN1qWokMU7qtiB2wAXZMgzRfCl4p0szK/0/LN4=;
    b=Blju/oUQ14DU5lMoEaBgNy+gkBT+xzuTD08ldPehmX9v4ustZvLRdpS4LGbz6Xi+rE
    gmuIHwluTb8R8tEpDaeWKVPIEesCu7qkEiHVhi/Cuh+32XyYRvCPfWJ441ZXSXLZTbwh
    1Rqxsgsiwn1EhTUTGDNpDtQ0t/ZNCrzVDgO4vNH07Xa5XfHYGNXELf18Bp48dXA15TjC
    Wt2qMac2dS9tVmkQBZZoQJQ7ivhGeY7A4Dx/yIXlphAlViUYM9RpC+JILq8OxiyuW3I4
    KyWzvKhHjnmgQKzVtwQaDsZt9bwLi7XG5JKKAuXvcCm3snrGyBP/A+iHBqdg6XIwKIpP
    VL6w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752596059;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=YC4bmDN1qWokMU7qtiB2wAXZMgzRfCl4p0szK/0/LN4=;
    b=o+1fAQaM2BV50ohzen76NJUl4bYYllIuQhCVIM0QAw2/+K6u0FozScggWQX48+peab
    +5tNzP+g0MkrY6aTxhk1QJZpPLE5WG1fTiVHcYBebll1nSjR3TS6LWTzBhseNuShDmTb
    wgaeuJMMQSg93b9yVm2HCHWeF7uXqoY3KeXdw6H2QKLfWz0ub+nfLlXKGraBaERNck6V
    62voOQqgn169asxbX/wHZny4DHZsybnE+KyjQDuG+ZFPgiQm7/I/hr2wRGC8TzrjJcSf
    irKcsf6VrSQvJjaBwSU3ZO2/1SlK5nDJHVFHIDU3elaN9hN6EPeNqDr2ABgYHAvlLp0w
    rMfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752596059;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=YC4bmDN1qWokMU7qtiB2wAXZMgzRfCl4p0szK/0/LN4=;
    b=XsuChMWo6CKYq+zor/YiLVEaMUDJ2/xPH6wZHWOifZI9Txlju+f22fns8+6f13lmU2
    aUpkGSepQcTni5Crf8BQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-2.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z1af2716FGEI7I9
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 15 Jul 2025 18:14:18 +0200 (CEST)
Date: Tue, 15 Jul 2025 18:14:18 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <261306466.197838.1752596058568@webmail.strato.de>
Subject: Request for review for 4.19-st6, 4.19-cip122
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.53
X-Originating-Port: 58384
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 16:14:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19543

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

c48013043b048 ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board
627881126ca62 mtd: nand: sunxi: Add randomizer configuration before randomizer enable
41dc5877485e6 mtd: rawnand: sunxi: Add randomizer configuration in sunxi_nfc_hw_ecc_write_chunk
78eb0dd7a6ae1 sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
4ba68bb59552a bridge: netfilter: Fix forwarding of fragmented packets
26258f7deffe6 vxlan: Annotate FDB data races
2c6d2af5bfee8 hwmon: (gpio-fan) Add missing mutex locks
76a605de51329 nfs: handle failure of nfs_get_lock_context in unlock path
dc112be66266d sch_htb: make htb_deactivate() idempotent
c5ddd5d93f411 ACPICA: Avoid sequence overread in call to strncmp()
ab2fcd0753f0a f2fs: prevent kernel warning due to negative i_nlink from corrupted image
4f4c2d50e6a0a f2fs: fix to do sanity check on sbi->total_valid_block_count
44215eca75e7d usb: usbtmc: Fix timeout value in get_stb
89bc62649598a drm/i915/gvt: fix unterminated-string-initialization warning

Thanks for having a look!

CU
Uli

