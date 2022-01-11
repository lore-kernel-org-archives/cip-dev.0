X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.12528.1641928042786677347
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jan 2022 11:07:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gGKBsYGG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso7155031pje.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jan 2022 11:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=bB56GvtMu2Apn+MtYxPBNegvVrBN+NL5wMzRCbthNos=;
        b=gGKBsYGGdz4nzHiIkjAjynwlVNwjjm0IspbSbyDTKH1ODKmfxw1JVw90dFe0Vxi2ka
         yARs+KonoOTdMndVut+zLvo7jmLENxo87K2gmXVA6nBNJJGac1l3V5FoZqzN1a+aEa3u
         CjOkgEMWwxJhfaQH+1vJbFpAIYHXAs8JhoM1WQh2KnY+s4ES2Bb9eU2MWATfQrDl+MSz
         ktdvZIBtBgUSxKrViuxJ7h5wTSdHMwzKqJ5H6dk24SQDVd/1ZdHiSAodMionAnaP6AKI
         kOsH/X8+/gIgKbaSKAfOgjEBECe4Fh0R1p7l98pFgIJO6nGa0TsySLDCxWW3LCzxsqaz
         pYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=bB56GvtMu2Apn+MtYxPBNegvVrBN+NL5wMzRCbthNos=;
        b=PShlzIPT/Imh1sEjff+BkD1GZHJ3Hd/eAskJCN3/qEJr+HUdIKG5qfMPMIAsY4Ri7L
         UyZOIX7NW/dUcv3LksTyZCsdetGOalRv4inSiQIyKtRb4Pq3OyYLDmcDIk4crtsbArOh
         zVYV0WTiLuQGEWM52irVhfnI/6EYamH94UTHTyjwQlYtBdddf0H0k1LLOKbSp7Sevy3K
         QYNSnGx70sOFnPfOsr/+L5qR5djR1MJpltJM4U26fi0GwTjzZJ6Ri2uav/iPPZrVeXsT
         udg4ix31b+Gb5CJxZPrqbQ6vVV2xJk3Za2pkaq1uH1RfOvuQ4eU/+jbvqy8pDwP1TSOz
         dLXg==
X-Gm-Message-State: AOAM530soxYI1kolSxgS3uKiXeP7/XejlO8621rOajsoVyZG2zqrji1Y
	srfefvdQo2Fy8SXNM3GJ8zupmLFJlSyKYbqO
X-Google-Smtp-Source: ABdhPJzRk1xBWO5P0rflItHzOOi33dqPe6VWtRTXFyRJ3QY2t7IuGnBONpTk3PW0ojLWysmy91SCpA==
X-Received: by 2002:a17:90b:4b8d:: with SMTP id lr13mr4757304pjb.192.1641928041987;
        Tue, 11 Jan 2022 11:07:21 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f12sm11306996pfe.127.2022.01.11.11.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:07:21 -0800 (PST)
Message-ID: <61ddd569.1c69fb81.352e9.c283@mx.google.com>
Date: Tue, 11 Jan 2022 11:07:21 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.83-cip1-89-ga7f9ee34265b
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 23 runs, 1 regressions (v5.10.83-cip1-89-ga7f9ee34265b) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline-nfs: 23 runs, 1 regressions (v5.10.83-cip1-89=
-ga7f9ee34265b)

Regressions Summary
-------------------

platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-89-ga7f9ee34265b/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-89-ga7f9ee34265b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a7f9ee34265bcc306fd450f83524d631b74b6dbb =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/61ddcb9507b26652b6ef6767

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-89-ga7f9ee34265b/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-r8a7=
7950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-89-ga7f9ee34265b/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-r8a7=
7950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211224.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/61ddcb9507b26652b=
6ef6768
        new failure (last pass: v5.10.83-cip1-74-g842fbb4554b8) =

 =20

