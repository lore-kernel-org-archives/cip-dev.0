Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B68EB8FAF
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 08:33:00 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web11.3868.1693989178035636766
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 01:32:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=hheOwj/T;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=QYjEKBGG;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1693989175; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PMNA77bKSEpY3yiFpnmtevH0tUxKnA99C4IoKLg7R17Ec9uz9/ei1Pq5Ug/UyaJqkC
    cH6VLvav8NQXsHO3htcAy21ZyWEH8Pu19+tpy2GEkog78Ry+Hx4cvbuNE19fLUdSkPWq
    sK3S2pLqh5atdxQyPT62fNA+aeNoSvrxNHjMRBJ4Vcge/9wHdsGCRTOTKiDQGIuplCTY
    HavC8w83xrp3bcuN1Wy/ha0Q/lH4WhaHheKYxUyNO2CmPWHFcUSmIRUjznP4zYYruiBW
    GM0tmnog8RsuaQawj0wkYNBEHLTxHE5hxC/GgCwSuSFhfKkBOPUGVfU4dJ/YoC+tr5wn
    I2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1693989175;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=Uu6j/jAwpJJ6GtGaVYURMm7qrRP1d1ZoxhE69wZfcQ0=;
    b=MflOtaPGCxi68D727Ykou4n43jPsVQHbZ4rxT/0rzpqI1ZM6JuoM3kJ9bVQawie1Cg
    YpZcwc5Y8YoNavh1wvMT+u09Ketl+KKy4iJKKNinUmTgL5EyvFT2Yv7WfKHH11SjKVDf
    +STvYrER9dUzq756rdGpTb48vM7e8Zwn/36dLlYKC7DuNT/au/nl9aYRr9B0+1N6PuFH
    cOkC+4Npjn8H3gnFDV9SCq5qRnrVJ6jMf/DWIWvlCn7SobphvqGht/8oEeDl0xaGUXL/
    0lw4AxbiUqOz4gzrv5LgU2qXcyj9o63NX1rrdyoLFJFUQcHvaWKAtQTuiebQNgWfZuaK
    YH7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1693989175;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=Uu6j/jAwpJJ6GtGaVYURMm7qrRP1d1ZoxhE69wZfcQ0=;
    b=hheOwj/T/Hh2hbbPg0T2vGQAP12LePVSiDRK7COmTkVvHo34PT04S5LGj8lqgUKyu5
    MTzbPCE9pbWs2IzsopiNpDaCqEI7zQ3ihFsO5vXqmX+dsMoSX2Qhi7N6NHsyhUy7t23o
    yCLByrz5781By9DK08OeZVn763IfcD8GpHYGYLyCLYK7lZlWP0eJnKSZS3AEjKI5XxIC
    hKhmeuA/FAniSYKK+3i9FMXiAhNEYSXUu0i5l8TsiIPpNo0mpUod3EWEfvpZ9U75+R1M
    RqDWQVkh7sGbxWZJTSd1bd6Jm0f0VRqV6I6oBTkB+WH75NJf4gKde4S/5+3vNSTq/le/
    AbgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1693989175;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=Uu6j/jAwpJJ6GtGaVYURMm7qrRP1d1ZoxhE69wZfcQ0=;
    b=QYjEKBGGOXr5m/cfgjCcyh6i6QmT56uxAOCGZffyQf+7E2AHUZtCC0SFx9w+az4eK3
    AERKMquhXzy4on+DbIBg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCs/83N2Y0="
Received: from ox-live-app103.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.8.2 AUTH)
    with ESMTPSA id eb482fz868WtNEZ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 6 Sep 2023 10:32:55 +0200 (CEST)
Date: Wed, 6 Sep 2023 10:32:55 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <342239032.350330.1693989175762@webmail.strato.com>
In-Reply-To: <ZPXC40QtoXU/EYpO@duo.ucw.cz>
References: <1583308606.3395319.1693820637255@webmail.strato.com>
 <ZPXC40QtoXU/EYpO@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st44 4.4-cip79
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev50
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 08:33:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12979

Thanks for the reviews!

> On 09/04/2023 1:43 PM CEST Pavel Machek <pavel@denx.de> wrote:
> Most look okay to me. I'd not put too much work with READ_ONCE
> annotations or qla2xxx warning tweaks, they don't really fix any real
> bugs. "ext2: Drop fragment support" probably does not hurt, but surely
> does not fix anything. I guess we can keep it when -stable took it,
> but...

I'm inclined to include such things if they are trivial to adjust because I think it will save time fixing up future patches.

> "usb: ohci-at91: Fix the unhandle interrupt when resume" is wrong, it
> should do ohci_resume() once, not twice.

Correct, I'll fix that up.

> "netfilter: conntrack: Avoid nf_ct_helper_hash uses after free" is at
> least incomplete -- nf_conntrack_helper_init() does not set the hash
> to NULL in the error path. (Mainline does not have that bug, and code
> change a lot there).

Seems like that applies to all backports between 4.14 and 5.10, at least. I'll leave that out for now and ask stable about it.

CU
Uli

