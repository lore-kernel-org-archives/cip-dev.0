Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CD9E77188
	for <webhook@archiver.kernel.org>; Tue, 24 Dec 2024 06:46:59 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web10.29302.1735022803548110330
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Dec 2024 22:46:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cA/dVzRd;
 spf=pass (domain: gmail.com, ip: 209.85.161.41, mailfrom: stephenecker240@gmail.com)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f4d935084aso1790015eaf.2
        for <cip-dev@lists.cip-project.org>; Mon, 23 Dec 2024 22:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735022802; x=1735627602; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cUXWETYnLxn8iJK11N9A+1OYJQwGC0d/BnxNzhlMB3I=;
        b=cA/dVzRdVU4rg074Mrnz05qoHIvef8k1RJzx9RNVs2LNeHqs40ZbBmakSFuGw1Dzpa
         T2JhaHNkO5sLSRwRkigKCkjWO1fRqQkN9XDSdT4yRHzLivPsz+UsqccyAXy9TVPtE0L3
         Yr1hOnH+lVvWq/RjBy26Nto7NrnPXKVaS048fROHUoAvw6HezYg/mcOOgr/7CFqKLGfM
         yog07c0AUexIwyBipFL6ABdBr3ztlh4vyUTYZBl6CrvPzPXNDLARo0UhgmBPYuI8q9Wm
         qayVXAOmdMcgMkpV7gaU7c0oPyoWfZIzcaWb6QGNrzlMpM3fNU6v8OO+hQML8TsKOtZb
         YULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735022802; x=1735627602;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUXWETYnLxn8iJK11N9A+1OYJQwGC0d/BnxNzhlMB3I=;
        b=DN46McppStr1tPoiQB7WVl34c073diHxMo3pv+n/okMl/5cT/ll0uwOkVXbThRH9nM
         Iv5CYIvhhLpk2oIWWpBk7wQ7BNejl9czraIfCuJL2NlgcY9B4BkUYrWgOIRm/qsBJ0ak
         XUk8MPXB7Ncv8NgtSaV/WdMM/hpvDiCb0fkQWzbuKxVN+TJMIaKRQnfFa99t9Lt/Qo15
         1BVvr6fDbJXh0NmSOJQxLqB306IX7iEejudKF+nVrId8J+zGTOB/nLjzFi+/Y5H/WCQA
         gtXL3uMLSqjKCLe/uSriGrEihsGRThxZFA/7YisVT482Q11HSUXPOf1PXYgE89kJz4ZO
         Foow==
X-Gm-Message-State: AOJu0Yzkmr4RPY4eig/AWYxjfv2hVD0Qe8EIwHBxvNE/bkSckkv22JkC
	KWKoZiox8e1fzNt2i7o0sdzn5hZSNMWdgmqkhWT2EcVEP7qPxtnTeVqmxACZ9KfbR32VDCqzZIE
	Wgye6PnKQHZBw5R/lzUswnBIy5gFzmw==
X-Gm-Gg: ASbGncsxL9D8f06fw+I+M97Lxj5cXM89vn6h1nRibVFsW2RdmabDDdsv7QEnUdTRf0s
	Rz1VyE2aH0LG1PqGx9/rl85EyQMyXOM72FEqk
X-Google-Smtp-Source: AGHT+IEiToiRHuKxlo7rQjtCragcVLhN50yf1sWkjqozhk5Txquq/sk3uoZmpDVHPCiilqWBunjYmdHFxT97MCDy8Rs=
X-Received: by 2002:a05:6870:610a:b0:29e:3de0:d400 with SMTP id
 586e51a60fabf-2a7faac95abmr9625306fac.0.1735022802066; Mon, 23 Dec 2024
 22:46:42 -0800 (PST)
MIME-Version: 1.0
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Tue, 24 Dec 2024 00:46:31 -0600
Message-ID: <CAK9C7GA60Zw2d4gApaRi5fw6x5G-XTn-6m8bi6Q=2ps2Xyp+Qg@mail.gmail.com>
Subject: efibootguard kernel missing squashfs mod
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Dec 2024 06:46:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17493

I am using squashfs as.the read-only filesystem, but the kernel is
lacking squashfs support... is there a directive for defining modules
which need to be added to the initramfs when building a unified kernel
for efibootguard (I am uncertain which parts of that are relevant)

thanks

