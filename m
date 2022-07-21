Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8469CCA48E
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:54:04 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.4924.1658400838308956244
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=hTZiHZv2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id f11so1457960plr.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=42IHtVQaNR7f9O0b3/2fYqfzPAEw0IQIxfsEQPkM7uk=;
        b=hTZiHZv24uY1y3dgo811lN+Np7YGN0CfmKZuUhOLQ38kdNTe0PnhU1IcyUk9qV4FTD
         RoxVvNCgqn/eOxwhDp1ctG+WkwyVKtWsNls8EIhMOBMB/3142VZbusnU48oVH7wHYjBU
         eilp9l9plvdnWJ6lulwjiSmfTCibIa6q56gPUr5ldW4D5elDHqm/BkCT7u1eJTBnNaEy
         c1GgoPWglH/bLcrW0H3YnJYV58ytpTH8umuTM5UdzI2pY0378Qs9mtlqRjzsb5q/ZDFy
         +cCM+yejZjBolGwNY2S7K1hga+poRAgrPCSBqll7Gay+6Ow6casCgHtlNlnQ87hRFSt6
         amRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=42IHtVQaNR7f9O0b3/2fYqfzPAEw0IQIxfsEQPkM7uk=;
        b=nSE1JxNXZXYlBLSzQHLxP1wOqAu/E+Z7wSkUOtqIxh52jqAfs8niLNJVWnEm6NdEmE
         23QTxwuMuF3nGFltZQ69XglBh5MnolcqTeJVzmPsvPOG2wTrJm6BDOU2VYjg/suJImjl
         sdSjwE6sGh9QPXt7CWS62ZzGw9l8P1wESOXC6OEDUbHmbstJ73aKeqUQyeLEmpArKZdi
         5/SusuoHbtvjy5nIvNm82wFpbBP+pE3e2YnVdMFMjYU90my46OWDgWq9GHOZr8rnNcvh
         eOymjqzDJL3ZqBaCEzP55BkCSq5iZNuY2/XUER92H8alO1X0Y08K2KVPujLhWyfY5OV8
         t/yw==
X-Gm-Message-State: AJIora+yGdSM7bCic3GAr1+5i8e1LtCz0dYCjKVR2iJ36mTn59L6zObf
	qsG3NpJZGVpQ2+lYJgrC565kV/BAMV9AiRqldiw=
X-Google-Smtp-Source: 
 AGRyM1sUKeQ42EPX32jWP0K1Bxu8mRMUgW9isvyKpqgvUb3DVnY7hSiKYyPmctsfFSDc2fZ7AKvcFw==
X-Received: by 2002:a17:90b:384f:b0:1ef:e95d:de66 with SMTP id
 nl15-20020a17090b384f00b001efe95dde66mr10430885pjb.174.1658400837652;
        Thu, 21 Jul 2022 03:53:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z2-20020a1709027e8200b0016b8b35d725sm1371904pla.95.2022.07.21.03.53.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:53:57 -0700 (PDT)
Message-ID: <62d93045.1c69fb81.27629.21df@mx.google.com>
Date: Thu, 21 Jul 2022 03:53:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 6
 runs, 1 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8875

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 6 runs, 1 r=
egressions (v5.10.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/ltp-fcnt=
l-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-12-ge4e007863cc76
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e4e007863cc767efd75ca69c0b98e5daab0c20ff

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d9289c9392949554daf063

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62d9289c93=
92949554daf064
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20

