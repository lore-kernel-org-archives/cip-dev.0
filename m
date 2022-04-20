X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.10102.1650473409023784360
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Apr 2022 09:50:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KsgfKkBn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id c23so2352812plo.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Apr 2022 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rt+KYqvh/9y3JBX2w6m7WZ1Jjrpzd8nHNdjhbKsZiKQ=;
        b=KsgfKkBnT13B1zd+FvuBaM9k3q0FDcIskqfLyB28oCSsmjYBQyEnQlUbpF9xWu5/V9
         935tVWKdGr2lm74UEUNVb1Gfcs6blpGnGkceb/btxJotu/HC9Uij8wdvhghc1gUyKN72
         0QzTA8vxAzP++w5RdHVjDeE6Gh3JLamcQdHCPiwMHvitAwdVvO+riaZPRTQPTF6JK1TE
         HeZPXrlMFjlz6U2ktmAfGjb7VdZHEHNgLT9wKDUBNR/exDMN4L/2FeGJ3+h/zVAbyydf
         dKdAzuIRW3Gfzaz66gbRSI7KUvtQ0RNRBNuFBHm0nqcsRTcmofMeoFq8BovazoZgUYBR
         C14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rt+KYqvh/9y3JBX2w6m7WZ1Jjrpzd8nHNdjhbKsZiKQ=;
        b=3vLCZl3pslbgoZlP8MMIwQb9zVszn5PfMYjaz2/paOv/QLbWBoLZ1PV9X+PHcLguWA
         4X6yB5IBdYloGf4kpJlWcvvAsCX07I0cX4n5H9z3R50HJ7/jN/hkn+1PgdBjJRNd78eJ
         IQiNSVenCsU9V1LqP5yOrPhqIkRvIGBbcWBbq4n67gQekwwEkw8h9xDCEl0lhpa+PhiE
         SH0KkX8kh8N5zXTreEcasWuYrElkSSlauylghej65WIs31IkRoJ6v6amwqOGDwgyyJgX
         e1voBNwFIVot+R/wOcur014w1IyLmPaFbNYHKNohSth1gVcC2+yvGcc8oRKeFor/zK22
         V56g==
X-Gm-Message-State: AOAM532zwhoBHWv3Ew70n/vFMcHz0qu0lomp39vg51MMBxfVz9lnj/mH
	pZPSpL5UrgR4/M9DX71MkhDe+Je/JfnZppXHWNQ=
X-Google-Smtp-Source: ABdhPJyQb/QTitkTw3zLYS9VDZgY4/BPQA91ll5PTrCcZbpGZOJJWBZns1s6h5+lOAlycI0xHHOogA==
X-Received: by 2002:a17:902:f64d:b0:14f:fb63:f1a with SMTP id m13-20020a170902f64d00b0014ffb630f1amr21860371plg.159.1650473408427;
        Wed, 20 Apr 2022 09:50:08 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c139-20020a624e91000000b005060cdff4ffsm20327889pfb.129.2022.04.20.09.50.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:50:08 -0700 (PDT)
Message-ID: <626039c0.1c69fb81.e57f1.0247@mx.google.com>
Date: Wed, 20 Apr 2022 09:50:08 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-875-g6ed0fe2c3e8b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 8 runs, 1 regressions (v5.10.109-cip5-875-g6ed0fe2c3e8b) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 8 runs, 1 regressions (=
v5.10.109-cip5-875-g6ed0fe2c3e8b)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-875-g6ed0fe2c3e8b/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-875-g6ed0fe2c3e8b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6ed0fe2c3e8b47b471924ff54d5cdb9d0afb1200

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  91fd818dbff1aa3bcefae3747f83e1dd5c1586dd =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62602b848a8a5d68f7ae068c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62602b848a8a5d68f7ae06=
8d
        new failure (last pass: v5.10.106-cip4-757-gd8c01ae8a4bc9) =

 =20

