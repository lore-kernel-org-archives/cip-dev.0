Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7E7C3F2D4
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:54:04 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web09.4944.1658400839726176006
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=BlHkfH5U;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id
 l14-20020a17090a72ce00b001f20ed3c55dso1093076pjk.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=k0T5vcLTYn3cOR6N4YOyWotjJ6taPPXWV+wAABtlMkc=;
        b=BlHkfH5ULBIEsnSldjwCgi8SHm4ZuPbJOxM+rQZwFznoWCjH/P5nvudwhSI4WALVKk
         lWKt66IKuZ8AKiowhIZYAglNWFgFmwkqofwbI0xLDy5Ag6zZLEuYwursyvjNJ4+jfzbl
         /5cLWRJd1Pk4kalVryk1n/MG9KliXEPvm9SYCt5boElOtcx210UVUbYcf36jRcXDg0f4
         anecs74PSBsIDvRmACPulz0vSpT+5cm+luzdNNO9o+9CdHGplMT5N5bA439IQtz2NxxH
         hnUsJJpA0rvIk5fX6DcNZv9/gNfq2napIMc7feLk2MsIAVLy932GFOTt/MrPR1CAxdfm
         cHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=k0T5vcLTYn3cOR6N4YOyWotjJ6taPPXWV+wAABtlMkc=;
        b=syB/IzXX1pETrNsBMxajooKNf/pqppJIO0GdUrqJV/09BUC80kN0NH2vnYxCWKTcjr
         YQJQg+HFiWCJ7N9kLqH+MGzVR0c1qhPa0Mew/uJQMJ2LkE5AyQik9MpXJ0m5qVsWLas3
         MmgGxJk1hcKYNsVAECc/Mf6R7Rtz1HHLjNOMHyz9T0wQgVEw5tu/G1+Bist6AJBhkPAr
         aBxdrs5ZQYQhJyNmSDFED72/VxnayMPvWGqYhOZOx4+qGlA6aLhVNTNbqurVilojrEAx
         uIn0rh72IsLg+PGWY0O7/Dqx4VZtHUhJjvZ9WL887grBANINi59tXr4PEfQKvmeTMTJA
         8HLA==
X-Gm-Message-State: AJIora+YNYua6XqeF9wQxYtLPAVql7JRlgNyTvkMBeY71OR5Fj7lAdDL
	6On+cRpTZsiE/iSdkbaMUZduyV/fuhUl9Ylj/TU=
X-Google-Smtp-Source: 
 AGRyM1vGSm7pxhX32y9XVOjSojoA1s8+hF16edqoULsNixxeROMoh6eJz0qCNu/hAf9nYr3FGaiBkA==
X-Received: by 2002:a17:902:ab53:b0:16b:ecde:3dfc with SMTP id
 ij19-20020a170902ab5300b0016becde3dfcmr42787757plb.131.1658400839054;
        Thu, 21 Jul 2022 03:53:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i127-20020a62c185000000b0052af2e8bba3sm1407505pfg.37.2022.07.21.03.53.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:53:58 -0700 (PDT)
Message-ID: <62d93046.1c69fb81.b0df0.24ce@mx.google.com>
Date: Thu, 21 Jul 2022 03:53:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 6 runs,
 1 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8878

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 6 runs, 1 regressions (=
v5.10.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/ltp-pty/

  Test:     ltp-pty
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


  Details:     https://kernelci.org/test/plan/id/62d92428829327238cdaf08c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62d92428829327238cdaf0=
8d
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20

