Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E51BC47258
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 02:04:53 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
 by mx.groups.io with SMTP id smtpd.web10.5348.1706493889558103208
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Jan 2024 18:04:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=o65oyFM2;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=ZfEH0A0d;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.23, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1706493887; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HuZp+gJIJDCweTkQONSN0ZukeQb/Lpp1kRNzWPtSamxVZvW29OhBLxFvsFoqwtT5go
    QmtqiOCSXlib1LqOXdxkRLxPf8GmzvhPqrbUnGK6ibH5LLnWWUZBB9ttXPFt4KF4IMYa
    Au64qE0D3f0LdW9h9gX1BsoZHykkAhc1W05zze1Hc2l/vSnwLSrg3sBDwHOxm7wpSNQu
    ftgFL9fYoSiMAA+f5xxMgTaOAtgLOaBLpj44VEgbjj3u/llIcFqPfxVfZk41OP3vXLeA
    OkI5VI1nsnNjJ0CzVmWQoaNAy1mOiSTJB7Bdsj2XvOgdGYpUrh+Ta/iNup1A3tsGdQ+P
    rMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706493887;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Zfvf/ioI78oKp+tze10LNXiGdvsZKMeL/2LwpWx+H0Y=;
    b=OtkB0FqLVPE26I7pNLiV2fr9Pu8/W1Go6bVNTJuBIdExTtc/Somooni96rshC2Wpam
    wW+d5G17hqsLB8bjPqQ4axcD38DaiW3YJSHuvG+nPafdUhiGS2ZESBOPrZfGaTpymuV8
    uRPK/OectlrWBiJdrJpePBwCqiAcGVbJjuRVFof2cSz1frXMcHThkXRyrSVwPqy0bTKz
    n8SM+3GmF/Z+O8N8EiEIbFlkzxKRoNzXlVmt790QGWelGmaen6qb4+EdSC8JLQVu3T2m
    wmbZDpAwT2tPg8js0a1NtPVEnXQg4gPpXTA1pHO8Z525HGgosv1AQwGw1zUvwENjy3FB
    3D0w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706493887;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Zfvf/ioI78oKp+tze10LNXiGdvsZKMeL/2LwpWx+H0Y=;
    b=o65oyFM2nz8o2fH4vWkYTJiPRalezf9hLJUqlPICzLiI9WBizR/+oHhVmYnX8kPn4e
    oJDaB0wkhJsjyeUYjz20L/D7XuCnSpE5/A452Wh0Mop5qUQKkISyvqr4D+hEH8nMUp8a
    TmbGlB8zU2W5qlhaS6u+s3dyd485LRyCwMr18+Ii132yLd5NEQKZQPOgAW5AZdZdrwua
    LQXJaHV0gq7fca6zNJPiWsfBOTqTOdG9Q2xCxlGxikYw36eDHqF2BJ9jAew1jfAg+QSe
    GJaO3pGHy4af5xdf5ELlkqvyqawTIPWm+OfgM9H6EYBOm6XrcrodFjHiMD+BqdE4Uaks
    IsWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706493887;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Zfvf/ioI78oKp+tze10LNXiGdvsZKMeL/2LwpWx+H0Y=;
    b=ZfEH0A0dTuDeTXcx6yCGcHQ1ifp6Yd7p+abtbVDTRZpascjdeMidJaWT6xVybhH6ph
    Oawp4aB7BH0DSdYfLLAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/wuMlg=="
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.11.2 AUTH)
    with ESMTPSA id Z7ddde00T24lEob
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 29 Jan 2024 03:04:47 +0100 (CET)
Date: Mon, 29 Jan 2024 03:04:47 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Alexander Grund <theflamefire89@gmail.com>,
	cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Message-ID: <1862675745.2863908.1706493887652@webmail.strato.com>
In-Reply-To: <20240111190658.153488-1-theflamefire89@gmail.com>
References: <20240111190658.153488-1-theflamefire89@gmail.com>
Subject: Re: [PATCH 4.4 0/4] Bluetooth: hci_sock: Fix possible OOB write in
 create_monitor_event
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev57
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 02:04:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14472


> On 01/11/2024 8:06 PM CET Alexander Grund <theflamefire89@gmail.com> wrote:
> From: Alexander Grund <flamefire89@gmail.com>
> 
> This basically fixes the `memcpy(dst, src, strlen(src))`
> where dst is a fixed size array and hence the copy can overflow it.

Thank you, applied.

CU
Uli

