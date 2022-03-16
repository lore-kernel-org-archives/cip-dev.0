X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web08.25926.1647440858308455996
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 07:27:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xVsgFiBV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id e6so379616pgn.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WzKbCix8xmlFz6CjPFE5C9OTIsYXI7+Xa17byDpv28M=;
        b=xVsgFiBVDlD6PrrDu3A8IVZPmQnodJamctiMF8vPw2Am4ktea/ABiD/L+VEQ2PKq5Y
         BZAjO4O1sEM4RIflxuE8YKcqyoCSTVHmbjq6mqMng/pGMr10H/rZbHARFMmp2gz8O+Xc
         Q+GbYqRq5i+9kFuA0p4rp6/rMjs8anZ8VxV5nETIdDqK+Hu3ClV3qqECbZx62lg1/L8b
         8hGrASa491LBFRQBTFIbA7lOq+oHJL0b1DhSHW9a5ySDSTDKEL6nsP9SPb3iymCnWCJN
         Km3WKtpadfm9cSA0r4drGT5ZyB/fJZIgnEzvJIcEIurRQnVi3BhqhPLpG6EesDyd9Smz
         xRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WzKbCix8xmlFz6CjPFE5C9OTIsYXI7+Xa17byDpv28M=;
        b=kNODi4qux1dLYQT7UWd8NZiWqgrk2WNTN3lgTZw67ojLPuy0Ivfvt5TZK9EARwVtHH
         ZZnDwQkahZgXSb+sLmXqPdnWULckugLOukgy+PImJBeDna1bb39LdLzq78DYw9oWho2N
         QYpodumq8JDfrdb6Q91RYeQunxqoK0nlv25fhHR/q0mmy4O/yTTEr4ndWe7/xH7qtE0L
         dSzta8Y96ycgerx1tE6zskv7HNFi4yBEkUPK71zowh0AFln+5PTDxMMbcqED+A45uU0P
         3MMKXRBKd+7nqUav2o4Z0T1fn7bY2yh3aNdHYES9WGAwO94FbSSbHDjGrZtwlwZHgnUg
         W2NA==
X-Gm-Message-State: AOAM532jGY3x+yGAVP45xGAAtv2XiPvDGmeKC72HjwUq9l1a5T043H7y
	MbqO2I+6VC613/NbpL5bfWaGgIFIR1lxpFDmYII=
X-Google-Smtp-Source: ABdhPJx3PXHbCIYVRGNM73yyKFduPolQk1W4Xrp7SIiNnBCKlAL2DwkmIPWHdvfbR5Bn/5fy+5BN1Q==
X-Received: by 2002:a05:6a02:20c:b0:381:f276:98d6 with SMTP id bh12-20020a056a02020c00b00381f27698d6mr1627665pgb.39.1647440857687;
        Wed, 16 Mar 2022 07:27:37 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lp4-20020a17090b4a8400b001bedba2df04sm2996612pjb.30.2022.03.16.07.27.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:27:37 -0700 (PDT)
Message-ID: <6231f3d9.1c69fb81.3b97.6a1c@mx.google.com>
Date: Wed, 16 Mar 2022 07:27:37 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-18-ga78419826225
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-18-ga78419826225) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-18-=
ga78419826225)

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
nux-test/kernel/v4.4.302-18-ga78419826225/plan/ltp-pty/

  Test:     ltp-pty
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


  Details:     https://kernelci.org/test/plan/id/6231deebfe78d2354cc62978

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6231deebfe78d2354cc629=
79
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231dfedab2a930967c6299d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6231dfedab2a930967c629=
9e
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231defce9236438f3c62990

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6231defce9236438f3c629=
91
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =20

