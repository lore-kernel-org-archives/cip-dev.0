Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAEEC6FD1C
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 10:07:35 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.97694.1679652451501939889
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Mar 2023 03:07:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xFW9ZpLi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id k2so1361750pll.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Mar 2023 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679652451;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=00uhdBxascwCbZ7wONU6oDSbo83Paz2wb9Z3677MNUo=;
        b=xFW9ZpLilazpZbBGCc/6CdIfjmtXdxXAUFnJnzb21AcanrVXEQnccB5RNSyXXtkTPs
         csyemH53BCl1hMRS7SGtXGuCAQfDPGWqf3uFdcDhT3ePwLSx8dpi+qMmHmCvG82mnOkn
         pTZ7HUalbf6WvH221IVt0vaqFmloz/PRkC7mh07szA78xVW8gC1eQ0UiEDREOO2ZZqiD
         RNFsQrgWlfI+ChixyXzxDBjmdkVaUg5QuqrO+ck5Yu+sd7feAt7Sr28NKm0nWl1hQrHY
         CNghZv3hu5JKKci0HwETjxFK+es6ty4heASEpwz3lc+diH4JB+UzGpEcPcQqYHXSO/wg
         7Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679652451;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00uhdBxascwCbZ7wONU6oDSbo83Paz2wb9Z3677MNUo=;
        b=Wmrrr/DsdRpKcc5A0esFLdjOQRnQQ56CV0LoPMPMlYF8Ja1XT7lt61TAKBlD+NlFos
         4tjNrUErqNJqEbsOZYEG5V26rUp4FlRqCRAYI/cr5e4Fu/2n+XBrDOq/eS4Yb0P5Zw4b
         F+GgZyw1i3KbexaVItXwS/iuxTprgraqEFI0qyk7x4acLmbTB2T5gMu5VQOfzZmMWbhW
         7bceVdAIOBFIEOTvT1hOD1SOXon6z+zIj7Ud7wGHNIJyvR4IyC85q45MbMPs/I4yvi3+
         rypo6gHuYyzjqjzb3AbhpbHw4tAMo0hFwiHAfA+WY0q3BJRHhMhSySsDZe28dEAIPRRx
         YmFg==
X-Gm-Message-State: AAQBX9fSBRAFmnhFJcytEaM8G+Xi5Q6PHDRsHgYQkY26yY2BXDxhvqTu
	CTLO7ziObzfmd+59o1YLAD/sqvBr3+HirccYUgeuqg==
X-Google-Smtp-Source: AKy350biCx39lNGP0/2RY8k/jvNBc7t1L1qO1NbA9WGmBg2AnzrfPkfLMxPRdnLuRN5oDTbFmp0Wwg==
X-Received: by 2002:a17:903:22c7:b0:19e:674a:1fb9 with SMTP id y7-20020a17090322c700b0019e674a1fb9mr2238458plg.69.1679652450722;
        Fri, 24 Mar 2023 03:07:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902fe8b00b001a21a593008sm895048plm.306.2023.03.24.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 03:07:30 -0700 (PDT)
Message-ID: <641d7662.170a0220.94f47.140a@mx.google.com>
Date: Fri, 24 Mar 2023 03:07:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.279-cip95
Subject: cip/linux-4.19.y-cip ltp-timers: 9 runs,
 3 regressions (v4.19.279-cip95)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 10:07:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11112

cip/linux-4.19.y-cip ltp-timers: 9 runs, 3 regressions (v4.19.279-cip95)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.279-cip95/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.279-cip95
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a166e121fe317e5b7a79c09a0ca641ca15cb61cf

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6d0dc38e7e26659c954c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.279=
-cip95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.279=
-cip95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/641d6d0dc38e7e26659=
c954d
        new failure (last pass: v4.19.277-cip94) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641d6e93ca87f444999c9560

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.279=
-cip95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.279=
-cip95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641d6e93ca8=
7f444999c9565
        failing since 117 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641d6e93ca8=
7f444999c9565
        failing since 117 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =

 =20

