Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA3ECD80BD
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 12:21:08 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.89533.1696940467366008259
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 05:21:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zNeZtFRY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c61bde0b4bso47292495ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696940466; x=1697545266; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AdsSd7ihR8dhX1QHyngwFpG4CHvgazKd6KFk7vmoQzI=;
        b=zNeZtFRY+JQJ7gCLZiWjlmCo02yUiTYF+i+0hcfnB8dbEE/6v7zt9xgikx0Yt487Mo
         AouqumqCb1b76j4CNl//PKpxePtU7J+ABZDI29uAflfDaUVGa8M8q9LsL63QwsBjE5ZW
         mCS2M4r0XKWN5KxHUkU4VN2Lwldy9t2oKeoufTeqSmCJuEuji6P3o85E+Cgha4WMzdgu
         XE1LoxSPsAtH4G8hWqJ+xgS0UAaCqRDLsB1AM4vcuuwefXdevgPlk4svUo6CUp+99mBX
         NFnUKKTLccW3n9cuhQvSh9SxKA5qqVLPBFIwHW9dA4cANh84Ox46+uZrzPCKUq0HTiEz
         Y9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696940466; x=1697545266;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdsSd7ihR8dhX1QHyngwFpG4CHvgazKd6KFk7vmoQzI=;
        b=lRBXSSo3Uw/PMyq7FomnIKjS6NUhmgDAgHqv7hyuXfRcj/1NIfeHWu9flMK+xW8rWU
         J1RL+xZla8D0PcJpvrbHgzt3C1hkXBdZxnHbo9a5K+YMUBejkuD5wi2OU4wPjDTcohnp
         pGGrdMAsYBY7DRhobA1uSh8AQBw00u11H1AM9d+gHJExGjYQ6cOwQlfWLiWF4voEFQG3
         g0vJwv5jzuDxd90vCZmSw8dRvsnFOv/zfLhQi+OEgSxDmhMRaVME2AI7kYWc3NrqbY08
         x2IEw0QydqyxWG7/BHFIedIPVkjLiwHBDb3a7C82+aA/QBw1kFpT2yu19/Kjf0rZm/zN
         jBig==
X-Gm-Message-State: AOJu0YxxGAVku7/UjDQPkDwPkCSiBf3d+5/exb4SlkQTlu1tTrrT5U+I
	EvHOqAj7Vol1BQe7F4pj7OWB1w+NiO5JD7UVD6QhRw==
X-Google-Smtp-Source: AGHT+IHQm+w9cvVOhbVhTnCd4P0oIUFm5ThJrv5qazqiflaEl8XHhhO2t6eFJPrtvuaiPc2e+/SBrQ==
X-Received: by 2002:a17:902:e743:b0:1c9:bf02:6638 with SMTP id p3-20020a170902e74300b001c9bf026638mr703955plf.51.1696940466317;
        Tue, 10 Oct 2023 05:21:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b001c728609574sm11598153pls.6.2023.10.10.05.20.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:20:59 -0700 (PDT)
Message-ID: <652541ab.170a0220.785b7.e0d7@mx.google.com>
Date: Tue, 10 Oct 2023 05:20:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-553-gd498c00818b88
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs,
 4 regressions (v5.10.194-553-gd498c00818b88)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 12:21:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13368

cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs, 4 regressions (v5.10.19=
4-553-gd498c00818b88)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

mt8173-elm-hana           | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-553-gd498c00818b88/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-553-gd498c00818b88
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d498c00818b8876a72d6eb6c2498058ec80d51bb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652534faabe3464acbefcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/652534faabe3464acbe=
fcf0a
        new failure (last pass: v5.10.194-cip39-552-gc89b2c57483f0) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
mt8173-elm-hana           | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525327cee77618a15efcf54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6525327cee77618a15e=
fcf55
        failing since 117 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525352d329df282e1efcf51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6525352d329df282e1e=
fcf52
        failing since 0 day (last pass: v5.10.194-cip39-1-g53e59f50ca3ff, f=
irst fail: v5.10.194-cip39-552-gc89b2c57483f0) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/652535ca48e0533822efcf06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/652535ca48e0533822e=
fcf07
        failing since 6 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

