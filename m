Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D163C3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 12:57:29 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web11.49162.1743080242336091238
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 05:57:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=b9iDYnBD;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=XjcNPD3W;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1743080240; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PprRBSSyvKsBQTIV3C3prwJ2MytNfdlWqKCqQSJiFKSQKbHqNCLkanrmZXZ9SJ6eH1
    5qQVnaWqH8A3xrYCWx2AitTIp9nehCpJvz2ppWVODqtKzvn10Tp+GYVsyNOv6btRqr8N
    cmlc3RRlNaD66yDkMtqXcWECN06LgVBuvplRLLG8cgFk3yZGQwSyUrqv0Xk8XYLozOlv
    FH56E6y4KDiF3j2yNIweeXSXHvRB2CRSSDjq+yILDey09ySHDoGFE8Bz4sF7k0xo6FCg
    8UWAzdaKWVy+IHqhVtFNOKJCfSg5Q8kcCYFWz/U9CpR/pJq5I4lG4pYwgp7C/zrGdFtP
    5rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1743080240;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=la+1ksIyNlZWSHBg2A3wn3CtV0Omx56Qu9W6lOW2W6w=;
    b=PdfqPeEvjhGsAaNDJm3zTxMu9YCz+MiKwqeUgiUZfgthtnygSZn89/58uEci9gjzoD
    kWeKQCJw0hwKRwuAu3Mp4EirHNhpAL5zHfyn7q9UpoFwOxEutGVoKXDvLyN8b3VzvDFZ
    HRFyrzavnmVeOfZ/zbdOWusa6ZuzdvuoC85tSX5UJT2dV6Egz+sPFOM2YCFL16Jak7Nl
    pobJmhwlfT1JWqEgQ8m/SRwHtSL9dBUIuE+8QFEuYqxe4HbliYHe7Tk521oM9H2k6DLp
    FJkGCGf5hPN17WBTUwttoU4K+K78l2rEPzZflqnX8cNrLeIRyrGqE3Q4SgcHiKy6hPDy
    NoMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1743080240;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=la+1ksIyNlZWSHBg2A3wn3CtV0Omx56Qu9W6lOW2W6w=;
    b=b9iDYnBDnT2EN8kTrya1OwDQFy+zhpXZdKPec0aqNeSns96APyHwd/8OWzkxKVlC9o
    boII12lJTaWfmONLeP573NWySAypXEooEtYgYiU9kjEOCuucSujTBRDYqYrHXgxNOVay
    RjhGoxh/e7m3qbjIJhNfJqI7R2eEFe5OnrP/RPYTkLWfBt63mEtQbGpWQh1sesgU+KGf
    HMP3z1t/gLLF+WTNq38No3DD0HNwUqHPLrtULtM86Aw92C7wFwmAvc3kOIDgpclAA0qB
    jDIX8Gtn5gfHS0s+p/bZBb2fgU/BIwSqXpKd1Cqr2NJBx/aivyNkegi+vBAY5Z95z+mz
    VwyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1743080240;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=la+1ksIyNlZWSHBg2A3wn3CtV0Omx56Qu9W6lOW2W6w=;
    b=XjcNPD3W6w6nPU/6Ux08OC3R6Nzr3vz4eRhk7MlcjhJ+tN0XACY+GgtP2Y2r4iiay0
    VupxhYbN8StoFB/7hLAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZsghGuyX3LvXid7Q=="
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34012RCvKZKH
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 27 Mar 2025 13:57:20 +0100 (CET)
Date: Thu, 27 Mar 2025 13:57:20 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Alexander Grund <theflamefire89@gmail.com>,
	cip-dev@lists.cip-project.org
Message-ID: <1253312789.35862.1743080240752@webmail.strato.de>
In-Reply-To: <20250323082118.8153-1-theflamefire89@gmail.com>
References: <20250323082118.8153-1-theflamefire89@gmail.com>
Subject: Re: [PATCH 4.4 0/1] Fix null pointer deref
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
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 12:57:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18377

> On 03/23/2025 9:21 AM CET Alexander Grund <theflamefire89@gmail.com> wrote:
> The patch
> "can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL"
> assumes the following patch which isn't applied yet to cip-4.4
> 
> Marc Kleine-Budde (1):
>   can: dev: make can_change_state() robust to be called with cf == NULL

Picked it, thanks!

CU
Uli

