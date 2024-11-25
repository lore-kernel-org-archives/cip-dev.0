Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAA3D3B7DD
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 06:03:41 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.web11.12972.1732514610379049189
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Nov 2024 22:03:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=F5cH9oH2;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=A60+LQq0;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1732514608; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TJRx++wvXDOyuq4x1w4CSRofKeSpev1MJtqxGnHgsWBWbsi4RAJMaLTNP54dHRRuOl
    KeLnmMTv8ClNZh74UD0McM4URT/Cf5aWEn8Lf9HS4oKXZW4gtGK10RSXuUs0vX137Cto
    dDAdKEEb8ZzUzfL7eXm1YXgp1BFI2AZLTqmESeZZ+JQ9M/vMIX0zjHvVTqXPN73wFXR/
    hikK1oKNi84rCidC6yRTIF5pukOSaNNfbmMZ1J+7DYLy5lGe107KMMn/RyCGwnIuvSUe
    a5iFJeEbhf/iz2M9XXKGzAyyCJJROOVkI9nbZfRm/ptFoWoj+eBo1CxoiZZ2gyA3CdDt
    7HZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1732514608;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=g/WQxduUFP4Irck6yPxEiWSK/9T03FI1A/31OfbQKFM=;
    b=iBjs1enOS41TT8KpEPQG5eU1R2HkvaVCnKAq/oLUmEtHBWill9r2g3u6LnN0+RLeOn
    WAY5n/j0iLe9vgKXIjP4iFjkQVPRWqS13DztPqzzn7T6nA0CQIia/IpXyhrJqdfiBcHT
    HikCGkCrVDcJJ/nh84RUP6x9bIBggnjE9T91/fD1cidcnrhbhDsqXB9X4P1GOujh7qmK
    oYlmPptDHSAhXVFz2WW8FpTj1PzjdQ00m6Sfo4q6nDTkH6LIV0CvfLSyR19Q0RunM5oH
    GTky+9SnT5Aa6Vr83Tq1YyYD2lmNLa3VWjlZJrt7KYENRAdFXhxNWXSd+8+BTW0jm6/R
    HccA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1732514608;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=g/WQxduUFP4Irck6yPxEiWSK/9T03FI1A/31OfbQKFM=;
    b=F5cH9oH2GYVqQrGO73a1Ro1M4do3B83nL06L91oe6Gw2Y+k0tF56XPuLHDFHjQS1Vj
    WtricHW3joWY2BikH0QbxjsHPDf2uGueWlxidTwxpLjbk5hgHiRnL1tLDTXMBFRUWpkV
    pfpu49yOTzA+T76ifJ8w3Nj/tjbWv3BRji+TGfsuSuOkfMQb+Z3MYB9+idkZY5NJCRzh
    qS1/6TnPJfLI/jCxEVmd90bEGjjuJgVTmggvZglKnWuRPzyE+iAYxhfHG5wDCVm8vNhO
    9Rlvk8pdWgKayvXhDEI9hCbESWySJR0nv6bakFJ69f57UExfg3uj6dGrPAQLtVcriYoY
    frtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1732514608;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=g/WQxduUFP4Irck6yPxEiWSK/9T03FI1A/31OfbQKFM=;
    b=A60+LQq0qgcS0gNGNY0q/1tBgdjc3hM4QJCPVMrtHEFHowbaKIOmU8yMsieeP49ZSE
    TG3MwoSZ1VJzfhIgWVAQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRNGvSKC"
Received: from ox-live-app405.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.11 AUTH)
    with ESMTPSA id z9fbae0AP63RSML
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 25 Nov 2024 07:03:27 +0100 (CET)
Date: Mon, 25 Nov 2024 07:03:27 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	"Nobuhiro Iwamatsu via lists.cip-project.org"
 <nobuhiro1.iwamatsu=toshiba.co.jp@lists.cip-project.org>, pavel@denx.de
Message-ID: <99279748.5465964.1732514607943@webmail.strato.de>
In-Reply-To: <OS0PR01MB638844CC21AB107A78268D6C922E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <1048687374.465216.1731913250080@webmail.strato.de>
 <OS0PR01MB638844CC21AB107A78268D6C922E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Subject: Re: [cip-dev] Request for reviews for 4.4-st58, 4.4-cip93
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev69
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Nov 2024 06:03:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17270


> On 11/25/2024 6:06 AM CET Nobuhiro Iwamatsu via lists.cip-project.org <nobuhiro1.iwamatsu=toshiba.co.jp@lists.cip-project.org> wrote:
> Thanks for your work! I reviewed these commits. There doesn't seem to be any problem without Pavel's comment.
> BTW, could you also consider applying the following patches? These two patches fix the build errors.
> 
> - https://lore.kernel.org/cip-dev/1732007374-15710-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp/
> - https://lore.kernel.org/cip-dev/1732007030-15207-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp/

Picked those up already after the RC; sorry for not mentioning that earlier.

CU
Uli

