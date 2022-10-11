Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C80DC433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 15:02:41 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web12.8537.1665500557173193700
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=V4ru67pG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id
 t12-20020a17090a3b4c00b0020b04251529so13428921pjf.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i0mud+Zmhcq4Ts0CU9L2Xg7kR6MzR8nlV0Qvzimg5KM=;
        b=V4ru67pGxLkVVLbDVjDS8q/yfXUKQEu+jytBwYlri2FJVno7HGeGhaWxvcURoSfHk1
         gdvtN0eFdaGpL/5l4X4PYFs5k3OC2xMUng8WRWHKOFj9P4by7S6dhgZ6Hm3T/zrYRKbM
         sA0tFZcQgDvWdkKreUbGuxdbONIX4mOUB1EtFLdnpyPK9BCrTXVm0y2iP2SKcKQMspFo
         KL3oSTBiK/jTLUAHdx0z1/u+cB+AAixXjF3EtpwvikxJsVT64sO2ci6sgRWiWdSC3sGj
         VdeRHJ0ot6FMydtUZXZqMvm0uRebY46Fsba3WKFVTTrraFKMgI+xM9VVYTgCTHqumnbn
         gTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0mud+Zmhcq4Ts0CU9L2Xg7kR6MzR8nlV0Qvzimg5KM=;
        b=Gf17dU156lSh1odrwgJGPnrzJbon4b6pR6fTDOFwseD0mFxZb9hEeAki7rvSQjm9ph
         3gQl7otukTdsI/53aTzjUTRoh+LYY/LwW2Q/km72JdBq5TGjNdlOxqxwh6RoPy+y+/DT
         L4sfff7JDysECvpNUUf0zrjAym8iBf9HLJ2vsyPQgUPoPrKY8x2/RCX28RXWnWBpq7vs
         aHl72B8x4dcY3u0pC8VT4Kczfxw2QpCVNLjyxJ/1vw49XVHMqe2jJpWl1Q16flXryd+a
         i4Xgjul4JfW4KnFE2QuBVQqu9Rhrsr8ZENi6IEGdv9oQbkIudq3Z6j/s7eHDiTkafiWw
         yVaA==
X-Gm-Message-State: ACrzQf1aPp979xv+Hem6V85k79crjznejuvjAk4SduQBHk2A9mBWw600
	igcTXyhIjpya/lXnzAEze2aKxARXN6Hgi7TjZzY=
X-Google-Smtp-Source: 
 AMsMyM6saEkOL42nI1e8S8TS2s9ZN8nPFQ0VIxvxC5uIohxSQdzF6Ww/SE2JNl6Td71kDXteqCj4ew==
X-Received: by 2002:a17:90b:1e07:b0:202:bb50:1963 with SMTP id
 pg7-20020a17090b1e0700b00202bb501963mr38642092pjb.82.1665500556502;
        Tue, 11 Oct 2022 08:02:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 s4-20020a170903214400b001830ed575c3sm3273531ple.117.2022.10.11.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:02:36 -0700 (PDT)
Message-ID: <6345858c.170a0220.bc37d.5a32@mx.google.com>
Date: Tue, 11 Oct 2022 08:02:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.145-cip17-1-ge85493c8cea0
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs,
 3 regressions (v5.10.145-cip17-1-ge85493c8cea0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 15:02:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9725

cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs, 3 regressions (v5.10.145-cip1=
7-1-ge85493c8cea0)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17-1-ge85493c8cea0/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17-1-ge85493c8cea0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e85493c8cea0c5b53ef511efe088b0749b4d5aa0 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6345749884e6a935d1cab5fc

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6345749884e6a935d1cab602
        failing since 105 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63457a1d35721caf28cab668

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63457a1d35721caf28cab66e
        failing since 105 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63457790a09bce82cfcab5ee

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63457790a09bce82cfcab5f4
        failing since 105 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =20

