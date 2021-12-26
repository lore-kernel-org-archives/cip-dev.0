X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web12.19191.1640547096264705139
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 26 Dec 2021 11:31:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=s6UlkpDH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so12665853pjq.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 26 Dec 2021 11:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+slnZQzfj7IrhPGDZasHZ2oCiGqICctX7Vv+PX2mLnk=;
        b=s6UlkpDHJJ69m1o5BR9ndaZb+TF4IgyQ2Ssi3IAlKIi75IiZUL3N0KsgK34009L+je
         3hcZjDfxmaKWGVdS+uQ1lr1/kVg69aefSVvUbNdUAopU91GwEoUp4h7xLYypBQ3O0ANn
         dpplArnrPnqtILtQvAB1kB2LMPoUULZM1EmAOaLR8WxlaZbSayUESTAEVFnjHszdLCoL
         EDjcSxdHQ3fERXSFaDKT6pjQY1/o88JEzXeOURFeFkSN3SpALDSBRI2zQir/HowRsYsd
         JPm4va3ZUWBA40DcKk4hdyf6zEwPLnHfhW2yFL4LHbFjmJOLUltT/5T0cDdV882OhCs8
         uMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+slnZQzfj7IrhPGDZasHZ2oCiGqICctX7Vv+PX2mLnk=;
        b=dOCiUsEhn/0Tt/9NzkGVaE+FkD7JpE0nOQ8o+EbYbl9/ZD82tV+/nbKiJGE7i6zqD+
         yRvRkTPSDJMC70cmSe1Z2zTyTgxBhZN/xr+nEWO1A1RTRQW0OrcsZEjFroGlxx/YS9XJ
         pME9ibbgNxmTu7aMzwde9ljslrdkgqCeTuXo+Rel5uf7/QAG8E2jCniSS4MAcaLYq8/2
         KpT+/MYBgShPXn8Wmco/HWCFaQrh/XaGpB7zo7DnQWm0jvtXids6mShfARXjxakHyM9l
         y3OJ5xmWWTHI1qvx1JsxS7+kFV5zyAoQJKiBtz5hSCxJbCWr+M4AbgsbRG+0KdfJ8K2u
         WURQ==
X-Gm-Message-State: AOAM530mcUNIulaEwtWfgDRYsJPWLi1e0V8Dx8GER/fJYj3B0q+7LakA
	YYlJKPfo1k4DnraPxnT30IkGj0YNd9yuUQZD
X-Google-Smtp-Source: ABdhPJxvO6fU9zRyBeDXjSC0XT5rrEFNvqyZNSK8aPkKFYEnHUG8GU0EpW+w7qzRbybZBFDSFvgPvg==
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr17760224pjr.45.1640547095468;
        Sun, 26 Dec 2021 11:31:35 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f9sm14368337pfd.59.2021.12.26.11.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 11:31:35 -0800 (PST)
Message-ID: <61c8c317.1c69fb81.48dee.a212@mx.google.com>
Date: Sun, 26 Dec 2021 11:31:35 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.83-cip1-74-g842fbb4554b8
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip sleep: 10 runs, 1 regressions (v5.10.83-cip1-74-g842fbb4554b8) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip sleep: 10 runs, 1 regressions (v5.10.83-cip1-74-g842fb=
b4554b8)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-74-g842fbb4554b8/plan/sleep/

  Test:     sleep
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-74-g842fbb4554b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      842fbb4554b81341a09f8c7995cce865e40a9d92 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/61c8ae9809ecc416f139714d

  Results:     22 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-74-g842fbb4554b8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/sleep-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-74-g842fbb4554b8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/sleep-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211210.0/amd64/rootfs.cpio.gz =



  * sleep.rtcwake-freeze-1: https://kernelci.org/test/case/id/61c8ae9809ecc=
416f1397158
        new failure (last pass: v5.10.83-cip1-53-g2f788040f8b6)

    2021-12-26T18:02:39.843703  rtcwake: assuming RTC uses UTC ...
    2021-12-26T18:02:39.850208  rtcwake: wakeup from \"freeze\" using rtc0 =
at Sun Dec 26 18:02:45 2021
    2021-12-26T18:02:39.853492  <6>[   30.731136] PM: suspend entry (deep)
    2021-12-26T18:02:39.860375  <6>[   30.742971] Filesystems sync: 0.000 s=
econds
    2021-12-26T18:02:39.866565  <6>[   30.747689] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2021-12-26T18:02:39.869707  <6>[   30.756463] OOM killer disabled.
    2021-12-26T18:02:40.924150  <6>[   30.759973] Freezing remaining freeza=
ble tasks ... (elapsed 1.082 seconds) done.
    2021-12-26T18:02:40.930850  <6>[   31.812114] printk: Suspending consol=
e(s) (use no_console_suspend to debug)
    2021-12-26T18:02:41.041067  =

    2021-12-26T18:02:41.041888   =

    ... (1149 line(s) more)  =

 =20

