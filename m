Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC73C4167B
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:50:38 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.22500.1702561837618539626
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:50:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ALXV0hum;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d345b187bbso24284395ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 05:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702561836; x=1703166636; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VZbx4Rwe4MH1fmAWZySFwwE2tJKE3V1z2PvoFnXJCyg=;
        b=ALXV0humX5A6VZW1I5UPjCTNELwAfJ3EYDQxRa8wRinkxm0VHdIGA7EB186d0R21lk
         evsX+QxxTrptwDBtkGyaNBZ6BHWYYMtOEMFfF3XXZbgVH1Q3INz6KqtHSOymIk+ixmJi
         KypyhuIVa6JTRXKupVaco5+mu+4eC4oTKNBBvMog/tdxhe9VaPxnJUTZPiDnhcbzfet4
         F8D/9BHGxVqSmoalSO2gRFgij3YHLYVaHancIi9l8cAkqnfimumUoIIv1wYledJPSyhm
         tSk0rqbAXPWky1vf0BU1FLTCbQVAfSaEeG9aYGrDF9+YcypWtwfAe2v1FaHOANrhP6vS
         V2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561836; x=1703166636;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZbx4Rwe4MH1fmAWZySFwwE2tJKE3V1z2PvoFnXJCyg=;
        b=EKfWIUp718nt4hcl1zBcWOSD8ltR6DpvWQ5qnsywcsU6lqspiJSdisJaBpVy3dECbf
         FfZ+ZkERRkxlCwNM6MH1fPc/0J1YOhgz8p+IMKhOGW4UPX9WbJzv+yD8FWNpqCz+jK8c
         Z9Zds6Cn6LYjsS32U0Dr6P8RaZhdDlKS5vancOcrTE6peE8VyLPQsAgAvwPDNONYmS/D
         9q7uspH/YoLCHEDMiKrHZgnfw/tmOX0mxXH3LUpQcPpKdluydaok1AunqH15tMK4ykQZ
         DU+CPZWcqHjX4Jmy/Y0Ffgs0MiiME1KktAO2BTiw547P0JHlr+yl9u55/qAxazepdVbB
         Cs0w==
X-Gm-Message-State: AOJu0YweCQ0KrvfSD9O2Sk5OzIDA5Rs5GJzbfX6Sm/pmfoIUlPU1uSEV
	1rfTHYIIw80asF1gxT8V38aRZ7xbcRVaEmmrI8M0kw==
X-Google-Smtp-Source: AGHT+IFAwiAZtfEkuJ9kQeTNAX1Hvp38hYiyS2Ff9qwnalszgFwtzScOGMXpYvD0nqB4VdntWHuE7g==
X-Received: by 2002:a17:903:1d0:b0:1d0:9e59:35e2 with SMTP id e16-20020a17090301d000b001d09e5935e2mr11886227plh.123.1702561836536;
        Thu, 14 Dec 2023 05:50:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902759500b001d326103500sm7167490pll.277.2023.12.14.05.50.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:35 -0800 (PST)
Message-ID: <657b082b.170a0220.d482e.787c@mx.google.com>
Date: Thu, 14 Dec 2023 05:50:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 8
 runs, 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:50:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14103

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 8 runs, 1 r=
egressions (v5.10.201-cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-69-g8f7b450fc28ed/plan/ltp-fcnt=
l-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657afad9d6bcbbb27be13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/657afad9d6=
bcbbb27be13476
        failing since 21 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

