Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31F9C3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 12:58:37 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web11.78981.1720443507338003026
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jul 2024 05:58:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=PTdSIXl2;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=pJORamd7;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1720443498; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VdOXMM+Z2PBx2ml+ogPhvxH4/rAUDLD2Tirj5KDZgHdV6AHfgBwrnv0G+VtHgEI5w8
    7r5i4TCmkoojfJ605byZn4xHYUKwx3sT7WHRi9opDP0AAd6ry6x+eNiqlQHPJVmeFWGT
    +JHFU3ceGg7yIFPx9sXAES+mSay4Ruf6iIXPT8VBOb+1loFVXHJnt7txh/yTv3eSKUq/
    9uGkRk3H4j/NYknHjC/Jl7uLXi2pbSDXi99pDiK7ZnKQdTtVfFpKdb7y2izUUUqS4QOl
    NMD3xqgPSzuXFnHERrJ1GTpEVJI0qXnXvCwft8+WlBmOzmLyV+rS92zmNGzLkqe1/LP2
    Oluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720443498;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=naW+Y2oY7GZ4D26Uo2ZfKAWm52yKdAgi/MzOTFpdNEo=;
    b=m/iriSZ3MQnmOVV+E1aCvxnrIwsavd4n6VCxX8AacEUO0li432AhjNcZSl0ffyqNdf
    FjnGjPL1xqKlXLyE2JIoxqgYA3PvuUd9YvikswuSJbPdz1xW54jMa+JRVi3t9/IEYUl2
    79M+ekA3U2b8D3C/BSKJEWz4nabuADF4gg72RC2cBDsxP2fI6gFcxeNGvVLAZjHFJ3hW
    uipcXNyBvs2Ui5D5xn3gKuIM+LZvlzYO6Qlb9WXFr+1Rq4AIq8bVMLMlMT4HfP/3kDhh
    vzgO3fDIiVgPH/yU0xbQqM9afkYr7RUXBFWsF7NNK2Ltu+MBEWZh6ldGkPEeIrPhn9hC
    yNJw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720443498;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=naW+Y2oY7GZ4D26Uo2ZfKAWm52yKdAgi/MzOTFpdNEo=;
    b=PTdSIXl2yUEiOE08duPrSVnrJ+eRYxR4UyZbjY8VMmtNaYq7aS+MW9OpN+Xkg8UdhX
    /MNjN8ueq+Z1/Q/4WL4W9aSllyistAo3HTIq6dskhYxTiBRArJ5jnFBtC4IhZtZ8Wfxo
    ZlR3ix40jQeyEENN5Jd1t79Fozhp2kf7aXUtnMaKliXyO80UKJX8TOlmJ4myhFObz96/
    aSpapvJUbaVOx+M6TnGeZ6T/sXOifZD5l/gYWj1tAuOPt2z6zIaZ8pziIBrFPKzeUX+q
    QUDK8vEl+NF1wFxQGdJ2GJgrQve67cqcw3UlFiDnJ6wGuSsNMqhUUZa7/++GFij/7JwI
    ulbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720443498;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=naW+Y2oY7GZ4D26Uo2ZfKAWm52yKdAgi/MzOTFpdNEo=;
    b=pJORamd7ZQol6p8PD2VGqyKMZegvhy4jVzlvfPTLvOT96V7+RWd59z7yA0eYxaFt02
    psI8jqB4vDW838mPGSDw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqtq89k3mYUlHMXIUnKaGpnZCxmxho2QT"
Received: from ox-live-app104.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z07fa7068CwHtOt
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 8 Jul 2024 14:58:17 +0200 (CEST)
Date: Mon, 8 Jul 2024 14:58:17 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <469223667.1546387.1720443497943@webmail.strato.com>
In-Reply-To: <Zob3CMMN5xTB21pM@duo.ucw.cz>
References: <729272238.766733.1719933056170@webmail.strato.com>
 <Zob3CMMN5xTB21pM@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st54, 4.4-cip89
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev66
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 12:58:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16433


> On 07/04/2024 9:24 PM CEST Pavel Machek <pavel@denx.de> wrote:
> Thanks for series.

Thanks for having a look.

> it turns -ERANGE into
> success. It should use 6.1 version of param_set_uint_minmax AFAICT.

Fixed.

CU
Uli

