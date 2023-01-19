Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2509AC678D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 00:28:57 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.33964.1674088129673981358
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 16:28:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=WJjOnpG0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so4246292pjm.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 16:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gRN2toHsGzPmta+euFXQKvodqDaWUeY95V1FcecjjRo=;
        b=WJjOnpG0HS4fJW/s0wmHaz5X/M6N3u9r5foUla0VxvoomDBSSJX0Zd0ajyNtIFkl6I
         lxbVkud7V/AvzkMUiY/MzJQHg13LcNO+0R+YdJvGnhX4cYR/jTAxOfxnsl3KtcVibHVq
         cPSs2L6qtmDhjlHaoHMzDIwhUjU/e2uigO7a4kjteqvXI3iPnk+krrrWaKQNgCzcnGm0
         h9LJHloJMh9DEKl0+bntzU2kFmqhkHsVaLKKbHFlePu7+ADH3RDAQqjYMCl1Lh5ucl4D
         xaQTMv5mia7yGjKdL+9ZwKsJ5vGcn+XrEEeMstcdbDos1vnW8yRwqhjUKBPkyXAjv7p3
         RlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRN2toHsGzPmta+euFXQKvodqDaWUeY95V1FcecjjRo=;
        b=agOXWW1WrwtQpc8nJVeuzHNKjqbA6CVElvmkeZAuzarRNYoZoMRjBYcn+wfx05MYiM
         25TPKb0MAfJqQ9TU9DoougC3/e22CasVf7gg49r3V2JJuqmxEIa5IV0ycorpyavAXzpT
         FxhxAGV8yfBZ67xrSSVGVUUYUH8+WdKM50B6RSTMDwlmoDpO0sEM3g5Xrm+9fzQj2OZM
         llxVCjcVByB32C51Gp6Ti3u2usQMv2l9tXV9lSSeHgOaZdk3oVbHnimvHG5UnmfOLsyS
         +RUOVHsAyJb8tvdmqHU/kjxba1krvv/zYet0VuzQNHYfbo2arTI9ihOmdWHs1EQOTGRo
         5+UQ==
X-Gm-Message-State: AFqh2krGu9g1Jz9T1VMJ1Q6soKD2hpAkKlqR4dGbBsbJSnVyQW4oN42J
	/XEmTlKzl5UT3au6hBSDrd11GOp8fjvHTLNq+vnNjA==
X-Google-Smtp-Source: AMrXdXtl5hnQWMESk2zKsAoeNHvJ+PT8v4J/I+wi3IGSReQV0f+n6vLqaPEU+TIcztYdfcRawWu7kg==
X-Received: by 2002:a05:6a20:1393:b0:b3:8808:b93d with SMTP id w19-20020a056a20139300b000b38808b93dmr12284108pzh.62.1674088128871;
        Wed, 18 Jan 2023 16:28:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b00177faf558b5sm3877708plh.250.2023.01.18.16.28.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 16:28:48 -0800 (PST)
Message-ID: <63c88ec0.170a0220.e0b7c.7235@mx.google.com>
Date: Wed, 18 Jan 2023 16:28:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-858-g4aae57dbf650
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs,
 5 regressions (v4.19.269-rt119-858-g4aae57dbf650)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 00:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10420

cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs, 5 regressions (v4.19.269=
-rt119-858-g4aae57dbf650)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-858-g4aae57dbf650/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-858-g4aae57dbf650
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4aae57dbf650bb88d187f251ebdbd3984020b619

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a90056dcef678915ec1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63c87a90056dcef6789=
15ec2
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/63c87e4804ea33d9c8915ebd

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c87e4804e=
a33d9c8915ec8
        failing since 63 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c87e4804e=
a33d9c8915ec8
        failing since 63 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v4.19.265-cip85-rt27) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63c87be47df42ca9a1915eba

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c87be47df=
42ca9a1915ebf
        failing since 71 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c87be47df=
42ca9a1915ebf
        failing since 71 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

