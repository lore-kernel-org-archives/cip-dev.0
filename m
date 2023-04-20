Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482AAC77B7F
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 20:26:26 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.2103.1682022383160429192
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 13:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3LnvzVFo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-63b73203e0aso9770049b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682022384; x=1684614384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wu1x9iB3I6SXqJ3TQA6YvlcEing7Rbdr3KK7kTDzCc=;
        b=3LnvzVFoY7hqziZp2yMGsL8vswj0+ZFKNE8wLr7C3tdgo2YGbtJsJyzYmC9MYWHbIv
         AEjrUxS6OplhZFGeasfH08BeqHKh+/ksma7bLXPYr/0XyVKRBevQxrBN0SjDPvA0m0ac
         z2bvIWbZcdEdMq+Q2vBvizs0w14I6nwa+ySDv/bWqsa4c2KFJI7puVkGDorqP2qiRISk
         dIGcEuadAWpx/dSf6IsKKfypiQ5LQqG0BARDQ1iyUbLmBk4GYa12uvnex/w24uMhgTOS
         +QTp3tFcgBOvymjhKci5PZG9P6w/TYI7HlrNvkvOsWAUQnXnkuoBwwSAh3oaOgpCknZO
         XaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022384; x=1684614384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Wu1x9iB3I6SXqJ3TQA6YvlcEing7Rbdr3KK7kTDzCc=;
        b=K9ICkASZCAIBb8BdL/uBYFAajG0gyIPmWzezr4DY+O96WRKBViJTxgvjzg5r+R3AF+
         A6vJO7WDttqdUHX1FNPSLgsl/DO2H5nf/O4/ysmRCuIIujBLMFI2LhrALl0fWLMAsfIW
         p9q8Srch/+5eygfLyCdMHMFJcGRNj72AX83ceJ1YUs6EFThH8tUHskanZjRRIR9oLvGy
         fbQ0AHxJBd2Ny3EZ/l1VOrxcvRagdZGdZUEurJLd1WbkJ+t9axRgLHwl+EuimCqWVhN4
         He3+qrJmS1Z9M8AoJL9dhAZOXkNxPC7Gv2SAmCmVTOFyDuAa22TDW1eYPOUcsVALHAm2
         rLdQ==
X-Gm-Message-State: AAQBX9fDYJsGH7BZKv9Rwefbx7S72FmTaN4txHzx6asmHBNFluUf2HGH
	dFWLGibOyA/zE0Bar0ST7YSZU/tjMl+a/KZVugQDX30J
X-Google-Smtp-Source: AKy350Y7ioyxMWnLDO0F3XC7zV7kujn0cjzLf8+qPpHqCh1UxN91qrsXl6QoOTz2k9UT0d3frOFEyg==
X-Received: by 2002:a05:6a21:339a:b0:e3:f25b:613f with SMTP id yy26-20020a056a21339a00b000e3f25b613fmr3491511pzb.14.1682022384455;
        Thu, 20 Apr 2023 13:26:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a631b03000000b0050f93a3586fsm1480232pgb.37.2023.04.20.13.26.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:26:23 -0700 (PDT)
Message-ID: <64419fef.630a0220.67042.3d6b@mx.google.com>
Date: Thu, 20 Apr 2023 13:26:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1100-ga8cadce4b9649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 2 runs,
 2 regressions (v4.4-st20-1100-ga8cadce4b9649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 20:26:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11270

cip-gitlab/ci/pavel/linux-test ltp-pty: 2 runs, 2 regressions (v4.4-st20-11=
00-ga8cadce4b9649)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1100-ga8cadce4b9649/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1100-ga8cadce4b9649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a8cadce4b9649177791a9adf0eef53ef0c90de78

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441936afba2ce9bfb2e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6441936afba2ce9bfb2e85=
f2
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644194aa7b08c3c21d2e85f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/644194aa7b08c3c21d2e85=
f1
        new failure (last pass: v4.4-st20-1099-g7b2580e1565dd) =

 =20

