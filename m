Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E4BC4332F
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 19:04:14 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.24262.1670785448730658157
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 11:04:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=erSzyJ3Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id m4so9923989pls.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 11:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=91LYgyyJpQ9RwN31lQ4Jglo7z3Jq4+ZhM0dE3Mk7zIs=;
        b=erSzyJ3ZzWt+gRvZe/6RLaoy5Y/keMekNEi1pK/aSVlmGLcRYMYpcZz+6Dwh+4Givp
         Tpz9nlQA2utE8l+u0TkeVByb9FeQizMyzj4CfWzqVSvFW7HeJD1GsEgFTA5jDLe1USXw
         IrwVHg3v2f3MfDzwI67XVe6Zl+jhNf+Z79O6Uis8rtr1ac1Wm6C5qEy3QTdpPvbsKnH7
         N5PQGRB0VmdLsfzUxnyv8Luhjx1z0wCo0BZxgqe/X7o65ifUc9kwDWxvDt9Tk+PR0RkJ
         QPkYDQ9nwu6mYa+NtqD+xjBSdLv2Ler9lNGsAaJzHHcTYvunDEr5AL8c9ZasSrkgVY4D
         //6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91LYgyyJpQ9RwN31lQ4Jglo7z3Jq4+ZhM0dE3Mk7zIs=;
        b=po6r9U7CXRhFz1Zsyx3uuJqERStqGHXMvMDu+1IND5d+4Hi9t6brH+Lr4P8zXGktOu
         AalyhdTeACHPNJ1pAudcXOndyHRQlUNrufQ5RzyiEcyYI0uVZAb4UhOv3aYpZyRMPC1c
         jCyKOlhyh4nkfBZcdFNVnlQRdIx2fUrAtlKxJVJ8Hx8nCKFOtpeKCUctrGU49/5nrANj
         WRFqvFe8NZHKwDYE9mmVn7p1T+lrLLoG7zzL0Q7louk7/9u6rHO0PqhGQPbD9nO85IgE
         vntEsVqYhjg9YfgHJJPZW6pxEiSVNveR9tu/EfrWSLGyc2s1HfBS1v8XKt0gLt7cAYuM
         U/zA==
X-Gm-Message-State: ANoB5pnsOaoE0LAHkO7Gi8cx/7LYCIEU1/jpKgAcDmloLxulittHD91L
	kqikQWhpSoQ/EAizxJfyBR+BEO6mvjsTffto
X-Google-Smtp-Source: AA0mqf7+WDyOvQ/5WT+gYXgrIMefTu1rAdifrWldjkRxMVMNkqPntTngP3Vb00oN4Omo0DBqDRo3QA==
X-Received: by 2002:a17:902:cf07:b0:189:e577:c83d with SMTP id i7-20020a170902cf0700b00189e577c83dmr15481980plg.66.1670785447616;
        Sun, 11 Dec 2022 11:04:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902f15200b00188b5d25438sm4685453plb.35.2022.12.11.11.04.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 11:04:07 -0800 (PST)
Message-ID: <639629a7.170a0220.92113.7e7d@mx.google.com>
Date: Sun, 11 Dec 2022 11:04:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.158-cip22-435-g2c52868ae1cbc
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 4 runs,
 1 regressions (v5.10.158-cip22-435-g2c52868ae1cbc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 19:04:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10202

cip-gitlab/ci/pavel/linux-test smc: 4 runs, 1 regressions (v5.10.158-cip22-=
435-g2c52868ae1cbc)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.158-cip22-435-g2c52868ae1cbc/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.158-cip22-435-g2c52868ae1cbc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63961b6c4aa13174c22abd1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-cip/smc-r8a7=
74a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-cip/smc-r8a7=
74a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/63961b6c4aa13174c22abd1d
        new failure (last pass: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

