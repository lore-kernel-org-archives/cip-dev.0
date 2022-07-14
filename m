Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E651C43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 13:55:12 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.7882.1657806911457723949
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Jul 2022 06:55:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Tg5NO5QM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 23so1606770pgc.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Jul 2022 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0JF5iKKVWO/4KkZoRg8hR3blbRnHEv3NP7VpuONIGiw=;
        b=Tg5NO5QMASBmmI/E2CJz0NNh3rMgiDSpND4klTLlOBUZQKVjXOm0zSmYvfuWdiNNTN
         g4YaXXZMOz+MMz1RzNEuNsNDVrfpUmKg21rZ1CvslDfWX/DpRF7iNz5dSYxPOpHPRdTF
         K/OUJH1iM2NDsv2jSYkfdRKyeIZPeCZsxdSwDR4e8d1r9J2knMXqRawFaLrTD56P+U3Z
         1fw596RNabyhGj6zRfz5376rKj6jR24a8L4f865Ns0dHBGnbggcDCCMY9H/v4Op72qA0
         siVE99iSiHHXLOwDASiYUjNNaBvku+lS9hjkdBLkpk1zUa2GSQv+GlyRf+Gya86yOYwI
         pbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0JF5iKKVWO/4KkZoRg8hR3blbRnHEv3NP7VpuONIGiw=;
        b=Wg3CfRTJdDtWWGS3FdwD1c9XvxRlTslQG1lMmWR/TyesaCRpKCCZUHYAHrryFrFJUT
         R64jfiFqT0BZww7zOIib09bS4rccMtmarHiEh1ixLd7NVqHSWp1MTeSaVDHfMo0ypB/g
         GSm/ovGeRkws7LIVgcrqAKjAl9umxWzOAm+eiPmwo8tPLP9uitIgQvXY0yDz5mn0oi2q
         Q4h1Fr/eevlBLfCLO/YRv1pl39M8AnHxAMz/3VcTAWfxBd7dI+7YUub5jHwTaZ/rkaku
         8tEke0oC+6iPnI4r9hfOIJN0NyN9n3zNPDvM6+POIchKPCkkc7CPnX1rtMtHLfp5c7xR
         DzGQ==
X-Gm-Message-State: AJIora+zDn6vnLbGgOaTaOds+Vfdx2Km8ZWG5H0ymT/FTvb/hYqjDvEd
	n0Dtw3yIbsji6Z6iXyMmRVt5icv3zTJvGM8YQSg=
X-Google-Smtp-Source: 
 AGRyM1tNmoe7dMTLk+tRt6kjPDMV1D/2+j9EQmHDqk11QwE9wMshZwF9qpF+nN7sofki/+0P5D9I/g==
X-Received: by 2002:a63:3cd:0:b0:415:f76d:fb4 with SMTP id
 196-20020a6303cd000000b00415f76d0fb4mr7581948pgd.587.1657806910596;
        Thu, 14 Jul 2022 06:55:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x10-20020aa7956a000000b0052ac99c2c1csm1706456pfq.83.2022.07.14.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:55:10 -0700 (PDT)
Message-ID: <62d0203e.1c69fb81.16641.2869@mx.google.com>
Date: Thu, 14 Jul 2022 06:55:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-508-gd887d54a1be6
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip69-508-gd887d54a1be6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 13:55:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8763

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip69-508-gd88=
7d54a1be6)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip69-508-gd887d54a1be6/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip69-508-gd887d54a1be6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d887d54a1be6de9a74cb732ba80ecaf1cedefb61

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  17d354e4d1bf15f7ad55500abc60f2049b57590f =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d0101d71368761eea39c29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-508-gd887d54a1be6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220708.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62d0101d71368761eea39c=
2a
        new failure (last pass: v4.4.302-cip69-296-g52de9431d314) =

 =20

