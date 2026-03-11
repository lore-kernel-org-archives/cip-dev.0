Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A2103E2EA
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 22:28:03 +0000 (UTC)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8964.1773268073806907349
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 15:27:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=kn/4shxz;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so388575d50.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 15:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268073; cv=none;
        d=google.com; s=arc-20240605;
        b=QCojUb28JkthsvGzk7fsJ/8/7YWRybkQ5k4njd0/Zy55pQOyfNzAmMND+28W8bLws4
         JOkNkvCjNFQv016Z06ZqPpml2qLXdUo3DN4E+FmC5alFWiRTQquJPVQylmjoSfbP0X4u
         GbYdQFYVDm2dmCwKyflKTJyMKsJnmbH9qWCLhfPA6dAgOkZ4wsgUoJ9o3MSnyt+xW/Bs
         3IpudsDnwko29fv4xT52VkYFnPSQTB7FQng+vuRe3Qt8pb4QplW89nlt4Hpd8Ds0biD6
         FeGPQdx9Pzhkoz96u0wgzATK/RISIrQMa4QReyRaBw6pMYIkGcCbPk2mlD89PcjroDZq
         W7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4nlWwUUuiNRdLk9g8QTgEqi1JJoGFGXBUzQ8UIlxydE=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=HVUIi/rzcWRhzX959O3kPWtNyisNqnsRDSzh1/ktyu3f+TiDr1vJevC1PF/H9iKxb3
         EdpJDv/5jPMzVoMdptt4Hl4pBV6etEzkh7AYCf0PPNjGUvxeO07EDRMYM9QcgVCRddfP
         IhumrYWT74vfviaha9MVnlkJiYd7rx3NvKcslQO5fmmcSEXE7UOcf3RU8HVQ5gETB9XZ
         hMWLvdx7Yve75IzYbmcs4yz7MjZPu/2jKwXCb1EIHXRJzRKBq/Al+bPmiE7C7OMzMaR8
         jxih7Kt+XMDUO6Wc/qY7/U/rX0a9IWl/4xqZZC/Ht6X1zIfoFrYHEcf2LJ17dxQ6vI+6
         pFBA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1773268073; x=1773872873; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4nlWwUUuiNRdLk9g8QTgEqi1JJoGFGXBUzQ8UIlxydE=;
        b=kn/4shxzR/FCoDGfZnQdcoeaJr0iwGLIuCwi5aOUOE4AYbprPlZEgjRSWshfwS7BJ+
         fFOyE+5CTIliLrrB4noMxuldeJBu6OHuX2PRJ1Dhf+Egd2YhWREJoALviWQ8KBCOUq4W
         dFY6Qz+WcyH2EO70scV/T9UzIZLZEALM7oGP18NONICrLExM74amFFP5JFtwinNHUw3j
         4Y08qX3b9wKAzK8yvTw5gu7vJ7WDmurmkA1q+L/SBu4amyOOMbLYmNwmOgjuViNlb8f7
         c2x/ombw58sFqmcPExqbuokYVh5KPOJUiTYCurFtKLUbEv9gdhbita+jFm79Xot6cGeR
         eyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268073; x=1773872873;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nlWwUUuiNRdLk9g8QTgEqi1JJoGFGXBUzQ8UIlxydE=;
        b=oLzUaGCzxA/ty9BExrmlahCH8e5HszU616ILlwvSCZazSil46hNs1w5sVWfiBJR+ih
         8Bci92tsoOuNW5vh6GmNHlMQJTNvFB04uxDLqC4xIoONRUM9M5pxWmEwNjsdXimTIT8M
         +32M0d77JEAlV80gvkLk7zBK6BRmrEjBDsGUVAiRfSyj++NhHz2BXanKEWU3ks5uu67E
         Q2z0gMi9I5WAJ+uyFkwagGLXh/3RhGyGFqmK2Ih60640G/3dRbGBy1JnjEGiodYo+uLF
         zB5TRmPsfFhUdP9cYCDXIgGY4omzfjNFAIdCN/uqmhWtaDCfzDnDwvq+uMtu1OV6VsLF
         8V8w==
X-Gm-Message-State: AOJu0Yz4hAYXJIQelYrhiW/k8Mfhbn935+URgjxaIe57FiY+fXeFo5cJ
	cFK3sekH+2KBkeWTJFznCiY7UI1Bwa50uroT79GhOjAbbrxf3otP0L2iBkRAfpvD7ojl6bl+ooC
	cD+BAfIsIJbFkOO+2WmEMPEYCD+bY7ioFTwHvuzjqLhnevtnc7BOX2IE=
X-Gm-Gg: ATEYQzyMr0BCxsX/nCUOYQz+LTpWSuQ5jGyt3s4ZldP0IldDIMbf3obm5qWXeYUn/3k
	SoQ37JsoLIsOT7quYYr+TMcBGNlJnMF9oLdxUNZCx1W9ZVdYQ1IhsxOwrLJiIxxpV8rBIjWzjCe
	9q7VnxZhj9JYmEXdn2FREq4es4NsUkQe42diRA1Wp3+9am78zu/cg16vOol5+j6FFLBYS6cJ1nI
	sYzOu3e4wBHYrYvaSufXFrBhtzcWdBVI76XqWB0ua9nBIQb0LK+ALM14W2Dn+ZkPyiz9zZrofpC
	MNcpTpEa
X-Received: by 2002:a53:ac92:0:b0:64d:6cf8:fbd with SMTP id
 956f58d0204a3-64d6cf81c1dmr2051875d50.67.1773268072730; Wed, 11 Mar 2026
 15:27:52 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Mar 2026 07:27:16 +0900
X-Gm-Features: AaiRm50XPy96R3fngJOgljqpXveusa3SyoGP2XgT5O-VCARzWlQ7SjfMoV8yZs4
Message-ID: <CAODzB9pmLzHyTxmSSgKSLN8u=C6hXv0E9D4NMgaX-s45V8SeBg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 22:28:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22345

Hi!

It's this week's CVE report.

This week reported 3 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2024-14027: xattr: switch to CLASS(fd)

Announce: https://www.cve.org/CVERecord?id=CVE-2024-14027

Introduced commit is not determined.Fixed in v6.13-rc1.


Fixed status
mainline: [a71874379ec8c6e788a61d71b3ad014a8d9a5c08]

CVE-2026-23239: espintcp: Fix race condition in espintcp_close()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23239

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1512c1db9e8794d8d130addd2615ec27231d994]
stable/6.12: [f7ad8b1d0e421c524604d5076b73232093490d5c]
stable/6.18: [664e9df53226b4505a0894817ecad2c610ab11d8]
stable/6.19: [022ff7f347588de6e17879a1da6019647b21321b]

CVE-2026-23240: tls: Fix race condition in tls_sw_cancel_work_tx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23240

Introduced by commit f87e62d ("net/tls: remove close callback sock
unlock/lock around TX work flush") in v5.3-rc4.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bb09315f93dce6acc54bf59e5a95ba7365c2be4]
stable/6.12: [a5de36d6cee74a92c1a21b260bc507e64bc451de]
stable/6.18: [854cd32bc74fe573353095e90958490e4e4d641b]
stable/6.19: [17153f154f80be2b47ebf52840f2d8f724eb2f3b]


* Updated CVEs

no updated CVEs.

Fixed status

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

