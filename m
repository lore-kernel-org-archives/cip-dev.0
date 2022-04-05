X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.833.1649183148082065088
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Apr 2022 11:25:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=pvl70pUT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso3409380pjz.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Apr 2022 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Cc+gma/BJ55KFFPE3U5YVmCAHKWXx4BvVpfFpQhmdV4=;
        b=pvl70pUTD0lrwDiE0/E3sJI5QUF7+tRKtHXOHkPdlo5YLvJuzbFYtSCGOXSLlkHuCO
         TAJrEytZZPgWk/KViGbMU4FLOITLEo5YxBUNeFxT8+Z0Ff8L3co4Iyh8Q67R5XMTA4Bh
         TcOtM9ReEYx/kuE/Z696oL3QwsNpxu0Nctwj1Hpe1j2qhrMvxWKX+rOIflKSTQafbO8J
         rAOG7TqyEibjYKdMzv8i1dh5eTsK5wcdDgjsyWKEMY83ajl2LU1ydspzNthS/NNS1TSr
         t5/5mRoivDINX0cwi5TTvAgweLMMZpCSSGKvDXqJlOS6bGXyhOnj4wGHOam1k6lJ8wp9
         ApoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Cc+gma/BJ55KFFPE3U5YVmCAHKWXx4BvVpfFpQhmdV4=;
        b=KEx2UOkfob+lR3HDTV4iSij1gkGQfA3n4Z7PrhK+4aTSC/S5Q/6Uk6izgUZ2a3qb6j
         Yr9tncEGPe0brvKOtCg2YHL6SVeFlyJbW43Zicu1N1D4rpdG279gBsMum52pdwXesJDI
         6Yygfp0VLHxI3zjhCPHcx2YC8A45Hzex5ZABcTkIWEWhqXeT4CzqQGC/DVXEZUWnvoMC
         L50BRvepSRAIkgb4Dq6WJoqkTHy74AnGM7p4Z+gk9t6dwFKekO6rhvtx69qHkEjU8lhZ
         Kg95+JDdnExtezP14n2Qo+iijlKP12O1ONNE72HVA2HFpxspfbX5F4RwRJM0eXgGuFJL
         FI2w==
X-Gm-Message-State: AOAM530HjIZNxZGLtqBtU9UcnBeMyct2PZWRXcEfJqfzOOETqZ0n2h5q
	8f6voOABgGKDeXwrIwWuldj8SET9b3N/Sk/VPx0=
X-Google-Smtp-Source: ABdhPJyD2MpqokGNSqmzIsf9v4PLLYhOm5z5D2Hj1Mj4HM07mj3O74OiXWQC29Qi3q7N+W1fD8r0+A==
X-Received: by 2002:a17:90a:7403:b0:1ca:7de0:8cf9 with SMTP id a3-20020a17090a740300b001ca7de08cf9mr5579192pjg.74.1649183147262;
        Tue, 05 Apr 2022 11:25:47 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u204-20020a6279d5000000b004fa58625a80sm16572830pfc.53.2022.04.05.11.25.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:25:46 -0700 (PDT)
Message-ID: <624c89aa.1c69fb81.ebad6.bedb@mx.google.com>
Date: Tue, 05 Apr 2022 11:25:46 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.106-cip4-69-g05f5682c2c593
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs, 1 regressions (v5.10.106-cip4-69-g05f5682c2c593) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs, 1 regressions (v5.10.106-ci=
p4-69-g05f5682c2c593)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.106-cip4-69-g05f5682c2c593/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.106-cip4-69-g05f5682c2c593
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      05f5682c2c59377ada2908abab911e0718b50f7c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  163cca9acb71d06492836a667a53554ceec37639 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624c7ebc4a6baf68c3ae0681

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.106-cip4-69-g05f5682c2c593/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.106-cip4-69-g05f5682c2c593/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/624c7ebc4a6baf68c3ae06=
82
        failing since 20 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =20

