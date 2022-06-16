Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D17C43334
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 06:50:01 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web12.15121.1655362196396571223
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jun 2022 23:49:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=J6xw+gjO;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217,
 mailfrom: uli@fpond.eu)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1655362192;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=1sKQQ2ViJ1iilLgGsVcgPL6eiqc7j6pt4/3LAWf2/G8=;
    b=J6xw+gjO8zeiePZQqGCPKFmX9H6FXj+WztDGU7/8F2VVf5AHSMvN8TQXHz+1FLhVNj
    ErZSzbxe9G54opdu0gKnSYry7DbuXNXTFycwg+WxwdXX3bP/P4Grcuz0uwlb0jjQECtu
    m6PAlsWfXqA7mU+clz6JlQfABOoPfNJR5VXmP16XBka4zFdJSRVE8NrB1/B4/7ZkpoxQ
    n+50bInTf30JeLpVBFMCitis0G8CRgf26Bb0UrltS7rTZSLaoqNiuWOm6M1adPVrAbn5
    Hd2zD1HiMM3SqJckcCSXjpYCVp0PeH8oUqp1wK5zgL1DSFLWj3NSGaXWZR9nwbCblbjM
    gNUA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2mpheg="
X-RZG-CLASS-ID: mo00
Received: from oxapp03-05.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.46.0 AUTH)
    with ESMTPSA id zae5e7y5G6nq53s
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve
 X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 16 Jun 2022 08:49:52 +0200 (CEST)
Date: Thu, 16 Jun 2022 08:49:52 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <31352177.298794.1655362192534@webmail.strato.com>
In-Reply-To: <349a076d-208d-c8a1-056e-1e2ef6102e1f@siemens.com>
References: <349a076d-208d-c8a1-056e-1e2ef6102e1f@siemens.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev16
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jun 2022 06:50:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8569


> On 06/16/2022 8:45 AM CEST Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6667/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 12:00:

I'll be on the road at that time, so I won't be able to make it today.

> * Kernel maintenance updates

I've been reviewing 5.10.121.

CU
Uli

