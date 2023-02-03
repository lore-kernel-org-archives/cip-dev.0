Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F983C636D6
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 00:28:16 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web10.8858.1675384088216223748
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 16:28:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=pTMbufJI;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1675384085; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MTk3YAGfMYIYMP9ucZl2HJ9qPrZ6Zi2PopQ/Vdda21C2iZv/1qOayLbr+CUTcgsTPd
    Y+iaGzpL+WA4TIaJfzt3KOouRBbjQjEnDeevNuJb0SuZ9mYFBQc2882ZIyLKopVV5uXz
    9Z4JmUdZr+WymPnEfJYT/kpNS4Wdt/3sKWf6p10vBwc/gy+6fdr+GbAd6v122EI6pm7k
    YjJZs+AtsdwAZLj35PMTgip1HKC0w5kWkZz2fF58dAqv+/TCISmdDFPCxTKKiQdnguOI
    lJ+NwtnSOP9W+TslJdO4qtqm2zKtVYnvSXbRy9P2xdh8bi888rk9TiFFZiDOQddWk8gr
    K2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675384085;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=Q56YagouYbBhVmjz7FUnmX4624gFXsOx6uJr0H5z87g=;
    b=g+zJqC/rhEpRqnlZKzpQAVejalJbS6GXPhma2WryU/jpnjdan3dA/yVTrfBznGD/lT
    UbMwmga7PbZ3gpH7Ugphm+UZ5O9FvPaPj9AACTGeBy4ax6if3yAHKhbhhd6B5tmRHkYA
    M0u5tzZsvJ2NxY5a4UFZzKWzac2iq+o/LFDqhd/gv1lmLrKP24huYnzZPygPxDJ6PeND
    f3RFxyayEkrqb5k2EFVcQz4xdnjsmGBMkfS/0JYKLVh20rMK7a55PJpyTQaf5tRJhMEl
    CygFUr3nv+VegI4FbWcRGzIa85dJ4giqPAZAs8r7UQOM38ftbX3AqbySSNa3ZaTGzRGY
    aRxg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675384085;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=Q56YagouYbBhVmjz7FUnmX4624gFXsOx6uJr0H5z87g=;
    b=pTMbufJIFEDgqdHyaXM95+PFQqBITST8cqSi+5XL1zRS3zwVaxXywI0dk4badC8kKc
    ozYZ1yQtoZBYzOd5Ign7ZuDsJJs6WrnM8QtCzk7cv6pO+1xyEzlUsTNBCfp3GRhOeTlc
    4sEYTqO5VD9orHSs/Np7FZCjg3UtCi64Losrg1ySFvaHxh2myVV4KHvACjWEsxhVizGR
    i5eeNCYAPX3TUiyR6mltxw6pkj/mmbJgBmXc/zQVXe7y5KI8UdDaW776L14yD4SAVQfc
    CEJOkuBjUvph1ke4k6JkheghQaljuS+qrEL/2dtLp5oWA3F/C6ZTOnz45Ug95TTqtGtY
    bZ/Q==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w6F/Yo="
Received: from ox-live-app301.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.2.2 AUTH)
    with ESMTPSA id vd711dz130S5Zwc
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 3 Feb 2023 01:28:05 +0100 (CET)
Date: Fri, 3 Feb 2023 01:28:05 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <1029873527.2137970.1675384085804@webmail.strato.com>
In-Reply-To: <Y9wV43XxIeT1vMP3@duo.ucw.cz>
References: <Y9wV43XxIeT1vMP3@duo.ucw.cz>
Subject: Re: [cip-dev] 4.4-st-rt update
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev35
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 00:28:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10576


> On 02/02/2023 8:58 PM CET Pavel Machek <pavel@denx.de> wrote:
> I'm beggining to update linux-4.4.y-st-rt tree. At this point I should
> be merging linux-4.4.y-st.
> 
> Would it be possible to add a commit on top of linux-4.4.y-st,
> increasing localversion-st and adding note such as "tree should now be
> up-to-date with 4.9.XXX" to the changelog?

Done.

CU
Uli

