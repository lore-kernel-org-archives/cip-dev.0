Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039B7C433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 11:25:20 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web09.6201.1665487503741695776
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=S4Afx9Hq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id
 n18-20020a17090ade9200b0020b0012097cso1384602pjv.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kMqNDq2OLoTKVhoXXsai6gvRwIN1LWYAasetkz9TC04=;
        b=S4Afx9HqUkpK4wRRbdMPaPp+YJbylkyOY8FqTotobe//aAjD/yF5CdMPiBamBN2hY0
         bbNFOmUfbQHwpG4qACgd1flr03Frh4XGdKvKD8EwlWg1LhZlCZsh0RH456a4lEg9vEGD
         +Xc4RtXeSIwDVh90SpRa4XgpcebQY2YtiCMAnocHKQFoRAjN+CvUfO2rRBwyERrrfne9
         01ZTitNVH6sb6ZfFA+n93Us18XEv0Van8/EYcufmNIUVkzz/EywGsonnaRUs1ps4U918
         WK4XY9a3KCnxpiofshgAD3dCxEx6BpDi2lbup7aY3fqlWgFGY5IlWczabFPVkIlHSVkO
         TuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMqNDq2OLoTKVhoXXsai6gvRwIN1LWYAasetkz9TC04=;
        b=XmSm92dxEVi6Wu1SsVU1NlK7lSMmu10D+y3qO71Ilftrt7Pyzl7GX9hl5PAnR7/dCG
         597w1nVIsnENWuf6SZbPMVspmGUMx4r80TYRMeHIXXjMf0xBkpTY1s18jFZCkkhdFhFa
         I9YXBYgfaRsgEnnpVLgDlP0y+uuoOwUlsm5479vcqGnaSVRgZ5ZDXpO91vT1rkH4tW9Y
         +VkvARl1vddt1BrbhfNG4fVmDx7CKXDD/GwD093Y0NxuLEQtvekAoczsBFQrHdCtzbOB
         qnxQVA0pkJiABH7xxPITRjOkbc238AK4a91VTI27fTadPXADbmwd9rcwBe+wlzD/W2wE
         OSJg==
X-Gm-Message-State: ACrzQf0RVzSimKNoHGofvbBW91RdzMJqruosw6qgbhRqErtTPNXShRWw
	/YBMeBe2km9GXNk9aM03NP+3s1ZoBPovo3V0APs=
X-Google-Smtp-Source: 
 AMsMyM4Mu0DUc9z/4JnSeRRlZnB8xtZ9Uu7qzaWWZvQU8lFhXyY6wPvelI4yC7ijqy8MWWWWP1NggA==
X-Received: by 2002:a17:90a:e601:b0:20c:ab05:f1c5 with SMTP id
 j1-20020a17090ae60100b0020cab05f1c5mr19216115pjy.243.1665487504888;
        Tue, 11 Oct 2022 04:25:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h8-20020a17090a3d0800b001fd76f7a0d1sm10901072pjc.54.2022.10.11.04.25.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 04:25:04 -0700 (PDT)
Message-ID: <63455290.170a0220.a4873.336f@mx.google.com>
Date: Tue, 11 Oct 2022 04:25:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-1-g92b5279a8e1f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 6 runs,
 1 regressions (v5.10.145-cip17-1-g92b5279a8e1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 11:25:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9715

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 6 runs, 1 regression=
s (v5.10.145-cip17-1-g92b5279a8e1f)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-1-g92b5279a8e1f/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-1-g92b5279a8e1f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      92b5279a8e1f1dd8189276753604ca74c0f32a76

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63454425341771d26fcab5ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-1-g92b5279a8e1f/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63454425341771d26fc=
ab5ed
        new failure (last pass: v5.10.145-cip17-192-gbe875d9d93504) =

 =20

