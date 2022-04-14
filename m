X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web12.6700.1649901147933517071
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 18:52:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=RRBAJyFS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id j8so3452744pll.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 18:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1OmUTY+HaS1o3NKPhjOyXhfLYRVLfbQk77yLmUu6elU=;
        b=RRBAJyFST5RClAl46ULbS/jRF1jSEwWpZWedX8WZUrFXwKbUIEWsCX8KK0YyEBThfE
         NHppUvo57Fe06ErjRgC8uI60K2B3gzJWk1mUB16Ig8RSrpcVshE0HW2aAh4Yfa1rlXpn
         qTEYH4eSOmQWy5Yf5JmuYBHNRU1lDpaL5N+BH+BScnQrur4riEztaIalKUlEUN1jyHx5
         ts3f714v9SJaMS+49eMFeVrUR+s8wqhyJ9s6XD4NZLnTcL+I7WCXMmAtCugozTp6pUPa
         bhOcJPv6HfonTq40QsTVEVl9a0ydZOkv+UeJJU3sfkXStDjux1CE5M9PxPbRVJqCtY/7
         +DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1OmUTY+HaS1o3NKPhjOyXhfLYRVLfbQk77yLmUu6elU=;
        b=mwOu6PQXPUdvnIbgsnWeCr7YP1KkzoTlz63GqIVbg1Bk5XyQIAJNQ1xVAtBZDjTVLL
         PDbBpPREVSzfOLlLGcGkfKGy1MJP+FpieIZwQ7hj3ks8gRQoSUxEee2IwZCEA/110hCk
         cVJ5dnFl9KGTdEMFcobnRFXN3iMdY4JQBlvOiKLEusqObxDvzxTyHITOsj3b2/36sNCH
         oMXJ2QzaROFFexKZw4gXNbbxepCX+/shS8xvm6/6CNI/OqkhV8JVJps1bbdoxiZc7nA8
         fdxqqGlGn7NJ3euHoYXU5HgNpiEKYlWqGUT8BEsyXpCnbzWvMeGbL7hnyZ3u+pHNteDe
         L6yg==
X-Gm-Message-State: AOAM533KhR7DdGTiHzxTYEZFrUPIf2T2J9XiTty+Uu/4ndRPnCBXydOe
	yNLhLIrMFrg2wD/ztFl7r+agvGhl4WfGGUZo
X-Google-Smtp-Source: ABdhPJyvgzuYvWcYmOLn/OiTYHMxcJRySKcdankT+1bwkAZDUzZ5BZEXGUpAagKzWiaEQpM2nQPmiQ==
X-Received: by 2002:a17:90a:a509:b0:1ca:c48e:a795 with SMTP id a9-20020a17090aa50900b001cac48ea795mr1711564pjq.165.1649901147132;
        Wed, 13 Apr 2022 18:52:27 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a654d0b000000b0039d82c3e68csm354904pgt.55.2022.04.13.18.52.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:52:26 -0700 (PDT)
Message-ID: <62577e5a.1c69fb81.2510f.173e@mx.google.com>
Date: Wed, 13 Apr 2022 18:52:26 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-770-g2801336f0f208
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 4 runs, 1 regressions (v5.10.109-cip5-770-g2801336f0f208) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 4 runs, 1 reg=
ressions (v5.10.109-cip5-770-g2801336f0f208)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-770-g2801336f0f208/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-770-g2801336f0f208
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2801336f0f2089b0d935efe67d93eccaa85e4bec =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6257690ea131bf3616ae06b2

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0=
005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0=
005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6257690ea131bf3616ae06b9
        failing since 41 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =20

