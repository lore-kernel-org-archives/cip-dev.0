Return-Path: <SRS0=IKEf=LI=lists.cip-project.org=bounce+64572+6518+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08483C2B9F4
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 16:02:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929AB61245
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 16:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929AB61245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6518+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id u9oLYY4521723xLGPVCLgk1K; Mon, 14 Jun 2021 09:02:44 -0700
X-Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web08.32012.1623686563627781613
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Jun 2021 09:02:43 -0700
X-Received: by mail-pj1-f54.google.com with SMTP id mp5-20020a17090b1905b029016dd057935fso10361920pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Jun 2021 09:02:43 -0700 (PDT)
X-Gm-Message-State: sQtXxRCQMcjNtdCLscPLsN5Rx4520388AA=
X-Google-Smtp-Source: ABdhPJyEsvUYdPEpCZ9BSWTaGdv0ttKAau5Ws0sWJ/ZwDEvByemBa+kopbK65WETA/pQ5Dr2d8zpVA==
X-Received: by 2002:a17:902:d2cf:b029:11d:1349:24f2 with SMTP id n15-20020a170902d2cfb029011d134924f2mr475518plc.58.1623686562910;
        Mon, 14 Jun 2021 09:02:42 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r11sm13283197pgl.34.2021.06.14.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 09:02:42 -0700 (PDT)
Message-ID: <60c77da2.1c69fb81.f727f.6a15@mx.google.com>
Date: Mon, 14 Jun 2021 09:02:42 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.272-cip58
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.4.y-cip baseline-nfs: 18 runs, 1 regressions (v4.4.272-cip58) #kernelci
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
Content-Type: multipart/mixed; boundary="skXAsg8rIa6ekDAiYo2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623686564;
 bh=BIEPEGZGxCuIlAHeVOTT8pDlQT9BOcsTqA3s3EUg8h8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=t44Rlc1ykegmItQ1UlK5fPp28BVUyV3NIrvRqcmhJ3RFBe/Axk/6iaxNRfkHskZCwis
 zo+cHK1+UUnjaOzRyWlAEAG7qdk0tt0LUV2n1Z68M97fb/tLVXZeMZ5VkQoUs/QUNMFH+
 3QBgAsdliGr6bZVMjFNah42hRWa2mB4eUXQ=

--skXAsg8rIa6ekDAiYo2G
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline-nfs: 18 runs, 1 regressions (v4.4.272-cip58)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.272-cip58/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.272-cip58
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91a8e96603d53c19b112388602066978c42cdc97 =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/60c776043541cb5447413275

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.272-c=
ip58/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60c776043541cb544=
7413276
        failing since 28 days (last pass: v4.4.266-cip56, first fail: v4.4.=
268-cip57) =

 =20

--skXAsg8rIa6ekDAiYo2G
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6518): https://lists.cip-project.org/g/cip-dev/message=
/6518
Mute This Topic: https://lists.cip-project.org/mt/83533957/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--skXAsg8rIa6ekDAiYo2G--
