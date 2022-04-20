X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.8877.1650467714892418896
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Apr 2022 08:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=qZnGnVPw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id o5so2260581pjr.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Apr 2022 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=u3bXqsgEklUwiiyyj4IUd/nQinhh20bv15W9n1KE6hQ=;
        b=qZnGnVPw924igZ7mK70hTb0KkvexrqB0FbszwGmka38mKOku/HZS1RPIdBm1u2l14H
         rFDi1t8b+neA29ZBrOAnZwDbgrPeCv6oAirKlxd6YiCy/GHW8zU88vp1sZZBE978AcKy
         0BsOAfQ5P7qpKX/T9tH447fmJcK4+cQrtxcc+AzV5bqAykT6sIAwgw/0oX6woUht3nvq
         NM9dchnwqK+zE0I5NcXAliO1cQZUtecZ41Op1oeq3zqeku5OqhIPMqi02HYM6rjokwmH
         Uqz/CV8dtYwypwfwVoaNytF/Z6QvX9SsxZVhJg8JElC37pWP+EwfB1odT9xKq1hkmwL4
         nxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=u3bXqsgEklUwiiyyj4IUd/nQinhh20bv15W9n1KE6hQ=;
        b=UsY2s35PTHLUPqAyiAAXy9VJ+G+uFHpdgajO0QsLa7ty41JPuOPYmwLXszIinmH8Z9
         qt0Z9JTNkwHlJ7JtnhJufJXENDadKTDWLst2ecAXrunl4ymcGJBR2zT20L6QqHHoEtWC
         HBz/nF9rqytOlWBZGqRFX6yLnJTfbvnBkrI7U0EFZJQ3nvKtej5lTEgBRtkI51KWaHg3
         K7aYfNP9silBjbM4f/6xOHul/cJzAkZ297e8cntdTe31auM5q8C1vSxycBZxwro6glG4
         VaY+lf+kby7g+oGaMnFIopZW4IVsaPnhQa8DfUFdUkG2KQhXW7K0C26wdsBMVUs4rGzW
         Mm3w==
X-Gm-Message-State: AOAM5307dYiYWxNjbTRBivXEUS0l+Dfp2fgbR+zGa1b9mmGxACWaKfyv
	i5rwSPGWUQyogQvO1SrwDNLpkTBxPEl1p2vPIKk=
X-Google-Smtp-Source: ABdhPJynZyC0untiurICA7now2JcBdNYbcGvCGmgdnvKjXffifcBwZB7k8OGX6ZFchOn9wNYPEpSqA==
X-Received: by 2002:a17:90a:df8f:b0:1ce:88eb:443c with SMTP id p15-20020a17090adf8f00b001ce88eb443cmr5024311pjv.25.1650467714077;
        Wed, 20 Apr 2022 08:15:14 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a174700b001d55fe3d4cesm42181pjm.1.2022.04.20.08.15.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:15:13 -0700 (PDT)
Message-ID: <62602381.1c69fb81.48667.01f1@mx.google.com>
Date: Wed, 20 Apr 2022 08:15:13 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.237-cip71-369-gd31a7c52552af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 13 runs, 1 regressions (v4.19.237-cip71-369-gd31a7c52552af) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 13 runs, 1 regress=
ions (v4.19.237-cip71-369-gd31a7c52552af)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.237-cip71-369-gd31a7c52552af/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.237-cip71-369-gd31a7c52552af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d31a7c52552af48848c6ccbbf8a48c4f1cb17bdb =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62601d90222bc224d7ae0694

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220411.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62601d90222bc224d7ae06b6
        failing since 37 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-04-20T14:49:27.164493  /lava-6132785/1/../bin/lava-test-case   =

 =20

