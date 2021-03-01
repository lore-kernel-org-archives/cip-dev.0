Return-Path: <SRS0=VS+T=H7=lists.cip-project.org=bounce+64572+6205+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F020C433DB
	for <cip-dev@archiver.kernel.org>; Mon,  1 Mar 2021 02:24:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A3564E10
	for <cip-dev@archiver.kernel.org>; Mon,  1 Mar 2021 02:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A3564E10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6205+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id grfmYY4521723xpwEXj78szw; Sun, 28 Feb 2021 18:24:38 -0800
X-Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web12.7084.1614565477666143595
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 Feb 2021 18:24:37 -0800
X-Received: by mail-pj1-f54.google.com with SMTP id b15so10078366pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 Feb 2021 18:24:37 -0800 (PST)
X-Gm-Message-State: JOaSVZMdIxkRrNy83EUlrAIax4520388AA=
X-Google-Smtp-Source: ABdhPJynBdLFdvREM1/+arCdZB6wWVBqdLYtSuoCrN20Lz72f9PB9JeSESyd4+megi6+3vZS/WO09Q==
X-Received: by 2002:a17:902:b609:b029:e3:4b8d:994 with SMTP id b9-20020a170902b609b02900e34b8d0994mr13285323pls.44.1614565476819;
        Sun, 28 Feb 2021 18:24:36 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b187sm14038738pgc.23.2021.02.28.18.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 18:24:36 -0800 (PST)
Message-ID: <603c5064.1c69fb81.fc291.0ff1@mx.google.com>
Date: Sun, 28 Feb 2021 18:24:36 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.177-cip44
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip ltp-ipc: 10 runs, 1 regressions (v4.19.177-cip44) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="B4Eq8ivieZzOWjzjMOhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614565478;
 bh=eYqBq2cMXOGm9dyJCpaZQ+8kot4LGjL0gdW/QWdwc3Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=TMKX2j9OdxLBnPOniupsNw6B4l/5z45CNMCENgWHXuNLswpxeyKBJ6bAo9Wb+D6ms4l
 MAv/pVhrpGoghE8xScGNZdloeW4RddkmsERmXnoJv7WcyFbM+45HLlw5j0xsw8TZ742Zu
 P8WBbs4yC6ya66AEMbikIE3YI/ptJnHaXSo=

--B4Eq8ivieZzOWjzjMOhG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip ltp-ipc: 10 runs, 1 regressions (v4.19.177-cip44)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig+CON...OMIZE=
_BASE=3Dy | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.177-cip44/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.177-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e48c182113555669a03ec13050eed01d1dc66e9f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c4f669f13106862b6d8be38adf7825ae00ca7ac5 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig+CON...OMIZE=
_BASE=3Dy | 1          =


  Details:     https://kernelci.org/test/plan/id/603c3b173490ba75b0addcb1

  Results:     8 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+CONFIG_RANDOMIZE_BASE=3Dy
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.177=
-cip44/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-collabora/ltp-ip=
c-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.177=
-cip44/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-collabora/ltp-ip=
c-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster-ltp/=
20210208.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/603c3b173490ba75b0addc=
b2
        new failure (last pass: v4.19.175-cip43) =

 =20

--B4Eq8ivieZzOWjzjMOhG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6205): https://lists.cip-project.org/g/cip-dev/message=
/6205
Mute This Topic: https://lists.cip-project.org/mt/80988114/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--B4Eq8ivieZzOWjzjMOhG--
