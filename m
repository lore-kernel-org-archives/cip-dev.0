Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061B3C76196
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 08:56:14 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.web10.65336.1680512164665665353
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Apr 2023 01:56:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=row7yGEc;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1680512161; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n4kTR/wU+4VcIsXBIz71PgtlQvNKKqn1P+nl9t/45opBAF7S52Os+1mGcDHXtx7Bmd
    fSR87IX5JSZQo1gLaD4kXl4nkhXXLGJw+daziNa1kTRn2YMIjT7EmOJLJI6KnayKGTEs
    f5Y3yN53NmO4PQCocxzgDC9rBzMQSvnZwDmqR4L+d90bEnorHM6w8t/YdmfSnEmXmm93
    sVIGHuumxumzjs9Qp9VhpssmAdsRMR8QDN9CVqq5LK2f63E//oV2X3duiUbfwmyyMTgz
    NGjZn3YfAhJS9K3FjrfBSUvyi4DyDEadJ79CxS1soAE2WmhnQFkWTp8SWRGL3dkSYxI+
    yokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680512161;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=1OBlxeXR3vj7ntfXNsZUbCQjBKzh6reCVC6pqWXIjaA=;
    b=o/pVd0me1ZSl1kKOl1j0XyyiYpCDxy2uIA1G1WqXEULXFeuDaGd4e4kI5xU2kbBLCA
    FtTKsp0jCKZ9uyd0kujTNLCAllpFQVvEvcyzxAOy1HXjRI2YKGI0/EKsZ+qkUNoWXXzA
    lYio9OXztJP/GxqpYnSEFF4mufh7EzQ8QrUfgBAE1UN9n1exqyHVjQzv5ECyLQ1kYe5O
    /NavcjCxZrU4cC2vRlMOKJqelwQlpZVSrzhoIW2THnWH+DnS0sugbkeStNA1csEE032v
    TAT5o+DeAG5cW+Lc4Dc/29e3OoXDa1RPxxA0eS9buzvDjTrk4EhNobT0bWVqr7+81MSZ
    /vew==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680512161;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=1OBlxeXR3vj7ntfXNsZUbCQjBKzh6reCVC6pqWXIjaA=;
    b=row7yGEcf4oQ7i/aiQWRdF6bpFm2LLmyUKIoRZIClVmJbPj23tNVj1chEGbNs/dp7W
    PIQvfjHMGCET/vXyiJ3d/QIZ12N4urRxTu5+ZpjEA8+iPW9w1bQBfMUJb4TaSkURwvPE
    2EY9enq6dIL8yPbAgLlh7afZeN1NvvMV6Y4YzrNM+LSbQuVLX5q5bEtzBzpBBJL1zQVI
    ksFC+KA09MmfH3TX5l06sEgzwnTNPXtpj1KPH8Xyms2zW7+oFxqArj5xH2P4jbJWW9xm
    Jh28KUVxtgqXDf7YJvvcrQCkc/CNO7PaLrU/6pqhFb9t1DqO6V9pDAjtgbrR0VquR6M2
    huPg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2mpg+g="
Received: from ox-live-app202.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.3.1 AUTH)
    with ESMTPSA id Uce81bz338u1vrz
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 3 Apr 2023 10:56:01 +0200 (CEST)
Date: Mon, 3 Apr 2023 10:56:01 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	Alexander Grund <theflamefire89@gmail.com>
Message-ID: <2044934813.1492674.1680512161046@webmail.strato.com>
In-Reply-To: <13330.1680278130230662040@lists.cip-project.org>
References: <585376205.1106587.1680176629311@webmail.strato.com>
 <13330.1680278130230662040@lists.cip-project.org>
Subject: Re: [cip-dev] Request for reviews for 4.4-st39, 4.4-cip74,
 4.4-cip74-rt43
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev40
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 08:56:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11145


> On 03/31/2023 5:55 PM CEST Alexander Grund <theflamefire89@gmail.com> wrote:
> Any chance to get the patch series mentioned in https://lists.cip-project.org/g/cip-dev/message/11116 into the next release? They fix a deadlock, a regression from -st37 to -st38. 

Absolutely, I just missed it because of a deficiency in my e-mail filtering setup.
Thank you for your contribution.

CU
Uli

