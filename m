Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48395C3F6B0
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:59:24 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.8547.1658851154456924787
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=DuKbLXCg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id o12so13579918pfp.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aRoGlPDKQr0/0LRFz7oobXERMnHLqHkDVY2ZtYByFXQ=;
        b=DuKbLXCgn1jnfAb9mLf/jU+E/wqvPChW9nDWvC763lNSaNAaI/PNmiVhdR1YnXe9t7
         tqeC7cWI/Uy6+OODw1rgiCQhS4vb2sWjLZaZ6SRHCzPksEltwGFKKqbv0HMqGsnnAlpe
         Scd/1kw7CdwKNf0sPgqwhtcgCYqqtydeGLgljSGARtKsj53nnjk1Dgj7zPaJ3d++00bi
         Zioqon0J5Z0jm3td1yhkJqXkeahC8yXgPSFsmGTQcYGjQChTSl06q/mC9qsgLXF1NLDO
         lWq07ZeK5RAjVrjwIlX8yX2Btbft1c2xjGOxpXiffrF+O5wc0HvKQcBMNgYwrm2wC3aN
         vO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aRoGlPDKQr0/0LRFz7oobXERMnHLqHkDVY2ZtYByFXQ=;
        b=AgXKnC4x8dCD9RCo6vzena+fanefxYB0IKsNYbikMCfQRllhpryDmfJLpRsia024p5
         JC4Nh02bK7Z1aKN8PdL8ncSyCzLaiprk99a8MQkK/qXgSL8WVmS0imsE7skZM1wnsZUA
         t99gPb9Q09cmm0GtWUBtlnAEvlm4GGtNpXnlj7gwtY1thiSz+VaKqytebAn1lpNkdF0E
         Dh1FzgeHng1QgwKXOnwZ6GduKRlexRCMSslfFsMNY/toxJvtFN1IYJmq0zk8jCL+tpgz
         CVsC9TGnQZH/x/lmy4+503fTZzLzB46RzEnf7LlurlAQLzYfUCtCC1u6PHKdMsfzBqmt
         u3dQ==
X-Gm-Message-State: AJIora+43ZCz+YqPCZfUIhHMyTM4DVEhaThjICAukfp7gbPrwZTYHzFg
	m99FNRmzdF2up5udGgs0tOekV8j2Qc5Si3pB
X-Google-Smtp-Source: 
 AGRyM1uOmHnXGy76oitQCSV+pG+vyRBdU64vDFZ6KZ+NMxN2lttgk89Mwns5p7eH4R/ryPGLUrhxyg==
X-Received: by 2002:a05:6a00:1a49:b0:528:6ea0:14e2 with SMTP id
 h9-20020a056a001a4900b005286ea014e2mr17654914pfv.22.1658851153700;
        Tue, 26 Jul 2022 08:59:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 im15-20020a170902bb0f00b0016beba9c3e6sm11784068plb.115.2022.07.26.08.59.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:59:13 -0700 (PDT)
Message-ID: <62e00f51.1c69fb81.c3719.2509@mx.google.com>
Date: Tue, 26 Jul 2022 08:59:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-586-geb97410e0086c
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 5 runs,
 3 regressions (v4.4-st5-586-geb97410e0086c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8950

cip-gitlab/ci/pavel/linux-test ltp-timers: 5 runs, 3 regressions (v4.4-st5-=
586-geb97410e0086c)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-586-geb97410e0086c/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-586-geb97410e0086c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eb97410e0086c865c804bdc822e061764810486c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffc2b287ac8506bdaf078

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62dffc2b287ac8506bd=
af079
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e00327cdb83945b0daf07c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62e00327cdb83945b0d=
af07d
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e005cdf141d16112daf08f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62e005cdf141d16112d=
af090
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

