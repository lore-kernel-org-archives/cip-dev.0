Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578CEB64DD
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 15:03:08 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.1949.1689087779575131163
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 08:02:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=wp60Ni9C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b89e10d356so30997365ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689087778; x=1691679778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zIn+bDnonUyALMuqaAxvAKRR5uBbvK3lNQyGPBBcwQo=;
        b=wp60Ni9C7ZenBo3IPYIufGOpgSK7YnqE9RO75+pLEKSzIpV7cWbNLefIZ8jeCCosVn
         Ww4zXxLH2VHK2UpLN0P/d4b+x7oBapZEbF9jguC8eNfnSQii8CgWUWBBUAWYG+89nJG9
         Px50ZKxHHR1LARfvYBsGUuJ2fTxql29e1P9O1dFWAcxxXXJZt6UWwyeV5WO1optXqUJE
         ou1BkcFGVjFWki6zFh6a9BrnbFwP7A8kTh2znvXEUbvaPOX4fzNkPsIoVzh0tbkhPHMp
         OTQpQcgDxpSjgQ6AyelOdq1c1L+bYaMqkR8ea2H+SD8yw7a49PO/KtZoxAGUXHr8HMka
         GRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689087778; x=1691679778;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIn+bDnonUyALMuqaAxvAKRR5uBbvK3lNQyGPBBcwQo=;
        b=S6lj1+4c6eswTePKNgicAFCDYoHt2BbEQPFpXjuRr4QWfTGVGBBR0U1MmUyRW7+fEe
         JF4h+3zOVT0fJ52PbCJJ4Eso4E0VAa/DfqBW94KuRaB/4+hiHoT8y9+h0y4Mq/6Ovv0j
         l/aoTlQS9yCYJcvuBmVQv7HL+qKVVIVtsqXaeyAY93D2zS+bRB8ABaLPj6/XgMqYeU/V
         w+RXJUCyBe+x1tIwQ3x4fUEsZxHX/IoG/0ORZDae5zpBqH498nKoIjIvQLACPEwcyOo4
         mLIxHUDCMN/qkSm9XSLxQN0NFIieavJyfnYSiMLV9IVwerak1dGyYvNQn5Eje4ipYtLX
         KABQ==
X-Gm-Message-State: ABy/qLb7tz12xyVc9DwzpqX9wkJf/KTWdzXFLkpXpWACLBSXIBXd9Vz1
	YNW+bGyq06x2oRow+iTbKiBpvvHMMQ08LdMHLTv0aw==
X-Google-Smtp-Source: APBJJlH6AozHjxDV+jgDzNBXrAErfRvln+uCVdVExq//+sIRPr566iS8+ZjiMTdNA3iS00sEISOS/w==
X-Received: by 2002:a17:902:d2cd:b0:1b2:5ee9:aa73 with SMTP id n13-20020a170902d2cd00b001b25ee9aa73mr15963636plc.62.1689087776170;
        Tue, 11 Jul 2023 08:02:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001b896686c78sm2047373plb.66.2023.07.11.08.02.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:02:55 -0700 (PDT)
Message-ID: <64ad6f1f.170a0220.231c2.48a8@mx.google.com>
Date: Tue, 11 Jul 2023 08:02:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8201543bbc8b6
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 5 runs,
 1 regressions (v5.10.184-cip36-13-g8201543bbc8b6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 15:03:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12314

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 5 runs, 1 regressions (=
v5.10.184-cip36-13-g8201543bbc8b6)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.184-cip36-13-g8201543bbc8b6/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.184-cip36-13-g8201543bbc8b6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8201543bbc8b67c2cfc76e71fda24c2e1f8a7920

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64ad60f8b1011904d3bb2a8f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/riscv/defconfig/gcc-10/lab-collabora/ltp=
-fcntl-locktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/riscv/defconfig/gcc-10/lab-collabora/ltp=
-fcntl-locktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64ad60f8b1=
011904d3bb2a90
        new failure (last pass: v6.1.31-61-g32a95f5a4e3b) =

 =20

