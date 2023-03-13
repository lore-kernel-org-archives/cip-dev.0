Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC08C6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 14:06:15 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.20269.1678716373531510950
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 07:06:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6do4WJTl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id nn12so12141112pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678716373;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eEh4ZC1mbNZKqbO/bCPMpY7QTFx6Vb5heWqRuIdMCRg=;
        b=6do4WJTl1EvXIGNOhgTvy2oTU28KJn8HzvPGA/4NsekYOX7pBDeUKF++wVv+i6AxDV
         oIRIMVfloHN2B2xiACxiBSp+wcz7eWbdQFh3WVPEvQ/k44PtrRKZC0BtzcpEYcp3iOwD
         NBeYPRwi3glQKciRu29L5qbLoQtelYfnvqO6YJutu9nUTPCPl86QW1NerAab7aC8TU8/
         jGAnV1dM9nKjWUGnhRHA1xQXQc5xHXmKYPWcDMs9jO5pFlFuwbF1SS3Z7djzSmvBWhJh
         K8MIEg14TELNGv9PgSGa147dqATXxIhgEhWXAY5PHGaRAls6ckW8GWvL/IySGfkw2EDG
         C+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678716373;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEh4ZC1mbNZKqbO/bCPMpY7QTFx6Vb5heWqRuIdMCRg=;
        b=wzrRifINftg0QELDXuPXgUxydSJRGsh9FIF26P+mMAmG4GTMssITeMJegCV0J+NsQ6
         oibEb3wAnmS2FcKYNM9RI8LkE55Ja41URHrBBFCGt9wpo15zr8FWlEvo2qe5alGCuTAh
         FfWF3yIwfMHDT2dMIarQMhQt1XDMAqu+KFThiSO3D/WwY3wSa46ObbC5u2iEA0v4adsM
         yScrmEbXdm6aLdAE4Y4Ws1GlepenFGJ6Omk44tvOlGlaBirkXFMfnm8YulNpM2fv74ch
         y/Icu5RUrCazyCj3/REyiN3DBT6cwqTLoGt0IczibGeuYCtdsvfrEm44g27AoVhWfAKw
         b8dg==
X-Gm-Message-State: AO0yUKV4JYy7zskp5+T/9kv5QtIr6vYZjN622NnY+Pi0yp1emuqklUqo
	DIRdp1FQiUHw7tZPFrtK9CAuUsd3+mdu1vL5Woy+fFZQ
X-Google-Smtp-Source: AK7set9j/KFg9/JkfEnSWVFQaijS/B7eEzcsGV2aG4yNp3d8fwn1+TDEVcTUmKPwQ3DXIW8GJirQRA==
X-Received: by 2002:a17:90b:1d8f:b0:237:161e:3329 with SMTP id pf15-20020a17090b1d8f00b00237161e3329mr34332730pjb.40.1678716372801;
        Mon, 13 Mar 2023 07:06:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090a6e4e00b00233acae2ce6sm1556695pjm.23.2023.03.13.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:06:12 -0700 (PDT)
Message-ID: <640f2dd4.170a0220.c937e.23d7@mx.google.com>
Date: Mon, 13 Mar 2023 07:06:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-939-g5ff13a6decb9
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-939-g5ff13a6decb9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 14:06:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11015

cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20-93=
9-g5ff13a6decb9)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-939-g5ff13a6decb9/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-939-g5ff13a6decb9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5ff13a6decb9b0e64a7efe5e840b90b27be9150b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3cbaaddf6f785d91aeb370beb75d0623f8c48624 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1dbccab0afe22c8c865c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-9=
39-g5ff13a6decb9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-9=
39-g5ff13a6decb9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/640f1dbcca=
b0afe22c8c865d
        failing since 47 days (last pass: v4.4-st20-234-g4e6ec7162c8e, firs=
t fail: v4.4-st20-821-g39bdf0444b23) =

 =20

