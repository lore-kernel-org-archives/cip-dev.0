Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AF1C6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 15:59:06 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
 by mx.groups.io with SMTP id smtpd.web11.24144.1678723137920562953
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 08:58:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=YblplJNK;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.23, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1678723134; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z0aEdGwXdvkWPSEgcCMRqvidRAS1RDuWa9dpTPcM9RykUJ/CS6kM/4LQYronwOhTry
    Be+Fijm6YYqPGrKoaq2BdxALzHpqlTrgj+zDCkIP+ho/f2JPU2TR31TbhKhJqqC/eOXV
    i0M0z28GokePLv7a+lRnJlG2gmI+7tyxEIgIZFiurAk6O9rnqmLKeaYn0yv+t+wpxVjt
    frlZLj9Cyh1FoXWzhkPJv+MHGR6Ec8KaSdOpDv/hVogVQLV3cGloCJiLGoTX4VwMIacT
    yCi822BWFWfmnw7pJTCdr9daWF4o8mBV+JmLKY0wTvuVlWWfndjCuHtRFR6DJ0oT9JD6
    66vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1678723134;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=DQiZ8NN004DS/vTmz6N8w9b9vgc118TQgM1yjEfO7Pg=;
    b=IYp/4q9BEpyI7n+V9QVogOEsVJ7xu5yWIfpN+xVCN7dC53aD4zxdCX2IeIKUj/qWhs
    vb5pt4xdbGymHl+TKa4sPhHR+TdWeIgNQGsI7fml+gzb6ts8AK1pVo64Leles12EW+VJ
    rqIBsVLFL3vAuF/eECoCTf96q+lIZVZQxWWmWXriRjA8n/15br45/qV9MicC8FgBugWb
    VA5VyLTTCHBI2+kY11m0vmukuTenFhkWFsiB4W9RRDsmbr/Ovi0ZHjRNTvdDF+G8LUoC
    7/Y5qv6lvuKGZLd3n3Dp0FdnZ64E4fHS0Lbofynl0S4hGF8V6Vuq8Euc6JYT6LAdGxxy
    VJsg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1678723134;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=DQiZ8NN004DS/vTmz6N8w9b9vgc118TQgM1yjEfO7Pg=;
    b=YblplJNKKx8eETB0J6PiiuhDPY3Gy9BhIRfYTtNZ/ELoiThYTFcLbW/ir58BIdMIaH
    EMbTzP3Zioecsxstm3GBOMxfjwdClhpag+/crpnIZASPTwxoUy7bhRa8AnUimj3q3Pxn
    SsZSDjdmOn1O3j8tAILKcqvkX30kh6T6IoOnQWnbDI/K9VZkBJ3S7KSRRzYkGUB8VdJh
    EJf9Hag1Xz3UlDewJAqxs+3BLPU6IikvTb26DoaWOS1FqBWY7SWZGXeejFNPJjsfXcdZ
    MeAm8H8uGcRUayPmchM8joc4f6jKYMLtcZsn+ELgbH14BIidhazgtT/NaZO+dUYLR6lG
    VHfg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w2B+Io="
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.3.0 AUTH)
    with ESMTPSA id 5ac80bz2DFwseBR
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 13 Mar 2023 16:58:54 +0100 (CET)
Date: Mon, 13 Mar 2023 16:58:54 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <161763654.1591667.1678723134566@webmail.strato.com>
In-Reply-To: <ZApRDHkYvu2bOgZM@duo.ucw.cz>
References: <1010789948.2703824.1677492030810@webmail.strato.com>
 <ZApRDHkYvu2bOgZM@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st38/4.4-cip73
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev39
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 15:59:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11017

Thanks for the reviews.

> On 03/09/2023 10:35 PM CET Pavel Machek <pavel@denx.de> wrote:
> I believe we should be taking this one. It is mostly theoretical bug,
> backport is extensive and we really have no way of testing it:
> 
> ! syscaller -> theoretical bug. This would really need testing. They
> were deleting code from ack_complete. Lets... not? > 57059c01a09d nfc:
> pn533: Wait for out_urb's completion in pn533_usb_send_frame()

I have dropped this one...

> I'd cite commit # being backported on the first one, and I'll need to
> take second look at these:
> 
> ! cite commit # of the patch being backported? > 7672af7c726f ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to prevent UAF

...and added the commit reference.

CU
Uli

