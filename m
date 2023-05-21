Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541C3C7EE23
	for <webhook@archiver.kernel.org>; Sun, 21 May 2023 10:25:24 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.5485.1684664723822268076
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 21 May 2023 03:25:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=TgKMRk52;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64d1e96c082so2400719b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 21 May 2023 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684664722; x=1687256722;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+q49IBhoU4N2rPNlFYz/CBcnSHLDOPno1Njh9SI/1nc=;
        b=TgKMRk52cOtXRBi1ftPn4LJ6RrtMhT09T8CMW22My091z0RSQevarIykTO0nS3kzH8
         tIYyvWElnWj3UsFezT/lFROLBGBUp07T5PbLNXclZo5P+BanXKA9EnWjURiWn0ONwq2H
         1OQp+uvwSn+PinhetUwYfdciyveerK7zcOqZ4kFexqN9cQS0K8la2tdqf0wGl6sSPBoR
         YBpuEfwnIOW90MT3UI2Xz07TxJKoqOMA5diPhVFZ+YUo4xzzxQrz/7KpDIvigAg1bJSG
         CQPQhmFxoye+jpAjF46dKN8FB4iX0cxkOuFV8PPoYck9FqF7hRArE6QnqcKBHtyhs9XK
         0bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684664722; x=1687256722;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+q49IBhoU4N2rPNlFYz/CBcnSHLDOPno1Njh9SI/1nc=;
        b=JYKsdYSRXKAw14n+2DSo+/EKjGMMQxOcByHju56uO87HtEI1K17LVHdfn4cde4tuHq
         SHSxOCjD5EaOX23kjbvcCTX1jUBORQQGwpYKvu949s8qCsB7a71adjkKOBqzQC/cHSEp
         H++nT3Tm5PDXVS4QtgB2lx6kMreJnRgypqufdJDgHDufGXXx7d+mysNpIKaWNg3AldXo
         xNqZPTf3X4fB4Dtwt7lMrgCgndMZkgGhX8fd6d3qAQsqcNWmeTC2wS1VNoL5U9lXjS6Q
         EjEOSu9m0pA7NgELv0n7y/jj/WKkaeKLOFKR7j08sdJqkXuQO8qG4dNEW35elvj3PCjt
         ru4A==
X-Gm-Message-State: AC+VfDzXGruLEoQDaO0SmXPB56IWaH+p3vsDVUqybCXZsSmpd356N6DX
	cG0ev3YCz2PSzC3q93bd20yN3mz5QXxVKJQUCDM8OQ==
X-Google-Smtp-Source: ACHHUZ4schLKLzQFNJdNaBl/e02f/UhjjI79ZSJ7znD9UFkua9rkDFYXi1Ta5t6FDHEUjAv3IVpL1w==
X-Received: by 2002:a05:6a20:6f07:b0:109:c477:540 with SMTP id gt7-20020a056a206f0700b00109c4770540mr6967353pzb.45.1684664722593;
        Sun, 21 May 2023 03:25:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s23-20020a63dc17000000b0052c737ea9bbsm2587058pgg.39.2023.05.21.03.25.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 03:25:21 -0700 (PDT)
Message-ID: <6469f191.630a0220.428cb.40f1@mx.google.com>
Date: Sun, 21 May 2023 03:25:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs,
 2 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 May 2023 10:25:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11579

cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs, 2 regressions (v5.10.180-cip=
33-11-gfea7994097935)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip33-11-gfea7994097935/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6469e458b54b3ee4012e8605

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6469e458b54b3ee4012e8606
        new failure (last pass: v5.10.179-cip32-471-g18129e1b68691) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6469e4662d2c86227a2e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6469e4662d2c86227a2e85eb
        new failure (last pass: v5.10.179-cip32-471-g18129e1b68691) =

 =20

