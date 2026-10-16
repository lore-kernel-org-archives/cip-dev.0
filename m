Return-Path: <bot@kernelci.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474C5CC6B38
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 02:30:11 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13310.1792117807575826452
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2026 19:30:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci.org header.s=google header.b=R0MXO7iE;
 spf=pass (domain: kernelci.org, ip: 74.125.82.180, mailfrom: bot@kernelci.org)
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35f036b17easo1304734eec.1
        for <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792117807; x=1792722607; darn=lists.cip-project.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5gNK3FwxXwKjSLR/6EF+2TpPkRVjwvd9mBz8NfJQlbI=;
        b=R0MXO7iE13hSvyGGVavzwmjSB+8fvMcOppouf2ON8j9EaZUKbEb8jpPEteAerPPBor
         czhlddnkHqe2ZpGTIaxSoEE5WSm+RgiwhlY4GPhCIpfr0088fwQVH3KSPk4LPpjpxmbM
         /0yp+NpBRWPYVYAGWwEV2LJ4VXY+HDzWzPryveCtv3Bvalswn9e6BxPcYZd7no+1jd9b
         MvAuiFcLZ5x6UOEBFL7VpHTyvny5mrisASh8wf677yCc3icbA1aB6ZunyZw80zSF66P4
         HsTugL8TslqDXiAezoCufZJq8cVDWvizwHFS+GgUuUQt0Rfso84+wP4Ckmtep9pMFhd/
         DFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117807; x=1792722607;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gNK3FwxXwKjSLR/6EF+2TpPkRVjwvd9mBz8NfJQlbI=;
        b=BMb1XTkKlQwgg2HT6RPbG6sxNvGtc8NfXMOMcI+qVRMhP3sbLxa4zHP3zJZcVXVTpu
         usNL0cdhq+CrwIBIOSYVrdhG6+6Qe0zKiLh3GHKIhspHLbqvdVjoJClluzdfMekN7i1t
         qcdRQFsKpPaB8OqK0FKjsbJ50Uk4PWrs9IZ6Gora2qjHAfmFFDLRLGBlPXKncdKebMtL
         THaWVUK7pkHRJbi4REpoKEqIyyBTqZ57xcrhcFaZLsKIkVcz1CdAheUe20CwFKHfrFOO
         pUsMv5PIIby3hDXqGjhKM/XOtOrf3SoFvwBI5uzTnajzbcEU9vf9B5STNmUYRZcoYdw2
         XJZQ==
X-Gm-Message-State: AFq9FYI67M6e9F89TFHC4DGP/S9CgmhHZ+U9YpqWUnsImjBnhC49aG7L
	GSLJGNcHr2snJwG4LMzIPsqSs0LTArtyaVRJSBTaxHKiIg4CI5kLVqG5lPVuNTORhJ0=
X-Gm-Gg: AYBFou0xa+KzkAldycpSXPaqcPsBjXjni/HumnpAFpIYjXEWbcXMaj32i+efD1p+4h3
	rVAVqRvfAmm33wgQvi8eWG7VaHB0qOinojulsu8Ig5mPu9CTz77RFwvSfi0psGG7qL7d2VDv5A7
	/lc7+3rEKD86Ohdv1WPDvjsWrUr2Adoq69byUglgvt520tH3zkCykKd3Jj7ev56UujeLk1QG+Cq
	g1yo56wkGINfLiDznBNdoZsmJA3/WUimpZeGtz6+OpyZAC4GKckxIkqNTV04BBZopbBEurXhcg5
	3YyBVcWVviHdVoNaYEepptEjuHFIGVU4GemjVSPDHZGPoAHAjeu2o0OzGhGz3NFZTkeyP5LjscR
	boFk4QnrFy/ac+ZDjucUHbJdB8qQz7rbr0gbSikkO1MueQHbkiP6+06RWNYt32XuO/3GRSbZLix
	zcA8Vbd6AgFxktpeeaC1XmJRUUZFyPqoKsEcUoqfi3zjsqVaXmxL3ZEPuopoo+xXo=
X-Received: by 2002:a05:7300:b293:b0:351:207d:bff4 with SMTP id 5a478bee46e88-3537deccb0fmr28226429eec.4.1792117806599;
        Thu, 15 Oct 2026 19:30:06 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm2086245eec.4.2026.10.15.19.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:30:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] cip/linux-6.1.y-cip-rt -
 407b1406d2fad2b7ac279f28757bbd06e1d541dd
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: cip-dev@lists.cip-project.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 16 Oct 2026 02:30:05 -0000
Message-ID: <179211780515.391248.13476473435623274437@244668f92ec4>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Oct 2026 02:30:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24475



Hello,

Status summary for cip/linux-6.1.y-cip-rt

Dashboard:
https://d.kernelci.org/c/cip/linux-6.1.y-cip-rt/407b1406d2fad2b7ac279f28757bbd06e1d541dd/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
branch: linux-6.1.y-cip-rt
commit hash: 407b1406d2fad2b7ac279f28757bbd06e1d541dd
origin: maestro
test start time: 2026-10-15 11:08:26.524000+00:00

Builds:	    6 ✅    0 ❌    0 ⚠️
Boots: 	    9 ✅    0 ❌    0 ⚠️
Tests: 	   19 ✅    1 ❌    3 ⚠️

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

