Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59587C7EE24
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 04:26:30 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.240.1685939180986403454
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 21:26:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Vlig01Dv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.219.53, mailfrom: bot@kernelci.org)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6260f03b76dso37494766d6.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 21:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685939179; x=1688531179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=92/Zsbh5uSjDgKWjyt0lb3GG4w626OdhiUqLw0cDD7A=;
        b=Vlig01DvaTFV4dRFEk+fABffLEnuvzuHKhE6/SsxnGSSd8qKf4B/Ci1dyq9wOhX+ZR
         H33+CHIMRq5m9zLLuEKHR4CSQRRqJC3urY7zZuk2M/lff9g3FeTlToM+d9b5BXntxbhp
         7Wjzc/wgT1ze8tFWSMxx1Csx88xQ2i3dNMqMnE4zX2jLZRa52/8VkFLYjjexNtItyyU2
         6ftQu7bEPB5ibAZ96eTu+sUCH4bWgM+iqo83/FQcRfutJx8tiLdP2jXtGpYJC4VmJIj7
         xikb7r7TAsDEKVrUtWgKrarSmXHWpYnTK6J7A/YhXv2hZpMBXnsG415wQrGgX6BTwLhg
         IR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685939179; x=1688531179;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92/Zsbh5uSjDgKWjyt0lb3GG4w626OdhiUqLw0cDD7A=;
        b=SE3Swk76L7wASq1ApMZg5A6CTb8WY8ID6ouvooYqtbPOVRJgFEs22TTraM4dBdEDWn
         F6bOZi7Sgz/Z6EYvjjdQSPj2O0phD/Mwa6GNa9SDOH1qmdm9PDxINhI4i1P6yyp6ocwM
         0cyisQ0I9qEEzssDWdf/6nQCi3+trAotjoUw8TZbAslJOR6TVGFtXP5Z3GiiglykLUay
         JwxTrIBm+FQqqGLx9MFihxHzEedHPsc4iLfyNMf9nGAkUENYL5TuvRZVbLzbVrTPI9on
         fVq4pSHNerxCuDcRMIuA4AgrfRs+IklPuSA2qfKBbwnS4XG3CDAflWYgXtQ5Ckl4WZOI
         YmPQ==
X-Gm-Message-State: AC+VfDyFjyohcJZXu2si5eac+IBTi0Whj8ZbES2Hc+u5CPEZ5NY9vbE8
	4MrrsCoLPXkh5WqaRrSYssH2P5qtIDfXcN2XZDZOXg==
X-Google-Smtp-Source: ACHHUZ4aEx8YH63TmzTeWMnsOX55DZ8OC/voSWeKpWbNITFV6jNlw43j/GmG5nYtfHasjDBTop+KYg==
X-Received: by 2002:a05:6214:e6d:b0:5ef:4233:ee8b with SMTP id jz13-20020a0562140e6d00b005ef4233ee8bmr5631390qvb.2.1685939179335;
        Sun, 04 Jun 2023 21:26:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v1-20020a170902b7c100b001b0218651a6sm5400214plz.178.2023.06.04.21.26.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:26:18 -0700 (PDT)
Message-ID: <647d63ea.170a0220.900d3.9064@mx.google.com>
Date: Sun, 04 Jun 2023 21:26:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gae79bc689058c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 13
 runs, 1 regressions (v5.10.180-cip34-19-gae79bc689058c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 04:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11772

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 13 runs, 1 =
regressions (v5.10.180-cip34-19-gae79bc689058c)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-19-gae79bc689058c/plan/ltp-fcnt=
l-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-19-gae79bc689058c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ae79bc689058cc27e73e1cde11fdc558c96a2889

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/647d531e7ba01808ecf5de65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-fcntl-locktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-fcntl-locktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/647d531e7b=
a01808ecf5de66
        new failure (last pass: v5.10.180-cip34-213-g6582dd41d2c22) =

 =20

