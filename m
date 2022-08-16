Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32680C25B0E
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 23:12:21 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.22467.1660691537567404725
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 16:12:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=i3LomUyH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id m2so10550232pls.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 16:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=7YW8r+ZGSe/KhXhgOvBmNAu1AGAfgyce4YzMnNw6zd8=;
        b=i3LomUyHfX9FcO9mHHu8xo0zQYhYaPvg7AZ/10qBZhrxKKQYjzMI7/Jqa1iEMC2oMh
         T7JKzAIj8x/l/wjAln/6FEhCfQQcc4Nii3JyWY63ZELoPSgn0RvQBuK7Zd4uHaLJL9DD
         uM7PBy2B846ZKW0M96FGoLOynjP6ZS5TyFfFper5WcPZ6ycSVCgdKD/rUjSQnp997j38
         Y/qY0aUdqsvXF2jTyK1LR4FKG6TDePHvhDudwjGi4tEYJgucxAx5I2jYSn2iW7pVfTUC
         ByNbE2ywGiLIAkMdpLGaetZWB5N5ILZFzac2BpKIywI/kfuTGotQqYnBu8WMFgWOqhSf
         XkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=7YW8r+ZGSe/KhXhgOvBmNAu1AGAfgyce4YzMnNw6zd8=;
        b=2nPTb7IzBbda5Y71GdQlzxsqgeRUEYThByEJnNRRlHcGr56yRVG2d2dI5gcFzAMOvl
         yoqSe6LV2V3undAcYV3nQNu4Peg+Y0Ax27uFCC7awHhMcognCVXpbqYhhvCIrv5UXOwx
         GT1zUo60FRJGsurMKi1G9lrTKz2yDpOMUe10N8jhom0Alj+9yrYz/rxlZhZS58jMRsr8
         aUl9hudXc++O4dO0iRBd+UbSkIO4vrqz4LoKMAUW3gp8TW7lXcaKihIR+uX/nfugjKUy
         5s2qRM5NzsDz+vSqnD9aIi6hYFiZYh8wKe6s7+nmCYP/9KUUdoYZ2BL5rWEkNbgUm1Y7
         3qzA==
X-Gm-Message-State: ACgBeo1KQx/URMXvq6iJGgGadRADR5eC60xifz3ujXzgCeNK7QUEVZnv
	2Xvj9W7sBdbDPMcvXImeiOzWp4wsFvRqgrEA
X-Google-Smtp-Source: 
 AA6agR7D29/8OffF+YQPoYkwKOsJ2XIE2nsLUCmyhPT+mOkmn1z1bAssLx2uPgA5GKixjRfSmTlqhw==
X-Received: by 2002:a17:902:d503:b0:170:8b19:2713 with SMTP id
 b3-20020a170902d50300b001708b192713mr24713173plg.53.1660691536696;
        Tue, 16 Aug 2022 16:12:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z185-20020a6333c2000000b0041aeb36088asm8027350pgz.16.2022.08.16.16.12.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:12:16 -0700 (PDT)
Message-ID: <62fc2450.630a0220.80c7d.d12a@mx.google.com>
Date: Tue, 16 Aug 2022 16:12:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-49-g1145e9c6352e6
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs,
 1 regressions (v5.10.131-cip13-49-g1145e9c6352e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 23:12:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9256

cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs, 1 regressions (v5.1=
0.131-cip13-49-g1145e9c6352e6)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-49-g1145e9c6352e6/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-49-g1145e9c6352e6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1145e9c6352e68c31b58d1035f4f1ff07b2f9c89 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62fc14c87413107c2735564b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/ksel=
ftest-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/ksel=
ftest-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62fc14c8741310=
7c2735564c
        new failure (last pass: v5.10.131-cip13-35-gab58aa0904675) =

 =20

