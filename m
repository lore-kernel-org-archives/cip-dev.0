Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C5BC6FA86
	for <webhook@archiver.kernel.org>; Sat, 17 Sep 2022 16:45:35 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.395.1663433135253388207
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=lQ6Xw9I6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id b21so24237245plz.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ZV2QyqzTf8YaI9TOX94ljYTiRVQWo3IoiRyaCuLlZX4=;
        b=lQ6Xw9I6r3k1yOtwAUAY9CYETyKaCSwR1860Pdlqs9nVFl78ZhAZQT77HMbbFfz5CJ
         py/IqfH2YAy4jMHDyejzrG+ciReyMDQJwLmiCgQQ+yYczp6cZ+FnEBv+J+X8+5pIdxcs
         VEeaO3RLtMQOT51gYoYwVc81FQITbS4fXuZ32UI5Wfaz63BloNBCHqtayllas6l0R5Ng
         q9fbjt7fp8J5IZrCHx4kenOXnVbynhJWb+tSeUau61xfGNkQKYcXR3cwHpeD6vNGzKxb
         Y8wEXJUcH5+JW04rDD2imZEuv3yvGxBxEFOHlbJieoykkhaLYW3jvvboV/49uUHqLp/f
         wDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ZV2QyqzTf8YaI9TOX94ljYTiRVQWo3IoiRyaCuLlZX4=;
        b=zLkkFd1WE5YD7a1WjJzx3/TBJB/7gch0dNbb0tc7SHCbIXzqY63GVIo1CYksFIPIzA
         Umm+S30Motp9KYJFpE2MNa8rgdrHwwsrdNV9KcxCCASuvMOwIy8/8QgRb5gj28x582cE
         j0sxSNbPJREuhc9EG7JJx220rxlujazyUegaT/oWL0xIwKpqtAQaxW2etKxsq+aZH/AK
         U2z29/JEjNr5l9eCzAiwYhDAmMAMoPsJeqdurG3X4EHTbKerJx6mLbFCyGO4kdcpdLMi
         R1KektenSychipeHwCF3Czx2si4UE3ic1QqIYf4TvRtlXYdswjrYq9LFj1SLBDqBthB7
         3TJw==
X-Gm-Message-State: ACrzQf14X5O53mosnlW+n3O5WwPvgUVqo3/fRt+HT/BufkLrSYeSiXRz
	LxcpLkFLLtBokxsrGu0UEF7kPFMpsheSZ0eFPto=
X-Google-Smtp-Source: 
 AMsMyM4b6LNUGUKHbOAOIlXiNNJzeXcOyTyJFDXM6XPf8NlmNNerJpseT5tgiTs06PMiRvmmBMeUnQ==
X-Received: by 2002:a17:90b:48ce:b0:202:61d0:323 with SMTP id
 li14-20020a17090b48ce00b0020261d00323mr11456214pjb.157.1663433134546;
        Sat, 17 Sep 2022 09:45:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i1-20020a17090332c100b00172bf229dfdsm17288496plr.97.2022.09.17.09.45.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:45:33 -0700 (PDT)
Message-ID: <6325f9ad.170a0220.44ea5.fb05@mx.google.com>
Date: Sat, 17 Sep 2022 09:45:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-229-gb433f12afe250
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs,
 3 regressions (v4.4-st20-229-gb433f12afe250)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Sep 2022 16:45:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9507

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4-st20-22=
9-gb433f12afe250)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-229-gb433f12afe250/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-229-gb433f12afe250
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b433f12afe2506afd30066f5b2b826129a20bc03

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb7c10bee55b5635564e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6325eb7c10bee55b563556=
4f
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb83cce9d9cb86355662

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6325eb83cce9d9cb863556=
63
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ebe8f77bbf7a2b355663

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6325ebe8f77bbf7a2b3556=
64
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

