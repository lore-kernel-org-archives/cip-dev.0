Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD29C77B7F
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 09:13:55 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.37952.1750217915026754266
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 20:38:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xr8lPr1q;
 spf=pass (domain: gmail.com, ip: 209.85.210.179, mailfrom: zaq14760@gmail.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747fc7506d4so5281944b3a.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 20:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750217914; x=1750822714; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaL0HiH9jBIX2TlypOzxXsG0yj+HeZtCgZDd/6Q8FqQ=;
        b=Xr8lPr1qtjGHIzzfssixXrvF2zzBU2VlQOsdI8kkdpsniJCiVJINB58acidBh3RbAX
         l5TLllUzpzeztjp9Lm5qfDQMx9J20tLpWevkLH2Gq/VzQnQXqLd/6SVHXYbjqRUrWB2g
         pqzJYNJDYimq4TF/UVFYMmHKsp/X2JIF+7niabnrm4JLZfYIgKCRfMmIv8QQEewmsuAd
         2CRfQVZ39+nm1M+/l2JVEeKafE0hwYIARn+Cg7YeJjQ4vxRndCUtdBNEtkaWwsMbWxAc
         Ch/39tPnfqGf+27KcW6M7AHMZ/MK7Tale095Ixjc4CF1lCqWkVSkMlKYMkRZbKaFE+rd
         xHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750217914; x=1750822714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaL0HiH9jBIX2TlypOzxXsG0yj+HeZtCgZDd/6Q8FqQ=;
        b=sa0W18czSBsgpzlE5MqAZtrN9AxWadovjHKUUlgNUvwCendou/E0gd9sPMpfmxV5KI
         2g+a9VmoqR4xfJ89g4BmXCsPOfF4vmVYNlNTU+/b2+smiWKc+QXgxbovDeG80J7tCnKQ
         H3cT2U3DGsvcuEiVeeMPpItP8JlwrjXnscuB7+3rRSrsdgEUBBxfqrJASOM/2NEyjgnf
         JCfDQVHwaxkyPaGSe35oykjww3IbTnP9j7wDQjkadSVHUoaDACN2adr2N901ZpqfZ8A/
         FIIYFsyTUBTriOKTqgzuGboyjA1xZN9Q02a3L20rzuz5lV99o2px1bDqDReYjqRoTgDl
         XQtw==
X-Gm-Message-State: AOJu0Yyl0Ag607BdXDlN3EV2hQ805WNyawXAzsHpkb2nmlw9kFAm5P3j
	9rmpPTgrABynqHWfweznh7/6RIRM63gy6vIZN5cSGi19ycdaMSCFCA5XyLk+Unr5
X-Gm-Gg: ASbGnctLXYChhrVWsiRaZh/7SWJKZ040JVpXQgo3P68XRFcVbfX1nf7mqkAWcMc/pjw
	s62euMwf+vXHX2sMlyFVmXGCEhOUP22CGEllOU7nSeUyUZ+c4gphhKn3CWmLqi4KZj2fTNCy5t2
	tkTs3gHqb41ELopHzpaoY5Ve5Sd7Y42VOTsDLKQEclPfdgW8gCou049W+tvnyUaJFxGQFhhoHV4
	9WfyK+uS0/+Pcv/mLUHELd9leTHQfw8HAqqUxwXYVCk4oNmbvzYF1N4HdvVupChRLFNEvqmWfWI
	MgSq80moJhxcP/lMj62bF9rNO9Jw1bVjxAHJ6e1as9tqyGCKSoX76kffskhXGPYYXxT6w+twIQA
	XUEAvi/ROuMYmaxcLNdWbRrmrxo0EiCBu4xpDbnmY0G+tdUdvig==
X-Google-Smtp-Source: AGHT+IFFsSYdcuxWI3MsrMPZpLA7IiYafN2kXt3kRdGUmtKyDg/KnUQReXn+mRyiXifCZmz+qDAiWg==
X-Received: by 2002:a05:6a00:3cc9:b0:740:596b:4a7f with SMTP id d2e1a72fcca58-7489d038c17mr23312261b3a.16.1750217913948;
        Tue, 17 Jun 2025 20:38:33 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900822b7sm10147934b3a.101.2025.06.17.20.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:38:33 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	krzk@kernel.org,
	zaq14760@gmail.com,
	onlywig@gmail.com
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Mayqueen name
Date: Wed, 18 Jun 2025 11:37:29 +0800
Message-Id: <20250618033731.171812-2-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618033731.171812-1-zaq14760@gmail.com>
References: <20250618033731.171812-1-zaq14760@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 09:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19124

From: Wig Cheng <onlywig@gmail.com>

Mayqueen is a Taiwan-based company primarily focused on the development
of arm64 development boards and e-paper displays.

Signed-off-by: Wig Cheng <onlywig@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a8..8434ae355 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -631,6 +631,8 @@ patternProperties:
     description: MaxBotix Inc.
   "^maxim,.*":
     description: Maxim Integrated Products
+  "^mayqueen,.*":
+    description: Mayqueen Technologies Ltd.
   "^mbvl,.*":
     description: Mobiveil Inc.
   "^mcube,.*":
-- 
2.34.1


