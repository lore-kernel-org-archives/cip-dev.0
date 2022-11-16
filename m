Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A990C433FE
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 04:16:21 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web08.2908.1668572173765616574
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 15 Nov 2022 20:16:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Ogew8waE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id q1so15537045pgl.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 15 Nov 2022 20:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AZEydvRQGMD5lemYSjrRK+OJ+V8GDsjfqRurJ4VumSc=;
        b=Ogew8waEfQoh4EsXTSgST1d9L76mZ3BFmKd6EBMRSuuRcNt8/XyPAtChfg1k8Fj9zV
         nIaL+ZbLrMA2lCXxLdGTlUOpS2xat0NT4IuG526wPAI/MmUknv5jk7oHzZlpn173b+nd
         bV/Q/JVYJ+QBCjE+g63MHsUocNE1VuImOqAvYprvX1ulgheXdnZsrdu1ZTspTgJjnB7h
         llJS+rmw2darH3Es34Xz8Ol5FizvAox0NhoMo46AbLvx062Wmgr9hwcCLb0GpWjI/PVD
         +3ikqL7IiqFlnRDkSsYgUMnOPq1RKJv24IiPrkoBohl8XV1dyrIkqn+6ITueKX9U/Lfh
         q/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZEydvRQGMD5lemYSjrRK+OJ+V8GDsjfqRurJ4VumSc=;
        b=8Buh1kI/Xr/9vSwNmbpDMOaezL79i67Uog+QeGDumiUst5+n3albq8Ge2DRbxNVtyv
         r1RYA40y3GiLHAGQh9KazEi2u6co77dL0h8aoNfthqcOec+/bcMKRsbfTSqFgVvOzHwX
         6jU2KCZYAThsGye1UiqUCr2UwZpBG9ElB1m4PHDfIX34PHHqz6lYqRwYdHQXC8wZisVG
         BWvOydFYJaxzX5QGQMQWGa9n1MrhOenr69RPvdtKGSCVvNt94TmSK5ak5p5edYBJN1Q1
         dlCi7ZQJA+ipOt484AcJ4NFKfEha6BYTICfn//oPMcfmT4y333i8CFvj7QxJCo2B6JNp
         zmuQ==
X-Gm-Message-State: ANoB5pmHl4AqTpPIYC+aJ9PqctCX+WAX2V1nfRxBJ8L9SsKFij2Rc8Oa
	rS0oFYIUTA8D54QNYtX42FfWO29bmoRi0aZt7i8=
X-Google-Smtp-Source: AA0mqf6Psk4PNmkyhgAQupk1esYLKPQfBcOvwBR21tP/STrsZP/oEZC+uFAmBSH3leqf/C8l2JS9BA==
X-Received: by 2002:a63:1722:0:b0:476:85ed:5596 with SMTP id x34-20020a631722000000b0047685ed5596mr10804963pgl.88.1668572173134;
        Tue, 15 Nov 2022 20:16:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902710b00b0018685aaf41dsm10776764pll.18.2022.11.15.20.16.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 20:16:12 -0800 (PST)
Message-ID: <6374640c.170a0220.1ea3d.1910@mx.google.com>
Date: Tue, 15 Nov 2022 20:16:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.265-cip85-rt27
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 4 runs,
 1 regressions (v4.19.265-cip85-rt27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 04:16:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10044

cip-gitlab/ci/pavel/linux-test smc: 4 runs, 1 regressions (v4.19.265-cip85-=
rt27)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.265-cip85-rt27/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.265-cip85-rt27
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2b3defe99e6a33cd295c5120b96288f81f8bd7 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637463853533bfe4ee2abd07

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/smc-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/smc-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/637463853533bfe4ee=
2abd0d
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b)

    2022-11-16T04:13:43.931700  <8>[   15.882149] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =

 =20

