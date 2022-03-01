X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web12.7053.1646133990254238505
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 01 Mar 2022 03:26:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7dHlVhv1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 27so14163730pgk.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 01 Mar 2022 03:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3Jrv9TdKUFHEAkSGKt8wrfTq5DU2KGFoCf3/tpuhFCY=;
        b=7dHlVhv1T8I76blkJgv8aolWHwEyyPP5Ev6Ie0kNqfNSc7fXTjgZiOszdcvMzhHA23
         I791Hz0sbsGoCK2AfglvjE1OtUTIMAjrjKGfX3Ffds1GPCDW2lSRHivyeuSG+bl2K+vm
         aBlg+eg67sCC4X06yXECmGUdqbG5nRos2GL8ZBL5YB2sypTS0rs0EOL5QH2v3H+SnSzw
         sfLCD8bB9vdM5OQ8saYSy4lmalHTF5Lu4ZezFbQCHQ5e4u81mi+nOlU3GehpIyw730Sl
         WMQX4G5zpRPMIjpCgWDvDJZBimweb1NHY9ovkoUixWRjRh3JD8Ob5P3Sju5IUpusygU1
         TONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3Jrv9TdKUFHEAkSGKt8wrfTq5DU2KGFoCf3/tpuhFCY=;
        b=BTd+WlzjJed10Mau+EyTf/JdoPAw57P+wY5Hs22u71aCxAScJ1Kb5Dfg4AXlBYAZqV
         NCZcl50fBks7PmKquLPD43ZWegbuU3U945+OZ6s3Wl3ZSFFlzg+LYuQmLiWuuFi60dNY
         d0EM4vmBsiJOJIYqIh2CcQZAwm2ola+2hMyTs6LJW8HVFp3TEB2NAfoD+qDni1tFs4K/
         ES6GEQ/tmVz3z+nV6TlHAsuDTejFf02v+/NKirWgXXx3iwLAkFT6H1kq13wEv+X+bWB9
         V5om7JjAR0fSVrWUzNWtq/iZbrEQJeBmxK6hLtu1NxMq8SSk9trP0bOCWHAxooBmCirb
         e5KQ==
X-Gm-Message-State: AOAM532hnfGthCViy33m14omFUCrJkSz0NsEDlFv9pCXjt4Uh+p/5OBv
	bB/lTZXwAVN3LdwYYsO9OoLPKCIEptXG23PD6Ac=
X-Google-Smtp-Source: ABdhPJx76xesWqfvL1roVIdksUDuFGaYVr5kUNGKNTjBnkZMo4D9HnUsADJauEolIijLxH4nFpbeSQ==
X-Received: by 2002:a65:604a:0:b0:375:5cc8:7458 with SMTP id a10-20020a65604a000000b003755cc87458mr21734370pgp.205.1646133989598;
        Tue, 01 Mar 2022 03:26:29 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b004f3b1c23497sm16925884pfj.101.2022.03.01.03.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 03:26:29 -0800 (PST)
Message-ID: <621e02e5.1c69fb81.b2f68.ac84@mx.google.com>
Date: Tue, 01 Mar 2022 03:26:29 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.231-cip68
Subject: cip/linux-4.19.y-cip ltp-mm: 1 runs, 1 regressions (v4.19.231-cip68) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip ltp-mm: 1 runs, 1 regressions (v4.19.231-cip68)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.231-cip68/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.231-cip68
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c7477548dcf8c653b00e361f7a724f0b94e7d372

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  faffae0b7edd5385c0c5ba08ff03e158aa9c1a1c =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/621df1dbffa4da6918c62978

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.231=
-cip68/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.231=
-cip68/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220218.1/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/621df1dbffa4da6918c62979
        failing since 45 days (last pass: v4.19.222-cip64, first fail: v4.1=
9.225-cip65) =

 =20

