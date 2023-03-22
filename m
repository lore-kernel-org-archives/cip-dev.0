Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC3AC74A5B
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:57:13 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.43290.1679493432338240192
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:57:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OIcigmHv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id fb38so6236578pfb.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679493431;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tyj/yCzM2yMZMQ0wG2CMLicJYQdiCBfPtALwLdk8PDE=;
        b=OIcigmHvia0G8b843KWu0wTg2BdSrauqmgF5Wzt+iGYbt61wm3MN3qz5mHEnVFk4Pz
         NX0brH61v5IOszVYD8xffYfwo2iaQVkW1q9mw2SKwRDmKd4KbfH/i4HbyQ2Lwy67nr4f
         GMi2jo+e3wkjtbsXEpFagd66CZ141ExIa+fRHWE1x5QjkgsLxihHd0fV+pYksx8d+Ert
         hlhUTBZSnJVm3hc3xicLiN63K8pzpVQCe0m3opNXaUn5X+dNA+CJc6qtyzNfRBF79Qyg
         3uHqFqVJY9FIVtZ37ZkQ1lHezaY4qUK7MZ1Do1GANORzgBMYpfzjnGMYP9PPj0RstXTW
         /vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493431;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tyj/yCzM2yMZMQ0wG2CMLicJYQdiCBfPtALwLdk8PDE=;
        b=fMwzYgqxBGroPPqrucdw+N0Sb0Wz3RdGNs2GHUBel+yz3VK/D7qwy9/3LgbqspjBL9
         zVWlH4P4i8s8t5jT7WxZkF2Eet/i57ZCbnV0iuCEtsRYC7QwlRWr8B3mr6JV9+a8cCKq
         UpLWp3j70maXNiRLZj3ceQwzPSONGBeuyibqGKpaV5mxRP6k4tzYveF+xTBqqsk2RhVO
         3A8wO3EjY/zoD1bXupW+S0FgAEOvUWxDmpOgBYkNDVQNALFH1Sd0gzRdu9TmfLfq+umF
         tWSp/NvOr1ddn3PQ6eRvp/FHFN9KKzbqi8GkKe8SHij15hv2HdmDbVv8XIREOwufQgcU
         sFew==
X-Gm-Message-State: AO0yUKVEkMkjm5J4550v7z4/zVrluTmNZzVCS9JcOLDHTObq8Y47YPVZ
	enqL+DUaX99qm/VL2Yqc+pXsUpRgR1/gGV3YyO/vZg==
X-Google-Smtp-Source: AK7set+kninIIPwg9P8AYA8wEI1gj67XdrbdvE6SnsJfHW4APhbNUE2VXzBehkir8lN7hmpBa1QhKA==
X-Received: by 2002:a05:6a00:1d0b:b0:626:9a1:3731 with SMTP id a11-20020a056a001d0b00b0062609a13731mr1979810pfx.7.1679493431563;
        Wed, 22 Mar 2023 06:57:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v3-20020a632f03000000b00502e6bfedc0sm9935041pgv.0.2023.03.22.06.57.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:57:11 -0700 (PDT)
Message-ID: <641b0937.630a0220.9ba7e.1283@mx.google.com>
Date: Wed, 22 Mar 2023 06:57:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 9 runs,
 1 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:57:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11084

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 9 runs, 1 regressions=
 (v5.10.175-cip29-rt12)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.175-cip29-rt12/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.175-cip29-rt12
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af96f1681224ba89c951f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/641af96f=
1681224ba89c9520
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =20

