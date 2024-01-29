Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593B8C47258
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 02:06:53 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.web11.5187.1706494007110206038
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Jan 2024 18:06:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=ArRig6Bm;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=PHhFGXfx;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1706494004; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=q82XBX1KBZ47+GYgMc8tkvB0A9gCoIjbrSal+KPXJywiiI4jNJET5FDCBGIMkZcixk
    tJEgzliHNw5sJiin0ANtdhXyckc59/o9z7teFqXtpImnzN9bjJ8+TLghid8hUlMpUYju
    W7bcr19V8nggYqRLZvM1pBDI9VNzvOhRszUXqa+eU5m65GrP/QrQlT+mduWxHz4NgYKE
    jQdnMdExCC6UQqcvaDrnil66z6HEfKsCAfkZd3TvPTCPtaFrLDgeRUead/H4lrvzSyvh
    1t+GYuf5yVL/xmSpsdJfA1L8vHazEZ23h3czj7ObSf4aJEdDB3Bh1GpDlVrm7h+QuXNK
    13zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706494004;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=x2jTdHeyF65s5QzGRG3dNmEn6GtS7ARKhZhD2LyCHG0=;
    b=VSHHh6xaTt0DO72kgPH35sirhShNaWtA8yHdHTzaKzOHN3GbrKK25AV4+u1hN06cEl
    /d1lQnn7e+aFPmgqP4CJPbBToY/ykfOmhkmQDGkoVv0JZ1AEBem1z9KHR/nlpmSwC9MR
    ddHIp7Hc9NgsYpCHIGsyQIt2ZwPo3tOFRh+T1//5OxEHWt1o9RFlcaAe9oE4DnUgaqeX
    URNcTBNK3DcHC+J2dt8tnx/JwmTgCBdaifmSDANYGm+jjlCOxnJSmblps+lSSkVetwyq
    sWBbRZDx00mt6uyYuJi071h+NYP+CelDZ29bnrDOZCWdi9/Isji+crhRI/VaRqsauUER
    ZaCQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706494004;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=x2jTdHeyF65s5QzGRG3dNmEn6GtS7ARKhZhD2LyCHG0=;
    b=ArRig6BmsRgbJ9TX30hImv7n0AUDIom6vgibE3m0tDPxfxOFyQBtpMYV4Kqz4ANSv/
    q6sJpA0WcnMjPRHBklZFf6IJPDj2dlwNnM9409Im5VxCfxnoFM693RU0azxPXKOr4Piy
    GLE2gahAZ98Ybl84ufbyockFNWOxVFxMxe64+dSx4k6CnhjO3gZK7kt6dLcCziati+IE
    aAf6rSr9Qxn5RNWOGWbU/zPBuZvFulkllymYsik+1f9RPq6qmZ1RydxAilP6AwF4xM8+
    pCiFPeja2/ZesehBgdD5p7ut6fP783aNUqzvcBtp/06n1diUw318r0WtXZ6Rr3Sg64Nk
    TUyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706494004;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=x2jTdHeyF65s5QzGRG3dNmEn6GtS7ARKhZhD2LyCHG0=;
    b=PHhFGXfxEzZGrEteBOm1SNBxSQFVxqARUtvpFqOZ06WmtKqko4gTKBmf4di9B5S9Vm
    PuNWBM38FC2BaXrJdYDA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/wuMlg=="
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.11.2 AUTH)
    with ESMTPSA id Z7ddde00T26iEoj
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 29 Jan 2024 03:06:44 +0100 (CET)
Date: Mon, 29 Jan 2024 03:06:44 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Cc: uli+cip@fpond.eu
Message-ID: <188959571.2863918.1706494004411@webmail.strato.com>
In-Reply-To: <ZaWQF/fWwQSvfz2H@duo.ucw.cz>
References: <20240111190658.153488-1-theflamefire89@gmail.com>
 <ZaWQF/fWwQSvfz2H@duo.ucw.cz>
Subject: Re: [cip-dev] [PATCH 4.4 0/4] Bluetooth: hci_sock: Fix possible OOB
 write in create_monitor_event
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
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 02:06:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14473


> On 01/15/2024 9:05 PM CET Pavel Machek <pavel@denx.de> wrote:
> Series looks ok to me (with missing "upstream" annotation). Uli, will
> you handle this?

Will do.

CU
Uli

