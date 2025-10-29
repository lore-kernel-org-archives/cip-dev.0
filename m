Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05486CCF9E9
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 11:06:57 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.web01.3844.1761736013148611350
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 04:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=ac8Xos+D;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1761736006; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E2wW8eLlDAip2cji2jHrvV1zut0sMr7qDlw9NwyC+ikMw83I7V9cbrLsTMdbz9nRgk
    uiZ7qAzBrR2b8qlgPJn7SISg8t1FOqAlseGn4NmFrGmXryJClP42tlzHbk9++eNu627X
    yBR4bbPH7QoIDiayjl4JBxedkV/usbbCgu7aN8s6D2qTIifNICegv7rPEpy6tLFPVJ3z
    jkrjpAt0GjQrJTiQT3sSakVZlltkOIp5zq8EB2/I1OyUBMuCo34DJL83mxQH27dHQU3/
    w7BQjoVaVKnU/v26PmOejeUwuWQ0hI6r1bSiPsL+4Q/56q1Bz4T1Gwo0o+1PMwrHp3vt
    QwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761736006;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=0z1CTKnDkBlo/suxO/GNcZW/6VexS8bLi5dk0qss41Y=;
    b=qP4i58WTC+Hk1/Z2Mr//g2K2GJQY4G4u+p2OO8cAQojzvES+oiKkGI8L2m8p7vhFIU
    dNy9oz31C9yvqHbDvEY2gtoki8P4idL4kpzxUYx1JHOOWajK7KyZPts9KhiBxWs+orRC
    bfWKKR9TjcmTEZB54y1fwPvLKllgozB5lnOLW603SR3oy7T92qPP5HVw3Z6uc2rj3ZMF
    ivOnRc9v6/amXyK05apNhB2fFbZJFVk8Z2nGxRF33vpiHJ2U3Hqc13KX8QIwmZlIqQXX
    XKekeMA//YRM8NS4HmWDBvBaUXhPjZ8lf715Pkve1a0HXg+PUSOBPNnasn2EjbQf/Ete
    xE+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761736006;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=0z1CTKnDkBlo/suxO/GNcZW/6VexS8bLi5dk0qss41Y=;
    b=ac8Xos+DTCcuwv4Ra9DLZmI43T/pRKbN9WKFuHbeyLZyI2pC+yw3JMo50XF59LHQ3B
    0HRXTNZs/krM0h1Imh9b0yhRu2cWTxypnuy3mncsGfKeWQ10vp5GDdPY0GM4uWDiNnG6
    +mVkxU/e/kPtqoCZECoTD+ocm6sA3QEnCh1wHx4ztiYceXBnE+QL9Vchg92jfBnzMjHG
    selDVhkXbjqwxoOfGsIr8l6wfnt6VYJoBs1Qc5wb+CNPCZ6KO5L3m/WSLZSpfCo1ks2M
    IZ6PtsCYdjL3JcYLFgcsp8GgiEj4F6epC4zget+jY2FZijhr3QvbYSVWw3frAIWPH7ZS
    NtNQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHG+OxMWg=="
Received: from open-xchange-core-mw-gw-36.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 53.4.2 AUTH)
    with ESMTPSA id z2815319TB6kGq7
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 29 Oct 2025 12:06:46 +0100 (CET)
Date: Wed, 29 Oct 2025 12:06:46 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	"Nobuhiro Iwamatsu via lists.cip-project.org"
 <nobuhiro.iwamatsu.x90=mail.toshiba@lists.cip-project.org>,
	cip-dev@lists.cip-project.org, pavel@denx.de
Message-ID: <667154897.130105.1761736006462@webmail.strato.de>
In-Reply-To: <TY7PR01MB14818DB1B8949574A3367636DCDFAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1483065062.11009.1761645498941@webmail.strato.de>
 <TY7PR01MB14818DB1B8949574A3367636DCDFAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Subject: Re: [cip-dev] Request for review for 4.4-st69, 4.4-cip104
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.93
X-Originating-Port: 44176
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 11:06:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20275


> On 10/29/2025 10:15 AM CET Nobuhiro Iwamatsu via lists.cip-project.org <nobuhiro.iwamatsu.x90=mail.toshiba@lists.cip-project.org> wrote:
> Thanks for updating 4.4.y tree. I reviewed this series, looks good to me.

Thank you!

> BTW, could you apply these requests?
>   https://lore.kernel.org/all/OS7PR01MB14808FF4B6303383C05F05D27CD00A@OS7PR01MB14808.jpnprd01.prod.outlook.com/
>   https://lore.kernel.org/all/TY7PR01MB1481806DFD83FC78B45EF2CC9CDFAA@TY7PR01MB14818.jpnprd01.prod.outlook.com/

Done.

CU
Uli

