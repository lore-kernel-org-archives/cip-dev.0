X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.22863.1641994063704048076
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 12 Jan 2022 05:27:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=33ZTQEVD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id l8so4101941plt.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 12 Jan 2022 05:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=oJhlKdmxdyIGBtcjtJ2Rygot9FjpXtZnnNYuNoA3Brc=;
        b=33ZTQEVDpTRIC/nd3rY9w1VM9nFGOJmer+9UYRXwJYMdAiprCQqHFcZJxEY5okIiSt
         fgzv+zbFm+WdkL1xk9Mevsymz942adlbxpXfrlRusETyD5WWaqCd7bUZ5SvXGVybxj9j
         tSB+JWYQQ+NvON8JW5VB762GlfzHcS2N2EfSonmp3XnXxKCTinvuIyZ520XYU/b8vw8R
         7K5SWe1NZu7n7DRYlMY0S6HYlNQT8zM0gNkO8YSq4MQFgZlZo0igh9ELWVQ9vekyADzk
         JhXuswc/D3DJ0AWJg45Ou5XaGhIo1+gvrJEYT45XRq5rNhA94VNSWKM5H6coL2mILiaG
         oXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=oJhlKdmxdyIGBtcjtJ2Rygot9FjpXtZnnNYuNoA3Brc=;
        b=xALtEWRREhYfrpcd1EhuvOcqTgnu19XHtNo/nlmGGaC9iD7EM/bWl6a3I48ieqoiq+
         uyJ2ivXsh87LX9vq7TnJ6A1D3GimY99KM8SkY51Un/UCG7bCaRJjwX1N4lpYfyLLUGlF
         eYyiYyFpt5Rp6DV11sk/K4YvfehXtulZ2sJqYSkX8F2WoYIwC0a7vl2XO75p9e+RCPwq
         y6eVA1P4vAOEHzCCwQp80OWTZliQBpyJlpxYV6jnOd6WZznrrzXmNEOTkgp6AtlcuidK
         PE6ZdZovf5Vwl3UQ+urPUZbmI7P+YWkAVpWHY5/uFNwnxiQ2dOtvaS9xx203zQcpw0lI
         Crog==
X-Gm-Message-State: AOAM530QcdMEya5kawZ5Mld61Ws71xpgByulGQfr/U/we3/57bOZ4WNf
	mwOqpZdxBGUgvoYekqK1Tg6CxHGAexjaoErG
X-Google-Smtp-Source: ABdhPJxOnyXp2a14XetSdqNz3rch+lAwisfRW/qgadB9CXG4ozDqKfVdhVTrgdbcXkISZB7F76MuDg==
X-Received: by 2002:a17:90b:1bc7:: with SMTP id oa7mr8812480pjb.200.1641994062786;
        Wed, 12 Jan 2022 05:27:42 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m18sm982642pfk.180.2022.01.12.05.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 05:27:42 -0800 (PST)
Message-ID: <61ded74e.1c69fb81.d5b64.1a72@mx.google.com>
Date: Wed, 12 Jan 2022 05:27:42 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.83-cip1-150-ge27e063993d9
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip sleep: 8 runs, 2 regressions (v5.10.83-cip1-150-ge27e063993d9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip sleep: 8 runs, 2 regressions (v5.10.83-cip1-150-ge27e0=
63993d9)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =

rk3399-gru-kevin   | arm64  | lab-collabora | gcc-10   | defconfig+arm64-ch=
romebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-150-ge27e063993d9/plan/sleep/

  Test:     sleep
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-150-ge27e063993d9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e27e063993d9bed9942dbaddd575086dccd29623 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/61deca04423bb9d80aef6755

  Results:     22 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-150-ge27e063993d9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/sleep-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-150-ge27e063993d9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/sleep-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211224.1/amd64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-9: https://kernelci.org/test/case/id/61deca04423bb9d8=
0aef6762
        new failure (last pass: v5.10.83-cip1-89-ga7f9ee34265b)

    2022-01-12T12:29:22.369899  rtcwake: assuming RTC uses UTC ...
    2022-01-12T12:29:22.376549  rtcwake: wakeup from \"mem\" using rtc0 at =
Wed Jan 12 12:29:28 2022
    2022-01-12T12:29:22.378259  <6>[   31.348218] PM: suspend entry (deep)
    2022-01-12T12:29:22.382913  <6>[   31.357160] Filesystems sync: 0.000 s=
econds
    2022-01-12T12:29:22.392896  <6>[   31.362344] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2022-01-12T12:29:22.396437  <6>[   31.371305] OOM killer disabled.
    2022-01-12T12:29:23.881831  <6>[   31.374792] Freezing remaining freeza=
ble tasks ... (elapsed 1.444 seconds) done.
    2022-01-12T12:29:23.888159  <6>[   32.859450] printk: Suspending consol=
e(s) (use no_console_suspend to debug)
    2022-01-12T12:29:24.141887  =

    2022-01-12T12:29:24.142422   =

    ... (1150 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
rk3399-gru-kevin   | arm64  | lab-collabora | gcc-10   | defconfig+arm64-ch=
romebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/61dec37287c2380f82ef673f

  Results:     12 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-150-ge27e063993d9/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-150-ge27e063993d9/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211224.1/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-9: https://kernelci.org/test/case/id/61dec37287c2380f=
82ef6742
        new failure (last pass: v5.10.83-cip1-89-ga7f9ee34265b)

    2022-01-12T11:58:33.165677  rtcwake: assuming RTC uses UTC ...
    2022-01-12T11:58:33.172055  rtcwake: wakeup from \"mem\" using rtc0 at =
Wed Jan 12 11:05:56 2022
    2022-01-12T11:58:33.186549  <6>[   37.653319] PM: suspend entry (deep)
    2022-01-12T11:58:33.201401  <6>[   37.667581] Filesystems sync: 0.000 s=
econds
    2022-01-12T11:58:33.219625  <6>[   37.680824] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2022-01-12T11:58:33.230518  <6>[   37.698161] OOM killer disabled.
    2022-01-12T11:58:33.246785  <6>[   37.707823] Freezing remaining freeza=
ble tasks ... (elapsed 0.001 seconds) done.
    2022-01-12T11:58:33.264563  <6>[   37.728146] printk: Suspending consol=
e(s) (use no_console_suspend to debug)
    2022-01-12T11:58:39.774038  =16=00=00<3>[   38.350350] mwifiex_pcie 000=
0:01:00.0: adapter is not valid
    2022-01-12T11:58:39.784198  <6>[   38.575968] Disabling non-boot CPUs .=
.. =

    ... (98 line(s) more)  =

 =20

