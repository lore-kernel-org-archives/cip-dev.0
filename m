X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web09.10918.1652273669326626958
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 05:54:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Y5Z5iKQb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id p12so1956656pfn.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=m35eacqs7ocRd33mqOEns9g+pt8oJx7rnXy0VOojXhs=;
        b=Y5Z5iKQbooijv97nLz9COg6pK64gIWIFgrVmyariaCr5m9hiFuNxB504NaV+x41eGg
         0j/eLAbe5FTjD9S9fUDEnd7nSP2CKHOAuBns+7DvN/GXGWh9W23uKREVd3Qnc3nao/RE
         PSXzTQUsBeD57lCnZV/nEB4n/6KkXUfBg65vP+mFuy8TMReCoG09E7Ach8DkSzWd5Qoo
         e4y3bvciKHLVYJj8UM2P1AwgFCC1uB7gWpx32SYsOrljuhaTAOQsERSeSVMsIKpdS+gL
         Pv+8DPwUGMWOVVs7zHTMXxsSurhMV+xWXNbb6ZEH1kM7G3FpjKg8Ri3PNWAuZd3V4u/g
         F1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=m35eacqs7ocRd33mqOEns9g+pt8oJx7rnXy0VOojXhs=;
        b=EMmPQZNMM72Ag0xT43ewxZy1E7/8PXaoTkA7DtcLfY7nfchPC0jj8eWeMoN/SZ0vKf
         QUxKQpH+LSkHHlJXTpX1WdqKGACIHdVJXbIq+RgeY3RSjXwYq3PddNckCxJVUYp6Pqyd
         PiT2wvoekLmr8W3hUaLzG6d8X1yVdFnTkm43gvhKvcaf03RLvQ+MgcPc0HPHbMJi9BVD
         3AgDg5mv/k/RJ6W4etTyZvg+r8vBbqlDXC0jqB+fsbsEW1M0Sdh3cykObeB8FE8CCH28
         FY5T6DwQ7REOXOB4SUYtJ+Q8KWnr3UAOfsxLYOhUxSrlW7j8IBxARIJqA6nO3olh/45v
         4xfQ==
X-Gm-Message-State: AOAM530VuLKAzc8VNO9aYZMm5K6fLOEg8EwEvBG4YZ67CcriMvvLZKl0
	FINrusQk5qxS1MXF9qNpiIhWD3N8M9l1qfh6JPM=
X-Google-Smtp-Source: ABdhPJwZ/4qqxxkEqNIzh0bdBZCXVm0hyRVRo50GZ1tDOMrphC/mWobS+HK0wrHikcehcoQ9llLAiw==
X-Received: by 2002:a63:5a01:0:b0:3d8:22cb:9224 with SMTP id o1-20020a635a01000000b003d822cb9224mr6751020pgb.548.1652273668498;
        Wed, 11 May 2022 05:54:28 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lk12-20020a17090b33cc00b001dc37aef4ffsm1805854pjb.48.2022.05.11.05.54.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 05:54:28 -0700 (PDT)
Message-ID: <627bb204.1c69fb81.14de.3aed@mx.google.com>
Date: Wed, 11 May 2022 05:54:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-23-gf7cf04ab668f1
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 1 runs, 1 regressions (v4.4-st5-23-gf7cf04ab668f1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 1 runs, 1 regressions (v4.=
4-st5-23-gf7cf04ab668f1)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-23-gf7cf04ab668f1/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-23-gf7cf04ab668f1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f7cf04ab668f124b54f47c93fca7625e6eff3cfe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bacfcc0354e1ed18f571b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/627bacfcc0354=
e1ed18f571c
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =20

