Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83280C25B06
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:25:01 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.216.1659543894727278489
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=N9rv/Q6k;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id t22so9138873pjy.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fDJ1OnlkQVboh6Hj4Xf5Zm1r8/dnwAVkFK2EegPYaj0=;
        b=N9rv/Q6ktLMlpx9/nf0U/iI31tPOrITkW3kIDdhrqg/zpvD2l0Mc9PzfqRBzwv+GR6
         1ZjBLJJdhGiDPaJ2w12jJHMQ0srH6VFCqzxwsoIed1BqUTVKPUe1WgGuEbtRUG42vA3F
         cnrfPouPzbgHQ3w0nWTAM8Q/DZGNWVIIK4wdW72Uazzo3vzQ7TCS+OnJrXr3sAJYDw4A
         wY1L7BTX1O0DQwqlSz5i09hMzdOFT62W722pb+b/2/WOrUMM3zyZJMMREo5WLmLPIQyG
         CcU6H9ODrW7NDlYXhlwIEVQKGbTSTZUvkMBbX+yJI2Wkj3ZsrHgoi3/gyr0u14a/cHrF
         boTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fDJ1OnlkQVboh6Hj4Xf5Zm1r8/dnwAVkFK2EegPYaj0=;
        b=54bII/Yck8jbiMU55xRboyLsCPUnnNY496/e/kTTqKIOS2zEVgCtUDDBbpqwT2SO/1
         ZcUVe8pTrEF+wUdR9JsOWUvn3ZxGwjoMk81nW3DQxyRsJ0JDfQ5uoixYF0BVjda7Qfad
         8Rat+m9rlhQcdUUBXVpaEeNpY/WlWmPt8qBnskRvHWgzu6/JxEAraVIrjJgbx1gvTtCC
         9NxAWSLvZbPZBcQDnToFN4rqHZSVuAYd58Ug8hn5Dw4V/UF0QGDHknpgXONLcWihE0Oc
         s7+RYz05KXdX3gKoGr5wQivSLff/a9EJR6VC4NO/Qabgt6CCjauz8BfaPGvt4sEemNEa
         4WqA==
X-Gm-Message-State: ACgBeo0WmQMztdjJDslr6Z34AJzHArBW5RTPijLIDLq21NbiusuQGbGc
	jMIPweii4+eEkNNe30cawFMqY8lecaLBDpEl4z0=
X-Google-Smtp-Source: 
 AA6agR7LjiRcKjIcmQbyhbI1yioJGaRz1k91fgCHUS6tBamdR3BB094ASEGkPfRGGQZiPazMhhi/VQ==
X-Received: by 2002:a17:902:bf0a:b0:16e:90d9:a42d with SMTP id
 bi10-20020a170902bf0a00b0016e90d9a42dmr24289540plb.12.1659543894062;
        Wed, 03 Aug 2022 09:24:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d15-20020a170902b70f00b0016ef87334aesm2158467pls.162.2022.08.03.09.24.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:24:53 -0700 (PDT)
Message-ID: <62eaa155.170a0220.544fb.38a2@mx.google.com>
Date: Wed, 03 Aug 2022 09:24:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-431-g420b8f43ddc46
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 6 runs,
 2 regressions (v5.10.131-cip13-431-g420b8f43ddc46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9066

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 6 runs, 2 regre=
ssions (v5.10.131-cip13-431-g420b8f43ddc46)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-431-g420b8f43ddc46/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-431-g420b8f43ddc46
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      420b8f43ddc46ea18870caf6aa2052c5602729a5 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea8a4ee33df2a4cfdaf08f

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62ea8a4ee33df2a4cfdaf095
        failing since 39 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea8bac9fa96c4ce6daf080

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-gru=
nt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-gru=
nt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62ea8bac9fa96c4ce6daf086
        failing since 39 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20

