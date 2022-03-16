X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web12.25459.1647440858042575695
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 07:27:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=sLJDFYcN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id mv2-20020a17090b198200b001c65bae5744so1463847pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5tp4gvbqhscB11yJ1VN8Q1nBBYgEcMGDddkk7B/p9zc=;
        b=sLJDFYcNWXQXdo8nX/qHmMACHIFCflopl8J4NXVCUE0abx0tTKEvnkqlCeIivMgdSo
         1xI9vCkKFgzdVVuyOnRMI3kYWzPUYBVXteGnqU2sdaqoXzccNE3efLizr//uQCHXlHnc
         cPLZRCeA10xeGJWCzXT+9/mf6WMJm53PwdHN/ERfpI/yPMvZZVPV2V0HksLAFQ6VQ4LL
         NyG9mUy3fEelR4pSUSl7OF2GUisJjtP+u+ylChgK9qe8RwUbtepjGI1KhbBto5lzi2sK
         9zYAE/KP7/PbmpX6g39mrpQb7bsJIl4T+MbXHK/QGd/TQRmzywrPQATksRnksXrhGQ/+
         iTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5tp4gvbqhscB11yJ1VN8Q1nBBYgEcMGDddkk7B/p9zc=;
        b=pID+4OcljMZmzilt5hoEWH+tvAmWMObYId+oEepQl487eaHw/qyZkpLgwx/WdVAG8H
         n4LpiDPnbWJDTIK6cQpozJ/Yemf3E0SdtJHUVk178i5zRVDvHfjiLAovm/6/3ID2WUrQ
         EhVB0ZZ1nSUdpx4iaT+drfolFVw26N1mQcKtRb9JwCYU2QO4J6Sy62xrJR0IzlNY4CIE
         qh3h5UuPeyjuSVZQlzKxPwC7MUWwmyZ3Vkkf45VLOhZkhrE93jRSucdJRB2ciDRQB7+o
         DhQlcO6hJ4vIpAreOb5SeRwbDO56ob154CzYwH3TIFNeTgZZxcQjFxs32RwjfiyhUPG7
         cZtQ==
X-Gm-Message-State: AOAM53101i7jzOQRnQpOzdELAAXmfvXrJNKnLP7jO+XdIMqJEalvM4bg
	tduOYKEkpkcE8omnLplhff85r90mTsPFIlh2/aQ=
X-Google-Smtp-Source: ABdhPJwrqZoEH3t19W0yNFyfOsfN2ppwPdKpS4irh++8tP957lh+0S932twt4YfyypofGn44rBRe/g==
X-Received: by 2002:a17:903:240c:b0:153:c452:f282 with SMTP id e12-20020a170903240c00b00153c452f282mr1741131plo.88.1647440857246;
        Wed, 16 Mar 2022 07:27:37 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o185-20020a6341c2000000b0036fb987b25fsm2834125pga.38.2022.03.16.07.27.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:27:37 -0700 (PDT)
Message-ID: <6231f3d9.1c69fb81.855f1.6635@mx.google.com>
Date: Wed, 16 Mar 2022 07:27:37 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-18-ga78419826225
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4.302-18-ga78419826225) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4.302-18-g=
a78419826225)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-18-ga78419826225/plan/ltp-mm/

  Test:     ltp-mm
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
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231dfe0a021d4dce3c62995

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6231dfe0a021d4dce3c62996
        failing since 1 day (last pass: v5.10.100-cip2-319-g7182f5032311, f=
irst fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231dfb39ddbef2462c629fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6231dfb39ddbef2462c629fe
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231df07e9236438f3c629f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6231df07e9236438f3c629f1
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231e1ec410f188975c62972

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-mm-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-mm-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6231e1ed410f188975c62973
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =20

