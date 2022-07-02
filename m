Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B68CCA47C
	for <webhook@archiver.kernel.org>; Sat,  2 Jul 2022 21:12:49 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web12.54589.1656796368264357814
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=IhVotxe3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id 128so5579828pfv.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=MKzHPUvIkdEGaqn7JpxKE1gNyg1GHwL6vBhj+NTWiew=;
        b=IhVotxe3Pd5mkTZQPzaWv5xoxgvlarOWwMDCzWVN3+wlTVcBSLgXe3w3Wmk80hBQmn
         2NinlExyjSc5FB1iKTdfDKjCFl3IAQ1I2q3cNTntavcMvNRptn1Dbn7g4EU8J+gIOWSd
         L9gLXGdr+Fs0oAT0PX37Klu8tfmmy6CUVP7XXCi6YnCepfAlMHKFpI5pqW5GNKyKhAjX
         OAU/cKbaHHiR0iY5CdSHqlxHgQDQcPq+hmhxZlN5oz4QxfBZ48XObZkLOKIRX70tt/d1
         uM8031FxN8IjJBuvA+aprI8L7Cx/40H5ebibdeE1sQhXq62TEOlEPfrPgY1L1eqaoBqw
         xzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=MKzHPUvIkdEGaqn7JpxKE1gNyg1GHwL6vBhj+NTWiew=;
        b=2SyxKOyEbq6jVgzMKGVFcAhzauMHPQW84ATFieHnNj/hkUQL42zc4ESryXoGg8QkGb
         kqodH3vZb3Xz7r8ExUKBf+BhHgiCq4ByLCoBcfJD6lLUfpqXIchuEbKZ570pSpLmSp0i
         V0Qic+S0jUxKHZWiw2bGv1kodVK8YYm7crAcgubrXyin7Lql6pIF840DU9w8XhBdtjMd
         incC3bQFBi1trUYOKqPcSvAHv1xWornZdRG0Gyd70ID77TtrQdXfEI+Q2oNEtyyogMpT
         DX/mBnPwUhVMFdWav9mRbGzpgAlkmrGo7AUxBSWvXdq+FbnuIIVCJ0Q9Jg5RyZ5PzN3v
         SYMg==
X-Gm-Message-State: AJIora+z286WFhOHn9yVKGVc1+zQZBD8i7gXj8PX2/eq96urf3dGMLUO
	VWXqWK2K2LTYN9ErxdXaICKSHm/57c4q1rTK
X-Google-Smtp-Source: 
 AGRyM1tiq3pcWGfF/QnOwR9Nn74fVgo1sj/DgALM1zKbsKoHljHrQzDVQRsMbivLn7aYuSjdkBtdnQ==
X-Received: by 2002:a05:6a00:1803:b0:525:6ed7:cdc4 with SMTP id
 y3-20020a056a00180300b005256ed7cdc4mr27749056pfa.15.1656796367396;
        Sat, 02 Jul 2022 14:12:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n11-20020a170903404b00b0016a12571537sm17621543pla.299.2022.07.02.14.12.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:12:46 -0700 (PDT)
Message-ID: <62c0b4ce.1c69fb81.27ad5.a347@mx.google.com>
Date: Sat, 02 Jul 2022 14:12:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-118-gb03e159be974
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 2 regressions (v5.10.125-cip10-118-gb03e159be974)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Jul 2022 21:12:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8638

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 2 regre=
ssions (v5.10.125-cip10-118-gb03e159be974)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-118-gb03e159be974/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-118-gb03e159be974
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b03e159be9746a2cba92777632dfc469e7cdecf3 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c09f814ff8485549a39c3a

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c09f814ff8485549a39c40
        failing since 8 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c09f7f4ff8485549a39be9

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c09f7f4ff8485549a39bef
        failing since 8 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20

