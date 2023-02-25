Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A27C7EE30
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 00:32:04 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.34728.1677285119617777156
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 16:31:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=VVefaZHU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso907362pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 16:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s3divjzFl/5kqsjlS2aEmyj+/OQootajGliyGh0F5B0=;
        b=VVefaZHUIADfvVIQOHBmUj95+ifEyxnfEvdRWBGp9Cp3G1sBcW0R/NebxKt3PVqIEU
         y0vXMBjEG4GwF0uQLlbukBn/Vx313wfU7VbncHHWAYkkqKBEqjlH1XFaB/gkHLD2wg+u
         vQ3vL5F/BYs8TWwSAaC7qc0jATqsQI5+d8UOF26wLtdxNkIZ6eglYuHs3KsyYKp+VFh8
         zzyEKALahSzRPDQ7Kl5E3P7AxEP67SdsufRu/2HCDfO/C1TiCJMXoXZx3pG8A0EAsy2f
         89ft0klQmQve+x+nQYYgXmiMaEQP+kLomAILgBAHOBlKKXF5uYlSDr6gDR9bt2jbcj3b
         q98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3divjzFl/5kqsjlS2aEmyj+/OQootajGliyGh0F5B0=;
        b=O7kDC0cgHe0HK3YIbZCN2kXfpRTpd+Oq5XUVEg26IKDtbHjxJRMu9elN/D91oIK2Kf
         Mern0TygNCRqXfyV2ucRAzjIbs5qDAbPvPMlKQeBjtDcjZmc2e3sdCzDXShfzi4wO7td
         ILPkqWhzswd3Y6oI0VJ/oja9Kq7TwUdvNxth4m2ZqGYxf9siNZKF9Me6I4tZK4kh8QoM
         yaEg5854++F3GP6UbvImOG2oRVt3hpA+uBEoGC9ix/lS4lC70JSHYKiu5ODtvfYjUicn
         pJBdS+Ln5aKqR5bIOP2fcIbUv2wb37cfVMroknFmVp2Y75C0lTWL3gNgPECLPx9eSZSD
         MkCA==
X-Gm-Message-State: AO0yUKX/xIauQ+VavELqdkgZ+isIYVYSis5M0LGYe6chefZajQ3itCAx
	AhstjZ3Hj5lWdQF4f9XQbzxTNvqvfEplbClwk2mWzg==
X-Google-Smtp-Source: AK7set8Q1WICufU5Qf1f6Hqhz1FJaqByq2XLxnisBAUdM8rZXrX+VHu21JdDL3ds2/BGtlsXFt0vzA==
X-Received: by 2002:a17:90b:3890:b0:234:889f:c35d with SMTP id mu16-20020a17090b389000b00234889fc35dmr19040279pjb.3.1677285118911;
        Fri, 24 Feb 2023 16:31:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090ab88400b0023086d280c5sm229644pjr.3.2023.02.24.16.31.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:31:58 -0800 (PST)
Message-ID: <63f956fe.170a0220.74cb4.0cb9@mx.google.com>
Date: Fri, 24 Feb 2023 16:31:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-456-g42a59c4e5329
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 10 runs,
 4 regressions (v5.10.168-cip27-456-g42a59c4e5329)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 00:32:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10836

cip-gitlab/ci/pavel/linux-test ltp-timers: 10 runs, 4 regressions (v5.10.16=
8-cip27-456-g42a59c4e5329)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.168-cip27-456-g42a59c4e5329/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.168-cip27-456-g42a59c4e5329
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      42a59c4e5329312aec627def5fefeaf40a482f9c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/63f95311e973eed3f08c865a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f95311e97=
3eed3f08c8665
        failing since 100 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f95311e97=
3eed3f08c8665
        failing since 100 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v4.19.265-cip85-rt27) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f947e0db019d49d78c8692

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f947e0db0=
19d49d78c8697
        failing since 108 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f947e0db0=
19d49d78c8697
        failing since 108 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

