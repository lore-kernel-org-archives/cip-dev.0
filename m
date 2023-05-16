Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84F5C77B75
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 18:57:54 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.30570.1684263473569348238
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 11:57:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Trbabd8w;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-51b33c72686so10114771a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684263472; x=1686855472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R0ixmj0oe0m/YFf6yHR7mAEqLdsueZUQAeky0SsZ4LQ=;
        b=Trbabd8wKLwOIgV3O+o4wCsMSRPOaCd5kUc/7uYvzbyfX/SYVXy4VSSXSedQnV6ckR
         QBvF5CN8MlPIFEIh5rM9Vb3zBBc2Xx2oB3xiZYRQlLwKS5vxAcDXpl5P2krTJdyfWOL3
         80AxX78cK8Io1NROrLLXnu69DcPh7rO9gkfe4BT0GEbBEFDrjEE1zxatq6eQLqazbuRt
         N57uaZUxlCaFa/lA4ME1xEy9Yqusxqppf19MD6Rk/0nSCgS4FrvywcV3mGdI8zXZYtAl
         UecRyrZ31UaZvultPnQZxZI2R8ad0h8akb9Di5Bk40eR8AZ96lXq6kO5E8V6c60c06z6
         WYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263472; x=1686855472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0ixmj0oe0m/YFf6yHR7mAEqLdsueZUQAeky0SsZ4LQ=;
        b=BxLiixFiWTt/OizI3LJhqkfPO/S2+pUhx50BToxx33k91sLyGDgbp2WB7dFQCK6r2R
         nco/ENyXJ3d/Dbo7XUkKwW0e+5AiLAzZppStr1/gn5woN4SuH+1Xp/sVOPRDWGtKVrai
         DOOOv2vkuVpH1oD73mU0h2YISMLP1SMA6vbDLbrX42BE437w7EImP2jv1fasEx3g1UbZ
         uEtezfRLS0GttWfVpHEWal6CPJiI9Hatey5nFaOYbaEQUo5/tJxui4IQT05h2TQSO3RW
         E2wV9/ep4Z+SRZLx7E5C7P9iU86jnF2fq5XWIrx3R06XfTuFenlCYDx4Uwm+CvEK8y8H
         Wnig==
X-Gm-Message-State: AC+VfDxttQRQ7hrO3DiBOfsFDWi4SIMzfFbULGJ8cwfkFoJqlAFNogKj
	wRlUTzunFBP1ucMwkKShUImKpx24/OhW4IF47rmT5g==
X-Google-Smtp-Source: ACHHUZ43/bsiBNHWX3OXeEV/8NBTkIGHSCdOACP5hpHn0+qMJCiDhIMBQ1hLMVnzVdIp4vOoV/IyAQ==
X-Received: by 2002:a05:6a20:9153:b0:101:3600:6aa5 with SMTP id x19-20020a056a20915300b0010136006aa5mr30959150pzc.3.1684263472538;
        Tue, 16 May 2023 11:57:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f23-20020aa782d7000000b0063d2cd02d69sm13761780pfn.54.2023.05.16.11.57.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:57:51 -0700 (PDT)
Message-ID: <6463d22f.a70a0220.7dbc1.b926@mx.google.com>
Date: Tue, 16 May 2023 11:57:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-4-g580ea5dd85ae
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs,
 5 regressions (v5.10.179-cip32-4-g580ea5dd85ae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 18:57:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11474

cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs, 5 regressions (v5.10.17=
9-cip32-4-g580ea5dd85ae)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig    =
              | 2          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-4-g580ea5dd85ae/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-4-g580ea5dd85ae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      580ea5dd85ae9165b28861c2f5ab8bf05a13ecc3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/6463c4a3ba87dc48c32e860d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/riscv/defconfig/gcc-10/lab-collabora/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/riscv/defconfig/gcc-10/lab-collabora/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6463c4a3ba8=
7dc48c32e8612
        failing since 55 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12)

    2023-05-16T17:59:41.851797  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6463c4a3ba8=
7dc48c32e8612
        failing since 55 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12)

    2023-05-16T17:59:41.851797  =

   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c7493d560fb1c42e8653

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig/gcc-10/lab-cip/ltp-timers-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig/gcc-10/lab-cip/ltp-timers-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6463c7493d560fb1c42=
e8654
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6463c81ba58f0099502e85f2

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-4-g580ea5dd85ae/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6463c81ba58=
f0099502e85f7
        failing since 188 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6463c81ba58=
f0099502e85f7
        failing since 188 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

