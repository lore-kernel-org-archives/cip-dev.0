Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC0E7718B
	for <webhook@archiver.kernel.org>; Fri, 27 Dec 2024 04:57:18 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
 by mx.groups.io with SMTP id smtpd.web10.8156.1735275430247242811
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Dec 2024 20:57:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=S7PcuA/C;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=sATWC+An;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.25, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1735275418; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Qo194VYA5qREOZQoIaruFxdFUSCn68In68CaUpdUEu3M/OQOU7DbFKpd65B8Pf2LI6
    HU2ha9iDn+2JY1rBnsb2G4tYUCyD0boWMsIebfUwbuNNBdBSciL42pVA9WpacKbiJLPu
    ZCWprMbiaVtybs+R/fEDl2woTGU/7NUko/V3AV6GQ0TZOMm4UEaR50hnolE6pGk2rJjx
    5PISjWAvPdZJO+xnNMj1/PaTcdHwFC1St/14xEfzOMlEdQ6zn1XgR6H4t+ZVa1b6wEki
    moSiWDADc3yLyG0L8BZEhRjEFBYj6+R8wUmL7pHhyMZpA+h9QqtreU/IpyuupEeVffoP
    JcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1735275418;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=VCOq7O6FoCPeNxj7cg0V9cxFK/ZoSosFb0MRjIUm6oM=;
    b=TXRS9We8nPfZwvNM9Ut3qop1B9NFYbheTCZLsJ/4Q74P6xKilgcXRoI1fkBq7HSur4
    KzkFGoUoCgDuYHHdMEiO5BRTVhqxLGZamF+4hcEUeucKLx71MGgDpS+dQjela6xpfMVS
    NgtL5/hAdF26bVhu2I2dROXVl8mXCc5av7qadt0PSi+X9sW9NbHpkt1hm9lygSudZzCL
    SOqzFCJTj8mROeohDef36ZfcueucCA0TATGH7VNIYmi9hFv+bWambz6PwaOTxBws2/rp
    dQ27NFD0T9TbR+kD0wx7GDL/7D1B2HqaS0oBE9cuX0UugV20u+Gtd5QYwzQJW8WhLpBW
    dP1g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1735275418;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=VCOq7O6FoCPeNxj7cg0V9cxFK/ZoSosFb0MRjIUm6oM=;
    b=S7PcuA/CfaZ7EEIeF7FGNHiblNRs4YpNRW65oKTAty6GzQCkxoSpu2NDkzih48FIbq
    ZWG+Td+UqbL+SI6kvvkN1A3BF6M93nq+cnIHNOD4LPVQrSDh+mUi2XdGt5wtiYys/83o
    JUESXqxusHxiXEgH1+JXPjj0yep+tdnyXKV1Lx7V4pMD8lxlCkjXwtrlt94eNdtOseWQ
    HzdAdTFMHek2aVRPn0EKo5s/tDe+qlbXhwvskK6V6vJM156AEyABm51LsLiYIj/xZwzh
    Wzhe+O4554aMCy2oJWsgfiR9V9swxC6/Jb+hL92NOJtDfNhXVU2BnVD/RF8yENXGIYVf
    H5Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1735275418;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=VCOq7O6FoCPeNxj7cg0V9cxFK/ZoSosFb0MRjIUm6oM=;
    b=sATWC+AnlfAI7uPGGSfZNB+a7flqNXFh2tUtSKLn0zreZVD1ITA2xGvHI3+Jqp0vUU
    r3nWKTrAlLhJEowWggAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvtKuIw=="
Received: from ox-live-app104.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.16 AUTH)
    with ESMTPSA id zbe2f00BR4uwNkB
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 27 Dec 2024 05:56:58 +0100 (CET)
Date: Fri, 27 Dec 2024 05:56:58 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <295685651.3780611.1735275418169@webmail.strato.de>
Subject: Request for reviews for 4.4-st60, 4.4-cip95
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev70
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Dec 2024 04:57:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17497

Hi!

Here's the manual backports for the last release based on 4.19. As always, they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

8d8dec49e86e5 ubi: wl: Put source PEB into correct list if trying locking LEB failed
0705b897c226f usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()
f8fe313711e34 vfio/pci: Properly hide first-in-list PCIe extended capability
bab603ffcb9ca Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"

Plus the revert for the broken nilfs2 patch:

67baec71e0577 Revert "nilfs2: propagate directory read errors from nilfs_find_entry()"

Thanks for having a look.

CU
Uli

