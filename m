Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC39C3F6B0
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 12:08:14 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web08.27921.1660738087243793560
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=jQ1zPqaJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id bh13so11808767pgb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=hZUTuONBlO+Avqu1fMAI5USTGpsHUJgEWEDHLM4Wq5Q=;
        b=jQ1zPqaJYKgtzawUlTK6bDXddQRSL5u5InohoBgcRFWw0D8IugDPgburE7HYPgzpS9
         NqA2YKcv29B8s/utzFFuJt//bCbv9Wvbmz9Q7PFrtikrdFSAZfndYHTwgAezgu6tppTy
         ZTylnxzrdLuGRvU5dE9vscY/1OR1NKfQ0AURZNO3j8bzfWcM+tR6owM2/YoOOgNLvA8G
         q565i/Umr30ANDY6+0F5erY6FD3JK89lBvwsnrNLPy5WPWFzX6KUCSepE1SW5k1G+Pkk
         QMivrRlizINUNYvm1a/7J5L+FDYHMiE+QWkI4z5FxzeGG40LQsyjPTR7V/pkHc/1NCjs
         RUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=hZUTuONBlO+Avqu1fMAI5USTGpsHUJgEWEDHLM4Wq5Q=;
        b=ZwaVgxqjJIMqREvGyY01hT9D2Fq6mD5Dabqp8ZzlEoWjzqGUmNYww25cKfojN0oq03
         fQywf1eVG8pajPjfsyNhRseD0KMbYjjMqAXMVch+N+RU9y3MdCBGToS+34bRRZ1a2Jk5
         eL4ezDnvcHbexb/f+R9ad+xxVweGEURqEZZtAHCVtX+dPcWwb1LfgGLbakSCvUkFt5nj
         qNVvuUDVVgeIQEBHjeThGH0jLNl1pgENKvl1uOt+Y20U5ONN8AQURiPt9AtfJZSbIi/K
         Qru0aGNv9SKSAZx+porzUSEfgq7CY3GFd4w752Beky2qKD2968GGM0s9FGl6+XdU4MbB
         8c7g==
X-Gm-Message-State: ACgBeo1npeileQQCljgKs2IGQuf5dhLIYp6HQKFAAi0N1HWJOlIjnMgM
	XUd9ySbmnVLmTJUopxvAeLUO5bYTJUsGkDaD
X-Google-Smtp-Source: 
 AA6agR4gDLgIF8E//2skDSQx/n/OW4UYyQjrrtrYBzqdHruYFepM8pFOiFPPURPcFUcgb5eV+vlKaA==
X-Received: by 2002:aa7:86d4:0:b0:52e:fe71:77df with SMTP id
 h20-20020aa786d4000000b0052efe7177dfmr24736351pfo.35.1660738086554;
        Wed, 17 Aug 2022 05:08:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 mz22-20020a17090b379600b001fa8b909ef0sm1431037pjb.7.2022.08.17.05.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:08:06 -0700 (PDT)
Message-ID: <62fcda26.170a0220.a5170.2353@mx.google.com>
Date: Wed, 17 Aug 2022 05:08:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g3b53e4dbd9f41
Subject: cip/linux-5.10.y-cip ltp-pty: 3 runs,
 1 regressions (v5.10.131-cip13-84-g3b53e4dbd9f41)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9278

cip/linux-5.10.y-cip ltp-pty: 3 runs, 1 regressions (v5.10.131-cip13-84-g3b=
53e4dbd9f41)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-84-g3b53e4dbd9f41/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-84-g3b53e4dbd9f41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b53e4dbd9f41171cf639b3ba0b107f6d6f444ac

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bccfa7395fce4accfd30cbf7196c0a6e8db37728 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62fcccf92b92691ea5355660

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220812.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62fcccf92b92691ea53556=
61
        new failure (last pass: v5.10.131-cip13-49-g1145e9c6352e6) =

 =20

