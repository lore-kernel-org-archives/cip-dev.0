Return-Path: <SRS0=qG5w=4H=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A8C5ACC4
	for <cip-dev@archiver.kernel.org>; Wed, 19 Feb 2020 22:56:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EFE206F4
	for <cip-dev@archiver.kernel.org>; Wed, 19 Feb 2020 22:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DMBjuOIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EFE206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 679BD20773;
	Wed, 19 Feb 2020 22:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mXyuDD1PodWN; Wed, 19 Feb 2020 22:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EEF6220764;
	Wed, 19 Feb 2020 22:56:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2238C013E;
	Wed, 19 Feb 2020 22:56:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07A5BC013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 22:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DA6F920773
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 22:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4JmzkzGyL3LO for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 22:56:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 7645720764
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 22:56:26 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id v28so31241378edw.12
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 14:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=lc4SWhs6kSVKsXfCWDBM62zpdwNWwzO6momKZtUBK3k=;
 b=DMBjuOIQ3ma464X/1vzPZ2eQjo8FSgUuSy8orC8FMLXUYeO03kqVpgYy1dGPCClx30
 Vw5M1RZB9BvJUKYeo2JhOlSMybOUFFqh3AyMXlLcZuhJ4wQzTgQpb+5ZdVhJRYTYaGhy
 HEkLygx5hjglwRMW0orcD01mGzVZwZwpmhSZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=lc4SWhs6kSVKsXfCWDBM62zpdwNWwzO6momKZtUBK3k=;
 b=CEUbad0aMyunF357nATtOnEP6zsfVQ0v49x+05OkFigAI19JT+RWwvAdqgChtT8IEC
 Mqprbe4tlL7rzqRz5yGvwcjUMH6QLiZu4D/r9fRG/jH2TGNIjUoWCi9Dx8Li9oqkxC1Y
 SXSXa916Jlue430CeYmBRkq+byxWHyQ87PPmVf4gw1quHwIS4os2tddE6iw9h4f0Bx+J
 VZ6c2p3Ebm4fkgRridPIDkkeYdgTmMHuux518ZUJV8UVfvGOb+qU8lnz731U7KYQhUXP
 Ti5WzcdQCFO4Nh64TqLSPdD/wG7BfLqOOM6O91rxsC6nN/uT+jUbTzL3vR13XMXAY7ls
 zmqA==
X-Gm-Message-State: APjAAAUw9ls2n2glubg+nAuMF/k3HdfWYWIsnNrLZba87dWCzht9DOPN
 bFjUT8Jk8mgchsissdKkzm+EVbPGPrEdqw==
X-Google-Smtp-Source: APXvYqx26+/v0FV8U4yk00jcpGTV2XFoK1MwfDCpexHKVMb4Z2fcQJyJ6Bu+axM7LUuzcNiIZ8zdEA==
X-Received: by 2002:a5d:610c:: with SMTP id v12mr36302624wrt.88.1582152595485; 
 Wed, 19 Feb 2020 14:49:55 -0800 (PST)
Received: from chatter.i7.local (chomsky.torservers.net. [77.247.181.162])
 by smtp.gmail.com with ESMTPSA id g17sm1803872wru.13.2020.02.19.14.49.54
 for <cip-dev@lists.cip-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 14:49:54 -0800 (PST)
Date: Wed, 19 Feb 2020 17:49:51 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: cip-dev@lists.cip-project.org
Message-ID: <20200219224951.eoib5fie3g5epqg4@chatter.i7.local>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [cip-dev] This list is now archived on lore.kernel.org
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi, all:

This list is now archived on lore.kernel.org and is accessible at the 
following URL:

https://lore.kernel.org/cip-dev/

Best regards,
Konstantin
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
