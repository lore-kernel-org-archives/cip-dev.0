X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web09.2056.1652134975926055344
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 May 2022 15:22:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=nAunbVcW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso535119pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 May 2022 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nYH9YljqQKGz+PxPHxufZzWMbGMVN0/9Ow9hQpuTgVc=;
        b=nAunbVcWmwlZ1szJmGJat4hrvlGrMkFy2DaeucSayXke9Lqh7Q72Or6P7PhJiRttIk
         F446xLC2P2Y3ykTxRxCGQJFHk63SWUwc8eNa4WSqUJCdWTnBtZjwPiPidye4haIoM9jQ
         ePrM2unr4czrFdP+UZBtocvXgsj38hIig1GEcm9GRvFCRHzICjuI4JfUmOX5bhQraHYS
         HtrP0G/yFXYl7NAr3mwheqCzy2rGE4uk/OalY1USP919wfG2G254cDGndutVh+cTmEkm
         nKiwBT3+nC4IEfogTWpH84M6OExqMNbmr6g9B3kHB9b0kB6RxPNJw9sXe6a7slt/H5x7
         z25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nYH9YljqQKGz+PxPHxufZzWMbGMVN0/9Ow9hQpuTgVc=;
        b=sTKNQuHIlPzPs4xwmnAvGY6Igszu2hZfoEJfRECDvdzyR2Oe/Xps4SlT8pocWeQ47Y
         Hk8oZ0fea1BawopmXXqKSUMe+9BRSnHlHsbR/W3B0n+62T54oULDEp5hSHmD8tFWHsW/
         BmqZ6b1mYNcXxuvqChALD3jopzs/CBmSg15POSO//kxU2IqHYms6YMJ1NQUeqGI6jaoU
         6vE/im4LlFLueAu9MJdyKuRsyMbYXUh2Iyfge4lvShm182VbujPYBl2k/YmuEyiSPg64
         o26zZJlvLQrxyDngiiOThhk+iOFfmr7f2I4x0XNzAnF0iSyvz4M+EnRG2w1LNL3h17ku
         nWOA==
X-Gm-Message-State: AOAM532UzW71xn2mHWS82unZIMxtqSt5o1uIjRTSKLtptfKRc+gQVLdR
	UAx6Jp6Z7+0WxfR11100eIgUtwq+y5ibfL5O96A=
X-Google-Smtp-Source: ABdhPJz/l9WRoncd5xMRmoDXE/3QdKZ9DHkX4qi/7Jz5C5FMovGpuK8hCdtFpL+kzrXi/GK3SAQzlw==
X-Received: by 2002:a17:902:a413:b0:156:15b:524a with SMTP id p19-20020a170902a41300b00156015b524amr18034978plq.106.1652134975201;
        Mon, 09 May 2022 15:22:55 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b0015e8d4eb20dsm384593plh.87.2022.05.09.15.22.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:22:54 -0700 (PDT)
Message-ID: <6279943e.1c69fb81.20075.1465@mx.google.com>
Date: Mon, 09 May 2022 15:22:54 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.112-cip6-218-g8253434cd56a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 4 runs, 1 regressions (v5.10.112-cip6-218-g8253434cd56a) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 4 runs, 1 reg=
ressions (v5.10.112-cip6-218-g8253434cd56a)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-218-g8253434cd56a/plan/kselftest=
-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-218-g8253434cd56a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8253434cd56a1ed24ebcf6bd7bb980b182888279 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62798a62e808e129b58f5717

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-218-g8253434cd56a/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A200=
57-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-218-g8253434cd56a/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A200=
57-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/62798a62e808e129b58f571e
        failing since 66 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =20

