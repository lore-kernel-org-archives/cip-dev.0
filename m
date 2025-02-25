Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E330C021A4
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 02:34:03 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
 by mx.groups.io with SMTP id smtpd.web10.2626.1740450835169152211
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 18:33:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=VUsvVtL7;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=yHTBQbKM;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.166, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1740450825; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XbIip8YEYragakjMxkzMGrcYTGt1U01L1iTuYcAyuIgkhiuwKB72g6NSDpjGxss2zn
    B7Ko9TABAEc6mV6xgyJgvfPvqfTZvpfx9ogOzeYVGawJYvim8z5xUcNE/SsHhn70vYpS
    vzuTtcwSZdKGz87BuSJNqC9t9en0d64oZMlBb6YNCMbWOKHB6TxwS/+5bVIWYMaADjJ1
    VmbQhrDsYLM653UD8Zhao7738phqADCvNarOgJI6HGUXIEyg8OjbMdba5asloV1707H7
    rF2hd0/a/+DWPpy8T04mMV//3v8sBMkJfi6ufTBTHW8F+rlaOZ2JQm9xCHqV9I5vBL1j
    Sl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740450825;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=vPYQGUDHKMlL0A0FBypi7AaEW2KXeuDZqSE6wv+WNzw=;
    b=iDyoswxQPdlZmd9gbMDmJYP1Zq5vtgLE+fk6ufkjlvPOFLbawW8YowBUASOn1jE1tv
    SY9FLFMm8Ai9a8mWptWOGOID9C/nO33NI1yh2Yppg7fG3uX7RaLpYgWqFRO/DB6dNG1t
    WTIjf54/SR/U93eTN5SLxsAzMro6DpagYcMDRuEBVscDTEvc84KqPxCwrbBN5RBWh2Fl
    WTbNXEz7fE+uUOuuN8mPETMD3dm0k2P8tk4EFgb1xFcah5iHQbjRNUqlLk7XNMKic1tG
    LaZ4YyWkNKV2PyYcFJ3P2gn+7B9zLHt8bAbUPegeLWaGs42Kqx2+0p5h0iY+2JQO/Wbl
    thGw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740450825;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=vPYQGUDHKMlL0A0FBypi7AaEW2KXeuDZqSE6wv+WNzw=;
    b=VUsvVtL7R9z/inaymMj2y2f2SUhw7TlAZVz+iRY2qIOItoQ2gESgISaVgmwbvqfmc8
    0rmTjp0GK7plQpsL/ao2bajfBUu7tROu3XkOC1kGDBQtxPv1vpkFqKntcSEeVPM8P6Yt
    zc1tDDbZl7hCOZ/DTLG+KjmRVPiYnnkYMWMan9jLTXiGFU3Vo0irvtHWSOs1q0tqUik2
    gC3lHA1RGnVkKvJGlUAHxxsBUd9i85uMZ/sD90oh+HlCWSAKJKC/NKQzo9ZkiDfwn+xi
    bQr9jXpbs0JXcoyiD/ueTPCDNVmG/EpJ9/6oh3ix1rBn4aiFUNzOAZk1Jxvgh53mBXDK
    qgHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740450825;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=vPYQGUDHKMlL0A0FBypi7AaEW2KXeuDZqSE6wv+WNzw=;
    b=yHTBQbKMbbzDHAp+fmZ3if+i35YbHmWwanzLTwCddi7OiwuCfu9NinqN0pDxCMobpi
    uz1dGsSAiZP+QM6qubAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app301.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.23 AUTH)
    with ESMTPSA id z0a38411P2XjB4r
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 25 Feb 2025 03:33:45 +0100 (CET)
Date: Tue, 25 Feb 2025 03:33:45 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	"Paul Barker via lists.cip-project.org" <paul.barker.ct@bp.renesas.com>,
	Ulrich Hecht <uli@kernel.org>
Message-ID: <2107322599.2807883.1740450825568@webmail.strato.de>
In-Reply-To: <20250221165517.357768-1-paul.barker.ct@bp.renesas.com>
References: <20250221165517.357768-1-paul.barker.ct@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-st] ravb: Fix use-after-free issue in
 ravb_tx_timeout_work()
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
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 02:34:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17905


> On 02/21/2025 5:55 PM CET Paul Barker via lists.cip-project.org <paul.barker.ct=bp.renesas.com@lists.cip-project.org> wrote:
> 
>  
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> commit 3971442870713de527684398416970cf025b4f89 upstream.
> 
> The ravb_stop() should call cancel_work_sync(). Otherwise,
> ravb_tx_timeout_work() is possible to use the freed priv after
> ravb_remove() was called like below:
> 
> CPU0			CPU1
> 			ravb_tx_timeout()
> ravb_remove()
> unregister_netdev()
> free_netdev(ndev)
> // free priv
> 			ravb_tx_timeout_work()
> 			// use priv
> 
> unregister_netdev() will call .ndo_stop() so that ravb_stop() is
> called. And, after phy_stop() is called, netif_carrier_off()
> is also called. So that .ndo_tx_timeout() will not be called
> after phy_stop().
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Reported-by: Zheng Wang <zyytlz.wz@163.com>
> Closes: https://lore.kernel.org/netdev/20230725030026.1664873-1-zyytlz.wz@163.com/
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Link: https://lore.kernel.org/r/20231005011201.14368-3-yoshihiro.shimoda.uh@renesas.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [adjusted to apply to linux-4.4.y-st]
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> 
> This patch has been tested on RZ/G1M using the linux-4.4.y-cip tree, but
> I'm sending it for linux-4.4.y-st as the issue is also present there. I
> currently have no way to test the -st tree without the corresponding
> cip patches.
> 
> This patch addresses CVE-2023-35827.

Thanks, applied.

CU
Uli

