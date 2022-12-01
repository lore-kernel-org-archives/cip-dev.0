Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A14CC4332F
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 22:23:37 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.59580.1669933415630966215
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Dec 2022 14:23:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uG0GokKO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id a9so2985885pld.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Dec 2022 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a2XPMCsOQlSe0ViYnlx+AkCIdc78zuHrnvq5Yf0rE/U=;
        b=uG0GokKOk+7VL5pg5xyhKFvkTnMdTXrdqTwvAoE2a1WXBkQhTlU6vIAmJzFDu3OesQ
         dOY6SgyWPiIO4l+CGO7XCmjQ0KCIbE1jt40hn7z147Nhf/6LBbWiafiZ2GuFG07o6yjj
         VP+Cq3oL6uHX6+i6IG8ZRibk0B6sDnQvaEciQPCnWUYA9zWI/3q6YcH5Z4mAbkpyiD3B
         yAogUDWu4ZNlKKg1EFhM+2YVxrfNfSe9lC+kVXnAJBPFljNiTVnvRQOx4mLCK9Rh2haX
         Mk6yU2afLdv4XShb54vUDkNNWajOdyjq9zyf7wSjT1jA1ZFSp/CJSyrtoQSLWe2Kbw44
         uZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2XPMCsOQlSe0ViYnlx+AkCIdc78zuHrnvq5Yf0rE/U=;
        b=ofBHdPFTXxFdLStQTxJzP46Tb03SKshMt2fvvLODj+NXqyBUkYQ3eMoBFDx9OPsAUA
         H1bJ5RqN6wIJUDN8qkgHhtpIxsp8tHHXpHqCatyw6icK93N3KqGs2C/57NVpnUyrfaEo
         MmOSA2X1UDXNs8itFyh7IteyrcaibiDfxTLgJqPPqn9h/bSXwAeKIP4/RDmolqaqabmF
         17cPVyU3d/5QCaW1YcE9sR3o1OWoeTMVtluBOnNRD0Qu5ryTYtnBTwAemwqpZ0yBE+uS
         dv6xzD2BqqazU/uDXyz9K3ju8+yACTM2NM4jVNGiZ/ex5zEzI60ORrks3jswuKbUGCRh
         1yXA==
X-Gm-Message-State: ANoB5pl/3XprwDqnzSYzfXgyTWfGJErJJsqzW1t5hk4YPuayYfectoOC
	mkbw+bsaCVdDb580kdeHlV3G7/nlU/euOqm7eLA=
X-Google-Smtp-Source: AA0mqf6UyU4L4voliGMPnvDVKXqAKc+WtleIDNdspXbNyJ30mQDaEW/fTfGknFAC2Tw0Oc4XeFLEvg==
X-Received: by 2002:a17:902:e849:b0:186:898a:f33d with SMTP id t9-20020a170902e84900b00186898af33dmr50249072plg.33.1669933414839;
        Thu, 01 Dec 2022 14:23:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f205-20020a6238d6000000b00574679561b4sm3723573pfa.134.2022.12.01.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:23:34 -0800 (PST)
Message-ID: <63892966.620a0220.4efd3.77d1@mx.google.com>
Date: Thu, 01 Dec 2022 14:23:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71-1-g61333eee4869
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-pty: 2 runs,
 1 regressions (v4.4.302-cip71-1-g61333eee4869)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 22:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10159

cip/linux-4.4.y-cip ltp-pty: 2 runs, 1 regressions (v4.4.302-cip71-1-g61333=
eee4869)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71-1-g61333eee4869/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71-1-g61333eee4869
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      61333eee4869050c46b5f75ae6d337998d39f2a0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  498247917f40b0a82cb149e2ec1cb518acd7b632 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/638916228b92a69cc12abd00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-1-g61333eee4869/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221125.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/638916228b92a69cc12abd=
01
        failing since 140 days (last pass: v4.4.302-cip69-296-g52de9431d314=
, first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20

