Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A713C4167D
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 12:10:37 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
 by mx.groups.io with SMTP id smtpd.web11.29074.1698927035549342234
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Nov 2023 05:10:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=ssLlfU+G;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=dlhfWqV5;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.163, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1698927013; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Xdl1c3u0vUe2a6yDBCDLlu0bRUSgUTl03JXFzmb8weNz3KynHQWdTXxDiXE7FflNx7
    1DWufYmu/F4G+Wp6itFJ1v04RUlMk5MI20bL5eVZhDR9o3Oa7Xir/uuruS7hvjx2p87P
    4dNrioJts81wxhEpva5XTmRvzESRar7oK1ExLx4fz+5wruMiSCkeX1YQodlkKopc0eJq
    PXtVcXGYiEhr/6XKp3ifmlYHtqGvDFLXz/7ae1l9SqmnktDwWAZQmZi9UKB5lDg915M2
    PaZ+eZa4T4I5gyy4NowLknmtcoiEMRXTO5Rwqu8dm/YxkKBuzTNNp3WQyAbqVP8Ukt+F
    HLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698927013;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=DmPR98J7AYzkJw/516OXpToks3PP7DcpA2+RkkKqakg=;
    b=PePPBxmFzlK2M2MRi/uGk1xZosB35FjXG4exo7tL76l96TWENI5WnS0rW0pScnGgIZ
    fa1jPz70MaX6LabzqUyJsZeoFs5HuG1joUIqpo7Edpc1AK4EEhg92q7ndZhtMbHPOwjm
    6/VesqYUnhwZqE9zZc6mvSCE0yAV71fMnHwO8zx/SqAtcXHDUdLrrDMKkA9HNngd/GEm
    0/RstoMNJ/7O8sS24fAog6S6i4XkuPKMlJniiiu5hI89aZvlY8LKXeP4JkRFbS7V+47L
    9DtLTwNusfj0ycYHln53y3CawaFgFVAT7uRogZz2xXLHkZXGicMkzmSlsvSHzOWSmvHM
    j63g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698927013;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=DmPR98J7AYzkJw/516OXpToks3PP7DcpA2+RkkKqakg=;
    b=ssLlfU+G41WAS2ndOw+d9nZg5JeyOI9NA3e8Dfn6YNc3hdpLh0WWSQ1DkyCH5dGIsL
    hxFQluPIeRM4HM7RzwETNof2lB6veLu6lfHMB5M0nRm9Zm8n7Tx5jsRLmVtkM1iRxWHw
    lYIYeod+LnuI5vIrzbUP/ThzkJXpo3dos+buJcHPJgvlIvQFUPUpA0G/hSCRt831JBGV
    6LX3MsTU8LYvJJCILomormNT2AfeUNNvLcGBNQx9QIsvrA/3w8nSUof+kEwX7Ddgltll
    R7lsU6+D9q4ljUr9sYOEXg+SUAQtdlRxSrrdtqKpD8qMrqmXe+8wRhmabpbnnEr5NE7N
    W6VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698927013;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=DmPR98J7AYzkJw/516OXpToks3PP7DcpA2+RkkKqakg=;
    b=dlhfWqV5h7wtvRtn7q5GDb12mJ69fTk2xw1P84sJ0SYnGdGdOAjkK56OZzswUprCwZ
    xviOPj1Ljj/EVKUpAGAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/x64iFM="
Received: from ox-live-app403.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.9.1 AUTH)
    with ESMTPSA id V6209fzA2CADQN7
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 2 Nov 2023 13:10:13 +0100 (CET)
Date: Thu, 2 Nov 2023 13:10:13 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Daniel Kirsch <djkirsch326@gmail.com>
Message-ID: <1505483843.19257.1698927013236@webmail.strato.com>
In-Reply-To: <20231017225915.45448-1-djkirsch326@gmail.com>
References: <20231017225915.45448-1-djkirsch326@gmail.com>
Subject: Re: [cip-dev] [4.4.y-cip, PATCH] powerpc/prom: fix build
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev54
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 12:10:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13514


> On 10/18/2023 12:59 AM CEST Daniel Kirsch <djkirsch326@gmail.com> wrote:
> 
>  
> A missing include generated a implicit function declaration error
> when compiling for PowerPC. This patch fixes the build.
> 
> Signed-off-by: Daniel Kirsch <djkirsch326@gmail.com>

Thank you; queued for the next release.

CU
Uli

