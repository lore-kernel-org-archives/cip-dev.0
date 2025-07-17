Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A6C83F1B
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 10:48:24 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.web10.45741.1752749296558193666
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Jul 2025 03:48:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=EhGYpvi0;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=xJ/dwwN3;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1752749289; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eOPwDWCAQS9dN/0XrF0BJSff1OQiTbLTQuAoN2BrjMBvQAu/8KJBSWS5WT8UeS9pxZ
    mqFSVC5sBmgrXcQoEVMOkt1cRcRKA88Dc7PLDMeEG3HxanMMuK7kTgJ/LaImeXYHrupq
    rMTeLiFA9seQCk8ezuGtVP9wYs3XmD0Y8Q7MuU1XKkhaClTTFnRwy3/FIKwXbHLcaSuf
    t8MT3BACRy4p8SJhrKenJrvPkCiNrMC6xtSRCE5RT25ilCcOf++9TuFRF0iYNGzV2nq9
    zluPv8c2la8/50y3MdPCvPXVnk+f/8UtyOjhgBb++I6RU66ZtOdkpPHLUiFvQito9sh5
    v5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1752749289;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ntczUgl6FP060I1cgT9Akxwo0Rgup7JG1tLfr8V0JsQ=;
    b=bHMTTMrK+uNrkptvfuvdyVBBtNjvd0hvvVJ0/y3Use0GyxLX2FSibFO0x1qnpA4FW3
    R4EQhktBcHfyH5Z0KFMYKWEJlrCyKUWEB/RZXKrqVYDZ6ms1A292D0omNxAAB81pUA2O
    ZaahVYT6PVsz2ktZQACtjzFeh0LAxL6cLh1GnBbEan3kSPdcDz7Q7MnKYPd7HJQo5Eti
    IYORE0sr5Phhz26rc8bxAm58d7w0NwdBHTBhUsEO0z3UuXy0bOKJh37Jx8Vd6CQSFVOh
    HwwSfV5bjn1GI2HeH9cjrXYDe6YwczbNHK8zPx2LmoAHyX2x4QFisC7Xw1EizpodnFc8
    /Bow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752749289;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ntczUgl6FP060I1cgT9Akxwo0Rgup7JG1tLfr8V0JsQ=;
    b=EhGYpvi08L5vSZD2QAduUrERp7uQtrhUF8n0zIAAsS0iY20B0K9ly2lj1lglBqTQba
    JWo2FAptPN7UUzPqsSCUoF1Eak1ZPAMQYRBrsgMvBAD6jCRtr0z66JBLeTaFzUrEuSQO
    tYPeWYULlzTPRHjJM++FbvVQvKzCkvuZg66yaIzgHe8f8ahnJR45Q4affaIZ4znvwIxV
    DLGYMkPfGRYwRJBZ4b0hpmtncT48jd+hQ4lb5L/giLafnFoOXIsjLcHv3FdX3AfO1swC
    KTb1grGC6YHbRnnwT1DYx0EyfDClSusSZvKosYRdZRgqaupqMn/YYUsFE8iQRsjMLgx+
    2X9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752749289;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ntczUgl6FP060I1cgT9Akxwo0Rgup7JG1tLfr8V0JsQ=;
    b=xJ/dwwN3MlmHcCe62rt/Wjf8iwLi50ha0gxemTl6Z4x4b1OWS2NUwDRjmkL21pHgiw
    1q0kEru637mj0lb9UyDQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z1af2716HAm9FA6
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 17 Jul 2025 12:48:09 +0200 (CEST)
Date: Thu, 17 Jul 2025 12:48:08 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@denx.de
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1704590184.37166.1752749288838@webmail.strato.de>
In-Reply-To: <aHfDEgj+sx7vuTnf@duo.ucw.cz>
References: <261306466.197838.1752596058568@webmail.strato.de>
 <aHfDEgj+sx7vuTnf@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.19-st6, 4.19-cip122
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.55
X-Originating-Port: 36730
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Jul 2025 10:48:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19554

> On 07/16/2025 5:19 PM CEST Pavel Machek via lists.cip-project.org <pavel=denx.de@lists.cip-project.org> wrote:
> Most patches look good to me. I suspect "2c6d2af5bfee8 hwmon:
> (gpio-fan) Add missing..." is incomplete, mutex needs to go to
> gpio_fan_remove, too.

Thanks, fixed.

CU
Uli

