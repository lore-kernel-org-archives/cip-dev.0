Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FFACD80B2
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:37:07 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.88772.1696937826371808408
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:37:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=XASAeDo7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-690d2441b95so4076771b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696937825; x=1697542625; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2BdxcEy2eK2S5ssXdw2fTYSLd+xMSqXS5QdJ/QTLapQ=;
        b=XASAeDo7Piws1aH1MPYiOyeBvlxgS/p8bXLjUG3m4osckVF1jsctRmVVcY+dOjEbI2
         Qz2OJl6MYoEUCzPVim5T9wP8gqWYay45nChkloJgzacZWV+Frm17y9Pgx/goD6V2SHf7
         ypJP/yHnQVR3LEqgyLUAHSdGUgUvwP25Hek6qm1i/7skidxdxO0+UpKso7SToyAYWVLX
         3lcdPvM6lsOFmVhARM5D8VS8l1rrWzdXKr2P4zBTSnUVRZ1E7qd08dp4GAtuZrctBuUG
         XloMQ/Jf/Gv3KcWWnxi6wd+RX15/xESztKPXCLCIKtXHXVm+j7e+N7tmXIxaVR7rKeYL
         TOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696937825; x=1697542625;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BdxcEy2eK2S5ssXdw2fTYSLd+xMSqXS5QdJ/QTLapQ=;
        b=D6y3dV+ahbGWEh4Qzwl5DVZHJlev5UTfJu0B7hSMFGWXd78O1+pa3JFin62XhuqAfT
         LvRsy87jY4bK4F++yeLiRLZup/yJw4IDTflT5vaOhTe7+c5B+jT5bCl9jL/wnmuuBeZy
         nmQVcW0TnGMLQ/WJlN4qeoKM6wVPyG6C+zIgaklm/ebWDNhwE+xJOpwxs1d0niB+Aucr
         0ksqta/NyVeaQyAxyFll+77nWv4H4EGP9zpgjLL/+hQvPRHwAtNkRODH+qBP0RZxeVKv
         g0LI2cTc/M/6GzJK6pZurAq1eWprg2peNn6VeRqf/TBnwUfx8NKwmUuiH4WG0bcdBPfH
         6g1w==
X-Gm-Message-State: AOJu0YygeQ7z7T1lOE4cTTxuBYBDKNlSIbl2paF1lYDn/YwPH1AI22hj
	W62CXfuCIqN9LQg0dYysCpI+/b/om7BLwcPuvX8Nsw==
X-Google-Smtp-Source: AGHT+IH1VYDs0lPPJRliT62ma7imPpr61GQH6S2Fr4jtx9T9S7B4HPhKFLjsqurgVpRzsKxsy3dWMw==
X-Received: by 2002:a05:6a00:188a:b0:68a:6018:a66f with SMTP id x10-20020a056a00188a00b0068a6018a66fmr23322898pfh.2.1696937825361;
        Tue, 10 Oct 2023 04:37:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm8054866pfb.198.2023.10.10.04.37.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:37:03 -0700 (PDT)
Message-ID: <6525375f.050a0220.12be.3566@mx.google.com>
Date: Tue, 10 Oct 2023 04:37:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-552-gc89b2c57483f0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs,
 3 regressions (v5.10.194-cip39-552-gc89b2c57483f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:37:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13356

cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs, 3 regressions (v5.10.194-c=
ip39-552-gc89b2c57483f0)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-552-gc89b2c57483f0/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-552-gc89b2c57483f0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c89b2c57483f0aae7f9cb377230347592eb3520f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652523c39b073f9edaefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-pty-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-pty-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/652523c39b073f9edaefce=
f4
        failing since 117 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65252422c6c5afd2d8efcf15

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65252422c6c5afd2d8efcf=
16
        failing since 5 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65252ada8e141ed649efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/ltp-pty-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/ltp-pty-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65252ada8e141ed649efce=
f4
        failing since 5 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

