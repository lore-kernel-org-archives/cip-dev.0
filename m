Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C2CCA482
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:04:45 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web09.80469.1656990283243457934
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rr5ncnGA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 x18-20020a17090a8a9200b001ef83b332f5so5110969pjn.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZrAnccgD9KnZwSsCMRrbCOw6ALk7WMgm4b22U04266Y=;
        b=rr5ncnGAKqFcH0F36qIOrqV3ZZAZtsio0hdopTy6nAgNSSChT2CtwYvsCkvFzPSAJE
         DO7Bmk/oqvHlVkHKzo0Xl0KatNmu6QHOjh4ETx7ORtxJdRBkMO545nOK2lQ0kdEP9TZK
         pukhrAsayTaMm5HgBslsaOT8Q0ygEndpNCaXF+kFMck3odRkQFmgQHPdu3PDqzaEsb41
         9JO/+ZAf+HxxWJ5UGLAlXLQ/OUuedMQVRgNzgM1pYFOJxEvSOWojWeVYz7Vn5wc2DMjy
         KyDnXsrFy2B5r6aNjmcn27EH4CRhuxf740rQtXF4xiJe/VWNlWcS3veQ+241YYP7YWgx
         giQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZrAnccgD9KnZwSsCMRrbCOw6ALk7WMgm4b22U04266Y=;
        b=FrNv34f5j3jSadgwGK7bI9FRwuxrT7hqQYgKnXPFF//DiN9vt7gTkl+I7VS7hlyPWV
         X6mmpr/8Cd+ircgkwFfURA8MbUUkSwT76///QgpJf1bhbisXa1kZWdCnhUb3L5wumwMZ
         YNrLclF+lrBbGXJhWImetNsWdRosdsdqh1MD3zKhpioMKalO+Hql4JDjRlzyrb/TZm2D
         xZuWakQrUf7n09YjPltcInEBOCOdIrGnDXXQ1CRReZXq8xuHaT3SOVixBhhrBUiCjsus
         irff/w6+CPqpBs44UlPQJqSbBpwy4qDglx2ZDZT5ZEFAOrXpvQyz/XZzTpq9zNS5qpZy
         cuvQ==
X-Gm-Message-State: AJIora/VC5zpbplCElZncxJdOq0Ajapg9DOYebypZit60lhiStLIwMz4
	HF9mGxW9ex3yG1dlmViZahoacHjW0R9PFd6G
X-Google-Smtp-Source: 
 AGRyM1uephPFNFvG5MyUjJDvqqmd4JKzF2Up0A75yG0GnV3Em0kTm7kLJF/ZjzCo9mIIKZCq9V1J5A==
X-Received: by 2002:a17:90b:1bc7:b0:1ee:ffbf:95ad with SMTP id
 oa7-20020a17090b1bc700b001eeffbf95admr41596684pjb.37.1656990282520;
        Mon, 04 Jul 2022 20:04:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 s91-20020a17090a69e400b001ef831a2015sm4139140pjj.22.2022.07.04.20.04.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:04:41 -0700 (PDT)
Message-ID: <62c3aa49.1c69fb81.07f1.5813@mx.google.com>
Date: Mon, 04 Jul 2022 20:04:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-119-g603acbe1aceb
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 3 regressions (v5.10.125-cip10-119-g603acbe1aceb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8659

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 3 regre=
ssions (v5.10.125-cip10-119-g603acbe1aceb)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-119-g603acbe1aceb/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-119-g603acbe1aceb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      603acbe1acebe85cab7f594d9952a493be976262 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c399857d32a16ed8a39c4f

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c399857d32a16ed8a39c55
        failing since 10 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c399aac90f39a6e2a39c1b

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c399aac90f39a6e2a39c21
        failing since 10 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3a12f7498804f37a39be4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/62c3a12f749880=
4f37a39be5
        new failure (last pass: v5.10.125-cip10-118-gb03e159be974) =

 =20

