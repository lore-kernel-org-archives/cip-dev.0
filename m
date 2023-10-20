Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DA8CDB474
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 10:33:17 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.51354.1697797990755742889
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 03:33:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zdBbOtTx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1c9e95aa02dso5314025ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697797990; x=1698402790; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Afk3qSbFs67EhKNoZ1+aThthdDS/2GwnSjL1ms/mh24=;
        b=zdBbOtTxwFLCMv9lrvKz1e6BmLDCzpSpGoNOqQmBPLiMFacWVbuAnz05pWBwAgz1a+
         +T+6K+aPMABrbzeF3I2C5DH9YLJ3beDKciLA08ycbfGgYQz7MkcjdhYuAUml+cOqvtFM
         evH4KrpIFYr6Tn2AebcvBQoTt9sO768A6PkL3bkgpJyC+lp/0Q9Unkn+s1y7Bg3GyQoy
         P/HeaPhuIe+9PKePPCutydqatLshK79BsgMcyWt+C6DfcwKYxOi56imAOxD3DUpHMUX2
         d4Q/F8lMwYAcQfD/eNOzJ/9ZuFWI5w9SdVjzrTHg6LmGhQ1sUTCS6UYigDQV0JIlNqI0
         51zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797990; x=1698402790;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Afk3qSbFs67EhKNoZ1+aThthdDS/2GwnSjL1ms/mh24=;
        b=jReKSycNQuinKRIUXVnlT/GvIXC5L1f+Lb0euHh6VRNA5Lq17UUK6SzrCETRquxP8y
         LavyXGuTpbg2f6K78hp1JVFUqzYWcnqv1YASAp35mHfoZENA7hxKMRUSsMDrI7a6yNIc
         jJD8qZw5MpyMjAWNQQyI3hX3PmCNCAzW3HMznOiwqU5CLa10iZcdCoRQxhNrZofGxTJE
         cLserTDf+4I16JNhcceAT5+/LKb3GvKcp8WIfSVbuQbSK4OqesHv7/pEtgLFNBKbVajx
         HtS0id+tSV6s6Pl86Lu+xB+vhD/9oiZ8B4EzG+5F+UnQ1tDTw4Z1EObg1W1a94Cp6Knn
         5G2w==
X-Gm-Message-State: AOJu0YyzjVlc6mWovc+9I7uzNNWwNE/uy9VAiNaO36KNZBT9YnX9wxqC
	ZUNzPKLqiibaa1FMI06yBLlNq6rcXYia1FcfTAlXrg==
X-Google-Smtp-Source: AGHT+IGGbQUlIfTnpZ0X+eMpmmKZ6R9Mb/s5PZEydxA7Ur+d+pze4AFycqrbIhfufxPVrs+xZm1j0w==
X-Received: by 2002:a17:903:1c9:b0:1c9:dece:4c4c with SMTP id e9-20020a17090301c900b001c9dece4c4cmr2060984plh.15.1697797989730;
        Fri, 20 Oct 2023 03:33:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902ed0100b001c55db80b14sm1200726pld.221.2023.10.20.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:33:09 -0700 (PDT)
Message-ID: <65325765.170a0220.b27ba.3d12@mx.google.com>
Date: Fri, 20 Oct 2023 03:33:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-cip7
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip ltp-timers: 14 runs, 5 regressions (v6.1.58-cip7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 10:33:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13411

cip/linux-6.1.y-cip ltp-timers: 14 runs, 5 regressions (v6.1.58-cip7)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =

qemu_riscv64           | riscv  | lab-broonie   | gcc-10   | defconfig     =
               | 2          =

rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.58-cip7/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.58-cip7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5608f0095a5ba83c76af0e5824c2e2d3f41231b5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65324859e9a0d46fa4efcef9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timers-a=
sus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timers-a=
sus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65324859e9a=
0d46fa4efcefe
        failing since 136 days (last pass: v6.1.26-1281-g84d5372e0f314, fir=
st fail: v6.1.26-1314-g1ab0ac1d7e2e3) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65324859e9a=
0d46fa4efcefe
        failing since 136 days (last pass: v6.1.26-1281-g84d5372e0f314, fir=
st fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_riscv64           | riscv  | lab-broonie   | gcc-10   | defconfig     =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/65324e783ae2a0246defcef3

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65324e783ae=
2a0246defcef8
        new failure (last pass: v6.1.54-cip6) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65324e783ae=
2a0246defcef8
        new failure (last pass: v6.1.54-cip6) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65325143ab0c9bb3f6efcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3399-=
gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3399-=
gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65325143ab0c9bb3f6e=
fcef8
        failing since 126 days (last pass: v6.1.31-46-g4cc1cc26e90f, first =
fail: v6.1.31-53-g486caac40d06) =

 =20

