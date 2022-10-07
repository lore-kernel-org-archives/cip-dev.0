Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09CC433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 11:37:54 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web10.3311.1665142661945588219
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:37:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=0p6N5Kk/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 2so4424621pgl.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4pKlfeqQke4r9Sa5jnCby8wYuWS9hN51RQ/yyWCiIHg=;
        b=0p6N5Kk/w0SEqDlBfMseE+8Vwk8dWUrJzyIwoWvQDgVPw+yA9XUObmkFClRBwbKTDY
         7YHLVWjM+pPqtT/Voi52QYk8LqEKXcgE/5vNWWY+/Tcn0EqvGg7zTlks/DOeFgZx1LLz
         Ygrcyy+k/su4yZy4KHKLXjLjiUCYrbncSuv/+bfzhbodfsf+Ump4+k7luq5D+u/MWWxy
         rIcP15RVmInqGG3Gh9kLVrCiHwcwyoJ8ESeALuxMNKWmKMgX0TaFDaqv9Sahj2C4aRkv
         aQgT81l2p+aOUsPsMMNvK/Q7pMIn7RUR96aEIERdPYw1QKHMV5xVIbQUvuVvWmOuPqbH
         Ct1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pKlfeqQke4r9Sa5jnCby8wYuWS9hN51RQ/yyWCiIHg=;
        b=Ux75dKf5yve2PFKUb6076Sn9+bxaJnRUj3JrRf75hzKNF0/4J/ZWtwJBwvE96thYMU
         pBalykMZaOM5PKefPABrz8hxhGMBRcU+CsjTkDbWOVbk7suDkfK2w8pPTDB7JhfcwOzK
         eRev1KB2qU49PU7ibtSHClHPAP3RqccWOUse95OmAYL0gWnQY9ts8V/gCmaPAmNg/LI9
         CQWN+DvhS9LD/M9XB5d6G1LcZD99sPo+Sdh4gvCgQ8k0ABE+pG9OL22718/vNwlDZE/7
         zvWVNKLg/2jgvvVIKyndLv1Ta10mc+XyIacuWlTY3J4SoTRAi/9l5eSQlXzR4VlNfJZ6
         q4CQ==
X-Gm-Message-State: ACrzQf0eJsOwdC/P/82qLkjBLPldc5WWdWm5efLh93Cfu7MjvXgqXCab
	FSig8C2iBIXRBQ1L4Jd1v9cJyIuGCGGHWl0d09U=
X-Google-Smtp-Source: 
 AMsMyM65soAXDC+tATSsUXBO5Gi1j3jbNEd4VcnsaQOMjIuT4jYFlrqt1rPORdMG82KbFRny6GK8AQ==
X-Received: by 2002:a63:1203:0:b0:43c:7fa:f306 with SMTP id
 h3-20020a631203000000b0043c07faf306mr4150520pgl.169.1665142661063;
        Fri, 07 Oct 2022 04:37:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c2-20020aa79522000000b005625ef68eecsm1400984pfp.31.2022.10.07.04.37.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 04:37:40 -0700 (PDT)
Message-ID: <63400f84.a70a0220.80872.25a4@mx.google.com>
Date: Fri, 07 Oct 2022 04:37:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 2 runs,
 1 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 11:37:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9684

cip-gitlab/ci/pavel/linux-test ltp-mm: 2 runs, 1 regressions (v5.10.145-cip=
17-rt7)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-rt7/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-rt7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63400f61b00ec13782cab5ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63400f61b00ec13782cab5ef
        new failure (last pass: v5.10.145-cip17-421-g0d804ef4a611) =

 =20

