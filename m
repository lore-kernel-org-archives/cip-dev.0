Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC475C00528
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 16:45:19 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web10.2178.1689871511766445466
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 09:45:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=BnB4f9Mg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.46, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6b9cf1997c4so830749a34.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689871510; x=1690476310;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UnCh1TMt1S2M/OTzkkZKKDncFqzJQZSIdY3UQgDu1zE=;
        b=BnB4f9MgV9DsBpW1/gUFEVqJTzg11fURASaLOhVxE4zt5JYMkeo9Ktd8PzcMU+HBBM
         C5yDKHEj2cX5rmzYe73kuKNzS5lr4Zg8CnZTfvvbuZWlgA62XWAjXdcOiG8CfMKghVPi
         g/lFqHLw6PjcO0sqL8UflXhJliUL7F+H0tAdCTYAc9SlZTTEBmqXinhPgW8/7jKYQQev
         hTnKR1K0nU5PeTBxRQxZSUvvGW5clCowWGCj5JJzIcRsu+GiowIrJG5+m3/38h5xM70z
         tGPpoJjzahlD4hjgOVllRuDyh9COLwC78uMKeM78FsFdJU8F+TMuDKFQoeud26rGW76a
         sKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871510; x=1690476310;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnCh1TMt1S2M/OTzkkZKKDncFqzJQZSIdY3UQgDu1zE=;
        b=ZIU55pNvWY+DAAIAlYZwVmkqbQ4W+Cj+jrBMqCZdoGguxsdHT82Aeinwt+BkI38kkb
         GdnYUpPV3kuyXla6EGs04kfSumgzIpcHjZQueU5z3SS+ly3x8SAxEX2thYJoFHc2gmFG
         51FOg4CMavQds9fVETmVRqWJ7jiONBbhj1itphLP+i6QxNpnnex4cATGqnf9/8O+9eFf
         gXAmkYYE2qnaNbEzRMwYHKnzBrN2S31KM2IkH+EN65RQ9wop+dJlsw9g2v6mKS5PAOdy
         4MHsz4uz1Lgz8LN4c5Uax5iH0HxXu0bCWjWC7dRgGTqICo7R3t/giXClef9Ql6pBZTUn
         bVnQ==
X-Gm-Message-State: ABy/qLY0sUs7ymYXdtcBZ8hTg7dmDY4vhASKswinS+l5WnL4kcDL+9Fg
	AJvVYtFvloqwQ+IxRQmAwCBGhRHNonsTF6ePvwFrLw==
X-Google-Smtp-Source: APBJJlFrm/Cwl61DCbDMauowCbj6e4xfIDkC8yDxEZkRZoLdhzaM6/TbDql/ZAVtz1iniF0G1Fxakg==
X-Received: by 2002:a05:6808:2224:b0:3a1:e282:8405 with SMTP id bd36-20020a056808222400b003a1e2828405mr98423oib.13.1689871510549;
        Thu, 20 Jul 2023 09:45:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a564800b002657aa777f1sm2884032pji.19.2023.07.20.09.45.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:45:09 -0700 (PDT)
Message-ID: <64b96495.170a0220.2030c.5c4b@mx.google.com>
Date: Thu, 20 Jul 2023 09:45:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-12-gf8c9ce666de7b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 4 runs,
 1 regressions (v5.10.186-cip37-12-gf8c9ce666de7b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 16:45:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12480

cip-gitlab/ci/pavel/linux-test ltp-pty: 4 runs, 1 regressions (v5.10.186-ci=
p37-12-gf8c9ce666de7b)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-12-gf8c9ce666de7b/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-12-gf8c9ce666de7b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f8c9ce666de7b69f842e25063054c803ff45d06d

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


  Details:     https://kernelci.org/test/plan/id/64b94422223e45794a8ace28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-collabora/ltp=
-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-collabora/ltp=
-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64b94422223e45794a8ace=
29
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =20

