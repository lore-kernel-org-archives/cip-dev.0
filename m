Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66788C021A4
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 02:28:43 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
 by mx.groups.io with SMTP id smtpd.web10.2536.1740450513704372701
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 18:28:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=CvlWDmC1;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=j8+CFnyf;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.50, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1740450495; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MIUYEaZOWWo7Ma+fvpwYQwJ1so9aQ6GHPOqgu7FTZvvaJmTLqq015WsPHy780N4FVS
    2uWe3T0Q3a/+cOdqpFTv6q05H3U0dXZ0i4SFF5lx3gRaRI4J2GPWAa73I3cnSRKgH1xs
    WWyBJR+LhEBv3r/QWusUl9nSpWE9HPw1fd3QUfNZCHW+VP0RV2lmYn4BCVJn0Gpx385F
    Mt61OYLxQVNZAlNWYDv7rX+VojBnhrXG699T0pzAHj+VVxnvQdD0CM/Y1jKn+ghcjE+i
    gVaN1y7Qg/DKnfTbhiOrDH5V8WeNlmIsBc17GcI3Kkwrhu+yTmtqKTO14A9NNl2V7mjc
    KI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740450495;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=apQ12e0GfYBgGKVyFcimNlpWW8lKeUscNcLN6vYb2u8=;
    b=LXiBYVYHSglBV0vTA6CT20Ijogy2CKnS5nn8SWqm9R/Jit+1Z876fA4LE46RydWyAv
    q1c632oY6ljOEqnpaTDm/PJZX4uZtlmvuMmguf+rexjo9TrAIo7m/DS1SueD0epqq2bM
    jK0SwSLdXqSIRPIIHD6YoWyn4/dNen8HNsXmjKMkXRYceClrVITSoHY4Qh9R6lqu9xB0
    F28kQurUoIBZw5hJm75XjDZKjjoIkKe6iMrydTqzN8CzYH17Uhg1xXvjSkQKyDxLtLuv
    NGYnetq8Dmu6Z6VNRKy8PJ4FvmLqxlWAJmQVEx1Re/Kp5GLe69eiNVT6k+LM0dvoC17M
    +sJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740450494;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=apQ12e0GfYBgGKVyFcimNlpWW8lKeUscNcLN6vYb2u8=;
    b=CvlWDmC18I8gIWBgJsViN0iOxdYhpSX1Yz+K5HxigMP3P1GFBy0rtSbZlRLwD9ZqA/
    uXHDpMgzeZxjtJmaFbShgfmHE7jJyb3eySjBRIrJzKzkWtnmDv/vKUuU2KCY3WOTC+lV
    mbjNdqrhm4/Ae5V/31Z1yxjU+95s9FMdLTKl88ebQunIryUCTABTUtLNkA7r+hRU9oNM
    gXA1ikti49+zTN+FQyjEYkzsOqZVsk/4xMOF/CU/oSQBgavk7f+lGwiu58b078pIl3XG
    Dl/VHRlVoxx3qNHal7UnvlQTBij9pj8jeAr4WwpzB7REwBDwtgmGKnlg+CcAboxtHWlW
    MHbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740450494;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=apQ12e0GfYBgGKVyFcimNlpWW8lKeUscNcLN6vYb2u8=;
    b=j8+CFnyfjGUHM7DivVx8qDQuAasU6Plslcv2Ddyd/oJBdAKtNf3dnJwQ9SVesz38Ju
    CfY52jbcBP7OD5PYs3Cw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app301.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.23 AUTH)
    with ESMTPSA id z0a38411P2SEB4d
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 25 Feb 2025 03:28:14 +0100 (CET)
Date: Tue, 25 Feb 2025 03:28:14 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	"Paul Barker via lists.cip-project.org" <paul.barker.ct@bp.renesas.com>,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1074551120.2807839.1740450494914@webmail.strato.de>
In-Reply-To: <20250221165755.357838-1-paul.barker.ct@bp.renesas.com>
References: <20250221165755.357838-1-paul.barker.ct@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] watchdog: renesas_wdt: support
 handover from bootloader
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
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 02:28:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17903


> On 02/21/2025 5:57 PM CET Paul Barker via lists.cip-project.org <paul.barker.ct=bp.renesas.com@lists.cip-project.org> wrote:
> 
>  
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> commit 962085a2bb823d8c88c6bc706c654648407e6408 upstream.
> 
> Support an already running watchdog by checking its enable bit and set
> up the status accordingly before registering the device.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/r/20200908095615.31376-1-wsa+renesas@sang-engineering.com
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Thanks, applied.

CU
Uli

