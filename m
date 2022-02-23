X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web12.3558.1645590187395026990
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Feb 2022 20:23:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uMoV1o0m;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id om7so1550250pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Feb 2022 20:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VIUAHpOTdOAYXiyi70r1Y/OI4hf4ZvtDw2f7LPNqKyE=;
        b=uMoV1o0m0t4VyidHMb6I9nWgdoEAy6k47tX9ItXNfudSaagDTSGEpiF5mPvzGduFXt
         /cgaBJOc6BME6CLFLbE8CzHvlPNkeQN56SOiI2aksamZtS9mtwwj57yYa0HL7sbYE5Dj
         kZXcPL2QMQ1vcJCYTvNTo2Obs+DkGAJaOC2x0m9pOMTwg00mwi0AzPQnz7ygtBLcxA7B
         wcgM49yPvqlxilFlUMCSO4L3iXnjZgfS5x71y252Nuu82eFX00GtvxOdebWRAy3m6hfd
         0EHBWffYde9psHloFDJ5oh7G/mvtgDZyAMO920Rqlrgqz6TGFYfWR0MFMdifblkVoWn0
         iMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VIUAHpOTdOAYXiyi70r1Y/OI4hf4ZvtDw2f7LPNqKyE=;
        b=4sT9rVzL3CBJeGANBEImT88lZ+qvhIXOWI4MRX2GLGwpy3MUh86FSRjLS54vYJh/rp
         JefWwM9hLaeihk1FWp+B52pWNKBgnMvjf6v2HJg8wcPXtUUOGIzRk1i5pQ+BlRHf7rZf
         tYhLFiJBYTBs6XTHFOEU7Vxe2VSHK3iVKuIINI64QB2NxcPqIjznnbasZhj70C4YF3Z6
         4tUWp1fsFS2x000Db0vY5W5tVGy68pShx9C0zvnJAMhfHnTkeRuyzQ9YkggxmMq2u8L0
         tlnMNfO3rvbEFhCJSK7O+WyQ87tDXANomHEzn0Q2+L5Iv4N2dGTmUT2i6UnvClIagkBq
         1fbA==
X-Gm-Message-State: AOAM5325v/2AGJ9a0XMWvkK6YvfDLDdvtgc8zORQRubYvNQfDQ/dJBsv
	vr6yfRmDe1BzYgK7dDqmwMyMoO29+DgUsZYa
X-Google-Smtp-Source: ABdhPJxbcUCc9ft1MU71Lw7sZM0qbKA+WGg4MuiBgfPwfsSuGojFnRBYheYWTMBAunqNi44Y2Lcqqw==
X-Received: by 2002:a17:90a:9503:b0:1bc:7783:4513 with SMTP id t3-20020a17090a950300b001bc77834513mr5831783pjo.74.1645590186629;
        Tue, 22 Feb 2022 20:23:06 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 10sm3069546pgn.0.2022.02.22.20.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 20:23:06 -0800 (PST)
Message-ID: <6215b6aa.1c69fb81.c5d16.79b8@mx.google.com>
Date: Tue, 22 Feb 2022 20:23:06 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.100-cip2
Subject: cip/linux-5.10.y-cip baseline: 64 runs, 2 regressions (v5.10.100-cip2) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline: 64 runs, 2 regressions (v5.10.100-cip2)

Regressions Summary
-------------------

platform                 | arch | lab          | compiler | defconfig      =
    | regressions
-------------------------+------+--------------+----------+----------------=
----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.100-cip2/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.100-cip2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cacf08e29f7abd0acd44dd086650d57fb159d76e =



Test Regressions
---------------- =



platform                 | arch | lab          | compiler | defconfig      =
    | regressions
-------------------------+------+--------------+----------+----------------=
----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig | 2          =


  Details:     https://kernelci.org/test/plan/id/6215a91c08e491e39ec62995

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.100=
-cip2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-imx6q-var-dt6cust=
omboard.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.100=
-cip2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-imx6q-var-dt6cust=
omboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220218.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6215a91c08e491e=
39ec62999
        failing since 21 days (last pass: v5.10.83-cip1-151-ga4163710a1dc, =
first fail: v5.10.83-cip1-178-g2cf1d12aab81)
        4 lines

    2022-02-23T03:24:52.676373  kern  :alert : 8<--- cut here ---
    2022-02-23T03:24:52.707284  kern  :alert : Unhandled fault: alignment e=
xception (0x001) at 0xcec60217
    2022-02-23T03:24:52.707806  kern  :alert : pgd =3D (ptrval)
    2022-02-23T03:24:52.708694  kern  :alert : [<8>[   44.966713] <LAVA_SIG=
NAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=
=3D4>
    2022-02-23T03:24:52.708961  cec60217] *pgd=3D1ec1141e(bad)   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6215a91c08e491e=
39ec6299a
        failing since 21 days (last pass: v5.10.83-cip1-151-ga4163710a1dc, =
first fail: v5.10.83-cip1-178-g2cf1d12aab81)
        26 lines

    2022-02-23T03:24:52.760572  kern  :emerg : Internal error: : 1 [#1] SMP=
 ARM
    2022-02-23T03:24:52.761083  kern  :emerg : Process kworker/1:5 (pid: 95=
, stack limit =3D 0x(ptrval))
    2022-02-23T03:24:52.761328  kern  :emerg : Stack: (0xc36d5eb0 to<8>[   =
45.013689] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=
=3Dlines MEASUREMENT=3D26>
    2022-02-23T03:24:52.761558   0xc36d6000)
    2022-02-23T03:24:52.761775  kern  :emerg : 5ea0<8>[   45.024991] <LAVA_=
SIGNAL_ENDRUN 0_dmesg 1609005_1.5.2.4.1>   =

 =20

