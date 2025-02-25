Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5069BC021A4
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 02:13:03 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
 by mx.groups.io with SMTP id smtpd.web11.2340.1740449580396741374
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 18:13:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=CQOSegjc;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=0yL9Ecmk;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.163, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1740449568; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gm6TfSeovYpXScxahiPKfwEav43yXyvw71LyhEwENdnPmPy1Tu+ViTrcM4VJscnCZY
    3oXY69R9D7S5NfI0ckx/7O5WrLwN9Nd38g7s8scGyPV8hYVj+kUOlTgNWW1dKAFnJ/dV
    2YYR4VkoALsXWBMMx56sIYnzzhrFTOICDIPCDJhpMg9SaKKb9o4VcUDo/2wxPWEkXwET
    7CoIFdVseclEXSsmh74MspRB1s4Sw2SMuN/Ut2F1ub+ivfXtphm4furKZD4YCFw4V6jT
    7ximJ0508sLGjmFEHFnu56x352CsFoix5oehkmMeNByyRZmBlmIyo2BKZ5AKSyZhn9sf
    SIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740449568;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=rKw0EU1a4n11NF6vRXbQF+YSpN88yre4pNG63+hgd2Y=;
    b=LsFgqcJYanyEVeYJ2GzI9rf3+3AZ3JQosnSokA5YY+u9rNZ+9ijKDFWUvM4DlnRgGf
    udWvieZAwM4CMjvqXJWKrKFlYxQyj3ZzbDotL4P1UBsXiROB+NTXphluWt28lgZoY8Xk
    nQUwpr9P/FOq+BNaTWi5cE1+H37MwbdhJuItrctwPpApNXDrsOAZEITnW7sn4FQ/6Wzz
    kFTKoWIK21kABC1z1TpDd/UUS5Y6ifUnKclWou/OGJRRmRyTTY8gsZsiDjOXiMsDLF/6
    To7kgR99iwWG0HLVt6g+SKFtyN/+HbLxCuAIslLXdtMwxVHYSLJnz0+vjcd366EebyNu
    0uEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740449568;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=rKw0EU1a4n11NF6vRXbQF+YSpN88yre4pNG63+hgd2Y=;
    b=CQOSegjcW17FCBAaeIJ1J1MBdVXWo7WmQ2KyuQO1EjOTNBg9czkuhTtcL8ejkJiR3m
    +XwpSqVESqvLaRtW2J8JZyB6iijh5EmFo2zQQ7mNfe+lPdB5C7iHhIZy4upxHT9acIYE
    jJKNFYtqMmzxIC9E5sSYvtbW3Ep+zdiI2+DJw54wTdJTjpy84n0EHzCeN1cEzrfNaaf2
    lST7N3zH2XB8CLkFYrZ7JlJDjy26bKXaMnFunWKW2SvVzODhdnpZHhwsFx20b7QvTBoH
    l2QLxQ7G+XGu3tT4IvMObDd6tu9VYv1xkxwl2qwnj1XwDJIYpqZ/2Jht29wrD7CZYCbH
    ZPGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740449568;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=rKw0EU1a4n11NF6vRXbQF+YSpN88yre4pNG63+hgd2Y=;
    b=0yL9EcmkSMsqsIJyJ4X6cIV5FbJ2Cf+JeU8TWbrXK7C570kqB5D9jXO6agbZxbNFFJ
    AVJkLoSF0GvhYjDo7OCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app301.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.23 AUTH)
    with ESMTPSA id z0a38411P2CmB3k
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 25 Feb 2025 03:12:48 +0100 (CET)
Date: Tue, 25 Feb 2025 03:12:48 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, "Paul Barker via lists.cip-project.org"
 <paul.barker.ct=bp.renesas.com@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1061717272.2807780.1740449568541@webmail.strato.de>
In-Reply-To: <20250221165628.357818-1-paul.barker.ct@bp.renesas.com>
References: <20250221165628.357818-1-paul.barker.ct@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-st] ravb: Fix use-after-free issue in
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
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 02:13:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17901


> On 02/21/2025 5:56 PM CET Paul Barker via lists.cip-project.org <paul.barker.ct=bp.renesas.com@lists.cip-project.org> wrote:
> This patch has been tested on RZ/G2H using the linux-4.19.y-cip tree,
> but I'm sending it for linux-4.19.y-st as the issue is also present
> there. I currently have no way to test the -st tree without the
> corresponding cip patches.
> 
> This patch addresses CVE-2023-35827.

Thanks, applied.

CU
Uli

