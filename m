Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5E0C761A6
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 12:41:04 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.68991.1680525656444555696
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 03 Apr 2023 05:40:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UZ/l34hv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id kc4so27834719plb.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 03 Apr 2023 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680525656;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=myzvgkXXG2TyeQzUaOt7GegEjvYTkod/65TOOftKywE=;
        b=UZ/l34hvamk7vjf7n4I0c8P1vHODE2VUvUY6LzJPAAE1gsswgYwynwTfNMG5DEBqaX
         qF/dpN8JoCz9WMQO0MPUaM0VANUdDNFw60+ebPV8QVHE8HMdZxT/qIb7fzf1f51RAAdc
         KOEOKtg140jll+Qe6EGjIhfUJcyrCIWBS+gCk7jPyQTq8A2s0NfPdHfNTEs+CsY8P+qd
         /GsSQZBX1wvFiDsocPAPGl9T0zIBixLCJxDDh1vFjBMC4SzECzYecXKQZqX9SZiS9NfH
         HZDbmlJjRpPEgkKkMtBxFxUFGGwv0F7dUNFSK1gixFoouzyWr7vNgtB8aK+6bDrR5TjH
         Mddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525656;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myzvgkXXG2TyeQzUaOt7GegEjvYTkod/65TOOftKywE=;
        b=L5orOXDUw4sY/GoTNzVsFNz8tSHM3OeovmFncJF3m8vEBEOviYuJF+neeqaY+yn1Wh
         1hZafWJfARdd1OfILAyyFMFE1+N3gdvzfRHe0TDhsCNjjz5kYhWdya6NNJziMMiIwyMB
         Z1CU0ZECdZANpYql5f/+DVsjZl3ESpGxU9WzHDCuAZrziBJNfcz1tAHSriaNPFl/P3hW
         fBUeUAfS09IctAhebSQbk9+IdNc5fkUFVJUOvX6rwDM4yewGWOV4evbuMVyqSZEwXmj5
         WU52zhvJO8nYfVY4miCisbXmR4pgADTda7Fbo1CyLjnhvrPc1OeMTMo+SXP2qmLbyNsb
         qJuw==
X-Gm-Message-State: AAQBX9czGlrVrlfN709nd8tW4axXFVQoT7Z26z2sxGwOgN1yu4InYfpl
	8527SpoDW9nyq91tTlalkr48pQpDjNqbk1TzN9o=
X-Google-Smtp-Source: AKy350YyjmfN0s3frjtT3oYAXF4aumQgttZqgQK/gZaBaIvuf+jpk+3IHb9MY/KV7gMVUB5dOGgNwA==
X-Received: by 2002:a17:90b:3807:b0:23f:e675:9c4a with SMTP id mq7-20020a17090b380700b0023fe6759c4amr39321157pjb.21.1680525655652;
        Mon, 03 Apr 2023 05:40:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cm16-20020a17090afa1000b0024095afa776sm6140968pjb.20.2023.04.03.05.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:40:55 -0700 (PDT)
Message-ID: <642ac957.170a0220.9b50c.ade8@mx.google.com>
Date: Mon, 03 Apr 2023 05:40:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1097-g52d843097a439
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 19 runs,
 2 regressions (v4.4-st20-1097-g52d843097a439)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 12:41:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11153

cip/linux-4.4.y-st-rc baseline-nfs: 19 runs, 2 regressions (v4.4-st20-1097-=
g52d843097a439)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1097-g52d843097a439/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1097-g52d843097a439
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52d843097a439b3e38b2dde18a7c7fc256a94f4e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642ac340e4c3b583e962f78b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230324.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642ac340e4c3b583e=
962f78c
        failing since 83 days (last pass: v4.4-st20-234-g4e6ec7162c8e, firs=
t fail: v4.4-st20-799-g1229c813bcd9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642ac21f2e1086b36762f778

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230324.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642ac21f2e1086b36=
762f779
        failing since 83 days (last pass: v4.4-st20-234-g4e6ec7162c8e, firs=
t fail: v4.4-st20-799-g1229c813bcd9) =

 =20

