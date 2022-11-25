Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E069CC4332F
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 08:52:26 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.43139.1669366341143578846
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Nov 2022 00:52:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=8FD2HAzB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id 4so3456772pli.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Nov 2022 00:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AAFDLEyO3E0Yq/UDJfa2ScAWRNSc88sRN7kKLm3eYSA=;
        b=8FD2HAzBb55Ijt1HxDH2HGQXTBRpYzQeoDZQjr4BBPRzDnfVHyQIOCx7WMQUOQCsZI
         Pi0KrgHELvTyweSIPzsHz6DHEuuixHreEbb2CYyRQ7QT310r9kI/9JBWWfgEt5p76OsD
         hMjFQ8bO2KivVf6F/eKeivCBSS8kjLIduMefxH/Hnf+xWQDDebR5PZi+95XpztgIMb6Y
         HMK4I8vBKoHgg5rQVzo+aH1ciBRJwCMu6q2z1yj+eVxZ0u+pasGeRUW1eB09P9V0hrz7
         jD+nVB9Dncxm4d87nQBxG2cA5yFBumVqc4LyA+3xwsZ/l6WnzY95ONMdmwFOl8bu2nY1
         0YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAFDLEyO3E0Yq/UDJfa2ScAWRNSc88sRN7kKLm3eYSA=;
        b=pvrizWvbaSzxUmbb1jafOdgWpkRnRb4/OzLiy8SdSJHUil97jzdyDY/pzXOfIvdjX8
         uC94UBvr67Bjk1haRuQkrMDaZe7PD8p8110oKbADawjrur6dszY7I5M7nyB5E5xCnmL6
         z101UkgaWt+AaAI7/uXznI2FPmOrJF4TWG8olj6tlGlwlB+eAJMyG51wxiaQz+bDI1Ft
         JPtz/aShfJSX/yeHDdA22Q3ICJJos89IqzOLMcka56TMJAIM1jVofIQr4/ywAe4pbcKv
         8WEx2OIEOdGyApihRKhg2iZH9Ttfbkld2XRhp4FYbas4I826vyIr8N+ZtcLU70pggAB8
         KV9w==
X-Gm-Message-State: ANoB5pnHzWGqou3kN78efAXG+5XbqrWvEeRSWyLLVnJUtBoXwZCXdJPh
	Zq0P1KpSR9dgcuulohYopFaM/M9XdtjRGWnyNns=
X-Google-Smtp-Source: AA0mqf6/7fXMTEROkv2vHl+kLv1p0zOshiFSjCCC8q3EHWQQ5zNEjmh7HDxKzwsJmXz19KDlPUq4pw==
X-Received: by 2002:a17:902:e74f:b0:186:61fd:7446 with SMTP id p15-20020a170902e74f00b0018661fd7446mr26923911plf.150.1669366340250;
        Fri, 25 Nov 2022 00:52:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b00188fdae6e0esm2822563pla.44.2022.11.25.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 00:52:19 -0800 (PST)
Message-ID: <63808243.170a0220.73d2f.3e48@mx.google.com>
Date: Fri, 25 Nov 2022 00:52:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-98-g7f7838c92740
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip70-98-g7f7838c92740)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 08:52:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10103

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip70-98-g7f78=
38c92740)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-98-g7f7838c92740/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-98-g7f7838c92740
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f7838c92740fa423a5a3f12c00ed02d92851254

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6380742733640e038b2abcff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6380742733640e038b2abd=
00
        failing since 133 days (last pass: v4.4.302-cip69-296-g52de9431d314=
, first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20

