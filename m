Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A0C3DA6E
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 21:10:41 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.6479.1671225037816263374
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 16 Dec 2022 13:10:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Kb1O+Pes;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id o12so3655490pjo.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 16 Dec 2022 13:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=62Cfe3uFJypbB5l8cmeQDTohBb6gUS6/knb53hyP1uo=;
        b=Kb1O+PesBicdvtCHJYlOb2sYGFuEj8DGMz3GveYiANylQRPUMSpAwltHH3fnQ6tFXG
         EBV6gdWRag35lAo7md9dlCdl3zqLEGErxBm3wZegYsT1ddlwgDQTdJ0sjgNRi5Ja3CIy
         nnI9uO85JPT3FypYMlob2miHymrb5e/1ACZ4x1vWLhc4tTyLMC9HwkvxVYZt+G7chPDA
         haCzPFuHB58hIm5+151+eCxsTwGQROk0qLCIOIGleRxi2EoopFHX0JWpQFT0MfRQEm8R
         Ap4flmnzOfOKNWLIPM97UV/hIdkBjbTuo/euyGR/QN3rZaANqXZt9iqu5kayv6mKWbAs
         AvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62Cfe3uFJypbB5l8cmeQDTohBb6gUS6/knb53hyP1uo=;
        b=VfuZrYyCbyK3lWL7b4NZYXAp8IYCv8rVHxApTJeXKUIGnBXcv0nKPu1vLuslKsfYK6
         zoRcKm112SGeLZGTV9uAWjf+FwEEnoMrX6bMuSIpwKG6GGHdPDVE0LSBgucXay4mej0a
         VJMb4hHRrUkzc2SlCnsryDMmVrl9zT/WMudb4NA+EEx0RaUBKzfMNLx0LKub7KfpwsYI
         ZTDyez744Jmy/FSca1RYZUPUfTxXh/tt/RoDoRryRW2yFH1HYYuwlxm/JsqeJjSLLQko
         g8eyyE3YQEX0EOlcl0bXpKEzb7d0NkofvadxKi2MRkd7cCf7rcEATNNZho9URW/7cUX/
         YBaw==
X-Gm-Message-State: ANoB5pkPNpQvO3Ukv2dlO+SIrW1yZpFdnehIzIqX2eyRta8orMGoKEH7
	yoyFeUp7uKYJuwvNx+YWBtUHnOmtbnyRga4UvS0=
X-Google-Smtp-Source: AA0mqf5QsNT/hD0Cbc6Vi/6ExTyyeaLBlchlQYrPomxBetxGEq8Ptmw/dZSh6bk0mQXdpU1Y1jsstw==
X-Received: by 2002:a17:90a:9f42:b0:219:36c6:f06d with SMTP id q2-20020a17090a9f4200b0021936c6f06dmr34175384pjv.20.1671225036603;
        Fri, 16 Dec 2022 13:10:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w31-20020a17090a6ba200b0021870b2c7absm1748728pjj.42.2022.12.16.13.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:10:35 -0800 (PST)
Message-ID: <639cdecb.170a0220.2db3b.3ada@mx.google.com>
Date: Fri, 16 Dec 2022 13:10:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22-7-g92462fd9830b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 8 runs,
 2 regressions (v5.10.158-cip22-7-g92462fd9830b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 21:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10246

cip/linux-5.10.y-cip kselftest-seccomp: 8 runs, 2 regressions (v5.10.158-ci=
p22-7-g92462fd9830b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22-7-g92462fd9830b/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22-7-g92462fd9830b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92462fd9830b23227198482fe4bee42316a5694d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/639cc84911f8a8ffa42abd43

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221209.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/639cc84911f8a8ffa42abd45
        failing since 36 days (last pass: v5.10.153-cip19, first fail: v5.1=
0.153-cip19-3-gc76f4e7e5c71) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/639cd77224a427782f2abd4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselfte=
st-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselfte=
st-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221209.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/639cd77224a4=
27782f2abd4e
        failing since 6 days (last pass: v5.10.155-cip21, first fail: v5.10=
.158-cip22) =

 =20

