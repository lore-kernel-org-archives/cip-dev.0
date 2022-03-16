X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.25817.1647440857139999014
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 07:27:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Aw88x8n3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id mm23-20020a17090b359700b001bfceefd8c6so5158033pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=N72Q4IP6WyEceikZ8HPMviljMbFGcRpstZhhNb5Cfv8=;
        b=Aw88x8n3XufKh/QaS2I47tP3aPlsXC8Yq0VGTcetI4d+SlMD5ZfTX0C80YIe1xmJ+z
         GQhTdPPq3Vuz6q1VwA/F9OeMRZSKiPmCBjmXq6NNjMr5aLjP9bZUJRsWR23bLWm3QTP4
         RTsSlQw7jRUIQrXq0FbRIlmM5zfh+spMPid7bW0+I0aq7Cfgtqy8bW4deDqncgXDY/P0
         2gS7ntgCP2GpkGXDzOJkaV7FGw3yX9WEgjppE/2MrMTB5froEwadRvl7jmkkaqNBvL3s
         kfO62NfUnNgQL3MH1Y4cq7Fc+WiyeytDRkITHS7o/ydpMYbtG4CW/Cps8Kq3sbIow9BZ
         CtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=N72Q4IP6WyEceikZ8HPMviljMbFGcRpstZhhNb5Cfv8=;
        b=hqVq/vdgqklh1KcGrsHea8SxDp7JvPHs+pj4NzxsoSrIlfiPHCRFYLYwsRppOOT2rq
         e7rUsiSLsF+BWFw+40giu49KN1eZ8XvG9gsXMkHjYOLLHrQwmRjhONWb7vvmSyrw+5Rv
         29im5MtETARe3BGwsDc434J0jrQQK0A5djBKg8pS/R1zhFNQsgZHnQvJLgCZQmBAVf1Y
         4aKWUxbsR8aPVZ9MN5QDuOeAislVtjKEeXHepn1l4vpn6v5oAsGKvKLZEyc4YwaFTfCi
         e0L+dhHkgTdZsQl0bmbEm9XmEk+hnnMxLJAGUoP6Iq5Ty4Z/c5pHCY0frshXVV6e9/lq
         5Gnw==
X-Gm-Message-State: AOAM531mqvKRC7CpBN1kL30u/exOTg0UwR6Y1rkQtKiq+p8Z48g84bZq
	DpatNOPdTF6b5eWtW3N6TCiSrsLjZqn/LGiEBWk=
X-Google-Smtp-Source: ABdhPJxywVuD7jooUnpxonBXVHjO4sdHQCMVs2hg+z+FoQ5m7xKWIuOoHg4dZyDe2fKTkbHXHB4siw==
X-Received: by 2002:a17:903:22ca:b0:153:b408:d9f0 with SMTP id y10-20020a17090322ca00b00153b408d9f0mr4180685plg.163.1647440856403;
        Wed, 16 Mar 2022 07:27:36 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w17-20020a056a0014d100b004f79bb37b54sm3881610pfu.195.2022.03.16.07.27.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:27:36 -0700 (PDT)
Message-ID: <6231f3d8.1c69fb81.36d79.840b@mx.google.com>
Date: Wed, 16 Mar 2022 07:27:36 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-18-ga78419826225
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (v4.4.302-18-ga78419826225) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4.302-18-ga78419826225)

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

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-18-ga78419826225/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-18-ga78419826225
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a7841982622594475c87d82372d03c2cd9a4786c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231deeefe78d2354cc6297b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6231deeefe=
78d2354cc6297c
        failing since 1 day (last pass: v5.10.100-cip2-319-g7182f5032311, f=
irst fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231def2fe78d2354cc6298a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6231def2fe=
78d2354cc6298b
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231defee9236438f3c62993

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6231defee9=
236438f3c62994
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =20

