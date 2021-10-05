Return-Path: <SRS0=mY3J=OZ=lists.cip-project.org=bounce+64572+6780+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A95C433F5
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 01:31:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66EB6126A
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 01:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D66EB6126A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rCilYY4521723xlRt263RcuU; Mon, 04 Oct 2021 18:31:01 -0700
X-Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web12.19662.1633397460862394718
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Oct 2021 18:31:01 -0700
X-Received: by mail-pg1-f171.google.com with SMTP id h3so7632987pgb.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Oct 2021 18:31:00 -0700 (PDT)
X-Gm-Message-State: kC3ce3SdUaXU2JG2HZQmwnijx4520388AA=
X-Google-Smtp-Source: ABdhPJwhrSKkIPMhCwfOmZllb86uVUzB7iNh/OFYqAQGmIz6HdOfQ8pQK7YIoPzeka++l8cAawBAqg==
X-Received: by 2002:a63:131f:: with SMTP id i31mr13601848pgl.207.1633397459888;
        Mon, 04 Oct 2021 18:30:59 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s38sm14951033pfw.209.2021.10.04.18.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 18:30:59 -0700 (PDT)
Message-ID: <615baad3.1c69fb81.b3a4b.dd41@mx.google.com>
Date: Mon, 04 Oct 2021 18:30:59 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.4.285-cip63
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
Subject: [cip-dev] cip/linux-4.4.y-cip sleep: 4 runs, 11 regressions (v4.4.285-cip63) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="FpaEvZH2677V9aBB9XKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633397461;
 bh=rm64KSoS1P+yEMI1xPz17Jl7/G1wpkIOjShy9Nbzkt0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fGLfEwQDGX3d/iBWG7kp8CTd5RySRW3NfRlvmg67K6UBM4OYgEvBXxqSntjYP0XBCg9
 Nt/zaXIqj8jwWJ75dZqJyNmHBAQHr4JWs49qJo2rcL6Q2CH/hr+ZZtxXGD9VZwGajET0m
 RJOKmLy8dq2ZvfSMAdBYrWnGraXl8NMSzYM=

--FpaEvZH2677V9aBB9XKs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip sleep: 4 runs, 11 regressions (v4.4.285-cip63)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-8    | x86_64_defcon...6-=
chromebook | 11         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.285-cip63/plan/sleep/

  Test:     sleep
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.285-cip63
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      18016d4e60e0ab15de4683f6caf64b6289612ac6 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-8    | x86_64_defcon...6-=
chromebook | 11         =


  Details:     https://kernelci.org/test/plan/id/615b92c0838d998dcc99a2f3

  Results:     12 PASS, 11 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.285-c=
ip63/x86_64/x86_64_defconfig+x86-chromebook/gcc-8/lab-collabora/sleep-hp-11=
A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.285-c=
ip63/x86_64/x86_64_defconfig+x86-chromebook/gcc-8/lab-collabora/sleep-hp-11=
A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/amd64/rootfs.cpio.gz =



  * sleep.rtcwake-freeze-10: https://kernelci.org/test/case/id/615b92c0838d=
998dcc99a2f5
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.899141  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.905533  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:15 2021
    2021-10-04T23:48:08.912620  rtcwake: write error   =


  * sleep.rtcwake-freeze-9: https://kernelci.org/test/case/id/615b92c0838d9=
98dcc99a2f6
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.875562  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.881816  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.888878  rtcwake: write error   =


  * sleep.rtcwake-freeze-8: https://kernelci.org/test/case/id/615b92c0838d9=
98dcc99a2f7
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.851816  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.858325  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.865292  rtcwake: write error   =


  * sleep.rtcwake-freeze-7: https://kernelci.org/test/case/id/615b92c0838d9=
98dcc99a2f8
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.828165  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.834754  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.841594  rtcwake: write error   =


  * sleep.rtcwake-freeze-6: https://kernelci.org/test/case/id/615b92c0838d9=
98dcc99a2f9
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.804423  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.811232  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.818081  rtcwake: write error   =


  * sleep.rtcwake-freeze-5: https://kernelci.org/test/case/id/615b92c0838d9=
98dcc99a2fa
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.781073  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.787424  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.795022  rtcwake: write error   =


  * sleep.rtcwake-freeze-4: https://kernelci.org/test/case/id/615b92c0838d9=
98dcc99a2fb
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.757434  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.763738  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.770767  rtcwake: write error   =


  * sleep.rtcwake-freeze-3: https://kernelci.org/test/case/id/615b92c0838d9=
98dcc99a2fc
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.733587  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.739885  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.747630  rtcwake: write error   =


  * sleep.rtcwake-freeze-2: https://kernelci.org/test/case/id/615b92c0838d9=
98dcc99a2fd
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.708577  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.715565  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.723797  rtcwake: write error   =


  * sleep.rtcwake-freeze-1: https://kernelci.org/test/case/id/615b92c0838d9=
98dcc99a2fe
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.677533  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.683832  rtcwake: wakeup from \"freeze\" using rtc0 =
at Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.693546  rtcwake: write error   =


  * sleep.rtcwake-mem-10: https://kernelci.org/test/case/id/615b92c0838d998=
dcc99a2ff
        new failure (last pass: v4.4.283-cip62)

    2021-10-04T23:48:08.642798  rtcwake: assuming RTC uses UTC ...
    2021-10-04T23:48:08.649788  rtcwake: wakeup from \"mem\" using rtc0 at =
Mon Oct  4 23:48:14 2021
    2021-10-04T23:48:08.653112  [   30.563557] PM: Syncing filesystems ... =
done.
    2021-10-04T23:48:08.664642  rtcwake: write error   =

 =20

--FpaEvZH2677V9aBB9XKs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6780): https://lists.cip-project.org/g/cip-dev/message/=
6780
Mute This Topic: https://lists.cip-project.org/mt/86083995/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--FpaEvZH2677V9aBB9XKs--
