Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A2C433EF
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 09:04:35 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.25])
 by mx.groups.io with SMTP id smtpd.web10.8222.1636621473979855399
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Nov 2021 01:04:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=DnLs6A9A;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.25,
 mailfrom: uli@fpond.eu)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636621462;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=rmJY+dvCpHonjSOAbeUD9RvVTITbPoI9bLVuvLr+5R0=;
    b=DnLs6A9AzO1fpzhNA/uJk5WyyTn6fdvOCKTxpiYysl9y6GYTk82icFwUMIkfqFxwR4
    daCq92L43avHwkl10AxPhpjX35TWfCZLpQpF0Vnmej3Io0buJtm+a/JMnS1tNbB5UZ3F
    VkLrmF8A0tvCyWWr4aO7M7feQo+3mvfWMgkUwL+p4r7YMbmAUxj4GExIRq3TCtNaZp+B
    0XebMRPwTV31K38bbSq3PD7+79PhkRMyYpj3WAx0TFeBtd9k+qXphv+wvwYI0JsMyDj1
    F55XQIuTxdw0AgsWUSp6wAT7VzE6LLdS3gWQ1YwnJ48sF/27zBiX4I1V8JfBMtLIcVRd
    Jtjg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2qthug="
X-RZG-CLASS-ID: mo00
Received: from oxapp03-01.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.34.5 AUTH)
    with ESMTPSA id R03b4fxAB94M8zz
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve
 X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 11 Nov 2021 10:04:22 +0100 (CET)
Date: Thu, 11 Nov 2021 10:04:21 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, pavel@denx.de
Cc: jan.kiszka@siemens.com, masami.ichikawa@cybertrust.co.jp
Message-ID: <1047231455.163841.1636621461970@webmail.strato.com>
In-Reply-To: 
 <TYAPR01MB6252AE15ABA567A3301A9F4992949@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB6252AE15ABA567A3301A9F4992949@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Subject: Re: [cip-dev] New kernel patches review management
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev27
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Nov 2021 09:04:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6875


> On 11/11/2021 7:29 AM Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
> I considered using the gitlab wiki to switch the current patch review
> management to another.
> 
> The gitlab wiki can be used as a regular git repository and can be
> viewed from his browser by writing its contents in markdown.
> 
>   e.g. git clone git@gitlab.com:cip-project/cip-kernel/linux-cip.wiki.git
> 
> It can be created using the API on the project wiki[0]. Since
> namespaces are available, we can also create hierarchies such as
> 5.10.y/v5.10.77 [1].
> The wiki page is first filled with the commit ID, then the CIP kernel
> developer writes the name after the commit they plan to review.
> 
> The commit content of [1] is an example, so please let me know if you
> have any opinions about the format and others.

It would be helpful if each line would also contain the commit title.
Other than that it looks good to me.

CU
Uli

