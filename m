Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D1C001DD
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 16:07:27 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.58.1689091640261847969
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 09:07:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JANjRjyX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso3374909b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689091639; x=1691683639;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IEfQjJmYRGIWcm55tQgvqQVjoodKsvFBjj4BECeTCWU=;
        b=JANjRjyXvBMeOzQYS0mBC93DzbiDjT8vcAD6sn1gaIej8P5j9p+3QrFAb9YOCIecfo
         0uHZNkCRYk+llcRjYQVchA+SALHkgdzfv1ncZtdQGaOb5gXnlLOoNel0JYs2YFibK9gY
         VmholRuzFw5yhbsHbn5BAfGYb180n2fcmYezCdRYHFP11JANkS1czWUotmN9t9gGxzJV
         Mx9/TpVcuWcv70nBR0NLmrrWPykAqO/HxsGkJXTntatmOiqos2amjdUaL1xZSIowAFgE
         o8wITnTuLsDQeH/dEWjnMiT/AJduBmbq8SuoZC0XA9lhd6McNPCRbFRwfnIZMtiM9GO2
         lonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091639; x=1691683639;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEfQjJmYRGIWcm55tQgvqQVjoodKsvFBjj4BECeTCWU=;
        b=SBoRnHuDUa+p6OAEIO+BGXJIbe0fywazQCB4lhmqAmhF1fKOd3SQnZvYb7OjYqy+sd
         khdSkaCI4+1VL6//4S0yvNXmasjSNwBHblgTw6f/K8YP5eo6stXIpOAl1P6P6nmq2jCE
         FjT4IO52wclLM+gGSaEH7vCYumOkJZMmrBmqYIRwR3HMOlg927QMFztpq5ebKL5hzyl0
         +QWbONc2W7UVAs8n9btimFdwM24uxe8p49H07eAqBX15FXnz41sPQa+giQaxy6gk8Rrm
         Irp4WayD98THzm4GbEiNIq7Y0C/2uHeROwaan6qKOZvMh+bm/E8NzDHh5zkPL4ynX5vS
         1Q+Q==
X-Gm-Message-State: ABy/qLZfDdMBIbWecFkFVMGShrgqz8XG0k6+kI1VGGY0I62lHlthkH3E
	kjkjkWtHI9JRcEDBEWdXRgmmFawBWv4+rFf1+fxBLA==
X-Google-Smtp-Source: APBJJlFWjvHDts1310+cOjLLZM4lk71EuuOUVAS6ApB+SeNNsnL7Ymn8NgSYsnXIXlfUsh1GFThvpQ==
X-Received: by 2002:a05:6a00:390e:b0:667:e17e:85c1 with SMTP id fh14-20020a056a00390e00b00667e17e85c1mr13787789pfb.1.1689091639309;
        Tue, 11 Jul 2023 09:07:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b00682ad247e5fsm1924674pff.179.2023.07.11.09.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:07:17 -0700 (PDT)
Message-ID: <64ad7e35.620a0220.64bef.3ed9@mx.google.com>
Date: Tue, 11 Jul 2023 09:07:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8fae18103387
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip smc: 3 runs,
 2 regressions (v5.10.184-cip36-13-g8fae18103387)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 16:07:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12322

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.184-cip36-13-g8fae18=
103387)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36-13-g8fae18103387/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36-13-g8fae18103387
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8fae18103387e09e360941d7df884a2fc6010f66 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad700629407acb0abb2a76

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64ad700629407acb0a=
bb2a82
        failing since 372 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-07-11T15:06:42.730734  <8>[   13.288350] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64ad700629407acb0a=
bb2a83
        failing since 372 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-07-11T15:06:42.717088  <8>[   13.274808] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

