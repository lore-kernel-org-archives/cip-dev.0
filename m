X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web09.4066.1649213189438966982
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Apr 2022 19:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OOOIr5rF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso4516632pju.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Apr 2022 19:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jEifBGXx76cBNx8wVOX22rMNGyFHFnUCSuBTPmXGp7o=;
        b=OOOIr5rF2EXw0yHH0zP3IMobfkHcMrTZ5nBZ9xOY4yW1zaNB5nLzQiH524HFwUGe8u
         PrvHUXjRODzV0Xq3Z628WFWSMPnrfndYkdlC9YH5lcMFlNME9yZIP648w+SBKbqNFLfb
         d6N7I7GMw+NRYi5NJka0bP85Bi4UKNx52Ysw1ZNd6SWXw4tZDXTvSK3b+S8heFh43j3S
         4pbfVxtcvXXjSk71+cHxapwysf7M5b/O5cx6ebCz288mEGfHlxWH3g8LmvqUgA8DFA5v
         nxXhrvyvY0D7ai8Z0vmvx1dSRrZA3e9iW842K4ztov9OFMplEj+fwaFSW/cfETTDcguW
         mA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jEifBGXx76cBNx8wVOX22rMNGyFHFnUCSuBTPmXGp7o=;
        b=sL2r2otpijOg+q5F+zczfdf9Ht36juGT8ff8ERMESjreOXoUE353mRHQDP14hdrt1y
         yfeqXS9OzFJn5vFVplz9yOWxZOFjZnxFeTpOgBlsmFaRmW7daESP9y3cFOv+LxoAHUlU
         HRk21aq/GENHVIjafHSB8A8aFxSbiQfJtcHYFthpTks0WIXFNbJXYdr1ZU2ww0ylCyvL
         jJtb/+o/B8bccqV9zxfa/LLpOOLOBvLdDrONhd/rUehGVChpYjg+8tv300bbaif6gHsr
         Geu6nWBLM5/nutuC2+L7gv+6O/EsoZMnI+ViVD5N3onkSCNhLrDzq1zEg1PhBFWeWr+w
         mOwA==
X-Gm-Message-State: AOAM533uwaa3YXiq8zRkV2mcg8LNvGcUWF2XW646EUcl/FlIRj0Bmtyk
	8qM1Mtip2MEZeVGMRbcFzfnnVMmVWJgbCPhMOvg=
X-Google-Smtp-Source: ABdhPJyZFhRDSYEoYOvx1pY3hMbcykH8RYsIhCUEG6vvlD2i+0zdxbkAsJq+OT510RVSSdLOAuG23A==
X-Received: by 2002:a17:902:c7d5:b0:156:878e:f876 with SMTP id r21-20020a170902c7d500b00156878ef876mr6098016pla.165.1649213188873;
        Tue, 05 Apr 2022 19:46:28 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q28-20020a656a9c000000b00372f7ecfcecsm15125922pgu.37.2022.04.05.19.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:46:28 -0700 (PDT)
Message-ID: <624cff04.1c69fb81.77e14.8838@mx.google.com>
Date: Tue, 05 Apr 2022 19:46:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4-66-gc8c4cc5cdb54c
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 4 runs, 1 regressions (v5.10.106-cip4-66-gc8c4cc5cdb54c) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-lkdtm: 4 runs, 1 regressions (v5.10.106-cip4=
-66-gc8c4cc5cdb54c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4-66-gc8c4cc5cdb54c/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4-66-gc8c4cc5cdb54c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8c4cc5cdb54c5d2534c7533f0cd8a10adff3ba0 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/624cf9edd46d0adfbfae079f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4-66-gc8c4cc5cdb54c/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220401.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/624cf9edd46d0a=
dfbfae07a0
        new failure (last pass: v5.10.106-cip4) =

 =20

