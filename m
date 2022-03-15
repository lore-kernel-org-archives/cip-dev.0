X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web09.4898.1647305467953186287
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 17:51:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0xEAMV/b;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id q13so14935542plk.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=FmrZX0GoUzXATbO7/3JrKSbequJGa0y9pIUSN3/UKec=;
        b=0xEAMV/bThefnKFL1dqhL/MIHlsc066BcPWwfKZDPRYfawSHSB01CM9JTRW0Qgi6mj
         irY4k+OlaAIPIuD39tSogMakSr6xcU2clS+jN6syUDlEKf+hJ1GzmRvYmZgAfobc06pK
         +hsvJdT1KtbQAHuILxN8rNCr2r7Mh+UAzcfS3uv/OUBLLfoIcIZg38UAWjpS/6l1/MkX
         +8EsJies9n3tyRjgqPpZa6qc7UeflnUwf829wFiNORc5BNlv2aYc7qh5o3KEZto1W8R9
         RuZzd1HiVfnkrmLPwRnz1889kkQVCiZyQkYOLPQOrqA57sYUoiWIxbcJXe4xF+1/wlcW
         T03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=FmrZX0GoUzXATbO7/3JrKSbequJGa0y9pIUSN3/UKec=;
        b=SJJDE26BeTVRiobygW3yV/dF+khIYXmzFR+qiqXO2UHG3ZytxRShtz/FLjgLLKGuQj
         63Vd0kE4/sJAyzd+kMeO2e2u9Mqf3S4Px4tM68TqFe6ecsN8E9jDRX1evLuLcxjNJrG0
         qanEzdTK744qKsn9qOITVkzxtNfv44p6nsvJWLH9GedG302MCSUaixGVeXl6OXFU+4B3
         xhQxU72+L8WirUcD8PcVnDVxjS1dseOEU0FLS/KQmZ2QE1q5FQ67RwU8CxlG3WZh18s+
         B7sa60VXIYigS8c7WANSoHilHa0WojnQDWy0h3RkA8oLXSC6oxkGlNTTcz1+hBKoEdpk
         4y/g==
X-Gm-Message-State: AOAM5322DtIcmSmJwOwFRXNiTnQO1IcIQjqI15Q7VCb4Tyu2ewurERHu
	AFBnU+eldXO009nU2Ppt5Nq7L5L9CBGIdiDawaY=
X-Google-Smtp-Source: ABdhPJzzJEYCFTvfoQFtuoE998SVDvollKW6hcShoaxXAXaoHAhrFNaxW6MeYNKqyFKEH/D5D/BZGw==
X-Received: by 2002:a17:903:244b:b0:151:d869:3b1f with SMTP id l11-20020a170903244b00b00151d8693b1fmr26264542pls.155.1647305467209;
        Mon, 14 Mar 2022 17:51:07 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090abf1600b001bf4b374d1dsm667229pjs.47.2022.03.14.17.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:51:06 -0700 (PDT)
Message-ID: <622fe2fa.1c69fb81.3ec3.2bf1@mx.google.com>
Date: Mon, 14 Mar 2022 17:51:06 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.104-cip3-rt3
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 5 runs, 1 regressions (v5.10.104-cip3-rt3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip-rt ltp-mm: 5 runs, 1 regressions (v5.10.104-cip3-rt3)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.104-cip3-rt3/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.104-cip3-rt3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1105279cf875fdf297e0225252cf3e595105a831

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fdb271082530cdec62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/lt=
p-mm-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/lt=
p-mm-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/622fdb271082530cdec62969
        new failure (last pass: v5.10.83-cip1-rt1) =

 =20

