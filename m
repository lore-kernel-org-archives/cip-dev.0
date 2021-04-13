Return-Path: <SRS0=fzvO=JK=lists.cip-project.org=bounce+64572+6364+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D4DC43460
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649B36135C
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649B36135C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6364+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QPfJYY4521723xmCukQtt5pT; Tue, 13 Apr 2021 01:55:25 -0700
X-Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web09.6393.1618304124760145890
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Apr 2021 01:55:24 -0700
X-Received: by mail-pl1-f181.google.com with SMTP id m18so5635753plc.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Apr 2021 01:55:24 -0700 (PDT)
X-Gm-Message-State: zcZZkg4e7O1g2qmvlKLHGbhHx4520388AA=
X-Google-Smtp-Source: ABdhPJzH4VUPJ656jJAn8tr3uxjnsFje32owyLLaSkMSWaqvRpFn0teZs4aV01CxZEgf7F04oWgIUA==
X-Received: by 2002:a17:90a:7e8f:: with SMTP id j15mr1248703pjl.71.1618304124181;
        Tue, 13 Apr 2021 01:55:24 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 77sm14111417pgf.55.2021.04.13.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 01:55:23 -0700 (PDT)
Message-ID: <60755c7b.1c69fb81.e1920.2e40@mx.google.com>
Date: Tue, 13 Apr 2021 01:55:23 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.186-cip47
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip ltp-ipc: 22 runs, 1 regressions (v4.19.186-cip47) #kernelci
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
Content-Type: multipart/mixed; boundary="XXJ8STFnGid4GnC9ekYo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618304125;
 bh=NakTnLEnHlSKMZ9Xcq3TC37AhNFs/aRrbivD3r+bAc4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=SpK9WPK2QkEcp+pctTy5kzxwfDa1N5O0ehRSa4d++1h8Qdc7Gv4cV54mgvuAwr0daC5
 SRFmLNfN/Jc1AimDJTtQWnEDPuMsiSfx1jRLO5COnHa1cVF8WtKhS2QDGx7oNDMwwBmL4
 Ft0CcSmfPJ9SP26VyG4CH82jVQEuczTrf8c=

--XXJ8STFnGid4GnC9ekYo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip ltp-ipc: 22 runs, 1 regressions (v4.19.186-cip47)

Regressions Summary
-------------------

platform   | arch | lab           | compiler | defconfig          | regress=
ions
-----------+------+---------------+----------+--------------------+--------=
----
odroid-xu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.186-cip47/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.186-cip47
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6aacc392bf723d573084332054aa3070424576fe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3e0e60074495e1c350b634848e5dd1f7993ec2ef =



Test Regressions
---------------- =



platform   | arch | lab           | compiler | defconfig          | regress=
ions
-----------+------+---------------+----------+--------------------+--------=
----
odroid-xu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/60754e71e0d014a259dac6b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47/arm/multi_v7_defconfig/gcc-8/lab-collabora/ltp-ipc-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47/arm/multi_v7_defconfig/gcc-8/lab-collabora/ltp-ipc-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster-ltp/=
20210324.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/60754e71e0d014a259dac6=
b2
        failing since 96 days (last pass: v4.19.163-cip40-5-g95fea62f9f453,=
 first fail: v4.19.163-cip40-34-g2f3a6d08a3bd) =

 =20

--XXJ8STFnGid4GnC9ekYo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6364): https://lists.cip-project.org/g/cip-dev/message=
/6364
Mute This Topic: https://lists.cip-project.org/mt/82060344/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XXJ8STFnGid4GnC9ekYo--
