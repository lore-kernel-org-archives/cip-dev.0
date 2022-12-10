Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDEEC25B04
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:19:39 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.6169.1670638770641570562
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:19:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=S9j6IWSI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id jl24so6719791plb.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9yKzYtkewDcMYoGTDtrX26kSTLahb5rsU7F4FUl6IP8=;
        b=S9j6IWSIxSQxppnfxMnl7YSaRwYIgP+d1UbwO768f4tEui2tx6uD3X28lgryK5QwgD
         uoW89q4rPs0J4MX+P64UkNP7LciE2wmU6tX9UcSNYeVGGgvXgFK0I9JbPjSqIwozi12E
         w5cB3CEqNyUvhKvZMNTMp7k7ta3aVLKMbhh3k4N8Bj8NQ3q0+UAfNw+9S+OkpVsTci9U
         zOrmU10PExYHqyPyLDIfLPJUsa/xquS2GJuRS4Lxz+tNn8KD7WSdJxFitPNWjaRB4JQ7
         jwQg/dEaLcwTRqlO4NQ59gIq9UUoVHQivQIC2IE2cypZsLB0+zQHm8OuWODPd6vxk2rk
         iIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yKzYtkewDcMYoGTDtrX26kSTLahb5rsU7F4FUl6IP8=;
        b=VTFgPLlOCAV2VNWEmD1ucswVlZCfdw4RJKClvHv7trahFRGv/GurIdtSTf8AoWsJOo
         rQq0UafnCOyrv2Pkfgm7h38xzQl1NZl3y3KOCSO+1DLxrNshPwg1NzI+INhr9P6aer8D
         73R3xW4jAjqSk8bRSHL/HnioZ4PHe7aZkAMig0hrDN9A5xStQcVA2oPrj3COxTVVEs3x
         6Sg1vPI3sbybR0upSJ0ZqMRwoySNCplCDp3PguuM2mZszlID62cRvWMQWooeR/KEBib4
         g8GB1xo/XH/5FecWUtdkhDSTnHO117HRPnntLg8orYYL9VmHQdMRqWDmssbRUhOr/47c
         nsCg==
X-Gm-Message-State: ANoB5pk837D/xc0IODeij2/BvGWfW4SUvh9yWp3HgpjC06pBYbkQaVFG
	gBajciIGvp/OXi0FCmR5Z+CrWhy4faN2RPLUsR4=
X-Google-Smtp-Source: AA0mqf6IBC79jzfl+PJIWiQf8zOgdT9CZ1Y00Z9L2ZJpcDpzqjWLjnkPRIOQC72YQWCZeHqEiVNPow==
X-Received: by 2002:a17:902:aa8b:b0:186:fb90:573d with SMTP id d11-20020a170902aa8b00b00186fb90573dmr9720104plr.3.1670638769801;
        Fri, 09 Dec 2022 18:19:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b00189ed861791sm1913146pln.266.2022.12.09.18.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:19:29 -0800 (PST)
Message-ID: <6393ecb1.170a0220.369b1.3e2b@mx.google.com>
Date: Fri, 09 Dec 2022 18:19:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 7 runs,
 2 regressions (v5.10.158-cip22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:19:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10189

cip/linux-5.10.y-cip kselftest-seccomp: 7 runs, 2 regressions (v5.10.158-ci=
p22)

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
l/v5.10.158-cip22/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f37e570b7c4ab8bcfacf36780a9e204878f2c181 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6393debed1f0862ef52abd05

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221202.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6393debed1f0862ef52abd07
        failing since 30 days (last pass: v5.10.153-cip19, first fail: v5.1=
0.153-cip19-3-gc76f4e7e5c71) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6393e38e64004162662abd19

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221202.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6393e38e6400=
4162662abd1a
        new failure (last pass: v5.10.155-cip21) =

 =20

