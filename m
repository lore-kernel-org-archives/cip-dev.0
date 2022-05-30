X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web08.38926.1653929488822174637
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 09:51:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XklHrWMI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id a10so2191762pju.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2n9VX45laOq9fREWZg6SpqGDYoFb3BRgl7PfVZix9lA=;
        b=XklHrWMIm+JR/2NWfGIHWUn5BjrfYsKK9QFLGrBv6fg/HmTfkllvK5e66yvocIpyK1
         VpcWr+nG2LXOHa/VMS2hB4X5NA81vZfk+MgydHMevR65b9BMf/1QLg+Yv5iW7y4q9C+6
         H8g3joywugVtlxXo5qVyY5ot7MTghB9h1dQsZLgqfIrmApLLAv4RuLnztAgeAk7379gm
         21lGLDat+mZpgfV7nYQt1EgeRDGxrfJCLSe/rEnuLzKZrBp0guRS8FrA+LYTfzPaHfr0
         59qbL8UORnai4nl/YVocNnaGIoXgMEbunRAs7bgGvYFNYZM8wX5kuMge55ixIEY6ECz4
         lafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2n9VX45laOq9fREWZg6SpqGDYoFb3BRgl7PfVZix9lA=;
        b=6/UbtDQf3itSEiRY2KuA2KUo3PnKSBRJn8AmHCW2SLvSH2DRu61gzEXYKba8i7mqDf
         0nfShQLD3byRHOvtQE5RpS439b8Kvv21DF3Zf73JvlUVNE9WYpWOIIqSdG+92OmrTFvq
         w/v9KE3KHxCSIHZ6ESKFno22z63narTGuD0Ta2hYw79A7C8ogvgSht0zADFWUzuSdfYq
         fSh8CBjUaUu2vK4vxmmtV7TSREQtwl1sAo185IT9Gt9v4HigaqvuafkSa7qcuas7JG6/
         9lQ1ePHO/7QgUBgOFXwUBUuMRXEAKl5cSKS/UwX1D3sjwRP2Po6Zm5OnLJDi/f/Y4/v1
         F5QA==
X-Gm-Message-State: AOAM5300+BBoPkoe56OiD1icxgQA9umLO7wCOaR9UbZ6TmP07IcdrWl3
	gqoX+1O1X44owavo/S/eje3D/AuHRYr1HnigEG0=
X-Google-Smtp-Source: ABdhPJy6duA+IKHZsj9wyyCJ5zeA1C4/EYDkevgCS90vspkYmFi2PVKtxihrH5U8L4BsDkN2tcG+WQ==
X-Received: by 2002:a17:90a:5b17:b0:1e3:2d12:65ca with SMTP id o23-20020a17090a5b1700b001e32d1265camr903021pji.71.1653929488022;
        Mon, 30 May 2022 09:51:28 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b0015e8d4eb1cesm9622433plh.24.2022.05.30.09.51.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 09:51:27 -0700 (PDT)
Message-ID: <6294f60f.1c69fb81.fa5ca.5ad8@mx.google.com>
Date: Mon, 30 May 2022 09:51:27 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.118-465-g0af29783a3c9
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 1 regressions (v5.10.118-465-g0af29783a3c9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 1 regre=
ssions (v5.10.118-465-g0af29783a3c9)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.118-465-g0af29783a3c9/plan/kselftest-lkdt=
m/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.118-465-g0af29783a3c9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0af29783a3c96b3caf71bb01eb38e07102566f10 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6294eb69a8adc66adaa39bf4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+kselftest/gcc-10/l=
ab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+kselftest/gcc-10/l=
ab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220527.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6294eb69a8adc6=
6adaa39bf5
        new failure (last pass: v5.10.115-cip7-81-gd05f72e501084) =

 =20

