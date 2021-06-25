Return-Path: <SRS0=njyT=LT=lists.cip-project.org=bounce+64572+6583+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0369C2B9F4
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 12:27:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308DC6162F
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 12:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308DC6162F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6583+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ULKCYY4521723x7Tizwc9fYf; Fri, 25 Jun 2021 05:27:30 -0700
X-Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web09.6738.1624624050301497148
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Jun 2021 05:27:30 -0700
X-Received: by mail-pj1-f51.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso7207485pjx.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Jun 2021 05:27:30 -0700 (PDT)
X-Gm-Message-State: E9uF94S1d3nMJYdXRDgWtAqqx4520388AA=
X-Google-Smtp-Source: ABdhPJw+TDT3QiMba5bbZ763ExVHtzdVAMlSg9PJBcgz8cUGd7OdlrebAI5Wk0jO2GUk/y/5zN5QNg==
X-Received: by 2002:a17:90a:6404:: with SMTP id g4mr20790458pjj.155.1624624049758;
        Fri, 25 Jun 2021 05:27:29 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w123sm5754657pfb.109.2021.06.25.05.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:27:29 -0700 (PDT)
Message-ID: <60d5cbb1.1c69fb81.bb2ce.ff76@mx.google.com>
Date: Fri, 25 Jun 2021 05:27:29 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.195-cip52-rt20
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip-rt ltp-ipc: 10 runs, 1 regressions (v4.19.195-cip52-rt20) #kernelci
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
Content-Type: multipart/mixed; boundary="3X1Rg2ysoQbyetVjnPb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624624050;
 bh=JKKc6R4EYETGCSl7nWbL3E9IEFmVWtkAKCXw8R+g8yc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=SdcsFodhX6zNCtdnIRiy4lbup4m4tXSUsZnrM84cwzm4pGSZYBxuoaHPiFwSUsO/+BK
 qmNApRBI5DIB3upklM/C8BsS25vpMHZOtV20QnDnyfZDUnBbd3/cBAXegw61uQOAf3XRS
 U7K36fkgIPTHmeLgrOayldT49lG0fS/mEMg=

--3X1Rg2ysoQbyetVjnPb3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip-rt ltp-ipc: 10 runs, 1 regressions (v4.19.195-cip52-rt=
20)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig+CON...OMIZE=
_BASE=3Dy | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.195-cip52-rt20/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.195-cip52-rt20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f732dada94956f37e51436f20562ae815aa3bf7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  9dcbf4e96a41ac69842e705d4dea51fc8e7b0860 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig+CON...OMIZE=
_BASE=3Dy | 1          =


  Details:     https://kernelci.org/test/plan/id/60d5b99b326f4727b5413268

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+CONFIG_RANDOMIZE_BASE=3Dy
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-collabor=
a/ltp-ipc-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
195-cip52-rt20/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-collabor=
a/ltp-ipc-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster-ltp/=
20210520.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/60d5b99b326f4727b54132=
69
        new failure (last pass: v4.19.182-cip45-rt19) =

 =20

--3X1Rg2ysoQbyetVjnPb3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6583): https://lists.cip-project.org/g/cip-dev/message=
/6583
Mute This Topic: https://lists.cip-project.org/mt/83782850/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3X1Rg2ysoQbyetVjnPb3--
