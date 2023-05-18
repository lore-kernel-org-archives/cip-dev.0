Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2486C7EE24
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 12:16:36 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.15598.1684412193118532861
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 05:16:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=L2r+actd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ae557aaf1dso15874755ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684412192; x=1687004192;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QcIfTWXJE6vNpRJmWohqiyqobBLvDD98xEWmdDv+pAY=;
        b=L2r+actdL+QquoqHTnLXXc19hXJSDAsT1V/kUCgA9SPHElaVP30BQ/fkoHdzGy5LtS
         x7BiL13oCPkGtnHUNI/Ip+wM89cbnNJdjrTExwvuCSLjKbADl7Kfeqo/CL1+3U7zlKcc
         mpGSWgSgX6/76ydSnO3k77XRFdB9p64G6ZeWoX2oTNwWTAu02RwsEtQa5QUiBD57FBeJ
         khGkKCAXTW/P8JjX7mQwd+1NiDF7N0bC6DS0g2jS5jJMdDKtvRJmbHgWOAKumu6M/eUZ
         9rzp0uMGCJ/tKsWssTbLY+wH/xbgTBnUoglPGy/eap8eZ9S+LgK0vmc7Wl9/dMwNCVMV
         WmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684412192; x=1687004192;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcIfTWXJE6vNpRJmWohqiyqobBLvDD98xEWmdDv+pAY=;
        b=FZqw63qpOxHxNB1bJnzkBF6k0/YMSKvpXcLLY0Q14Q/cmyAioUUBs5E7JWGycRCHue
         7vb2sVqxd087UFzPEIcbVv04tEI9HeTkZnmLIlLrmni3N8VQ3FHa6WAcnr+DrwjASGQu
         0JxIcYQ6gOBFFGiYKN8ejKp5SNUNZQyjd+I0Z3HXSRZIEl5p+sXUQy0cKOSOl/5v+AMk
         qMywSVzUIB9nBpkU1D1bimhBHDhxrWuUFmLeCKu2YPXLN7x1mTFXCROBZtXecCnxvvQR
         dJwe3mQ8BjKKfUlhudU4JWEhqXXtbsugKeBjJOzffMbj6BfeiDCwCSRp+WHzNlQI5MPY
         8KZg==
X-Gm-Message-State: AC+VfDydGyCJ5hbdcI1dOHBlB8wybHyZd2YY4uKqD+gvGJSGWqkbNxpF
	jBwIua9LFhdL6P8wEOdq1dv9mde5+HXGlxxIQuXcDQ==
X-Google-Smtp-Source: ACHHUZ7m+TERRdDOxUe/hbsu4YAv37War2JulDUtRxiS01vwlRN28ait+ObQ8+NnezuViuM8XzQ9iw==
X-Received: by 2002:a17:902:ecc6:b0:1a9:9a18:345c with SMTP id a6-20020a170902ecc600b001a99a18345cmr2486635plh.44.1684412192094;
        Thu, 18 May 2023 05:16:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170903278b00b001ae5cc15655sm1325661plb.5.2023.05.18.05.16.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:16:31 -0700 (PDT)
Message-ID: <6466171f.170a0220.ade77.1dde@mx.google.com>
Date: Thu, 18 May 2023 05:16:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-471-g18129e1b68691
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs,
 2 regressions (v5.10.179-cip32-471-g18129e1b68691)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 12:16:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11521

cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs, 2 regressions (v5.10.179-c=
ip32-471-g18129e1b68691)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig           =
       | 1          =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-471-g18129e1b68691/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-471-g18129e1b68691
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      18129e1b6869127ae39e5978bb2fe70ecd53f174

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig           =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/64660a3509415710882e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-collabora/lt=
p-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-collabora/lt=
p-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64660a3509415710882e85=
e8
        failing since 1 day (last pass: v5.10.177-cip31-33-gd59f246891e73, =
first fail: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64660f692cf8678bfa2e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64660f692cf8678bfa2e85=
e8
        failing since 1 day (last pass: v5.10.177-cip31-33-gd59f246891e73, =
first fail: v5.10.179-cip32-4-g580ea5dd85ae) =

 =20

