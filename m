X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.22559.1641992262492113776
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 12 Jan 2022 04:57:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bDtEyyox;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id l8so4008413plt.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 12 Jan 2022 04:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Kxru4u3pcO18o1kD/hzkgFHyhmSSxWNecEqJrivgQWU=;
        b=bDtEyyoxF36/7TP/0CD6HYflL4CvmzOoP5sDIFS9xXXsBl1/kD0g4du+eaFRkazElq
         miXrFd32JlEcDaR6biwVsGx6aNtbBiaQWhnMb28SoFNzsQvlm/Z7jkj355KhXfciaVZr
         zcod8wEPn6xsPcW0jhpDcH/JeH15TUnv8cBbD4D0myzz8LQkAXjEwtujY7OS/dwj+FQi
         4JqGxKH214pjGKaXGD5xEJzZS5A6F1hgcc22Y+KNwb3Co0RIRgD9ziD43TE+V+IIygMu
         FH+/7KNOejEmXJbeWdFVf+cBvTYxZtz0HtOpBK3yOdD5CGvTbP3N7oYa1srGjw7jzgOw
         Up9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Kxru4u3pcO18o1kD/hzkgFHyhmSSxWNecEqJrivgQWU=;
        b=YvJKXb6dgRWGLBRVm6y8amnzdluxh5O9ls/6FbnaLfpfGkhgQluz+8hT7YhafKJcdM
         ntQO665NICjs4qtD1mRtLAm5eTZoMM2Wxc7GKLp8qDWqXVy7tj5j348iwHlasD+Lv8eT
         ymr32pxlXBJXkfcHnGC88CeggXncCaN7FuTII7anSPBH2vcYstryYTd1FYIe6fTkW0qr
         WGuPPftbcPMRnbsjiYvnaX0/mCTxjIOKsKmGp0X57fnxs//mbcK7HY/j4rrGbHWq/UcR
         71KXzAv5oIOPH+3iEy1AWHrwh2a65dERHTAbsZEIcqMvPFgECfeCPmouC/lO1PKGUyVY
         uD4w==
X-Gm-Message-State: AOAM532OQhbKLJ4uSUqTItB3bFSrTF27743/qZeWKQ6kJxiJ0gsIXlh8
	X7zfOV3T2MNdMbpMWwC9QJV05EX/5zolGjat
X-Google-Smtp-Source: ABdhPJy25rVCA7ouEmvSEybDjum6j4UNy3glZfAg0qPzP5MCITDmpGYenrm+2UKGdWXN+VTArG5PwQ==
X-Received: by 2002:a17:902:9887:b0:14a:199:bc51 with SMTP id s7-20020a170902988700b0014a0199bc51mr9543223plp.39.1641992261839;
        Wed, 12 Jan 2022 04:57:41 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a9sm13342612pfo.169.2022.01.12.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:57:41 -0800 (PST)
Message-ID: <61ded045.1c69fb81.4a777.1bf4@mx.google.com>
Date: Wed, 12 Jan 2022 04:57:41 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.83-cip1-150-ge27e063993d9
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline: 169 runs, 1 regressions (v5.10.83-cip1-150-ge27e063993d9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline: 169 runs, 1 regressions (v5.10.83-cip1-150-g=
e27e063993d9)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-150-ge27e063993d9/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-150-ge27e063993d9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e27e063993d9bed9942dbaddd575086dccd29623 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/61dec875dfbef98145ef675e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-150-ge27e063993d9/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g=
xbb-p200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-150-ge27e063993d9/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g=
xbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20211210.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61dec875dfbef98145ef6=
75f
        new failure (last pass: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

