X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web09.5546.1647307800538614830
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 18:30:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=u6TKQ0X9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id a5so17073536pfv.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 18:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8RZ4Mr7mXbR6iEscB+/OShJdpvGCTOD5iFznTZfNBrU=;
        b=u6TKQ0X9zivT/9QLf99vJes3yME8sLaW5ywTSQh8TrC0ctBFRYfAiHYYkhpVRivb8U
         /95p/WRfxR8hIixDEBhiyukX2OMP/69ei75mBLaBD5T9fgIzV/ysggGvpuMBmhVz+it9
         9NPqfg4TEnqs5FlxCa5CFT3ZG/0bDIO4pOiNvtSeYgJ4R7c34x5jqevUCM8fDAwtNUbu
         +CFbvRs7CAAlBf4EVPo+CJESJnJNb5z6feLzx/y4eYxNaZqdMu9/exKniPTIQ3kZNShI
         EL9MMDtE3Jy3A044yuJgMICZKOLfPETmOOFCxT/1VlxqS0l36GTJZ1WPSoUTkhW1w4GU
         Revw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8RZ4Mr7mXbR6iEscB+/OShJdpvGCTOD5iFznTZfNBrU=;
        b=Ukls+YeHaWRLpVu3h9X7UY/DJSlv3P1kAk/hmsqhFS/WnoP093VRK2CSMQCK+GX2uz
         XwvC6lOkTdea6nAbpXNFvbw4jywJFx+7LJ5Y+pU/mJR9gxUn9/jCDXDvH+ULmPieyx5Y
         cDam2kcD+sqOhYhBXI+mGuYrKWIl1Lzn167VDJHj1ZvCY9eRe5pEashsyLDFFckpcZ8R
         KwNeJ+o3LcT87DzlNGAfo+qiFjMhk268R07CWp0rxx3UqQQrfHjvFDb57W4cSVDl/ufE
         ASPFhGeou+mgJPXaCPxU8Gufb54Dm7VYTSLA0TM24/Cdgp94Ye2R9QEqMvMFNU5y4hZd
         uUBQ==
X-Gm-Message-State: AOAM531gg6dEqidXmzjZpDxJpKUzN9usckS2WRcCXCMOBLPYgcxjR5l9
	anAQebixya1ODzoCIFtRsJpugs+lUPJCrmwVaEQ=
X-Google-Smtp-Source: ABdhPJzB3SxGVlNPQzmE9hH01PMh2vGRliLoiOSK4RbQaqraO3q2dVlP926ftsIpMNj4ZdbJeQCmNA==
X-Received: by 2002:a05:6a00:114e:b0:4c8:55f7:faad with SMTP id b14-20020a056a00114e00b004c855f7faadmr26033764pfm.86.1647307798965;
        Mon, 14 Mar 2022 18:29:58 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o7-20020a056a00214700b004c169d45699sm21512935pfk.184.2022.03.14.18.29.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:29:58 -0700 (PDT)
Message-ID: <622fec16.1c69fb81.fea7.7c53@mx.google.com>
Date: Mon, 14 Mar 2022 18:29:58 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.233-cip69-1019-g2e5815777e975
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs, 1 regressions (v4.19.233-cip69-1019-g2e5815777e975) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs, 1 regressions (v4.19.233-cip=
69-1019-g2e5815777e975)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.233-cip69-1019-g2e5815777e975/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.233-cip69-1019-g2e5815777e975
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2e5815777e975e9b2702739a96b2af41357c95fe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd7507f3e137290c62993

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/622fd7507f3e137290c62994
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =20

