X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web12.24166.1647248222241436912
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 01:57:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5BdaZ2Fd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id g19so13714074pfc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VTI+Q/LbY85QvYLN3VyX19dMju0A0AdQt0MP1rDr7q0=;
        b=5BdaZ2FdK0Lf5wLCq9ioa2C6afKejRTeUXSAU12SFmI8O3UZoexadMqhp9F48qcvDj
         ide0pnV9Uh+SThQ/jLDZ3PEduYS/E1kShGMJ331pEy4FqXpYaeemp2+EYFpr20jbnhaj
         fU0TG/fMjUPy8Xqs9QLZz38EwEMvxsNAdOitXnF5e8MZWbJ1isPW8B1sVI9fgXl2PY5m
         YuRb4B0TJDE+TIzWRnC/d3pFud/bgOltJZZFFiWrKFo1FFRUxKGvnfNbRTrvxnXkuC9Z
         BLuuDCkWlPQPzEcbEonq7ou2H+kmSIgbjqSqlagjMk386FiIFJLnB5jUwTPnKqrWq3Bs
         2vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VTI+Q/LbY85QvYLN3VyX19dMju0A0AdQt0MP1rDr7q0=;
        b=2pGhK0zNuzrJ+zQH4z/1OXmKpVcZA7GSY2K8fBLY73w2hEizAUdnEVgX6+xwkgW+xz
         Iqh7dbvZ54MDxgARjh8RqINLGIJA4hymJWxcB1Uni2mB2tOp6PrrsizcEYkU81gb4qYl
         Fi6HRl9DUUQNoZwzEZ+SOK27fy/7XRO08/7QwolIH/U6etBH3LhhXIJ0LdgyC9LSgq/A
         8zxBVtk5hxstvtDIOSD+Sc3EKHDQtIdQa/JrEbJVMkhtOZEC8YgxylT3S11f9oocRVeA
         o9rtJ3dy5iEv/S/sLdDNcxuL528EXSCL/UoyEdDyZCLwAKC/4sTZMDDbQ8bHu/NLmEtN
         pVcQ==
X-Gm-Message-State: AOAM531qIWkIZeteqrl1Tgm/aXT1NDGCyuAdjjE8C+MJz1fL3Gwg3Yyr
	qYgGi8FmLTT5ZAS4UHn4E2xp2PZmBQlLIyuYu9g=
X-Google-Smtp-Source: ABdhPJz4/bUMBbAh+dtr1Fd/78XWMvwIpBJYYaB4ikMbFv11heBnWRtHfd3NvkTug5bjjTqfFbFyBQ==
X-Received: by 2002:a63:510c:0:b0:378:4f82:9448 with SMTP id f12-20020a63510c000000b003784f829448mr19281003pgb.69.1647248221646;
        Mon, 14 Mar 2022 01:57:01 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 67-20020a630846000000b00372782a65d0sm17312370pgi.60.2022.03.14.01.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:57:01 -0700 (PDT)
Message-ID: <622f035d.1c69fb81.3ab4c.b3c4@mx.google.com>
Date: Mon, 14 Mar 2022 01:57:01 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.233-cip69
Subject: cip/linux-4.19.y-cip ltp-mm: 6 runs, 1 regressions (v4.19.233-cip69) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip ltp-mm: 6 runs, 1 regressions (v4.19.233-cip69)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.233-cip69/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.233-cip69
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      adce3ecbc12596b052ad50a96e765702abcbca8e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/622ef77d95cbca34fac62969

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.233=
-cip69/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.233=
-cip69/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/622ef77d95cbca34fac6296a
        failing since 57 days (last pass: v4.19.222-cip64, first fail: v4.1=
9.225-cip65) =

 =20

