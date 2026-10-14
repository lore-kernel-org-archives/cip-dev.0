Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CD7CC6B27
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 08:26:39 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4919.1791945445130487883
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2026 19:37:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci.org header.s=google header.b=IxVRknLH;
 spf=pass (domain: kernelci.org, ip: 209.85.219.47, mailfrom: bot@kernelci.org)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917c04630c2so47570126d6.3
        for <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 19:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791945444; x=1792550244; darn=lists.cip-project.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1zK6hhyjJZxR1MB+YNvj8cxc4fABPsOXq09NiZQeVgA=;
        b=IxVRknLHAW6jacEQVtbCuGnQtZ7D2Oort5eSMVIn2RNsAp4YiGAgb+xaFMweT82VO/
         UBUPfQpTDKXIRsKFJ6ThgnL9V/iuv7537RbiR+ehCY9bNkD1LGu1eXtuf4rs++gsEdAo
         q9jNsLyqhDVX1whRlNMcS2fxf6QEJWL4Wi2ttC4lkfIG6pd9AwhQW1g6vrKrDXwDTerd
         Z4O45QkHL6TbU2+/YZbO3hCPzfKz3RThmW9gFhF4i1sObcLcdvVkFdHZ2nQiV46Vepjr
         PncJo8NQ+NPYAIshq/ibJy4HPOLHyMiMIxUKy802Wfyc4JHrcDmya7w7iXFnpnmokl+w
         z+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791945444; x=1792550244;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1zK6hhyjJZxR1MB+YNvj8cxc4fABPsOXq09NiZQeVgA=;
        b=d7uf7Gm8iZmfBioUjXQud9P60KFm31OcC77mL9uTpp+ihxzbgxouwuIpztI8ieOQaC
         /YmIW9m2RvY+YjaFvQcdMEZWyBqVwWQcsH07ll9oxdM0TCC48uFBeAtE2b5TQsmYu2qx
         L9Sq6V3fewQaYlQ4PNWo9HegnjU27J3IeeCY0q3d1RJwlmvHBN9tkc+s38Wg5YWflqIE
         T++WCsoz0Ly83PRYg3W6IRvDo4jvsxVEKCOgG7HwqKAsWDRq6cL1j17SxX2UeQueQptk
         NvDCd3bKzSQdWP7Xc38pHD+mZJdFN7BGA3MTvn2qdc/BS8Xl5E2dL7j4rb5j5Qipj9JW
         NwVQ==
X-Gm-Message-State: AFq9FYIOzhpmI2fVZTSoQi4tb1+FIAV6MCDKQGPgvgTqbv3EidjTjAZD
	tHngTHAQEWoCvybrEIC2njpyv7gD5a4mCvpzJnaWD2rnkkNEvhE84CkE6aEabFug1N2Oasjzt1i
	PcJS8
X-Gm-Gg: AYBFou3JWJ8EkeEZUqAkGL/4nBY6QNKAhTb34HODXhu+nzH683ZfBLBQ9cDmezG7G+k
	A0LW/HnPejq+V9KXYGJJcTTltb4CYU6xDTHtaUhrmUembCwvyXxcLVCB8cIFU2QVubkUOKqvJsc
	5yBya1H8xju8qgjzY1PLaYmGod8MmdzPWAb7PxM4leYjLGZRmKSWk96rBi/Ozp7aXpEnVDmBn+G
	Kcsmbhi/XNSCyjKHrE9gf/Al1EqkCOEZ7aG9C4j5dH2L66xFsvacWuYRQ52E3jlkXqXurowbgjl
	jso6AGmc44eifKBCMMeX7iSIRT3r6sfN0mUW+ZOUIw3e5Ww4pvsSAHtlOkuNeeDBhPuYCG3AZcW
	FIynPHd1ncgf15E8HLO2iHQGIXDrY/ts/eKuHAgb4h09h3xmf/INEU58+m0cZ9Reg+qJBHZ0ArF
	PqlstX/EwKTPqzyQTBq+0LU+jkqui793Yb2zyyeQptA5ywz5dsYir2T8t8bAD44Ak=
X-Received: by 2002:a05:693c:4146:10b0:35d:ddf2:e986 with SMTP id 5a478bee46e88-35dddf2eaf5mr899922eec.11.1791945017171;
        Tue, 13 Oct 2026 19:30:17 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm53824717eec.3.2026.10.13.19.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:30:16 -0700 (PDT)
MIME-Version: 1.0
Subject: [STATUS] cip/linux-6.12.y-cip - 35e6dee6bee87f669b7829a809f3a8359b40975b
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: cip-dev@lists.cip-project.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 14 Oct 2026 02:30:16 -0000
Message-ID: <179194501626.288311.13031199333622605368@244668f92ec4>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 08:26:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24457



Hello,

Status summary for cip/linux-6.12.y-cip

Dashboard:
https://d.kernelci.org/c/cip/linux-6.12.y-cip/35e6dee6bee87f669b7829a809f3a8359b40975b/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
branch: linux-6.12.y-cip
commit hash: 35e6dee6bee87f669b7829a809f3a8359b40975b
origin: maestro
test start time: 2026-10-13 05:10:27.552000+00:00

Builds:	    6 ✅    0 ❌    0 ⚠️
Boots: 	   16 ✅    0 ❌    0 ⚠️
Tests: 	   72 ✅    0 ❌    9 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

