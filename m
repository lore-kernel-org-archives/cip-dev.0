Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB7DC4332F
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 00:27:46 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web11.7019.1669076856676275320
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Nov 2022 16:27:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=SmIA23Le;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669076853;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=ldH5nJGjsmiO1HYpR+wnz5tYt8Xz4qZ1YVTS6cMYCvM=;
    b=SmIA23LeN6dY0O6CGAp/YM8NjjfLbxsmgHpgJB5E2LL1Yjolo2PQVqmRs8fH2SLorg
    /mR55ir4Ns1kXEDuJhc4//2zJsJTcKXvZ9zxf43Z975sA3hf32Ttv4wV/dKHF9lmDVi2
    AjcHO6aD4RtGGw/dF8IA4mekTnaOptggdBXfOr4zpFA303ZQIi82NLy2SR1P0R8Ma0Tr
    J9DznjwCefQCRjC+/dZtvurATqo2bNkHla1sg2Uylc6F+B1g0USWkTVG6k/hHpmaMjaK
    9VKWgD6QAvG0B4DkvGBH/f9QX5prXybOtnNtOuIVb+u0/r3oyutWylKhwtmEoMMsaaqx
    vfMw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/x64jlM="
X-RZG-CLASS-ID: mo00
Received: from oxapp06-05.back.ox.d0m.de
    by smtp-ox.front (RZmta 48.2.1 AUTH)
    with ESMTPSA id y28384yAM0RXuir
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 22 Nov 2022 01:27:33 +0100 (CET)
Date: Tue, 22 Nov 2022 01:27:33 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <1082906324.934329.1669076853699@webmail.strato.com>
In-Reply-To: <Y3Ea4T2hx8Sq/CdK@duo.ucw.cz>
References: <Y3Ea4T2hx8Sq/CdK@duo.ucw.cz>
Subject: Re: [cip-dev] 4.4-st-rc updated with patches up-to 4.9.328
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev30
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 00:27:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10065


> On 11/13/2022 5:27 PM CET Pavel Machek <pavel@denx.de> wrote:
> Results were pushed to -st-rc.

I have reviewed the new commits.

"fbdev: fb_pm2fb: Avoid potential divide by zero error" has been applied twice.

Other than that, everything looks good to me.

CU
Uli

