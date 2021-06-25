Return-Path: <SRS0=I93o=LT=lists.cip-project.org=bounce+64572+6581+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B3DC2B9F4
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 11:57:29 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436C46161C
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 11:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436C46161C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6581+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RIhiYY4521723xjCyaiu9vGr; Fri, 25 Jun 2021 04:57:28 -0700
X-Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web09.6422.1624622248476991555
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Jun 2021 04:57:28 -0700
X-Received: by mail-pj1-f41.google.com with SMTP id g4so5357765pjk.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Jun 2021 04:57:28 -0700 (PDT)
X-Gm-Message-State: vZpIbYjwImq1L6IEACgVTfJnx4520388AA=
X-Google-Smtp-Source: ABdhPJxGAuh2frXItxNu5uS1iE2QK98Y/c/BVMNUZydzEUqftQ6e74C0BDWwv1gtQJSo3BbLFApgow==
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr11070412pjn.212.1624622247737;
        Fri, 25 Jun 2021 04:57:27 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g8sm5586389pja.14.2021.06.25.04.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:57:27 -0700 (PDT)
Message-ID: <60d5c4a7.1c69fb81.6e61a.efa2@mx.google.com>
Date: Fri, 25 Jun 2021 04:57:27 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.195-cip52-rt20
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip-rt baseline-nfs: 30 runs, 5 regressions (v4.19.195-cip52-rt20) #kernelci
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
Content-Type: multipart/mixed; boundary="a83Dpt1GHc3Lun9xjgLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624622248;
 bh=eZ/OL9FNaQejd2PcYJO/rk87qxTzzFBz4YLmL3VTFZk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=X4HQ32MCfL+aYmlH8REHg5B5EvrWOMANxgts2780ukfEeosvWZD917H8zsN7uavl8yk
 sObRhjRwTUO+L7+AZutmVl5mGSBc3we7A0TPkp9RmjI25jpWiDZbGI78thmIEaiyKopsy
 iQ4/kyrab5qGRCDijaNsppmymmVCj2e5SqE=

--a83Dpt1GHc3Lun9xjgLq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip-rt baseline-nfs: 30 runs, 5 regressions (v4.19.195-cip=
52-rt20)

Regressions Summary
-------------------

platform                  | arch | lab           | compiler | defconfig    =
      | regressions
--------------------------+------+---------------+----------+--------------=
------+------------
rk3288-veyron-jaq         | arm  | lab-collabora | gcc-8    | multi_v7_defc=
onfig | 3          =

sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc=
onfig | 1          =

sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre  | gcc-8    | sunxi_defconf=
ig    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.195-cip52-rt20/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.195-cip52-rt20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f732dada94956f37e51436f20562ae815aa3bf7 =



Test Regressions
---------------- =



platform                  | arch | lab           | compiler | defconfig    =
      | regressions
--------------------------+------+---------------+----------+--------------=
------+------------
rk3288-veyron-jaq         | arm  | lab-collabora | gcc-8    | multi_v7_defc=
onfig | 3          =


  Details:     https://kernelci.org/test/plan/id/60d5c148cf25646c74413287

  Results:     63 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-nfs-rk32=
88-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-nfs-rk32=
88-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/t=
est/case/id/60d5c148cf25646c744132a3
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:42:54.150883  /lava-4093727/1/../bin/lava-test-case
    2021-06-25T11:42:54.180917  <8>[   31.267817] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/t=
est/case/id/60d5c148cf25646c744132a4
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:42:55.212932  /lava-4093727/1/../bin/lava-test-case
    2021-06-25T11:42:55.242549  <8>[   32.329317] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/=
test/case/id/60d5c148cf25646c744132bd
        new failure (last pass: v4.19.182-cip45-rt19)

    2021-06-25T11:42:58.563505  /lava-4093727/1/../bin/lava-test-case
    2021-06-25T11:42:58.595614  <8>[   35.682714] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>   =

 =



platform                  | arch | lab           | compiler | defconfig    =
      | regressions
--------------------------+------+---------------+----------+--------------=
------+------------
sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60d5b92ab7fa57cebe413270

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i=
-a20-olinuxino-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i=
-a20-olinuxino-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60d5b92ab7fa57ceb=
e413271
        failing since 92 days (last pass: v4.19.165-cip41-rt18, first fail:=
 v4.19.182-cip45-rt19) =

 =



platform                  | arch | lab           | compiler | defconfig    =
      | regressions
--------------------------+------+---------------+----------+--------------=
------+------------
sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre  | gcc-8    | sunxi_defconf=
ig    | 1          =


  Details:     https://kernelci.org/test/plan/id/60d5b6d195bdf16f5741327c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a2=
0-olinuxino-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a2=
0-olinuxino-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60d5b6d195bdf16f5=
741327d
        failing since 92 days (last pass: v4.19.165-cip41-rt18, first fail:=
 v4.19.182-cip45-rt19) =

 =20

--a83Dpt1GHc3Lun9xjgLq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6581): https://lists.cip-project.org/g/cip-dev/message=
/6581
Mute This Topic: https://lists.cip-project.org/mt/83782324/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--a83Dpt1GHc3Lun9xjgLq--
