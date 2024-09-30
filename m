Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E2CF6497
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 08:05:49 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.web10.49218.1727683543853486933
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Sep 2024 01:05:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=XBRNmpLN;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=N6bSETEW;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1727683529; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lbffYZ9Iu02G8vQB7NaHalsCcdmSK8/fmOR/e2ibljwjUFk1h+tpuSlnA612wH40w6
    f6Ydb7U6yM3QRpiADsOUI6HNdfVeqHg2vP7tfL+KzBYzbjL4yKO8u3O/AhwgfuUQsmih
    Z8umaR0YAiGev/O+BAUoaxecuy0ALh4Y/xu233QyuEB4a89aGTuykZLfovDWbbXQqqRb
    vxTbZI/VD5meTe8nrQvuBz9/5BGzRx/vm9HlWUZbpReph2S7BCJ76OBMfNYTmTCk2dBR
    FWKSyfufCaC/az5VUk60ABq2s4SZHtOeFZ4eLqpfyuSSMt2/MHSUqW7FBrglLBXqcVht
    ePtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727683529;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=EEcIBlTxPz7Nme6HslHxqRkQkH5sX0Mb3S/EqXGS+40=;
    b=IAzTig8yIq/DHVDYyzB9p/tH/QAMk1oRTK3SCq19QOBuWQpLNaoWsmwXULHHE0YjwB
    GGSd4LsBlH0HB4NlRLpT6TE1KMZvZb1KOtdt6SEZcjkxDuIWxiYUrJSnv9F3e4w9u4oB
    kAPpIAxJbtT0AdXYrI771BPEAzg6jDY3egeMTf1XtBvZWtgUxkPhv3QV9C478rg6pIh6
    sI8utkL6u+PtwdTwYfmQg5Qaxl39ZO+dGrDfGcddg5Pjj9S/tUT6/yg2L/rq5bZJX0Pa
    8xkzSLJRsg0uBQBLmhSwV/7d/Kk1iwKENU3RywVBq0vFas8atvkkIUFYSixF1ORfnPYi
    QUgQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727683529;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=EEcIBlTxPz7Nme6HslHxqRkQkH5sX0Mb3S/EqXGS+40=;
    b=XBRNmpLNEl9sWFH2pNPh/IWLRBTdVOe2HbZUfqZpU5AzCzYOBIbNGsA42uBewI9Ejj
    45LbvZ44t3YHx37edb2F4hz7oUY71bjofyKdAY8Cb/hzHJhO3o/oTRNMLbLIDN36ElP6
    pldmiQToIAC1CbTpPhnrAoNP7jZM13dOOqYp9ewMkMAd24i7yErAjn6rAgDrJcDFo7D1
    nKPUfAJmqQCoCAy4jJeV1pYjH5lOeslJMYvPTaCvkG7DA8NePxxebSb9UKR9IvF62jhJ
    NIboJEfmXIBFjxuJZW1cK5XIStC75AgQRKGbuHrgbK9fITLt6bDRfjvk4darwJMhMInt
    0bbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727683529;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=EEcIBlTxPz7Nme6HslHxqRkQkH5sX0Mb3S/EqXGS+40=;
    b=N6bSETEWiknjPxIwdoMDmHu1JbG9Yx0r8Wu/75i4WQcp23un00OHimj1m+NkE6/341
    1bup++jfak1vQaKOkPCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqIHiuLmP1Lpd+UesJUZWVaudd1Gjb1n0"
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0d2fd08U85TWmD
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 30 Sep 2024 10:05:29 +0200 (CEST)
Date: Mon, 30 Sep 2024 10:05:28 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: cip-dev@lists.cip-project.org, linux-m68k@vger.kernel.org,
	geert@linux-m68k.org, fthain@linux-m68k.org, viro@zeniv.linux.org.uk
Message-ID: <282827158.1735339.1727683528989@webmail.strato.de>
In-Reply-To: <20240930020840.15226-1-schmitzmic@gmail.com>
References: <20240930020840.15226-1-schmitzmic@gmail.com>
Subject: Re: [PATCH v4 0/2] m68k v4.4 backport fixes (resend)
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
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 08:05:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16934

> On 09/30/2024 4:08 AM CEST Michael Schmitz <schmitzmic@gmail.com> wrote:
> Resend (partial) of my CIP v4.4 backport patches for m68k.
> 
> This series only contains patches 4 and 5 of the previous
> series (Al Viro's signal handling fixes) - everything else
> appears to have been applied in the meantime, or isn't
> really a bugfix. These patches need merge conflict fixes
> and are not suitable for cherry-picking from v4.19.y.

Thanks, applied.

> Tested on 60830 (Atari Falcon)

Are you using atari_defconfig? If not, could you send me the kernel config for reference?

CU
Uli

