X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.58552.1643766112622435016
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 01 Feb 2022 17:41:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BIWjmqvx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id cq9-20020a17090af98900b001b8262fe2d5so1020140pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 01 Feb 2022 17:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+gzmsiSN7dnu5lo7dEPpfnVmvua7k6d9dmJ10eZ0zhg=;
        b=BIWjmqvxO5l1SKJgmo+X7FB8TsmBrhendkWaiplX6zPwO4+W1M2BOKZwRQ+PeypGYj
         moM8nZE7V8dNVeyEG8Lb6XoZxBlEWOWURPdXPxUIC5Cs3kfsCYMohfi5AwYYSBpqE29/
         wM8wPdtyMnOb/40Nb/R4TLAfv8dV9JYKx/QG0jzLQVF5PZT7LtFyluQEywlyJlbtFgCl
         w71AV87if8hMBRiJqdHCU1sg0Hr9ocyAnBu2cpw8OV+kWNu5/euIlAlv8yKS+5VfnMKP
         qVt6/h1zdS/vh4hTkI4If3AdcLmOEE1mhS66xCI0MdmTVgOwlqIV9guVeB8tgossmtJ2
         be8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+gzmsiSN7dnu5lo7dEPpfnVmvua7k6d9dmJ10eZ0zhg=;
        b=Kbr/rXHneZJqkesSSMazj2Dh9Sw+CYJKoCrY/qsv9rDk4KZVqFtz8nD/0Wkv/TPxR6
         s0WhipgREECwfzAMsR2bcG/RNuCgHIEFOyJnQ0Wa+hsM6COicN1B5sOozFR+ao8l0Lnw
         qct9X5vSAWNG1H33SqCdj0kUMHrMKw+CCYiK3aay5j5bMtwz3WaaRwoEGuHvu40fi1wX
         bOk2to+8EoBTF+EMS/m1B73SBwg4JmzPVdYWzYXbfDI10199waLyWdUwOqbVKD0FN8Ob
         fgqIMkdtI4vFVIy5qgSkztyIhvkChPnJLyBKmUK/IkyySdR0p0K3aEMRnB5fPscs5rOp
         3U1A==
X-Gm-Message-State: AOAM533Kr1Z0JaAj+kQRfcWFLi3s0Evkp+SuKSzwZqn9TqiRki/NSfbB
	AhWjrsGqSjjmHngYtNTWeRaLDZUm9kVOFE7h
X-Google-Smtp-Source: ABdhPJy2SM2AABCsymjd8FffizRXtFdZRnVyPCfM2Qr0KkVz9jX47ntuDu9BpFlMD9fbB7uwnHF++w==
X-Received: by 2002:a17:902:e810:: with SMTP id u16mr28178836plg.98.1643766111957;
        Tue, 01 Feb 2022 17:41:51 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k12sm23889095pfc.107.2022.02.01.17.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 17:41:51 -0800 (PST)
Message-ID: <61f9e15f.1c69fb81.876ca.f37d@mx.google.com>
Date: Tue, 01 Feb 2022 17:41:51 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.83-cip1-178-g2cf1d12aab81
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline: 129 runs, 2 regressions (v5.10.83-cip1-178-g2cf1d12aab81) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline: 129 runs, 2 regressions (v5.10.83-cip1-178-g=
2cf1d12aab81)

Regressions Summary
-------------------

platform                 | arch | lab          | compiler | defconfig      =
    | regressions
-------------------------+------+--------------+----------+----------------=
----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-178-g2cf1d12aab81/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-178-g2cf1d12aab81
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2cf1d12aab81945a16019888de695cb923db5225 =



Test Regressions
---------------- =



platform                 | arch | lab          | compiler | defconfig      =
    | regressions
-------------------------+------+--------------+----------+----------------=
----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig | 2          =


  Details:     https://kernelci.org/test/plan/id/61f9d65c9cdd86ce275d6f27

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-178-g2cf1d12aab81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-=
imx6q-var-dt6customboard.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-178-g2cf1d12aab81/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-=
imx6q-var-dt6customboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/61f9d65c9cdd86c=
e275d6f2e
        new failure (last pass: v5.10.83-cip1-151-ga4163710a1dc)
        4 lines

    2022-02-02T00:54:35.795933  kern  :alert : 8<--- cut here ---
    2022-02-02T00:54:35.827053  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 0000004c
    2022-02-02T00:54:35.828239  kern  :alert : pgd =3D (ptrval)<8>[   39.45=
0731] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dline=
s MEASUREMENT=3D4>
    2022-02-02T00:54:35.828510  =

    2022-02-02T00:54:35.828748  kern  :alert : [0000004c] *pgd=3D491b4831   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61f9d65c9cdd86c=
e275d6f2f
        new failure (last pass: v5.10.83-cip1-151-ga4163710a1dc)
        53 lines

    2022-02-02T00:54:35.843912  kern  :emerg : Internal error: Oops: 17 [#1=
] SMP ARM
    2022-02-02T00:54:35.885831  kern  :emerg : Process udevd (pid: 130, sta=
ck limit =3D 0x(ptrval))
    2022-02-02T00:54:35.886351  kern  :emerg : Stack: (0xc397bcd8 to 0xc397=
c000)
    2022-02-02T00:54:35.886599  kern  :emerg : bcc0:                       =
                                c0f00590 c09ddbbc
    2022-02-02T00:54:35.886833  kern  :emerg : bce0: c39fcdb0 c39fcdb4 c39f=
cc00 c09e369c c397a000 c1445d0c 0000000c c0c5ce69
    2022-02-02T00:54:35.887317  kern  :emerg : bd00: c19c7a10 c3a64d00 c200=
1d80 ef86cc80 c09f0e24 c1445d0c 0000000c c3268d40
    2022-02-02T00:54:35.887791  kern  :emerg : bd20: c19c7a10 c0c5ce69 0000=
0001 c3a6bdc0 c3075d80 c39fcc00 c39fcc14 c1445d0c
    2022-02-02T00:54:35.929222  kern  :emerg : bd40: 0000000c c3268d40 c19c=
7a10 c09f0df8 c1443a30 00000000 c39fcc00 fffffdfb
    2022-02-02T00:54:35.929491  kern  :emerg : bd60: bf026000 c22d8c10 0000=
0120 c09c6df0 c39fcc00 bf022120 c2329f40 c3966d08
    2022-02-02T00:54:35.929971  kern  :emerg : bd80: c3af08c0 c19c7a2c 0000=
0120 c0a237c8 c3a6b3c0 c3a6b3c0 c2232c00 c3af08c0 =

    ... (34 line(s) more)  =

 =20

