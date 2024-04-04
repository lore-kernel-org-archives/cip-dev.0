Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBA9CD1284
	for <webhook@archiver.kernel.org>; Thu,  4 Apr 2024 12:46:34 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
 by mx.groups.io with SMTP id smtpd.web11.36955.1712234790856144387
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Apr 2024 05:46:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=jqzWrK6Z;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=p65wuyZu;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.216, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1712234789; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Jcdwtp6mStwu9dcpcUeHSGFO6x/5QLkx4UTyIBeEzdv05fK7T4HvsWFAHm125xLwMG
    gakvLvjxhKXXFFjTvuVvhYqCZBSiBIhMaNHZoLWYjRGay1L5Mv/ZgFKY8dFVByKV1/gl
    +nXHZXWrW797bCempvwyD9shYzEPfYNUPH+UyNrFXsXBk223dpswcc7EZkqJJCKb96/D
    RqPmldhtEW4+v8SvzZvPhVyZP8ZMcIohfFCgJeVOEapP/iLN1tPNR6auXVdS3NXHBtrn
    HmczLDxctqX+cBYrpRd7gAR5v8kbtBTDeAvPJwvY5dQBIt/rj7CwPqEv0rmlIDxf7EkZ
    SOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712234789;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=mDDpKo87wdZsr3r5PBfzT9UJfvtw+r1adzgEDdjPRVo=;
    b=LZYcoSg2mIiJeLjE1S5IbI2yF73q3kcFdjyZtIFVW2FibWiVPe4r9KhL/WRUDiMRLK
    EuTusG9rhKwu/kRIWSSl5XkVGOUKpmqSagS7xwAYRxoFnKWkqwkOwnVzBY2gM8rBaK5Q
    IIvI32Dv/KjdmPf6Gqmwff5xT7TE4TIIype1/5yC+e/rIheNG/0OKy2H9r01GsHqILgY
    kWR07QSOuMXs6ry+XFtmn7eh+RKQAqZM6vXaB8WFzLRG+Eo2/lpTO0ZWs/BQqPASsRpl
    WqnmeFLy/dgrLmKH9I3GeALez5EngNuRd8lYWBV0R+6MAEjQVGPhgn7pmBEOzufI+7kg
    kl6A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712234789;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=mDDpKo87wdZsr3r5PBfzT9UJfvtw+r1adzgEDdjPRVo=;
    b=jqzWrK6ZqYN7NR5Kpyz9N/agNUVJrZ4Bu0g2/ZiSYOYrxl2i4oU+/khVwscLFqbJxN
    nv3lOyhhS59RNmRqb4/iPyQvo4Q9CIa6UlFq+RUhO3Lx46jDO7ff3azUwGEfcBw8FXKK
    Kw3DwFylQbWpETPQfhRYARsiBXIVMMrM5BjVqTdFPQrioBSrJ+STeTaGkYcnH52iRveY
    baX+jpZgrswvXfJ8PdKt0Nui8bp7jhrvooRxjFp2nEKCbKfAm+hZbVbRf/WvrDIHNw0A
    sT1tJm4lLs7S1PhajuyPJbBmEHyGLDmD/xzhrdwPUtEpQMx644UGKdIHejN7NWtVK0Kq
    VjHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712234789;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=mDDpKo87wdZsr3r5PBfzT9UJfvtw+r1adzgEDdjPRVo=;
    b=p65wuyZuh+inmqKfvgDyKR51Cp3TyfO7C6lBWKEjJdU6nlRCZzIBqXFYjSi1Hl2QA3
    8cAbhKMY3aYQcORZwTAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7sKNcZueM1/kk7cFJ9/ZpmwZW4gIWTSFIrn4w83ZMTG"
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.3.2 AUTH)
    with ESMTPSA id zaeee6034CkTiWr
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 4 Apr 2024 14:46:29 +0200 (CEST)
Date: Thu, 4 Apr 2024 14:46:29 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: Alexander Grund <theflamefire89@gmail.com>,
	cip-dev@lists.cip-project.org
Message-ID: <28983187.1206355.1712234789231@webmail.strato.com>
In-Reply-To: <20240323124301.250422-1-theflamefire89@gmail.com>
References: <20240323124301.250422-1-theflamefire89@gmail.com>
Subject: Re: [PATCH 4.4] bonding: Break instead of returning in
 alb_send_learning_packets
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev61
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Apr 2024 12:46:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15492


> On 03/23/2024 1:43 PM CET Alexander Grund <theflamefire89@gmail.com> wrote:
> 
>  
> From: Alexander Grund <flamefire89@gmail.com>
> 
> The upstream commit used a function which upon returning an error value
> would break out of the surrounding loop.
> In 4.4.x the loop is inside the function alb_send_learning_packets
> hence returning would be wrong as it will skip the rcu_read_unlock.
> Moreover returning a value from a void function doesn't even compile.
> 
> Fixes d6b83f1e (bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk)
> 
> Signed-off-by: Alexander Grund <flamefire89@gmail.com>

Thanks, applied.

CU
Uli

