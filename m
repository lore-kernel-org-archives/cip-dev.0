X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.10304.1645709997090261703
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 24 Feb 2022 05:39:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=CwtoITWY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id v4so2026692pjh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 24 Feb 2022 05:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=j6gpo+ThdAs2fhUUa/ZrlcUP7bUzv5DWqmR/gmHdyNc=;
        b=CwtoITWY3qbNjSYojVgZ6d7k8t/IKQn7ISrDlGCZfW2OBQigjPrAETq6oLVOFRyorm
         qz1KTX14Dzh7czqklNxQc46naBoeVsCH4EiWy4e76UzmXzuVYebGFfAMIrcDSVGF+urr
         5RQ/6eBTo2Ip3/QaoZ0ESoew4VyvWmgrM7HrMiD1XmIpTG5l6/hDdkB6eE+EKbvo0KK+
         Oi2B1F5xZWsYp9DqpwH6LSUacisLhBNy1Nup0KeHyD/G56oa254kKx/yyRG1C/tEaS0m
         A/wwVLwvjpdn9T/92X79lendVscdKEbr2crv1sVzTA2ke36fbSxnTp2M+3i0V8oqO9l7
         KfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=j6gpo+ThdAs2fhUUa/ZrlcUP7bUzv5DWqmR/gmHdyNc=;
        b=m4DlojbfjikkzokOHxQYqGREhv6lXzTRO7l8Y2c3rWn5NPutfqN1RomQcuPNH6q4Jj
         tAcqiUTeTvC+lKRNmY7FA3QZgWNfbqhOzp+eslcMqqVMki8JPTmJt5SE8SJCCaSxeCBO
         GvV3nIs1k2KvNtVeGAEgQBDtPetn+lL6evAB6yKNRE6qKJtHcx0hIz5tQ0RkJ3+5hB6H
         Eaibzn2aRjPdrTw+Arusp5vXEYhIVi7wJZgFsNGyc0nftu7bjb4r7HvHW7eviX1KOhZU
         VyykUcxir+KhDzq9RNEYkv3HEURgLTylvMjm9rkB6WbYYs8n+NWKYxTTKdG3muRIFUNN
         ZImg==
X-Gm-Message-State: AOAM532UGwSmzAU71HxBiyX4ax1uQzERA1L44JPSxzVJBPHA2v8V02m8
	fWBKtUb8+MvFUSLy5T+pwsxnk8XBuAyZWgaHsKo=
X-Google-Smtp-Source: ABdhPJxaBhW3ur3hOumMvqghNL9EXwchuFfJxtjEIgDx8+69m+I2OFIdEBs7CfJ4eoSJZMDOXQL8eQ==
X-Received: by 2002:a17:90a:6543:b0:1b9:1dce:a23d with SMTP id f3-20020a17090a654300b001b91dcea23dmr2808662pjs.243.1645709996441;
        Thu, 24 Feb 2022 05:39:56 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r14sm3636021pfl.62.2022.02.24.05.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:39:56 -0800 (PST)
Message-ID: <62178aac.1c69fb81.4bae.8e29@mx.google.com>
Date: Thu, 24 Feb 2022 05:39:56 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.100-cip2-rt2
Subject: cip/linux-5.10.y-cip-rt baseline: 81 runs, 1 regressions (v5.10.100-cip2-rt2) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip-rt baseline: 81 runs, 1 regressions (v5.10.100-cip2-rt=
2)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.100-cip2-rt2/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.100-cip2-rt2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4fd346e094c9f171fadbb5c9945188e761af7a29 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62177c8e776af96786c62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
100-cip2-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
100-cip2-rt2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220218.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62177c8e776af96786c62=
969
        new failure (last pass: v5.10.83-cip1-rt1) =

 =20

